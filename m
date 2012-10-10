From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/2] quote: let caller reset buffer for quote_path_relative()
Date: Wed, 10 Oct 2012 20:59:03 +0700
Message-ID: <1349877544-17648-2-git-send-email-pclouds@gmail.com>
References: <1349868894-3579-1-git-send-email-pclouds@gmail.com>
 <1349877544-17648-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 15:59:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLwp6-0007gp-I9
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 15:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756571Ab2JJN7b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 09:59:31 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34656 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756404Ab2JJN73 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 09:59:29 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so734362pbb.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 06:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8D4wf5d4I6xXcPaZK+Lm0J14uy9uhk++31HGPMwbPkQ=;
        b=werYhCfPvdi7qsZ4jT7w7FdFTBdubjWaj9c/DcxWzLTC64f/ze/E47dhWPl+1scAMZ
         aMtqDp1AYo7iIfFS4Ja9V7SOr329ddletWKah8I/UbIs/OPa0FLLH4zrUbeMQeaLNXjK
         9Nu+QB4eLsBz7ELKzIceaTydIxybZT9kPxVtcx2Fqy/BCgJVXroJwBBac2CG9FyJm4NF
         wJPN2JJZ9CuvTZVtYB3Up/N7KvOvrgFvuRAv7Gx6yowjTjJuFgqBH4+a91zlT3yvwPkt
         wn9Lrs6Cv8LJY0ohb7kI8Bp9zXIQxXApvvpmlATEqQWS2ZGdkC2aWYyyje+mXPA8ZTjN
         mwGg==
Received: by 10.66.77.40 with SMTP id p8mr62299844paw.78.1349877569336;
        Wed, 10 Oct 2012 06:59:29 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id gk5sm1074713pbc.21.2012.10.10.06.59.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 06:59:27 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 10 Oct 2012 20:59:19 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1349877544-17648-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207411>

quote_path_relative() resetting output buffer is sometimes unnecessary
as the buffer has never been used, and some other times makes it
harder for the caller to use (see builtin/grep.c, the caller has to
insert a string after quote_path_relative)

Move the buffer reset back to call sites when necessary.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clean.c    | 2 ++
 builtin/grep.c     | 2 +-
 builtin/ls-files.c | 1 +
 quote.c            | 1 -
 wt-status.c        | 1 +
 5 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 69c1cda..ff633cc 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -149,6 +149,7 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
=20
 		if (S_ISDIR(st.st_mode)) {
 			strbuf_addstr(&directory, ent->name);
+			strbuf_reset(&buf);
 			qname =3D quote_path_relative(directory.buf, directory.len, &buf, p=
refix);
 			if (show_only && (remove_directories ||
 			    (matches =3D=3D MATCHED_EXACTLY))) {
@@ -171,6 +172,7 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
 		} else {
 			if (pathspec && !matches)
 				continue;
+			strbuf_reset(&buf);
 			qname =3D quote_path_relative(ent->name, -1, &buf, prefix);
 			if (show_only) {
 				printf(_("Would remove %s\n"), qname);
diff --git a/builtin/grep.c b/builtin/grep.c
index 82530a6..377c904 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -376,9 +376,9 @@ static int grep_sha1(struct grep_opt *opt, const un=
signed char *sha1,
 	struct strbuf pathbuf =3D STRBUF_INIT;
=20
 	if (opt->relative && opt->prefix_length) {
+		strbuf_add(&pathbuf, filename, tree_name_len);
 		quote_path_relative(filename + tree_name_len, -1, &pathbuf,
 				    opt->prefix);
-		strbuf_insert(&pathbuf, 0, filename, tree_name_len);
 	} else {
 		strbuf_addstr(&pathbuf, filename);
 	}
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b5434af..1e0cae9 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -395,6 +395,7 @@ int report_path_error(const char *ps_matched, const=
 char **pathspec, const char
 		if (found_dup)
 			continue;
=20
+		strbuf_reset(&sb);
 		name =3D quote_path_relative(pathspec[num], -1, &sb, prefix);
 		error("pathspec '%s' did not match any file(s) known to git.",
 		      name);
diff --git a/quote.c b/quote.c
index 911229f..7e23ba9 100644
--- a/quote.c
+++ b/quote.c
@@ -381,7 +381,6 @@ char *quote_path_relative(const char *in, int len,
 {
 	struct strbuf sb =3D STRBUF_INIT;
 	const char *rel =3D path_relative(in, len, &sb, prefix, -1);
-	strbuf_reset(out);
 	quote_c_style_counted(rel, strlen(rel), out, NULL, 0);
 	strbuf_release(&sb);
=20
diff --git a/wt-status.c b/wt-status.c
index 2a9658b..be8b600 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -690,6 +690,7 @@ static void wt_status_print_other(struct wt_status =
*s,
 		struct string_list_item *it;
 		const char *path;
 		it =3D &(l->items[i]);
+		strbuf_reset(&buf);
 		path =3D quote_path(it->string, strlen(it->string),
 				  &buf, s->prefix);
 		if (column_active(s->colopts)) {
--=20
1.7.12.1.406.g6ab07c4
