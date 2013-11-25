From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 03/28] clone: prevent --reference to a shallow repository
Date: Mon, 25 Nov 2013 10:55:29 +0700
Message-ID: <1385351754-9954-4-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 04:52:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VknDL-0001fT-Sl
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 04:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188Ab3KYDvz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 22:51:55 -0500
Received: from mail-pb0-f47.google.com ([209.85.160.47]:40899 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914Ab3KYDvq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 22:51:46 -0500
Received: by mail-pb0-f47.google.com with SMTP id um1so4786451pbc.20
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 19:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9dYRa71Wx1UHZC5hzToxIJ6qOhqc+qpG5reJMr9zhRY=;
        b=zibL/5+9OBFTvda/yyJAcfCRZ2HBF6Ng++BDYpm0PKva/GwvPdHdD5Go32bAqIgiaa
         9PuGsc2puHuF5O569ZpnoMn65k0nkdKwohTxFOkLrx5itiMS7yXPF7VCMtDh2yUtAdge
         H8xr4gmvT7wOyRpIv8LKRsI+NpGtYJiUO+hpyKVNHRwQ5/nHPvjx/WrMVZpWC3xNyXgb
         EfdV9qxkX/s+BS2Dn3GwZGBNQu2m/Ser4cFS2mhOpHdcgjp5288+10A5Wlxqd37yi90o
         QBQ/4gUoh1Mq8CUJ18aKPAbymCQ6RhtUMeQIPYZUNET50mm0dRfZex+hcf2qwfk90NKR
         iCzQ==
X-Received: by 10.66.188.203 with SMTP id gc11mr24798422pac.63.1385351505685;
        Sun, 24 Nov 2013 19:51:45 -0800 (PST)
Received: from lanh ([115.73.213.240])
        by mx.google.com with ESMTPSA id ha10sm69714914pbd.17.2013.11.24.19.51.42
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 19:51:45 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Nov 2013 10:56:18 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238275>

If we borrow objects from another repository, we should also pay
attention to their $GIT_DIR/shallow (and even info/grafts). But
current alternates code does not.

Reject alternate repos that are shallow because we do not do it
right. In future we alternate code may be updated to check
$GIT_DIR/shallow properly so that this restriction could be lifted.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 874e0fd..900f564 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -252,6 +252,12 @@ static int add_one_reference(struct string_list_it=
em *item, void *cb_data)
 		die(_("reference repository '%s' is not a local repository."),
 		    item->string);
=20
+	if (!access(mkpath("%s/shallow", ref_git), F_OK))
+		die(_("reference repository '%s' is shallow"), item->string);
+
+	if (!access(mkpath("%s/info/grafts", ref_git), F_OK))
+		die(_("reference repository '%s' is grafted"), item->string);
+
 	strbuf_addf(&alternate, "%s/objects", ref_git);
 	add_to_alternates_file(alternate.buf);
 	strbuf_release(&alternate);
--=20
1.8.2.83.gc99314b
