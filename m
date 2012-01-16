From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 08/10] clone: refuse to clone if --branch points to bogus ref
Date: Mon, 16 Jan 2012 16:46:14 +0700
Message-ID: <1326707176-8045-9-git-send-email-pclouds@gmail.com>
References: <1326439322-15648-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 10:47:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmjA9-00033K-JS
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 10:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918Ab2APJrd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jan 2012 04:47:33 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55465 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801Ab2APJrc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 04:47:32 -0500
Received: by mail-iy0-f174.google.com with SMTP id f6so2315494iag.19
        for <git@vger.kernel.org>; Mon, 16 Jan 2012 01:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mJKGjLd8iAiOIXQMGOzR3ax3WSkhhzaF86wyHAUhqzU=;
        b=jJ/dphtph79txWmyHUSrpJrWHcK6ErwMCgAzhBf/pnvR0qmsaV5Izev9ULYLyH6qBE
         FqOXNqZtV7X6Dn6m5lrZaG6aJoE9OVt0ZAJpXeCBaEtLxCjw3E12MbtrzdbN4R7fVB8e
         4olMX+6eUd1FKN7r7yw+I/dfQhKmr0ZWqC+g4=
Received: by 10.50.184.168 with SMTP id ev8mr2376437igc.29.1326707252292;
        Mon, 16 Jan 2012 01:47:32 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id cv10sm24327129igc.0.2012.01.16.01.47.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Jan 2012 01:47:31 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Jan 2012 16:47:22 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326439322-15648-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188623>

It's possible that users make a typo in the branch name. Stop and let
users recheck. Falling back to remote's HEAD is not documented any
way.

Except when using remote helper, the pack has not been transferred at
this stage yet so we don't waste much bandwidth.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c         |   12 ++++--------
 t/t5500-fetch-pack.sh   |    7 -------
 t/t5706-clone-branch.sh |    8 ++------
 3 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 253a794..3cfedb3 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -518,8 +518,7 @@ static void update_head(const struct ref *our, cons=
t struct ref *remote,
 	} else if (remote) {
 		/*
 		 * We know remote HEAD points to a non-branch, or
-		 * HEAD points to a branch but we don't know which one, or
-		 * we asked for a specific branch but it did not exist.
+		 * HEAD points to a branch but we don't know which one.
 		 * Detach HEAD in all these cases.
 		 */
 		update_ref(msg, "HEAD", remote->old_sha1,
@@ -816,12 +815,9 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 			our_head_points_at =3D
 				find_remote_branch(mapped_refs, option_branch);
=20
-			if (!our_head_points_at) {
-				warning(_("Remote branch %s not found in "
-					"upstream %s, using HEAD instead"),
-					option_branch, option_origin);
-				our_head_points_at =3D remote_head_points_at;
-			}
+			if (!our_head_points_at)
+				die(_("Remote branch %s not found in upstream %s"),
+				    option_branch, option_origin);
 		}
 		else
 			our_head_points_at =3D remote_head_points_at;
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 7e85c71..5237066 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -282,13 +282,6 @@ test_expect_success 'clone shallow object count' '
 	test_cmp count3.expected count3.actual
 '
=20
-test_expect_success 'clone shallow with nonexistent --branch' '
-	git clone --depth 1 --branch Z "file://$(pwd)/." shallow4 &&
-	GIT_DIR=3Dshallow4/.git git rev-parse HEAD >actual &&
-	git rev-parse HEAD >expected &&
-	test_cmp expected actual
-'
-
 test_expect_success 'clone shallow with detached HEAD' '
 	git checkout HEAD^ &&
 	git clone --depth 1 "file://$(pwd)/." shallow5 &&
diff --git a/t/t5706-clone-branch.sh b/t/t5706-clone-branch.sh
index f3f9a76..56be67e 100755
--- a/t/t5706-clone-branch.sh
+++ b/t/t5706-clone-branch.sh
@@ -57,12 +57,8 @@ test_expect_success 'clone -b does not munge remotes=
/origin/HEAD' '
 	)
 '
=20
-test_expect_success 'clone -b with bogus branch chooses HEAD' '
-	git clone -b bogus parent clone-bogus &&
-	(cd clone-bogus &&
-	 check_HEAD master &&
-	 check_file one
-	)
+test_expect_success 'clone -b with bogus branch' '
+	test_must_fail git clone -b bogus parent clone-bogus
 '
=20
 test_done
--=20
1.7.3.1.256.g2539c.dirty
