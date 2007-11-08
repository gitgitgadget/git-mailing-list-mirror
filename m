From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Port git commit to C.
Date: Fri, 9 Nov 2007 00:27:52 +0100
Message-ID: <20071108232751.GC4899@steel.home>
References: <1194541140-3062-1-git-send-email-krh@redhat.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Kristian =?iso-8859-15?Q?H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 00:35:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqGso-00081H-14
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 00:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762443AbXKHX1z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2007 18:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762438AbXKHX1z
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 18:27:55 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:41715 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762420AbXKHX1y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 18:27:54 -0500
Received: from tigra.home (Fc819.f.strato-dslnet.de [195.4.200.25])
	by post.webmailer.de (mrclete mo44) (RZmta 14.0)
	with ESMTP id j02716jA8IdP8s ; Fri, 9 Nov 2007 00:27:52 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id ADE9D277AE;
	Fri,  9 Nov 2007 00:27:52 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 4BABE56D22; Fri,  9 Nov 2007 00:27:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1194541140-3062-1-git-send-email-krh@redhat.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWowxOg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64087>

Kristian H=F8gsberg, Thu, Nov 08, 2007 17:59:00 +0100:
> This makes git commit a builtin and moves git-commit.sh to
> contrib/examples.  This also removes the git-runstatus
> helper, which was mostly just a git-status.sh implementation detail.

Applied instead of 00c8febf563da on Junio's pu it breaks t1400:

* expecting success: echo TEST >F &&
     git add F &&
         GIT_AUTHOR_DATE=3D"2005-05-26 23:30" \
         GIT_COMMITTER_DATE=3D"2005-05-26 23:30" git-commit -m add -a &=
&
         h_TEST=3D$(git rev-parse --verify HEAD)
         echo The other day this did not work. >M &&
         echo And then Bob told me how to fix it. >>M &&
         echo OTHER >F &&
         GIT_AUTHOR_DATE=3D"2005-05-26 23:41" \
         GIT_COMMITTER_DATE=3D"2005-05-26 23:41" git-commit -F M -a &&
         h_OTHER=3D$(git rev-parse --verify HEAD) &&
         GIT_AUTHOR_DATE=3D"2005-05-26 23:44" \
         GIT_COMMITTER_DATE=3D"2005-05-26 23:44" git-commit --amend &&
         h_FIXED=3D$(git rev-parse --verify HEAD) &&
         echo Merged initial commit and a later commit. >M &&
         echo $h_TEST >.git/MERGE_HEAD &&
         GIT_AUTHOR_DATE=3D"2005-05-26 23:45" \
         GIT_COMMITTER_DATE=3D"2005-05-26 23:45" git-commit -F M &&
         h_MERGED=3D$(git rev-parse --verify HEAD)
         rm -f M
Created initial commit 2bc82dd: add
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 F
Created commit d244b72: The other day this did not work.
 1 files changed, 1 insertions(+), 1 deletions(-)
launching editor, log (null)
fatal: * no commit message?  aborting commit.
*   ok 28: creating initial files

* expecting success: diff expect .git/logs/refs/heads/master
3,4d2
< d244b725ca2c5f8aaacd9df2468b890499380862  C O Mitter <committer@examp=
le.com> 1117151040 +0000 commit (amend): The other day this did not wor=
k.
<   C O Mitter <committer@example.com> 1117151100 +0000 commit (merge):=
 Merged initial commit and a later commit.
* FAIL 29: git-commit logged updates
        diff expect .git/logs/refs/heads/master


Which is not the test actually failed. The failed one is 28, but the
last "rm -f M" killed the error because of missed "&&" before it.

I believe you need something like this to fix the test:

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index ce045b2..a90824b 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -205,7 +205,7 @@ test_expect_success \
 	 echo $h_TEST >.git/MERGE_HEAD &&
 	 GIT_AUTHOR_DATE=3D"2005-05-26 23:45" \
 	 GIT_COMMITTER_DATE=3D"2005-05-26 23:45" git-commit -F M &&
-	 h_MERGED=3D$(git rev-parse --verify HEAD)
+	 h_MERGED=3D$(git rev-parse --verify HEAD) &&
 	 rm -f M'
=20
 cat >expect <<EOF

and something like this to refill the strbuf of commit message with
the text read from the amended commit (the failed test was a
"git commit --amend"). The patch is on top of yours "Export
launch_editor() and make it accept ':' as a no-op editor":

diff --git a/builtin-tag.c b/builtin-tag.c
index c3b76da..8ca9ffb 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -42,17 +42,17 @@ void launch_editor(const char *path, struct strbuf =
*buffer)
 	if (!editor)
 		editor =3D "vi";
=20
-	if (!strcmp(editor, ":"))
-		return;
-
-	memset(&child, 0, sizeof(child));
-	child.argv =3D args;
-	args[0] =3D editor;
-	args[1] =3D path;
-	args[2] =3D NULL;
-
-	if (run_command(&child))
-		die("There was a problem with the editor %s.", editor);
+	if (strcmp(editor, ":"))
+	{
+		memset(&child, 0, sizeof(child));
+		child.argv =3D args;
+		args[0] =3D editor;
+		args[1] =3D path;
+		args[2] =3D NULL;
+
+		if (run_command(&child))
+			die("There was a problem with the editor %s.", editor);
+	}
=20
 	if (strbuf_read_file(buffer, path, 0) < 0)
 		die("could not read message file '%s': %s",
