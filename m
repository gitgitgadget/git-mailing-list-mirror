From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] Re: Gitk --all error when there are more than 797 refs in a repository
Date: 18 Sep 2009 15:06:17 +0100
Message-ID: <878wgcbb52.fsf@users.sourceforge.net>
References: <6F87406399731F489FBACE5C5FFA04584BFA53@ex2k.bankofamerica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Murphy, John" <john.murphy@bankofamerica.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 16:06:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Moe6X-00062J-Iz
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 16:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756808AbZIROGT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Sep 2009 10:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756669AbZIROGT
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 10:06:19 -0400
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:47024 "EHLO
	smtp-out2.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756123AbZIROGS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 10:06:18 -0400
Received: from [172.23.170.140] (helo=anti-virus02-07)
	by smtp-out2.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Moe6O-0002Re-Fn; Fri, 18 Sep 2009 15:06:20 +0100
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out1.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1Moe6N-0001d7-KA; Fri, 18 Sep 2009 15:06:19 +0100
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 0197251843; Fri, 18 Sep 2009 15:06:18 +0100 (BST)
Cc: "Paul Mackerras" <paulus@samba.org>
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <6F87406399731F489FBACE5C5FFA04584BFA53@ex2k.bankofamerica.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128798>

"Murphy, John" <john.murphy@bankofamerica.com> writes:

>There is a error when running =A0gitk --all when there are more than 7=
97 refs in a repository.
>We get an error message:
>
>Error reading commits: fatal ambiguous argument '3': unknown revision =
or path not in the working tree.
>Use '--' to separate paths from revisions.
>
>I believe issue is with this line of the code in proc parseviewrevs:
>
>       if {[catch {set ids [eval exec git rev-parse "$revs"]} err]}
>
>When there are more than 797 refs the output of git rev-parse is too l=
arge to fit into the string, ids.
>
>797 refs =3D 32,677 bytes.
>798 refs =3D 32,718 bytes my guess is a little too close for comfort t=
o 32,768 bytes.
>
>As I was deleting refs locally the error message would change from '3'=
 to any char [A-Z,0-9].
>
>I am a novice tcl programmer but is seems like ids could be an array.
>There are also many other areas in the code where git rev-parse is cal=
led and using array may also be necessary.
>

Tcl strings can eat all your memory. However, there is a limit to the
size of the command line argument passed to CreateProcess.  MSDN says
of the lpCommandLine parameter:
  "The maximum length of this string is 32K characters."
A solution for this case will be to use a pipe to read the responses
instead of having it all returned to the caller.
The following patch might be sufficient:

--- patch begins -----

[PATCH] Avoid command-line limits when executing git rev-parse on windo=
ws.

This patch solves the problem handling large numbers of references
reported by John Murphy that is due to limits in executing processes
in Windows by reading the rev-parse result over a pipe.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 gitk |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 1306178..1bd7d65 100755
--- a/gitk
+++ b/gitk
@@ -236,13 +236,23 @@ proc parseviewargs {n arglist} {
     return $allknown
 }
=20
+proc git-rev-parse {args} {
+    set ids {}
+    set pipe [open |[linsert $args 0 git rev-parse] r]
+    while {[gets $pipe line] !=3D -1} {
+        lappend ids $line
+    }
+    close $pipe
+    return $ids
+}
+   =20
 proc parseviewrevs {view revs} {
     global vposids vnegids
=20
     if {$revs eq {}} {
 	set revs HEAD
     }
-    if {[catch {set ids [eval exec git rev-parse $revs]} err]} {
+    if {[catch {set ids [git-rev-parse $revs]} err]} {
 	# we get stdout followed by stderr in $err
 	# for an unknown rev, git rev-parse echoes it and then errors out
 	set errlines [split $err "\n"]
@@ -273,7 +283,7 @@ proc parseviewrevs {view revs} {
     set pos {}
     set neg {}
     set sdm 0
-    foreach id [split $ids "\n"] {
+    foreach id $ids {
 	if {$id eq "--gitk-symmetric-diff-marker"} {
 	    set sdm 4
 	} elseif {[string match "^*" $id]} {
--=20
1.6.4.msysgit.0



--=20
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
