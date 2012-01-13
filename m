From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 08/10] clone: refuse to clone if --branch points to bogus ref
Date: Fri, 13 Jan 2012 14:22:00 +0700
Message-ID: <1326439322-15648-9-git-send-email-pclouds@gmail.com>
References: <1326189427-20800-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 08:23:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlbU3-0008Bs-FX
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 08:23:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366Ab2AMHX1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jan 2012 02:23:27 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35052 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984Ab2AMHX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 02:23:26 -0500
Received: by mail-iy0-f174.google.com with SMTP id z25so3939442iab.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 23:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YFRJqh3vg4kAGCjnNzItsrwYqpvDItzCC52BFLCG1rY=;
        b=E0KFBR5Z5Yf4rQQkIHC3P/0pU+cUcU/uIwrF5tcG6TT5/+vGANq1uPDFtafggc2z3x
         y07HgHfLKHMJqFulHd3mMXK4q1Orp9X8MHj0yuWlzO3o1+0zlhEVFtqvzboJF5EBmHHt
         eUbq6PlBKZBgjHhwWGsr1XDKurmtoXNcTJ/6c=
Received: by 10.50.170.73 with SMTP id ak9mr4901069igc.17.1326439406214;
        Thu, 12 Jan 2012 23:23:26 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id xu6sm13073087igb.7.2012.01.12.23.23.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Jan 2012 23:23:25 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 13 Jan 2012 14:23:16 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326189427-20800-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188505>

It's possible that users make a typo in the branch name. Stop and let
users recheck. Falling back to remote's HEAD is not documented any
way.

Except when using remote helper, the pack has not been transferred at
this stage yet so we don't waste much bandwidth.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c         |   13 +++++--------
 t/t5706-clone-branch.sh |    8 ++------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 89ba6f0..6a2886a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -474,8 +474,7 @@ static void update_head(const struct ref *our, cons=
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
@@ -771,12 +770,10 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
 				find_ref_by_name(mapped_refs, head.buf);
 			strbuf_release(&head);
=20
-			if (!our_head_points_at) {
-				warning(_("Remote branch %s not found in "
-					"upstream %s, using HEAD instead"),
-					option_branch, option_origin);
-				our_head_points_at =3D remote_head_points_at;
-			}
+			if (!our_head_points_at)
+				die(_("Remote branch %s not found in "
+				      "upstream %s, using HEAD instead"),
+				    option_branch, option_origin);
 		}
 		else
 			our_head_points_at =3D remote_head_points_at;
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
