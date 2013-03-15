From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 13/45] parse_pathspec: support prefixing original patterns
Date: Fri, 15 Mar 2013 13:06:28 +0700
Message-ID: <1363327620-29017-14-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:26:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO5Z-0004yC-NC
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253Ab3COGZc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:25:32 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:58861 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab3COGZa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:25:30 -0400
Received: by mail-ie0-f173.google.com with SMTP id 9so3983981iec.32
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=9ktmZCpkCEodaFdxRvnh1Iogdd+OTj96Qlxav2qsp7s=;
        b=nkavtuORyEMdWFO9bUIaBeNbePm5HYxVzU7DJyMysX5nZAeOvOToGrEd9CWCcGUx3s
         /P4av5F8vMlYDQ+9Ob7fo3FMA/Kn4QsDjaw7ox+dXsb/US0e7+w2f/yobs3B+FEixCWW
         2XbRg/BAP2FWdhmD7ywk/G2lm92yjTxev/xxiojiqc0xEN2/jYXSujrbfguKrTJicJfc
         vhRJJ0uv8pDdTWiqPEdgXQ7G4bMSHaPknQbE0tzN11LiZgIfLX0NOdUQVQlub0sv4Sfg
         qEQ9cFvpb0aieNaTKPxFKEn2PQElJ3TAyueDcx9CCbdWDqF5mmpmdLk5qpiH4XIszRie
         ewcQ==
X-Received: by 10.50.17.166 with SMTP id p6mr319720igd.12.1363328730150;
        Thu, 14 Mar 2013 23:25:30 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id l2sm629852igb.1.2013.03.14.23.25.27
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:25:29 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:08:32 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218200>

This makes 'original' suitable for passing to an external command
because all pathspec magic is left in place, provided that the
external command understands pathspec. The prefixing is needed because
we usually launch a subcommand at worktree's top directory and the
subcommand can no longer calculate the prefix itself.

This slightly affects the original purpose of 'original'
(i.e. reporting). We should report without prefixing. So only turn
this flag on when you know you are about to pass the result straight
away to an external command.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pathspec.c | 12 +++++++++++-
 pathspec.h |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/pathspec.c b/pathspec.c
index 834db80..9a57c0c 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -202,7 +202,17 @@ static unsigned prefix_pathspec(struct pathspec_it=
em *item,
 	else
 		match =3D prefix_path(prefix, prefixlen, copyfrom);
 	*raw =3D item->match =3D match;
-	item->original =3D elt;
+	/*
+	 * Prefix the pathspec (keep all magic) and put to
+	 * original. Useful for passing to another command.
+	 */
+	if (flags & PATHSPEC_PREFIX_ORIGIN) {
+		struct strbuf sb =3D STRBUF_INIT;
+		strbuf_add(&sb, elt, copyfrom - elt);
+		strbuf_addstr(&sb, match);
+		item->original =3D strbuf_detach(&sb, NULL);
+	} else
+		item->original =3D elt;
 	item->len =3D strlen(item->match);
=20
 	if ((flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP) &&
diff --git a/pathspec.h b/pathspec.h
index 6ffd09d..1cef9c6 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -34,6 +34,7 @@ struct pathspec {
 #define PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP (1<<3)
 #define PATHSPEC_SYMLINK_LEADING_PATH (1<<4)
 #define PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE (1<<5)
+#define PATHSPEC_PREFIX_ORIGIN (1<<6)
=20
 extern int init_pathspec(struct pathspec *, const char **);
 extern void parse_pathspec(struct pathspec *pathspec,
--=20
1.8.0.rc0.19.g7bbb31d
