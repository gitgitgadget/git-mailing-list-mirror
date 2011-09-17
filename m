From: Jeff Epler <jepler@unpythonic.net>
Subject: [RFC/PATCH] Configurable hyperlinking in gitk
Date: Fri, 16 Sep 2011 21:29:03 -0500
Message-ID: <20110917022903.GA2445@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 17 04:37:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4kmZ-0005pe-Ay
	for gcvg-git-2@lo.gmane.org; Sat, 17 Sep 2011 04:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776Ab1IQChV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 22:37:21 -0400
Received: from dsl.unpythonic.net ([206.222.212.217]:36557 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752424Ab1IQChV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 22:37:21 -0400
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Sep 2011 22:37:20 EDT
Received: by unpythonic.net (Postfix, from userid 1000)
	id AB8FC114953; Fri, 16 Sep 2011 21:29:03 -0500 (CDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181569>

Many projects use project-specific notations in comments to refer to
bug trackers and the like.  One example is the "Closes: #nnnnn"
notation used in Debian.

Make gitk configurable so that arbitrary strings can be turned into
clickable links that are opened in a web browser.
---
Some time ago I hardcoded this into gitk for $DAY_JOB and find it very
useful.  I made it configurable in the hopes that it might be adopted
upstream. (unfortunately, the configurable version is radically
different from the original hard-coded version, so I can't say this
has had much testing yet)

The definition of the allowed regular expression in the docs
probably needs some refinement.  Basically, they have to also be REs
that can be concatenated with the "|" character, which is not true
of REs that begin with the *** flavor selector (which I had not
heard of before rereading `man re_syntax` just now) or (?xyz)
embedded options.  Or maybe there's an efficient alternate approach
to scanning for the next non-overlapping match among several
patterns that doesn't involve concatenating the patterns.

I'm not sure about the "one line" restriction; at first I thought
that everything was fed to 'appendwithlinks' in arbitrary chunks,
but not I see that they are mostly logical chunks (and probably only
the comment, not the headers or commit descriptors, will have
anything to linkify).  The problem again seems to be how to succinctly
describe what is permitted.

There are probably better names for the configuration options, too.

Suggestions?  Problems?  Successes?

Jeff


 Documentation/config.txt |   31 ++++++++++++++++++-
 gitk-git/gitk            |   74 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 102 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 750c86d..67ed436 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1102,6 +1102,33 @@ All gitcvs variables except for 'gitcvs.usecrlfattr' and
 is one of "ext" and "pserver") to make them apply only for the given
 access method.
 
+gitk.linkify.<name>.re::
+	Specify a Tcl regular expression (which may not span lines)
+	defining a class of strings to automatically convert to hyperlinks.
+	You must also specify 'gitk.linkify.<name>.sub'.
+
+gitk.linkify.<name>.sub::
+	Specify a substitution that results in the target URL for the
+	related regular expression.  Back-references like '\1' refer
+	to capturing groups in the associated regular expression.
+	You must also specify 'gitk.linkify.<name>.re'.
+
+gitk.browser::
+	Specify the browser that will be used to display the linked
+	web page.
+
+For example, to automatically link from Debian-style "Closes: #nnnn"
+message to the Debian BTS,
+
+--------
+    git config gitk.linkify.debian-bts.re 'Closes: #(\d+)'
+    git config gitk.linkify.debian-bts.sub 'http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=\1'
+--------
+
+Regular expressions are as described in re_syntax(n).  Replacements
+are as described in regsub(n).  If multiple regular expressions match at
+the same location, it is undefined which match is used.
+
 grep.lineNumber::
 	If set to true, enable '-n' option by default.
 
@@ -1901,5 +1928,5 @@ user.signingkey::
 
 web.browser::
 	Specify a web browser that may be used by some commands.
-	Currently only linkgit:git-instaweb[1] and linkgit:git-help[1]
-	may use it.
+	Currently only linkgit:git-instaweb[1], linkgit:gitk[1],
+	and linkgit:git-help[1] may use it.
diff --git a/gitk-git/gitk b/gitk-git/gitk
index 4cde0c4..a21eea1 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -6684,7 +6684,7 @@ proc commit_descriptor {p} {
 # append some text to the ctext widget, and make any SHA1 ID
 # that we know about be a clickable link.
 proc appendwithlinks {text tags} {
-    global ctext linknum curview
+    global ctext linknum curview linkmakers
 
     set start [$ctext index "end - 1c"]
     $ctext insert end $text $tags
@@ -6699,6 +6699,30 @@ proc appendwithlinks {text tags} {
 	setlink $linkid link$linknum
 	incr linknum
     }
+
+    if {$linkmakers == {}} return
+
+    set link_re {}
+    foreach {re rep} $linkmakers { lappend link_re $re }
+    set link_re "([join $link_re {)|(}])"
+
+    set ee 0
+    while {[regexp -indices -start $ee -- $link_re $text l]} {
+	set s [lindex $l 0]
+	set e [lindex $l 1]
+	set linktext [string range $text $s $e]
+	incr e
+	set ee $e
+
+	foreach {re rep} $linkmakers {
+	    if {![regsub $re $linktext $rep linkurl]} continue
+	    $ctext tag delete link$linknum
+	    $ctext tag add link$linknum "$start + $s c" "$start + $e c"
+	    seturllink $linkurl link$linknum
+	    incr linknum
+	    break
+	}
+    }
 }
 
 proc setlink {id lk} {
@@ -6726,6 +6750,52 @@ proc setlink {id lk} {
     }
 }
 
+proc get_link_config {} {
+    if {[catch {exec git config -z --get-regexp {^gitk\.linkify\.}} linkers]} {
+	return {}
+    }
+
+    set linktypes [list]
+    foreach item [split $linkers "\0"] {
+	if {$item == ""} continue
+	if {![regexp {gitk\.linkify\.(\S+)\.(re|sub)\s(.*)} $item _ k t v]} {
+	    continue
+	}
+	set linkconfig($t,$k) $v
+	if {$t == "re"} { lappend linktypes $k }
+    }
+
+    set linkmakers [list]
+    foreach k $linktypes {
+	if {![info exists linkconfig(sub,$k)]} {
+	    puts stderr "Warning: link `$k' is missing a substitution string"
+	} elseif {[catch {regexp -inline -- $linkconfig(re,$k) ""} err]} {
+	    puts stderr "Warning: link `$k': $err"
+	} else {
+	    lappend linkmakers $linkconfig(re,$k) $linkconfig(sub,$k)
+	}
+	unset linkconfig(re,$k)
+	unset -nocomplain linkconfig(sub,$k)
+    }
+    foreach k [array names linkconfig] {
+	regexp "sub,(.*)" $k _ k
+	puts stderr "Warning: link `$k' is missing a regular expression"
+    }
+    set linkmakers
+}
+
+proc openlink {url} {
+    exec git web--browse --config=gitk.browser $url &
+}
+
+proc seturllink {url lk} {
+    global ctext
+    $ctext tag conf $lk -foreground blue -underline 1
+    $ctext tag bind $lk <1> [list openlink $url]
+    $ctext tag bind $lk <Enter> {linkcursor %W 1}
+    $ctext tag bind $lk <Leave> {linkcursor %W -1}
+}
+
 proc appendshortlink {id {pre {}} {post {}}} {
     global ctext linknum
 
@@ -11693,6 +11763,8 @@ if {[tk windowingsystem] eq "win32"} {
     focus -force .
 }
 
+set linkmakers [get_link_config]
+
 getcommits {}
 
 # Local variables:
-- 
1.7.0.4
