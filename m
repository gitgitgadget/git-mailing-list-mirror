From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 11/34] mailinfo: introduce "struct mailinfo" to hold globals
Date: Mon, 19 Oct 2015 00:28:28 -0700
Message-ID: <1445239731-10677-12-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:30:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4uA-0003dG-Cd
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbbJSHao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:30:44 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33694 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbbJSH3H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:29:07 -0400
Received: by pabrc13 with SMTP id rc13so182994822pab.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=zey35ZuGdJYwE2CiTuCs0SlKQo/OcgdTBt3GTvn+TUI=;
        b=oKOLoBTofixhbTqNavDiomHZ6DJLo6tiRllgN2wR9F67WDyMfSR4FHoXkXBz28zTKm
         xKsfG/oFa4ucicYvOnUtLmprvTQD1/LNVIuQJLe7X9vtBvS9Ft3Xc+Zm7+B0pO2hf7Kc
         ahq21hUU+P2cURrINMygJq8rc7lzZDFa9wXjRzOPl3NXrtJYfSL1WCI1YCVo+QvQibv8
         WA2Ulcuzpb+ccx/XW2Nit3zllPCBNiuXfA/+wdSNI41EsQb29N5cwZjvx4vPD4Ekxdwe
         I8AvrEH+eYdG4epK3O/v9CVwiNcnWnLFqqJ/SpE84zkyUlMtF4XwbfpLFrDNV2vITCAP
         reRA==
X-Received: by 10.67.3.2 with SMTP id bs2mr33056042pad.118.1445239747094;
        Mon, 19 Oct 2015 00:29:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id r2sm34821216pap.23.2015.10.19.00.29.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:29:06 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279865>

In this first step, move only 'email' and 'name' fields in there and
remove the corresponding globals.  In subsequent patches, more
globals will be moved to this and the structure will be passed
around as a new parameter to more functions.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 71 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 24 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index c8dc73f..e3c0c31 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -12,8 +12,11 @@ static FILE *cmitmsg, *patchfile, *fin, *fout;
 static int keep_subject;
 static int keep_non_patch_brackets_in_subject;
 static const char *metainfo_charset;
-static struct strbuf name = STRBUF_INIT;
-static struct strbuf email = STRBUF_INIT;
+
+struct mailinfo {
+	struct strbuf name;
+	struct strbuf email;
+};
 static char *message_id;
 
 static enum  {
@@ -45,7 +48,7 @@ static void get_sane_name(struct strbuf *out, struct strbuf *name, struct strbuf
 	strbuf_addbuf(out, src);
 }
 
-static void parse_bogus_from(const struct strbuf *line)
+static void parse_bogus_from(struct mailinfo *mi, const struct strbuf *line)
 {
 	/* John Doe <johndoe> */
 
@@ -53,7 +56,7 @@ static void parse_bogus_from(const struct strbuf *line)
 	/* This is fallback, so do not bother if we already have an
 	 * e-mail address.
 	 */
-	if (email.len)
+	if (mi->email.len)
 		return;
 
 	bra = strchr(line->buf, '<');
@@ -63,16 +66,16 @@ static void parse_bogus_from(const struct strbuf *line)
 	if (!ket)
 		return;
 
-	strbuf_reset(&email);
-	strbuf_add(&email, bra + 1, ket - bra - 1);
+	strbuf_reset(&mi->email);
+	strbuf_add(&mi->email, bra + 1, ket - bra - 1);
 
-	strbuf_reset(&name);
-	strbuf_add(&name, line->buf, bra - line->buf);
-	strbuf_trim(&name);
-	get_sane_name(&name, &name, &email);
+	strbuf_reset(&mi->name);
+	strbuf_add(&mi->name, line->buf, bra - line->buf);
+	strbuf_trim(&mi->name);
+	get_sane_name(&mi->name, &mi->name, &mi->email);
 }
 
-static void handle_from(const struct strbuf *from)
+static void handle_from(struct mailinfo *mi, const struct strbuf *from)
 {
 	char *at;
 	size_t el;
@@ -83,14 +86,14 @@ static void handle_from(const struct strbuf *from)
 
 	at = strchr(f.buf, '@');
 	if (!at) {
-		parse_bogus_from(from);
+		parse_bogus_from(mi, from);
 		return;
 	}
 
 	/*
 	 * If we already have one email, don't take any confusing lines
 	 */
-	if (email.len && strchr(at + 1, '@')) {
+	if (mi->email.len && strchr(at + 1, '@')) {
 		strbuf_release(&f);
 		return;
 	}
@@ -109,8 +112,8 @@ static void handle_from(const struct strbuf *from)
 		at--;
 	}
 	el = strcspn(at, " \n\t\r\v\f>");
-	strbuf_reset(&email);
-	strbuf_add(&email, at, el);
+	strbuf_reset(&mi->email);
+	strbuf_add(&mi->email, at, el);
 	strbuf_remove(&f, at - f.buf, el + (at[el] ? 1 : 0));
 
 	/* The remainder is name.  It could be
@@ -132,7 +135,7 @@ static void handle_from(const struct strbuf *from)
 		strbuf_setlen(&f, f.len - 1);
 	}
 
-	get_sane_name(&name, &f, &email);
+	get_sane_name(&mi->name, &f, &mi->email);
 	strbuf_release(&f);
 }
 
@@ -929,7 +932,7 @@ static void output_header_lines(FILE *fout, const char *hdr, const struct strbuf
 	}
 }
 
-static void handle_info(void)
+static void handle_info(struct mailinfo *mi)
 {
 	struct strbuf *hdr;
 	int i;
@@ -951,9 +954,9 @@ static void handle_info(void)
 			output_header_lines(fout, "Subject", hdr);
 		} else if (!strcmp(header[i], "From")) {
 			cleanup_space(hdr);
-			handle_from(hdr);
-			fprintf(fout, "Author: %s\n", name.buf);
-			fprintf(fout, "Email: %s\n", email.buf);
+			handle_from(mi, hdr);
+			fprintf(fout, "Author: %s\n", mi->name.buf);
+			fprintf(fout, "Email: %s\n", mi->email.buf);
 		} else {
 			cleanup_space(hdr);
 			fprintf(fout, "%s: %s\n", header[i], hdr->buf);
@@ -962,7 +965,8 @@ static void handle_info(void)
 	fprintf(fout, "\n");
 }
 
-static int mailinfo(FILE *in, FILE *out, const char *msg, const char *patch)
+static int mailinfo(struct mailinfo *mi,
+		    FILE *in, FILE *out, const char *msg, const char *patch)
 {
 	int peek;
 	struct strbuf line = STRBUF_INIT;
@@ -997,7 +1001,7 @@ static int mailinfo(FILE *in, FILE *out, const char *msg, const char *patch)
 	handle_body(&line);
 	fclose(patchfile);
 
-	handle_info();
+	handle_info(mi);
 
 	return 0;
 }
@@ -1014,17 +1018,33 @@ static int git_mailinfo_config(const char *var, const char *value, void *unused)
 	return 0;
 }
 
+static void setup_mailinfo(struct mailinfo *mi)
+{
+	memset(mi, 0, sizeof(*mi));
+	strbuf_init(&mi->name, 0);
+	strbuf_init(&mi->email, 0);
+	git_config(git_mailinfo_config, &mi);
+}
+
+static void clear_mailinfo(struct mailinfo *mi)
+{
+	strbuf_release(&mi->name);
+	strbuf_release(&mi->email);
+}
+
 static const char mailinfo_usage[] =
 	"git mailinfo [-k | -b] [-m | --message-id] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] <msg> <patch> < mail >info";
 
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
 	const char *def_charset;
+	struct mailinfo mi;
+	int status;
 
 	/* NEEDSWORK: might want to do the optional .git/ directory
 	 * discovery
 	 */
-	git_config(git_mailinfo_config, NULL);
+	setup_mailinfo(&mi);
 
 	def_charset = get_commit_output_encoding();
 	metainfo_charset = def_charset;
@@ -1056,5 +1076,8 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 	if (argc != 3)
 		usage(mailinfo_usage);
 
-	return !!mailinfo(stdin, stdout, argv[1], argv[2]);
+	status = !!mailinfo(&mi, stdin, stdout, argv[1], argv[2]);
+	clear_mailinfo(&mi);
+
+	return status;
 }
-- 
2.6.2-383-g144b2e6
