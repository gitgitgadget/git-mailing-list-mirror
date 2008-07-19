From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
 to "rebase-merge"
Date: Sat, 19 Jul 2008 20:40:11 +0200
Message-ID: <4882350B.6020003@free.fr>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com> <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx> <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness> <20080716012619.GM8185@mit.edu> <7viqv5r637.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theodore Tso <tytso@mit.edu>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Stephan Beyer <s-beyer@gmx.net>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 20:41:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKHMx-0006Ty-Fa
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 20:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478AbYGSSkS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jul 2008 14:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755204AbYGSSkQ
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 14:40:16 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:52482 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754263AbYGSSkO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 14:40:14 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 29EFE12B6D1;
	Sat, 19 Jul 2008 20:40:13 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 54AD012B6D0;
	Sat, 19 Jul 2008 20:40:12 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <7viqv5r637.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89125>

Junio C Hamano a =E9crit :
> Theodore Tso <tytso@mit.edu> writes:
>=20
>> While you have "git am" open, how about adding an "git am --abort"
>> which nukes the .dotest aka .git/rebase directory, and resets HEAD
>> back to the original position?
>=20
> This does not seem to have reached the list nor its archives.  I cann=
ot
> say I have really looked at it deeply but it may be a good starting
> point.  It needs docs ;-)

This can be squashed to Nanako's path: it adds missing docs,
'git rerere clear' and move $dotest deletion at the end in case
'git read-tree' failed (because of a dirty index).

Olivier.

-- >8 --
Subject: [PATCH] git am --abort

To squash.

Signed-off-by: Olivier Marin <dkr@freesurf.fr>
---
 Documentation/git-am.txt |    5 ++++-
 git-am.sh                |    8 +++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 2d7f162..e010a16 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -13,7 +13,7 @@ SYNOPSIS
          [--3way] [--interactive] [--binary]
          [--whitespace=3D<option>] [-C<n>] [-p<n>]
 	 [<mbox> | <Maildir>...]
-'git am' (--skip | --resolved)
+'git am' (--skip | --resolved | --abort)
=20
 DESCRIPTION
 -----------
@@ -99,6 +99,9 @@ default.   You could use `--no-utf8` to override this=
=2E
 	or `--skip` to handle the failure.  This is solely
 	for internal use between 'git-rebase' and 'git-am'.
=20
+--abort::
+	Restore the original branch and abort the patching operation.
+
 DISCUSSION
 ----------
=20
diff --git a/git-am.sh b/git-am.sh
index 5e645e4..04b2e96 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -22,7 +22,7 @@ p=3D              pass it through git-apply
 resolvemsg=3D     override error message when patch failure occurs
 r,resolved      to be used after a patch failure
 skip            skip the current patch
-abort           abandon patch application and clear .dotest directory
+abort           restore the original branch and abort the patching ope=
ration.
 rebasing        (internal use for git-rebase)"
=20
 . git-sh-setup
@@ -55,6 +55,7 @@ stop_here_user_resolve () {
     fi
     echo "When you have resolved this problem run \"$cmdline --resolve=
d\"."
     echo "If you would prefer to skip this patch, instead run \"$cmdli=
ne --skip\"."
+    echo "To restore the original branch and stop patching run \"$cmdl=
ine --abort\"."
=20
     stop_here $1
 }
@@ -203,9 +204,10 @@ then
=20
 	case "$abort" in
 	t)
-		rm -fr "$dotest" &&
+		git rerere clear &&
 		git read-tree -m -u ORIG_HEAD &&
-		git reset ORIG_HEAD && :
+		git reset ORIG_HEAD &&
+		rm -fr "$dotest"
 		exit ;;
 	esac
 else
--=20
1.5.6.3.441.g3087
