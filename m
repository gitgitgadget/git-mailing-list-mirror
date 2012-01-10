From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 08/10] clone: refuse to clone if --branch points to bogus ref
Date: Tue, 10 Jan 2012 16:57:05 +0700
Message-ID: <1326189427-20800-9-git-send-email-pclouds@gmail.com>
References: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 10:58:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkYTV-0005ek-GF
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 10:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755928Ab2AJJ6c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 04:58:32 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48718 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755672Ab2AJJ6b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 04:58:31 -0500
Received: by mail-iy0-f174.google.com with SMTP id z25so664914iab.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 01:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PLGgFurvJ+WgquikUKUytSycSYH9vxpDWRy/g3Smi3c=;
        b=KJ+3ZOxXvyqNwCawbT9SdvWf1d93majvFaE5MHWm/U39bL95tzWKPFBmBnLij23Ydq
         gRGUQxA0SYVhE8vQQRETNTNdoavjQgCBuUQU40sIBqpFTuhhl2aP+uajjBgJKfYVTwby
         ZopDyxk+CAcBQl63dOo5EgYruWvV4ZRRbn5hw=
Received: by 10.50.168.4 with SMTP id zs4mr1775775igb.28.1326189511453;
        Tue, 10 Jan 2012 01:58:31 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id py9sm128084170igc.2.2012.01.10.01.58.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 01:58:30 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 10 Jan 2012 16:58:23 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188240>

It's possible that users make a typo in the branch name. Stop and let
users recheck. Falling back to remote's HEAD is not documented any
way.

Except when using remote helper, the pack has not been transferred at
this stage yet so we don't waste much bandwidth.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c         |   10 ++++------
 t/t5706-clone-branch.sh |    8 ++------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 960242f..f751997 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -766,12 +766,10 @@ int cmd_clone(int argc, const char **argv, const =
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
