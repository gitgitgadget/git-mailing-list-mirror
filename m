Received: from mailproxy08.manitu.net (mailproxy08.manitu.net [217.11.48.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F36F3FBEC3
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.11.48.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538967; cv=none; b=SdhK6egL7qj9UF1WnX2F0RUHAjISpgLZEeyxWxxwByU9IRm4i9HoN309rLv7DDfzse9st39EKBaoRT90pK3308EIN+Sv+iDV6l2ya8EzdimBh0kVIHj1Z1sNcBpiw86fCmC+W4qvPLAK4JivQ9bOpwW52f4n+UW7ACQRPE3P7w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538967; c=relaxed/simple;
	bh=FYkaQZMR2uND+74yV8msChtx0m1DLWztEszfaR9MJv8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWBexdQhMTfjpUq/cYALcmhYIqfgTt+pir/Q4Lp2SGhoM/YmCHk1kxQrtLp4jxkM4SyCt22mJ4gTmUac6kNdW+2oOaQr6liWWDQ8ikUTt/tRk96O9fxLF8BtL4Dv6SSRP6gkc0yl+CoqGXgtkKcGMhoJMXTgNRN8unTSV0Bh30A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grubix.eu; spf=pass smtp.mailfrom=grubix.eu; dkim=pass (2048-bit key) header.d=grubix.eu header.i=@grubix.eu header.b=B3RICUSy; arc=none smtp.client-ip=217.11.48.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grubix.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grubix.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grubix.eu header.i=@grubix.eu header.b="B3RICUSy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grubix.eu;
	s=manitu-webhosting; t=1774538575;
	bh=R4ZpNPKThT9tczi/dK+IXFzydRruMCmm8k1YT6EoMks=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=B3RICUSynKZWzcQNbIzomKB97AlFCQqRzXnQXCgQrh73WhkPdWqMHbH+oqSNuKYY7
	 azRNMYcQIdGf7+8MtB06tMlMqO2lZG84W/SB7vP3ZqrXCUYRW0h/9IvgZzDCWyPHWR
	 beV5ggcGymNwuJZJXXwCMdH5SzAl/dIDy7n/xmFCpv/QSRjLu6FsJI5WDlNSIInj9h
	 vqUDxLC972tw7A3FODggCxyhikbY8tfPGGzQzksbBdXMzuwzFX9sHshgJmDrx6f+NM
	 GVQhcPShXce8+nGPqBRF0nxlsXk7i/Q6+a2wy/JwQm8dX+toomlF3G8l/NX0yI6KiO
	 +0GA9q62uVl4A==
From: Michael J Gruber <git@grubix.eu>
To: git@vger.kernel.org
Subject: [PATCH 1/6] do not discard const: the simple cases
Date: Thu, 26 Mar 2026 16:22:47 +0100
Message-ID: <a3a1d2759a0ec5a3ee285689832832e5e3a63768.1774537954.git.git@grubix.eu>
In-Reply-To: <cover.1774537954.git.git@grubix.eu>
References: <cover.1774537954.git.git@grubix.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depending on glibc version and compiler flags (ISOC23), strchr() and
friends from string.h may return const pointers for const arguments and
non-const for non-const (rather than non-const for all argument types).
In particular, our current code base gives warnings such as:

```
builtin/config.c: In function 'get_urlmatch':
builtin/config.c:855:22: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
  855 |         section_tail = strchr(config.section, '.');
      |                      ^
```

Note that with
```
const char *foo;
char *bar;
```
we can always assign `foo = bar` but `bar = foo` throws said warning. In
particular, we often pass in `char *` for a `const char *` argument and
expect `char *` back but get a `const char *` in said scenario.

This patch covers the easy cases where we deal with a non-const pointer
to begin with. It is solved by the cast `bar = (char *) foo`.
---
 builtin/config.c       | 2 +-
 builtin/receive-pack.c | 6 +++---
 http.c                 | 2 +-
 pager.c                | 2 +-
 range-diff.c           | 2 +-
 refs/files-backend.c   | 2 +-
 remote.c               | 2 +-
 send-pack.c            | 6 +++---
 transport-helper.c     | 2 +-
 9 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 7c4857be62..bd277e5911 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -852,7 +852,7 @@ static int get_urlmatch(const struct config_location_options *opts,
 		die("%s", config.url.err);
 
 	config.section = xstrdup_tolower(var);
-	section_tail = strchr(config.section, '.');
+	section_tail = (char *) strchr(config.section, '.');
 	if (section_tail) {
 		*section_tail = '\0';
 		config.key = section_tail + 1;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e34edff406..7712a1c3c2 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1042,7 +1042,7 @@ static int read_proc_receive_report(struct packet_reader *reader,
 		response++;
 
 		head = reader->line;
-		p = strchr(head, ' ');
+		p = (char *) strchr(head, ' ');
 		if (!p) {
 			strbuf_addf(errmsg, "proc-receive reported incomplete status line: '%s'\n", head);
 			code = -1;
@@ -1072,7 +1072,7 @@ static int read_proc_receive_report(struct packet_reader *reader,
 				new_report = 0;
 			}
 			key = p;
-			p = strchr(key, ' ');
+			p = (char *) strchr(key, ' ');
 			if (p)
 				*p++ = '\0';
 			val = p;
@@ -1095,7 +1095,7 @@ static int read_proc_receive_report(struct packet_reader *reader,
 		report = NULL;
 		new_report = 0;
 		refname = p;
-		p = strchr(refname, ' ');
+		p = (char *) strchr(refname, ' ');
 		if (p)
 			*p++ = '\0';
 		if (strcmp(head, "ok") && strcmp(head, "ng")) {
diff --git a/http.c b/http.c
index d8d016891b..02c4fbb234 100644
--- a/http.c
+++ b/http.c
@@ -774,7 +774,7 @@ static int redact_sensitive_header(struct strbuf *header, size_t offset)
 
 		while (cookie) {
 			char *equals;
-			char *semicolon = strstr(cookie, "; ");
+			char *semicolon = (char *) strstr(cookie, "; ");
 			if (semicolon)
 				*semicolon = 0;
 			equals = strchrnul(cookie, '=');
diff --git a/pager.c b/pager.c
index 5531fff50e..eb7011bfde 100644
--- a/pager.c
+++ b/pager.c
@@ -118,7 +118,7 @@ static void setup_pager_env(struct strvec *env)
 			split_cmdline_strerror(n));
 
 	for (i = 0; i < n; i++) {
-		char *cp = strchr(argv[i], '=');
+		char *cp = (char *) strchr(argv[i], '=');
 
 		if (!cp)
 			die("malformed build-time PAGER_ENV");
diff --git a/range-diff.c b/range-diff.c
index 2712a9a107..47e36a391f 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -106,7 +106,7 @@ static int read_patches(const char *range, struct string_list *list,
 				strbuf_reset(&buf);
 			}
 			CALLOC_ARRAY(util, 1);
-			if (include_merges && (q = strstr(p, " (from ")))
+			if (include_merges && (q = (char *) strstr(p, " (from ")))
 				*q = '\0';
 			if (repo_get_oid(the_repository, p, &util->oid)) {
 				error(_("could not parse commit '%s'"), p);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0537a72b2a..71cab7e003 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2196,7 +2196,7 @@ static int show_one_reflog_ent(struct files_ref_store *refs,
 	if (!sb->len || sb->buf[sb->len - 1] != '\n' ||
 	    parse_oid_hex_algop(p, &ooid, &p, refs->base.repo->hash_algo) || *p++ != ' ' ||
 	    parse_oid_hex_algop(p, &noid, &p, refs->base.repo->hash_algo) || *p++ != ' ' ||
-	    !(email_end = strchr(p, '>')) ||
+	    !(email_end = (char *) strchr(p, '>')) ||
 	    email_end[1] != ' ' ||
 	    !(timestamp = parse_timestamp(email_end + 2, &message, 10)) ||
 	    !message || message[0] != ' ' ||
diff --git a/remote.c b/remote.c
index 7ca2a6501b..d7a37016b5 100644
--- a/remote.c
+++ b/remote.c
@@ -2861,7 +2861,7 @@ void remote_state_clear(struct remote_state *remote_state)
  */
 static int chop_last_dir(char **remoteurl, int is_relative)
 {
-	char *rfind = find_last_dir_sep(*remoteurl);
+	char *rfind = (char *) find_last_dir_sep(*remoteurl);
 	if (rfind) {
 		*rfind = '\0';
 		return 0;
diff --git a/send-pack.c b/send-pack.c
index 07ecfae4de..8b9f7e2f2f 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -181,7 +181,7 @@ static int receive_status(struct repository *r,
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
 			break;
 		head = reader->line;
-		p = strchr(head, ' ');
+		p = (char *) strchr(head, ' ');
 		if (!p) {
 			error("invalid status line from remote: %s", reader->line);
 			ret = -1;
@@ -212,7 +212,7 @@ static int receive_status(struct repository *r,
 				new_report = 0;
 			}
 			key = p;
-			p = strchr(key, ' ');
+			p = (char *) strchr(key, ' ');
 			if (p)
 				*p++ = '\0';
 			val = p;
@@ -237,7 +237,7 @@ static int receive_status(struct repository *r,
 			break;
 		}
 		refname = p;
-		p = strchr(refname, ' ');
+		p = (char *) strchr(refname, ' ');
 		if (p)
 			*p++ = '\0';
 		/* first try searching at our hint, falling back to all refs */
diff --git a/transport-helper.c b/transport-helper.c
index 4d95d84f9e..e7f2cb1812 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -800,7 +800,7 @@ static int push_update_ref_status(struct strbuf *buf,
 			state->new_report = 0;
 		}
 		key = buf->buf + 7;
-		p = strchr(key, ' ');
+		p = (char *) strchr(key, ' ');
 		if (p)
 			*p++ = '\0';
 		val = p;
-- 
2.53.0.1195.g771ffcb452

