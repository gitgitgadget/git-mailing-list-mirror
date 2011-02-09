From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/16] ls: add --column
Date: Wed,  9 Feb 2011 19:24:40 +0700
Message-ID: <1297254284-3729-13-git-send-email-pclouds@gmail.com>
References: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 13:27:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn99H-0007vU-87
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 13:27:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859Ab1BIM1t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 07:27:49 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47853 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837Ab1BIM1t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 07:27:49 -0500
Received: by mail-iw0-f174.google.com with SMTP id 9so74477iwn.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 04:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=0grWd1W74ApvbealzPRS+Amn8MoIFazt4m6r3YvoUTU=;
        b=PeeSWs+cY4pmumxa73rgbsRGI3cfXHSJmkAI7yTgPM4zOE8gP2TEKlDdSTZvwRA9dz
         etuHCbr3dz8nZU3pUYCkE9rlHpoYSoHTEp5vd2FI/rb7ildXZ27cMuGHXwhiXKTPxm57
         +zsvZ+BjdlFk4F+alO5oeNHg5i9iOGHrEX2Ag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vtTw9be1YXfbfAIObIKIMFy9L1iW/BQhGstdOMUWsAsXLZSpdous/wrOrMHeHJmkUq
         2O8wXNM++z/nN1BWh96tgmF7ukkyJyqYOYB1hbu5UYm/nnKIDJeis/cb4xeDqFuJHuGf
         y1oJu6Qo1TbpBobh8lstw/UKF1E9An5oq9DGo=
Received: by 10.231.15.204 with SMTP id l12mr14000623iba.148.1297254468621;
        Wed, 09 Feb 2011 04:27:48 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id 8sm256163iba.4.2011.02.09.04.27.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 04:27:47 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 09 Feb 2011 19:26:17 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166416>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index cab7a10..3195f75 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -13,6 +13,7 @@
 #include "parse-options.h"
 #include "resolve-undo.h"
 #include "string-list.h"
+#include "column.h"
=20
 static int abbrev;
 static int show_deleted;
@@ -45,8 +46,19 @@ static const char *tag_modified =3D "";
 static const char *tag_skip_worktree =3D "";
 static const char *tag_resolve_undo =3D "";
=20
+static struct string_list output;
+static int column_mode;
+
 static void write_name(const char* name, size_t len)
 {
+	/* No quoting in column layout. It will be done by the end. */
+	if (column_mode & COL_MODE) {
+		struct strbuf sb =3D STRBUF_INIT;
+		strbuf_add(&sb, name, len);
+		string_list_append(&output, strbuf_detach(&sb, NULL));
+		return;
+	}
+
 	write_name_quoted_relative(name, len, prefix, prefix_len, stdout,
 			line_terminator);
 }
@@ -637,6 +649,7 @@ int cmd_ls(int argc, const char **argv, const char =
*cmd_prefix)
 			DIR_SHOW_IGNORED),
 		OPT_BOOLEAN('k', "killed", &show_killed,
 			"show files on the filesystem that need to be removed"),
+		OPT_COLUMN(0, "column", &column_mode, "show files in columns" ),
 		OPT_END()
 	};
=20
@@ -652,6 +665,8 @@ int cmd_ls(int argc, const char **argv, const char =
*cmd_prefix)
 	if (read_cache() < 0)
 		die("index file corrupt");
=20
+	column_mode =3D core_column;
+
 	argc =3D parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
=20
@@ -669,5 +684,6 @@ int cmd_ls(int argc, const char **argv, const char =
*cmd_prefix)
 		show_cached =3D 1;
=20
 	show_files(&dir);
+	display_columns(&output, column_mode, term_columns(), 2, NULL);
 	return 0;
 }
--=20
1.7.2.2
