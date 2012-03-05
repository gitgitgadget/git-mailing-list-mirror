From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 11/11] update-server-info: respect core.bigfilethreshold
Date: Mon,  5 Mar 2012 10:43:48 +0700
Message-ID: <1330919028-6611-12-git-send-email-pclouds@gmail.com>
References: <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 04:45:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Oro-0004Dh-FY
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 04:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755611Ab2CEDpk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Mar 2012 22:45:40 -0500
Received: from mail-pz0-f52.google.com ([209.85.210.52]:52615 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755096Ab2CEDpj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 22:45:39 -0500
Received: by mail-pz0-f52.google.com with SMTP id p12so4472065dad.11
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 19:45:39 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.136.104 as permitted sender) client-ip=10.68.136.104;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.136.104 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.136.104])
        by 10.68.136.104 with SMTP id pz8mr23438748pbb.127.1330919139208 (num_hops = 1);
        Sun, 04 Mar 2012 19:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=79x2VxiDDLuorMe6MJoLVoSKL6uRT9WoSjYLwviz0rk=;
        b=XCOLBgQJSJwpYmVSC9lYDn0U6I+7nMiRZO/Zgxeg4g9oD0ITGppDHerkVEousu+ySr
         opwT/4jekaCHDrtbApcQjT5/b96qTvgSkvsq1TSZ+YRNiOJO+DcgdKmtAFLJWMl6a4mx
         x/4/ng/gsS4ggxIcb6OoiKZ6ATzH4L/KlVm1Q1bVuPTPDW0CS09lgjEFdj5RZ0dY2HX1
         bihIf2QdPua6sD15Ady72ULvTnRUEZDZbi2BaoVxFxZTL6GC8lsLlqbhAGs4clOykF4C
         Dp54O89fHoMzQ4IKBQRJQvhKgt3rIYcVw94HfxVYAhSPe1O5rHQHm1IOFHVKWG5+F7Jy
         L6mQ==
Received: by 10.68.136.104 with SMTP id pz8mr20521443pbb.127.1330919139156;
        Sun, 04 Mar 2012 19:45:39 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id p9sm12124054pbb.9.2012.03.04.19.45.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Mar 2012 19:45:38 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 05 Mar 2012 10:45:14 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192204>

This command indirectly calls check_sha1_signature() (add_info_ref ->
deref_tag -> parse_object -> ..) , which may put whole blob in memory
if the blob's size is under core.bigfilethreshold. As config is not
read, the threshold is always 512MB. Respect user settings here.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/update-server-info.c |    1 +
 t/t1050-large.sh             |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/update-server-info.c b/builtin/update-server-info.=
c
index b90dce6..0d63c44 100644
--- a/builtin/update-server-info.c
+++ b/builtin/update-server-info.c
@@ -15,6 +15,7 @@ int cmd_update_server_info(int argc, const char **arg=
v, const char *prefix)
 		OPT_END()
 	};
=20
+	git_config(git_default_config, NULL);
 	argc =3D parse_options(argc, argv, prefix, options,
 			     update_server_info_usage, 0);
 	if (argc > 0)
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 5336eb8..9197b89 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -147,7 +147,7 @@ test_expect_success 'fsck' '
 	git fsck --full
 '
=20
-test_expect_failure 'repack' '
+test_expect_success 'repack' '
 	git repack -ad
 '
=20
--=20
1.7.3.1.256.g2539c.dirty
