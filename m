From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] add: lift the pathspec magic restriction on "add -p"
Date: Thu,  5 Sep 2013 10:40:39 +0700
Message-ID: <1378352440-25410-2-git-send-email-pclouds@gmail.com>
References: <1378352440-25410-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 05:37:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHQOA-0007ds-JB
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 05:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005Ab3IEDhm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Sep 2013 23:37:42 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:54866 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884Ab3IEDhl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 23:37:41 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so1209900pbc.16
        for <git@vger.kernel.org>; Wed, 04 Sep 2013 20:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=iOzLLbbLhNc+s2bYh+Z0obKKA2UfR7ZInsO5oubM+pc=;
        b=rXdjRrDJY6/KGWbX5IuMPTODUCxE/nalKjg/QA/Ks43lCssiKSgIj8kZ3ZJgPbkZWS
         kvGFh3cJ+m154ZPVLhZ0Q3bIjqSFeYNMqKKTveF+GHQgQ1pctZGNKghgCSNK/Rf3f/U4
         5r7ok/trRyrSQFMsXjg5zH+UFUqw06kUKQDrrNAo5aymfxJ3ddUGMEym1zq3WrXE6FBU
         3xHCJqY/zXyu8VATCuUb0wZf9dIUclToFaYizd93MCOt4ETNstD41LCdUfmxfgzOn9xX
         R5vVeoAIaP7VihkAxMma6IgFTQ63IG1DNzWQnIq8WYQbUA7J3tQ1oUYFgj2SZeSuGaiz
         CyQw==
X-Received: by 10.66.182.229 with SMTP id eh5mr6824343pac.139.1378352261019;
        Wed, 04 Sep 2013 20:37:41 -0700 (PDT)
Received: from lanh ([115.73.237.243])
        by mx.google.com with ESMTPSA id xn12sm34552922pac.12.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 04 Sep 2013 20:37:40 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Sep 2013 10:40:48 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378352440-25410-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233886>

Since 480ca64 (convert run_add_interactive to use struct pathspec -
2013-07-14), we have unconditionally passed :(prefix)xxx to
add-interactive.perl. It implies that all commands
add-interactive.perl calls must be aware of pathspec magic, or
:(prefix) is barfed. The restriction to :/ only becomes unnecessary.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c      | 8 +-------
 builtin/checkout.c | 7 -------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 9d52fc7..b4035f6 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -270,13 +270,7 @@ int interactive_add(int argc, const char **argv, c=
onst char *prefix, int patch)
 {
 	struct pathspec pathspec;
=20
-	/*
-	 * git-add--interactive itself does not parse pathspec. It
-	 * simply passes the pathspec to other builtin commands. Let's
-	 * hope all of them support all magic, or we'll need to limit
-	 * the magic here.
-	 */
-	parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP,
+	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_FULL |
 		       PATHSPEC_SYMLINK_LEADING_PATH |
 		       PATHSPEC_PREFIX_ORIGIN,
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7ea1100..b235e04 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1149,13 +1149,6 @@ int cmd_checkout(int argc, const char **argv, co=
nst char *prefix)
 	}
=20
 	if (argc) {
-		/*
-		 * In patch mode (opts.patch_mode !=3D 0), we pass the
-		 * pathspec to an external program, git-add--interactive.
-		 * Do not accept any kind of magic that that program
-		 * cannot handle. Magic mask is pretty safe to be
-		 * lifted for new magic when opts.patch_mode =3D=3D 0.
-		 */
 		parse_pathspec(&opts.pathspec, 0,
 			       opts.patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0,
 			       prefix, argv);
--=20
1.8.2.83.gc99314b
