From: santiago@nyu.edu
Subject: [PATCH] tag.c: move PGP verification code from plumbing
Date: Thu, 24 Mar 2016 20:33:37 -0400
Message-ID: <1458866017-15490-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 01:34:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajFhw-0005B9-0S
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 01:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbcCYAe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 20:34:28 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:35803 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbcCYAe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 20:34:26 -0400
Received: by mail-qg0-f44.google.com with SMTP id y89so51813374qge.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 17:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=6LyTwe8ZXkjvtqs0AD8Kdl/1d9lWgp4psgAgLZ4KNLo=;
        b=dSAGbqL0989+lx7o8V4G85KBO6aOBr25PheLeEc6Bc0UBKCjbdBdn7mIUDuAKRtdnb
         7vWQo8NfFKTXfy+e8JfibPzlp+sI79HuCm7+cQcUB76uVJAKYtOz2NaEuSikmTXksgVk
         OqwLA2bL3uBuR1/DJku7yA/JN3Vm8QXal/FiBTJpqhE2eIw+j0q2KtjYeOmP6hsejLFX
         McPoCim+fCA0z+SjYvV8jNJWOwaAjS9cm5PBWXnP0EMuuVxw75GfGf9OQKkHjkNq0LL1
         xnederuLoGAJI0/1alrTbs/u6sxY4rEcr3/agx1p168t1K84ZGNGyRsDnO3+q2QeneaI
         /QIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6LyTwe8ZXkjvtqs0AD8Kdl/1d9lWgp4psgAgLZ4KNLo=;
        b=gUFmtb85CVhogkuitx0viGxMth0W3S2agzj4cMI12jxfSPJZmuVpUPiRNlAzyZGI2M
         C/JDgdUI6qZ2FG2uCtvgS2jettJj+qWQIqXaBdoUFsWmbgD8wXdMtIx0ZOlS6k7ctTRr
         v9q8Jpsdy3Qj2x93meTiYpHG2kc6EDIeEzO4jeAWR+ISrIDoPnmjGgqaYMooTlhIvyN+
         vnbzcwBIt30InNLrW6JL+4cZ7MfaYmQWiX2S+0ScAcI+Aw8IhzeZEfiC1rAgQnnKJ1Xo
         UocVJSvlNSHefMrMM3a7fTC7zikZOeDkcxn/nb4933FBwX8KXX1etYfZ4BevzMud+8l4
         PXPA==
X-Gm-Message-State: AD7BkJLTRxXDrM0BKe7lR57W1iC3i9RXS0F0xEN0AgYOYGwhjTdl6z+5FizVcqx7XK82Ynne
X-Received: by 10.140.106.68 with SMTP id d62mr14298664qgf.84.1458866065410;
        Thu, 24 Mar 2016 17:34:25 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-11.NATPOOL.NYU.EDU. [216.165.95.0])
        by smtp.gmail.com with ESMTPSA id q10sm4315926qha.25.2016.03.24.17.34.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Mar 2016 17:34:24 -0700 (PDT)
X-Mailer: git-send-email 2.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289836>

From: Santiago Torres <santiago@nyu.edu>

The verify tag function is just a thin wrapper around the verify-tag
command. We can avoid one fork call by doing the verification inside
the tag builtin instead.

To do this, the run_pgp_verify() and verify_tag() functions are moved to
tag.c. The definition of verify_tag was changed to support extra
arguments that match the builtin/tag and builtin/verify-tag modules. The
SIGPIPE ignore call in tag-verify was also moved to a more sensible
place, now that both modules need it.

The function name was also changed to pgp_verify_tag to avoid conflicts with
mktag.c's.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 builtin/tag.c        | 26 ++++++++---------------
 builtin/verify-tag.c | 60 ++++++----------------------------------------------
 gpg-interface.c      |  6 ++++++
 tag.c                | 48 +++++++++++++++++++++++++++++++++++++++++
 tag.h                |  2 ++
 5 files changed, 72 insertions(+), 70 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 1705c94..af8f3ba 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -65,9 +65,10 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
 }
 
 typedef int (*each_tag_name_fn)(const char *name, const char *ref,
-				const unsigned char *sha1);
+				const unsigned char *sha1, unsigned flags);
 
-static int for_each_tag_name(const char **argv, each_tag_name_fn fn)
+static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
+		unsigned flags)
 {
 	const char **p;
 	char ref[PATH_MAX];
@@ -86,32 +87,22 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn)
 			had_error = 1;
 			continue;
 		}
-		if (fn(*p, ref, sha1))
+		if (fn(*p, ref, sha1, flags))
 			had_error = 1;
 	}
 	return had_error;
 }
 
 static int delete_tag(const char *name, const char *ref,
-				const unsigned char *sha1)
+				const unsigned char *sha1, unsigned flags)
 {
-	if (delete_ref(ref, sha1, 0))
+	if (delete_ref(ref, sha1, flags))
 		return 1;
 	printf(_("Deleted tag '%s' (was %s)\n"), name, find_unique_abbrev(sha1, DEFAULT_ABBREV));
 	return 0;
 }
 
-static int verify_tag(const char *name, const char *ref,
-				const unsigned char *sha1)
-{
-	const char *argv_verify_tag[] = {"verify-tag",
-					"-v", "SHA1_HEX", NULL};
-	argv_verify_tag[2] = sha1_to_hex(sha1);
 
-	if (run_command_v_opt(argv_verify_tag, RUN_GIT_CMD))
-		return error(_("could not verify the tag '%s'"), name);
-	return 0;
-}
 
 static int do_sign(struct strbuf *buffer)
 {
@@ -424,9 +415,10 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (filter.merge_commit)
 		die(_("--merged and --no-merged option are only allowed with -l"));
 	if (cmdmode == 'd')
-		return for_each_tag_name(argv, delete_tag);
+		return for_each_tag_name(argv, delete_tag, 0);
 	if (cmdmode == 'v')
-		return for_each_tag_name(argv, verify_tag);
+		return for_each_tag_name(argv, pgp_verify_tag,
+				GPG_VERIFY_VERBOSE);
 
 	if (msg.given || msgfile) {
 		if (msg.given && msgfile)
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 00663f6..2e6a175 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -18,55 +18,6 @@ static const char * const verify_tag_usage[] = {
 		NULL
 };
 
-static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
-{
-	struct signature_check sigc;
-	int len;
-	int ret;
-
-	memset(&sigc, 0, sizeof(sigc));
-
-	len = parse_signature(buf, size);
-
-	if (size == len) {
-		if (flags & GPG_VERIFY_VERBOSE)
-			write_in_full(1, buf, len);
-		return error("no signature found");
-	}
-
-	ret = check_signature(buf, len, buf + len, size - len, &sigc);
-	print_signature_buffer(&sigc, flags);
-
-	signature_check_clear(&sigc);
-	return ret;
-}
-
-static int verify_tag(const char *name, unsigned flags)
-{
-	enum object_type type;
-	unsigned char sha1[20];
-	char *buf;
-	unsigned long size;
-	int ret;
-
-	if (get_sha1(name, sha1))
-		return error("tag '%s' not found.", name);
-
-	type = sha1_object_info(sha1, NULL);
-	if (type != OBJ_TAG)
-		return error("%s: cannot verify a non-tag object of type %s.",
-				name, typename(type));
-
-	buf = read_sha1_file(sha1, &type, &size);
-	if (!buf)
-		return error("%s: unable to read file.", name);
-
-	ret = run_gpg_verify(buf, size, flags);
-
-	free(buf);
-	return ret;
-}
-
 static int git_verify_tag_config(const char *var, const char *value, void *cb)
 {
 	int status = git_gpg_config(var, value, cb);
@@ -78,6 +29,8 @@ static int git_verify_tag_config(const char *var, const char *value, void *cb)
 int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 {
 	int i = 1, verbose = 0, had_error = 0;
+	unsigned char sha1[20];
+	const char *name;
 	unsigned flags = 0;
 	const struct option verify_tag_options[] = {
 		OPT__VERBOSE(&verbose, N_("print tag contents")),
@@ -95,11 +48,12 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	if (verbose)
 		flags |= GPG_VERIFY_VERBOSE;
 
-	/* sometimes the program was terminated because this signal
-	 * was received in the process of writing the gpg input: */
-	signal(SIGPIPE, SIG_IGN);
 	while (i < argc)
-		if (verify_tag(argv[i++], flags))
+		name = argv[i++];
+		if (get_sha1(name, sha1))
+			return error("tag '%s' not found.", name);
+
+		if (pgp_verify_tag(NULL, NULL, sha1, flags))
 			had_error = 1;
 	return had_error;
 }
diff --git a/gpg-interface.c b/gpg-interface.c
index 3dc2fe3..1b421b7 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -232,6 +232,11 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 	if (gpg_output)
 		gpg.err = -1;
 	args_gpg[3] = path;
+
+	/* sometimes the program was terminated because this signal
+	 * was received in the process of writing the gpg input.
+	 * We ignore it for this call and restore it afterwards */
+	sigchain_push(SIGPIPE, SIG_IGN);
 	if (start_command(&gpg)) {
 		unlink(path);
 		return error(_("could not run gpg."));
@@ -250,6 +255,7 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 	close(gpg.out);
 
 	ret = finish_command(&gpg);
+	sigchain_pop(SIGPIPE);
 
 	unlink_or_warn(path);
 
diff --git a/tag.c b/tag.c
index d72f742..7097a84 100644
--- a/tag.c
+++ b/tag.c
@@ -3,9 +3,57 @@
 #include "commit.h"
 #include "tree.h"
 #include "blob.h"
+#include "sigchain.h"
 
 const char *tag_type = "tag";
 
+
+static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
+{
+	struct signature_check sigc;
+	int payload_size;
+	int ret;
+
+	memset(&sigc, 0, sizeof(sigc));
+
+	payload_size = parse_signature(buf, size);
+
+	if (size == payload_size) {
+		write_in_full(1, buf, payload_size);
+		return error("No PGP signature found in this tag!");
+	}
+
+	ret = check_signature(buf, payload_size, buf + payload_size,
+			size - payload_size, &sigc);
+	print_signature_buffer(&sigc, flags);
+
+	signature_check_clear(&sigc);
+	return ret;
+}
+
+int pgp_verify_tag(const char *name, const char *ref,
+		const unsigned char *sha1, unsigned flags)
+{
+
+	enum object_type type;
+	unsigned long size;
+	const char* buf;
+	int ret;
+
+	type = sha1_object_info(sha1, NULL);
+	if (type != OBJ_TAG)
+		return error("%s: cannot verify a non-tag object of type %s.",
+				name, typename(type));
+
+	buf = read_sha1_file(sha1, &type, &size);
+	if (!buf)
+		return error("%s: unable to read file.", name);
+
+	ret = run_gpg_verify(buf, size, flags);
+
+	return ret;
+}
+
 struct object *deref_tag(struct object *o, const char *warn, int warnlen)
 {
 	while (o && o->type == OBJ_TAG)
diff --git a/tag.h b/tag.h
index f4580ae..22289a5 100644
--- a/tag.h
+++ b/tag.h
@@ -17,5 +17,7 @@ extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long si
 extern int parse_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
 extern struct object *deref_tag_noverify(struct object *);
+extern int pgp_verify_tag(const char *name, const char *ref,
+		const unsigned char *sha1, unsigned flags);
 
 #endif /* TAG_H */
-- 
2.7.3
