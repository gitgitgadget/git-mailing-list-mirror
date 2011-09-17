From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: [RFC/PATCH] Configurable hyperlinking in gitk
Date: Sat, 17 Sep 2011 08:45:28 -0500
Message-ID: <20110917134527.GA28463@unpythonic.net>
References: <20110917022903.GA2445@unpythonic.net>
 <4E7467B7.1090201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 17 15:46:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4vDa-00058T-0i
	for gcvg-git-2@lo.gmane.org; Sat, 17 Sep 2011 15:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737Ab1IQNpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Sep 2011 09:45:33 -0400
Received: from dsl.unpythonic.net ([206.222.212.217]:50080 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751204Ab1IQNpc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2011 09:45:32 -0400
Received: by unpythonic.net (Postfix, from userid 1000)
	id 6E238114953; Sat, 17 Sep 2011 08:45:28 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <4E7467B7.1090201@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181582>

> > There are probably better names for the configuration options, too.
> 
> It'd be nice if the config variables weren't gitk specific. .re and .sub
> could be applied to gitweb and maybe other git viewers outside of
> gig.git might decide to use them. My bikeshedding suggestion would be to
> just drop the gitk prefix and have linkify.re and linkify.sub.

This seems like a reasonable idea, though since the implementation
languages of gitk and gitweb are different it means some REs might get
different interpretations in the different programs.

> Sometimes when a commit fixes multiple bugs we put all the bug numbers
> in separated by commas. I don't know Tcl well enough to tell if your
> code supports that or not.

Multiple matches per line are OK, but they must be non-overlapping.

Looking at the actual practice in Debian changelogs, I see that they do
this:
    evince/changelog.Debian.gz:        (Closes: #388368, #396467, #405130)
so my original example would only linkify "Closes: #388638".  But a
revised pattern of #(\d+) would linkify "#388368", "#396467" and "#405130".
(but risk a few more "false positive" links).  I should revise my
example accordingly.

As for the problems with your substitutions, "&" is special in a tcl
regsub (it stands for the whole matched string, like \0), so you'd want
to use a substitution like
    git config gitk.linkify.debian-bts.sub \
        'http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=\1\&foo=bar'
The problem with "%" has to do with Tk's event substitution and it's a
bug that this happens; I should manually double the % at the proper
point.

This revised patch fixes the problem with % in substitutions and changes
the suggested RE for matching debian bts items, but it does not rename
the configuration options.

-- >8 --
Many projects use project-specific notations in changelogs to refer
to bug trackers and the like.  One example is the "Closes: #12345"
notation used in Debian.

Make gitk configurable so that arbitrary strings can be turned into
clickable links that are opened in a web browser.
---
 Documentation/config.txt |   31 ++++++++++++++++++-
 gitk-git/gitk            |   75 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ae9913b..13e8aa6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1064,6 +1064,33 @@ All gitcvs variables except for 'gitcvs.usecrlfattr' and
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
+    git config gitk.linkify.debian-bts.re '#(\d+)\M'
+    git config gitk.linkify.debian-bts.sub 'http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=\1'
+--------
+
+Regular expressions are as described in re_syntax(n).  Replacements
+are as described in regsub(n).  If multiple regular expressions match at
+the same location, it is undefined which match is used.
+
 grep.lineNumber::
 	If set to true, enable '-n' option by default.
 
@@ -1870,5 +1897,5 @@ user.signingkey::
 
 web.browser::
 	Specify a web browser that may be used by some commands.
-	Currently only linkgit:git-instaweb[1] and linkgit:git-help[1]
-	may use it.
+	Currently only linkgit:git-instaweb[1], linkgit:gitk[1],
+	and linkgit:git-help[1] may use it.
diff --git a/gitk-git/gitk b/gitk-git/gitk
index 4cde0c4..5532869 100755
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
@@ -6726,6 +6750,53 @@ proc setlink {id lk} {
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
+    set qurl [string map {% %%} $url]
+    global ctext
+    $ctext tag conf $lk -foreground blue -underline 1
+    $ctext tag bind $lk <1> [list openlink $qurl]
+    $ctext tag bind $lk <Enter> {linkcursor %W 1}
+    $ctext tag bind $lk <Leave> {linkcursor %W -1}
+}
+
 proc appendshortlink {id {pre {}} {post {}}} {
     global ctext linknum
 
@@ -11693,6 +11764,8 @@ if {[tk windowingsystem] eq "win32"} {
     focus -force .
 }
 
+set linkmakers [get_link_config]
+
 getcommits {}
 
 # Local variables:
-- 
1.7.2.5
