From: lists@haller-berlin.de (Stefan Haller)
Subject: gitk: "Show origin of this line" triggered programatically
Date: Thu, 18 Jul 2013 19:38:22 +0200
Message-ID: <1l67wml.upjrrz1nq48l7M%lists@haller-berlin.de>
Cc: paulus@samba.org (Paul Mackerras),
	angavrilov@gmail.com (Alexander Gavrilov),
	sitaramc@gmail.com (Sitaram Chamarty)
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 19:45:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzsGQ-0004As-K7
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 19:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759112Ab3GRRpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 13:45:08 -0400
Received: from server90.greatnet.de ([83.133.96.186]:51359 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758954Ab3GRRpH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 13:45:07 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jul 2013 13:45:06 EDT
Received: from [10.1.15.233] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id 520D63B0DC5;
	Thu, 18 Jul 2013 19:38:22 +0200 (CEST)
User-Agent: MacSOUP/2.8.4b3 (Mac OS X version 10.8.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230713>

The "Show origin of this line" context menu command on a line in a patch
in gitk is by far my most frequently used way of navigating back in
history. It's so much faster than git gui blame.

Now, I wish it were available right from my text editor, showing me the
origin of the line under the cursor when working with code.

In fact, it is; I have been using this feature in a roughly hacked way
for a couple of months now, and I don't want to miss it any more. Most
of my co-workers are jealous when they see it.

I'd like to get it into gitk for real now, and I need some guidance on
the best way to implement it.

I can see two ways:

1) Add an option like '--show-origin=foo.cpp:25'. This would run
   "git blame" on the given line in the working copy, and highlight the
   result.

2) Add an option like '--select-file=foo.cpp:25'. This would be used in
   combination with the existing --select-commit option to simply
   highlight a given line in the patch (so the caller needs to do the
   initial git blame himself).

There are pros and cons to both. 1) is certainly easier to use from a
text editor scripter's point of view (a simple one-liner in most cases),
whereas 2) probably needs a glue script to run the initial git blame. On
the other hand, that glue script could also take care of restricting the
history to a week or so forward from the target commit, which makes gitk
load much faster. Also, 2) could be used from git gui blame's "Show
history context" command, which currently only selects the commit but
can't highlight the line.

So I think I'd lean towards option 2).  Below is the prototype that I
have been using; not sure how buggy it is. If we go this route, one
question would be whether we want to ship the glue script too, and how.

Any opinions?

-Stefan



>From 80acb168ef13a55521e9b821450800450660769d Mon Sep 17 00:00:00 2001
From: Stefan Haller <stefan@haller-berlin.de>
Date: Thu, 18 Jul 2013 18:55:11 +0200
Subject: [PATCH] gitk: Add options --select-file and --select-line

These can be used in combination with --select-commit to jump to a given
line in a patch. This can be useful for scripting your text editor to bring
up gitk showing you the place in the history that last modified the line
you are on.

For example, given this little glue script, saved as "show_line_in_gitk.rb"
somewhere in your path:

        #!/usr/bin/env ruby

        if ARGV.length != 2
          puts "Usage: #{$0} <file> <line>"
          exit 1
        end

        file, line = ARGV
        blame_output = `git blame -p -L#{line},+1 "#{file}"`
        exit 1 if $?.exitstatus != 0

        blame_output_lines = blame_output.split("\n")
        commit, line = blame_output_lines[0].split

        file = blame_output_lines.grep(/^filename /)[0][9..-1]
        date = blame_output_lines.grep(/^committer-time /)[0][15..-1]
        datestr = Time.at(date.to_i + 60 * 60 * 24 * 7).to_s

        system "gitk --before='#{datestr}' \
                --select-commit=#{commit} \
                --select-file='#{file}' \
                --select-line=#{line} &"

you could add this function to your .vimrc:

    function! ShowLineInGitk()
        execute "!show_line_in_gitk.rb " . expand("%p") . " " . line(".")
    endfunction

and map it to a key.
---
 gitk | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index 5cd00d8..318a484 100755
--- a/gitk
+++ b/gitk
@@ -464,12 +464,17 @@ proc stop_rev_list {view} {
 }
 
 proc reset_pending_select {selid} {
-    global pending_select mainheadid selectheadid
+    global pending_select pending_select_file pending_select_line
+    global mainheadid selectheadid selectfile select_line
 
     if {$selid ne {}} {
        set pending_select $selid
     } elseif {$selectheadid ne {}} {
        set pending_select $selectheadid
+       if {$selectfile ne {}} {
+           set pending_select_file $selectfile
+           set pending_select_line $select_line
+       }
     } else {
        set pending_select $mainheadid
     }
@@ -1597,6 +1602,17 @@ proc getcommitlines {fd inst view updating}  {
     return 2
 }
 
+proc select_pending_line {} {
+    global pending_select pending_select_file pending_select_line
+
+    if {[info exists pending_select_file]} {
+       selectline [rowofcommit $pending_select] 1 \
+           [list $pending_select_file $pending_select_line]
+    } else {
+       selectline [rowofcommit $pending_select] 1
+    }
+}
+
 proc chewcommits {} {
     global curview hlview viewcomplete
     global pending_select
@@ -1611,7 +1627,7 @@ proc chewcommits {} {
            reset_pending_select {}
 
            if {[commitinview $pending_select $curview]} {
-               selectline [rowofcommit $pending_select] 1
+               select_pending_line
            } else {
                set row [first_real_row]
                selectline $row 1
@@ -5083,7 +5099,7 @@ proc layoutmore {} {
     if {[info exists pending_select] &&
        [commitinview $pending_select $curview]} {
        update
-       selectline [rowofcommit $pending_select] 1
+       select_pending_line
     }
     drawvisible
 }
@@ -7082,6 +7098,8 @@ proc selectline {l isnew {desired_loc {}}} {
     global autoselect autosellen jump_to_here
 
     catch {unset pending_select}
+    catch {unset pending_select_file}
+    catch {unset pending_select_line}
     $canv delete hover
     normalline
     unsel_reflist
@@ -11940,6 +11958,8 @@ if {[catch {set gitdir [exec git rev-parse --git-dir]}]} {
 
 set selecthead {}
 set selectheadid {}
+set selectfile {}
+set select_line {}
 
 set revtreeargs {}
 set cmdline_files {}
@@ -11955,6 +11975,12 @@ foreach arg $argv {
        "--select-commit=*" {
            set selecthead [string range $arg 16 end]
        }
+       "--select-file=*" {
+           set selectfile [string range $arg 14 end]
+       }
+       "--select-line=*" {
+           set select_line [string range $arg 14 end]
+       }
        "--argscmd=*" {
            set revtreeargscmd [string range $arg 10 end]
        }
-- 
1.8.3.2.747.g15edaa9


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
