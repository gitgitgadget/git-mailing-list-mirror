From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/45] parse_pathspec: support prefixing original patterns
Date: Sun,  9 Jun 2013 13:25:45 +0700
Message-ID: <1370759178-1709-13-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:26:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ4y-0000AW-1I
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926Ab3FIG0L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:26:11 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:49165 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007Ab3FIG0K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:26:10 -0400
Received: by mail-pd0-f174.google.com with SMTP id 10so5285372pdc.5
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=R5wxMCV7XK3APGNQLMjfayTjgpg5Y/jcVn08dfmmk/Y=;
        b=nW3lMmpbl/fNKZB9GN1O2wtJRbIJYdFsJsRt3ZO3HABq/iqbKFqPJcyOlKjPOSrx2t
         b8Dl3AaRrYNFlqTWOf6rzRxkzECdgd3iJlovhAa8O/xkSRiTWXu7EylIg4Nu0loL1o5O
         4j+TRc/ZsB9cuMMXwX6E1u52kXDAjR4Z8WS9nvBwtXcVXmDRlWCmHCPTC3ArdURRlYU3
         hEbseq+dTNSm+onkNHpopPfk9kXT1ZNPsQ1iBV9slRx8pj48DD37LIGR4kIYwiyVSOoX
         +oZomB2aV76YWXCcomDUrwjSTxC9TWrRnRHr2zRvVdwWe1WicORQWCEMmWU9svImrz3e
         KL6Q==
X-Received: by 10.68.6.10 with SMTP id w10mr5003923pbw.220.1370759169921;
        Sat, 08 Jun 2013 23:26:09 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id cc15sm10278613pac.1.2013.06.08.23.26.06
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:26:09 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:27:41 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226904>

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
index 9aaec36..ba0a41d 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -203,7 +203,17 @@ static unsigned prefix_pathspec(struct pathspec_it=
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
index b631514..3ca6636 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -43,6 +43,7 @@ struct pathspec {
  * safer than _SLASH_CHEAP and also more expensive.
  */
 #define PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE (1<<5)
+#define PATHSPEC_PREFIX_ORIGIN (1<<6)
=20
 extern int init_pathspec(struct pathspec *, const char **);
 extern void parse_pathspec(struct pathspec *pathspec,
--=20
1.8.2.83.gc99314b
