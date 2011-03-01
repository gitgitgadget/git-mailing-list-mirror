From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] gitk: ensure quoted tag names in event bindings
Date: Tue, 01 Mar 2011 23:50:50 +0000
Message-ID: <87tyfmqu1x.fsf_-_@fox.patthoyts.tk>
References: <20110227224024.3751.96676.reportbug@pcfelipe.sateler>
	<20110301013841.GC5597@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Felipe Sateler <fsateler@debian.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 00:51:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuZLQ-0007u0-Di
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 00:51:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756749Ab1CAXvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 18:51:01 -0500
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:36985 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756534Ab1CAXvA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Mar 2011 18:51:00 -0500
Received: from [172.23.170.145] (helo=anti-virus03-08)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1PuZLF-00043b-5G; Tue, 01 Mar 2011 23:50:57 +0000
Received: from [77.100.97.230] (helo=fox.patthoyts.tk)
	by asmtp-out6.blueyonder.co.uk with esmtpa (Exim 4.72)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1PuZL9-0004n8-7G; Tue, 01 Mar 2011 23:50:51 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 8C85C21850; Tue,  1 Mar 2011 23:50:50 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <20110301013841.GC5597@elie> (Jonathan Nieder's message of "Mon,
	28 Feb 2011 19:38:41 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168281>

Tag names that contain a % character require quoting when used in event
bindings or the name may be mis-recognised for percent substitution in
the event script.

Reported-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---

Jonathan Nieder <jrnieder@gmail.com> writes:

>Hi,
>
>Felipe Sateler wrote[1]:
>
>> Gitk chokes on tags containing a % character.
>
>Reproduced as follows:
>
>	git tag a%b
>	gitk
>
>and then clicking on the "| a%b >" symbol.
>
>Result:
>
>	can't read "tagids(foo1ar)": no such element in array
>	can't read "tagids(foo1ar)": no such element in array
>	    while executing
>	"set text "[mc "Tag"]: $tag\n[mc "Id"]:  $tagids($tag)""
>	    (procedure "showtag" line 19)
>	    invoked from within
>	"showtag foo1ar 1"
>	    (command bound to event)
>
>It seems that a tag containing a percent sign works okay in
>an expression like $tagids($tag), but not in a quoted expression
>like "$tagids($tag)".
>
>Hints?
>
>Thanks for gitk, of course. :)
>Jonathan
>
>[1] http://bugs.debian.org/615645

 gitk |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index 9cbc09d..6513537 100755
--- a/gitk
+++ b/gitk
@@ -6300,6 +6300,7 @@ proc drawtags {id x xt y1} {
 	       -width $lthickness -fill black -tags tag.$id]
     $canv lower $t
     foreach tag $marks x $xvals wid $wvals {
+	set tag_quoted [string map {% %%} $tag]
 	set xl [expr {$x + $delta}]
 	set xr [expr {$x + $delta + $wid + $lthickness}]
 	set font mainfont
@@ -6308,7 +6309,7 @@ proc drawtags {id x xt y1} {
 	    set t [$canv create polygon $x [expr {$yt + $delta}] $xl $yt \
 		       $xr $yt $xr $yb $xl $yb $x [expr {$yb - $delta}] \
 		       -width 1 -outline black -fill yellow -tags tag.$id]
-	    $canv bind $t <1> [list showtag $tag 1]
+	    $canv bind $t <1> [list showtag $tag_quoted 1]
 	    set rowtextx([rowofcommit $id]) [expr {$xr + $linespc}]
 	} else {
 	    # draw a head or other ref
@@ -6335,9 +6336,9 @@ proc drawtags {id x xt y1} {
 	set t [$canv create text $xl $y1 -anchor w -text $tag -fill $fgcolor \
 		   -font $font -tags [list tag.$id text]]
 	if {$ntags >= 0} {
-	    $canv bind $t <1> [list showtag $tag 1]
+	    $canv bind $t <1> [list showtag $tag_quoted 1]
 	} elseif {$nheads >= 0} {
-	    $canv bind $t $ctxbut [list headmenu %X %Y $id $tag]
+	    $canv bind $t $ctxbut [list headmenu %X %Y $id $tag_quoted]
 	}
     }
     return $xt
-- 
1.7.4.msysgit.0
