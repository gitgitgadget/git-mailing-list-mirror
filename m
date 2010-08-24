From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 22/32] commit: use commit_narrow_tree() to support narrow repo
Date: Wed, 25 Aug 2010 08:20:12 +1000
Message-ID: <1282688422-7738-23-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:23:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1uO-00030j-6c
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755918Ab0HXWXV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:23:21 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49107 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755767Ab0HXWXT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:23:19 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so2814108pvg.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ddPjpo+RTM6MUkm8JH0rFoWJ2oGamIIsLP0JDnL/WDk=;
        b=ckugnlHfa/QUH4/cnATB0df7huLYJza2fRudmU0J12qKYbb8ppSNoLaNw+1xwuwaxr
         2wQ1UZjczzLGay43q495Hfh4LeeuFmmH2VmMPW0P2XqRqssUUmlg2hQfpcGLlAdFU8af
         1CIrOTgsKbVrc7WmYbUi4TMA9nWFs4HmxvB5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=NgEoX51fqXRQRWn3ubu8R8ULVkKlM/hW+QUG0t61KdhwTn/+hByEUHYAJaYj1E+uLK
         KxMudItwMf8f1Hrn8tCdK5Bc8nj8sbJ7Gr+H1L8ND4PZ6r92rNzDV3whVq8K4YlPkPyO
         hL4+9fdPn0TT5fw2sm4HjFWbsJ+PjVmqrGP68=
Received: by 10.114.123.4 with SMTP id v4mr8543044wac.0.1282688599513;
        Tue, 24 Aug 2010 15:23:19 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id d38sm944017wam.20.2010.08.24.15.23.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:23:18 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:23:13 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154363>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 66fdd22..59da654 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1351,7 +1351,15 @@ int cmd_commit(int argc, const char **argv, cons=
t char *prefix)
 		exit(1);
 	}
=20
-	if (commit_tree(sb.buf, active_cache_tree->sha1, parents, commit_sha1=
,
+	if (get_narrow_prefix()) {
+		if (!parents)
+			die("Narrow mode does not support initial commit (yet)");
+		if (parse_commit(parents->item))
+			die("Bad commit %s", parents->item->object.sha1);
+	}
+	if (commit_narrow_tree(sb.buf, active_cache_tree->sha1,
+			parents ? parents->item->tree->object.sha1 : NULL,
+			parents, commit_sha1,
 			fmt_ident(author_name, author_email, author_date,
 				IDENT_ERROR_ON_NO_NAME))) {
 		rollback_index_files();
--=20
1.7.1.rc1.69.g24c2f7
