From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Bugs with detection of renames that are also overwrites
Date: Sat, 13 Feb 2010 18:46:55 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1002131820150.14055@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 14 00:52:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgRmU-00085a-IG
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 00:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758223Ab0BMXwB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Feb 2010 18:52:01 -0500
Received: from DMZ-MAILSEC-SCANNER-4.MIT.EDU ([18.9.25.15]:60167 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758065Ab0BMXv7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 18:51:59 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Feb 2010 18:51:59 EST
X-AuditID: 1209190f-b7bbfae0000035e9-d3-4b7739f27506
Received: from mailhub-auth-2.mit.edu (MAILHUB-AUTH-2.MIT.EDU [18.7.62.36])
	by dmz-mailsec-scanner-4.mit.edu (Symantec Brightmail Gateway) with SMTP id 63.70.13801.2F9377B4; Sat, 13 Feb 2010 18:46:58 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id o1DNkvTq028025
	for <git@vger.kernel.org>; Sat, 13 Feb 2010 18:46:58 -0500
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o1DNlGNu003092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Sat, 13 Feb 2010 18:47:18 -0500 (EST)
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139870>

One can create a rename that also overwrites an existing file, for exam=
ple=20
with =E2=80=98git mv -f=E2=80=99:

$ git init
$ seq 100 200 > a; seq 300 400 > b; git add a b
$ git commit -m foo; git tag foo
$ git mv -f a b
$ git commit -m bar; git tag bar

Git does not ordinarily detect this as a rename, even with -M.

$ git diff --stat -M foo bar
 a |  101 ----------------------------------
 b |  202 ++++++++++++++++++++++++++++++++++---------------------------=
-------
 2 files changed, 101 insertions(+), 202 deletions(-)

But it can (sometimes*) be forced to detect the rename with -M -B. =20

$ git diff --stat -M -B foo bar
 a =3D> b |    0
 1 files changed, 0 insertions(+), 0 deletions(-)

However, the resulting patch incorrectly omits the deletion of the=20
overwritten file!

$ git diff -M -B foo bar
diff --git a/a b/b
similarity index 100%
rename from a
rename to b

Therefore, the patch can=E2=80=99t be applied to its own source tree.

$ git checkout foo
$ git diff -M -B foo bar | git apply
error: b: already exists in working directory
$ git format-patch --stdout -M -B foo..bar | git am
Applying: bar
error: b: already exists in index
Patch failed at 0001 bar
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".

If it matters, I=E2=80=99m using Git 1.7.0.

Also, a question: is it possible to get =E2=80=98git merge=E2=80=99 to =
recognize this=20
rename?

Anders

(* I say =E2=80=9Csometimes=E2=80=9D because -B only detects the rewrit=
e if it deems the=20
renamed file to be sufficiently different than the overwritten file.  I=
f=20
you use 190 and 390 instead of 200 and 400 above, the rewrite and renam=
e=20
will not be detected, even though the rename would be detected if it wa=
s=20
not an overwrite.  This also feels like a bug.)
