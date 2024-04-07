Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A7A846C
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 01:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712451784; cv=none; b=Z+Cg+YQE8ahPGNDOr89ThLkHbCUBvcDFB/bBRR8uVcQOfVV3TieRtddAdELV2nBiwFqR9E6Jcy0+61L39zT2Vda/Kb043EbMeMiihlQM46LHyU0qbaQiwY620Mk9+Z/mCjHFKKpmL5C2zc9roM41JG2AjsooLefLtBAVusQO2CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712451784; c=relaxed/simple;
	bh=furYD7rJjb5L1dTjoCFf484t83zght39Jeg3a5fqPHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMwo4vMfHOzuHfPjzdgT5RANm9AVFJ9gft+xdHn5OOIg4b+7pgaqXH8J8kFiALDgM22Uj/TpQ72nTI+zZwVqcBmY5B16o/nOsnchECHTfUgNs6uW/NvihPu6lbyNYEBfBMv0fJwaaNS+r4b2a5P1wDKnTHtGBP5E0F9OvG0nsEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7347 invoked by uid 109); 7 Apr 2024 01:03:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 07 Apr 2024 01:03:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11256 invoked by uid 111); 7 Apr 2024 01:03:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Apr 2024 21:03:05 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Apr 2024 21:03:01 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH 07/11] config: use git_config_pathname_dup() in easy cases
Message-ID: <20240407010301.GG868358@coredump.intra.peff.net>
References: <20240407005656.GA436890@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240407005656.GA436890@coredump.intra.peff.net>

As with the previous commit for git_config_string(), this fixes simple
cases where calling git_config_pathname() may leak if a config variable
is seen multiple times.

Signed-off-by: Jeff King <peff@peff.net>
---
I mostly split this out because the diff is big, but maybe it would make
sense squashed to share the rationale?

 builtin/commit.c | 4 ++--
 builtin/log.c    | 4 ++--
 config.c         | 8 ++++----
 diff.c           | 4 ++--
 environment.c    | 6 +++---
 environment.h    | 6 +++---
 gpg-interface.c  | 6 +++---
 mailmap.c        | 2 +-
 mailmap.h        | 2 +-
 9 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 9b6546d401..693175e5c4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -107,7 +107,7 @@ static enum {
 } commit_style;
 
 static const char *logfile, *force_author;
-static const char *template_file;
+static char *template_file;
 /*
  * The _message variables are commit names from which to take
  * the commit message and/or authorship.
@@ -1626,7 +1626,7 @@ static int git_commit_config(const char *k, const char *v,
 	struct wt_status *s = cb;
 
 	if (!strcmp(k, "commit.template"))
-		return git_config_pathname(&template_file, k, v);
+		return git_config_pathname_dup(&template_file, k, v);
 	if (!strcmp(k, "commit.status")) {
 		include_status = git_config_bool(k, v);
 		return 0;
diff --git a/builtin/log.c b/builtin/log.c
index eb336f7efb..3df261f94a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -957,7 +957,7 @@ static int do_signoff;
 static enum auto_base_setting auto_base;
 static char *from;
 static const char *signature = git_version_string;
-static const char *signature_file;
+static char *signature_file;
 static enum cover_setting config_cover_letter;
 static char *config_output_directory;
 static enum cover_from_description cover_from_description_mode = COVER_FROM_MESSAGE;
@@ -1044,7 +1044,7 @@ static int git_format_config(const char *var, const char *value,
 	if (!strcmp(var, "format.signature"))
 		return git_config_string(&signature, var, value);
 	if (!strcmp(var, "format.signaturefile"))
-		return git_config_pathname(&signature_file, var, value);
+		return git_config_pathname_dup(&signature_file, var, value);
 	if (!strcmp(var, "format.coverletter")) {
 		if (value && !strcasecmp(value, "auto")) {
 			config_cover_letter = COVER_AUTO;
diff --git a/config.c b/config.c
index 449b8f4f66..c2863d6514 100644
--- a/config.c
+++ b/config.c
@@ -1434,10 +1434,10 @@ static int git_default_core_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "core.attributesfile"))
-		return git_config_pathname(&git_attributes_file, var, value);
+		return git_config_pathname_dup(&git_attributes_file, var, value);
 
 	if (!strcmp(var, "core.hookspath"))
-		return git_config_pathname(&git_hooks_path, var, value);
+		return git_config_pathname_dup(&git_hooks_path, var, value);
 
 	if (!strcmp(var, "core.bare")) {
 		is_bare_repository_cfg = git_config_bool(var, value);
@@ -1601,7 +1601,7 @@ static int git_default_core_config(const char *var, const char *value,
 		return git_config_string_dup(&askpass_program, var, value);
 
 	if (!strcmp(var, "core.excludesfile"))
-		return git_config_pathname(&excludes_file, var, value);
+		return git_config_pathname_dup(&excludes_file, var, value);
 
 	if (!strcmp(var, "core.whitespace")) {
 		if (!value)
@@ -1780,7 +1780,7 @@ static int git_default_push_config(const char *var, const char *value)
 static int git_default_mailmap_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "mailmap.file"))
-		return git_config_pathname(&git_mailmap_file, var, value);
+		return git_config_pathname_dup(&git_mailmap_file, var, value);
 	if (!strcmp(var, "mailmap.blob"))
 		return git_config_string_dup(&git_mailmap_blob, var, value);
 
diff --git a/diff.c b/diff.c
index bb00bc1110..6236746920 100644
--- a/diff.c
+++ b/diff.c
@@ -58,7 +58,7 @@ static int diff_context_default = 3;
 static int diff_interhunk_context_default;
 static char *diff_word_regex_cfg;
 static char *external_diff_cmd_cfg;
-static const char *diff_order_file_cfg;
+static char *diff_order_file_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
 static int diff_no_prefix;
@@ -433,7 +433,7 @@ int git_diff_ui_config(const char *var, const char *value,
 	if (!strcmp(var, "diff.wordregex"))
 		return git_config_string_dup(&diff_word_regex_cfg, var, value);
 	if (!strcmp(var, "diff.orderfile"))
-		return git_config_pathname(&diff_order_file_cfg, var, value);
+		return git_config_pathname_dup(&diff_order_file_cfg, var, value);
 
 	if (!strcmp(var, "diff.ignoresubmodules")) {
 		if (!value)
diff --git a/environment.c b/environment.c
index 5e9fab4d1a..87123f902c 100644
--- a/environment.c
+++ b/environment.c
@@ -46,8 +46,8 @@ char *git_commit_encoding;
 char *git_log_output_encoding;
 char *apply_default_whitespace;
 char *apply_default_ignorewhitespace;
-const char *git_attributes_file;
-const char *git_hooks_path;
+char *git_attributes_file;
+char *git_hooks_path;
 int zlib_compression_level = Z_BEST_SPEED;
 int pack_compression_level = Z_DEFAULT_COMPRESSION;
 int fsync_object_files = -1;
@@ -60,7 +60,7 @@ size_t delta_base_cache_limit = 96 * 1024 * 1024;
 unsigned long big_file_threshold = 512 * 1024 * 1024;
 char *editor_program;
 char *askpass_program;
-const char *excludes_file;
+char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 enum eol core_eol = EOL_UNSET;
 int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
diff --git a/environment.h b/environment.h
index f06024a457..c33f101b24 100644
--- a/environment.h
+++ b/environment.h
@@ -124,8 +124,8 @@ extern int warn_ambiguous_refs;
 extern int warn_on_object_refname_ambiguity;
 extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
-extern const char *git_attributes_file;
-extern const char *git_hooks_path;
+extern char *git_attributes_file;
+extern char *git_hooks_path;
 extern int zlib_compression_level;
 extern int pack_compression_level;
 extern size_t packed_git_window_size;
@@ -222,7 +222,7 @@ extern char *git_log_output_encoding;
 
 extern char *editor_program;
 extern char *askpass_program;
-extern const char *excludes_file;
+extern char *excludes_file;
 
 /*
  * Should we print an ellipsis after an abbreviated SHA-1 value
diff --git a/gpg-interface.c b/gpg-interface.c
index 4b2f70ef44..d6e45ff09c 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -28,7 +28,7 @@ static void gpg_interface_lazy_init(void)
 
 static char *configured_signing_key;
 static char *ssh_default_key_command;
-static const char *ssh_allowed_signers, *ssh_revocation_file;
+static char *ssh_allowed_signers, *ssh_revocation_file;
 static enum signature_trust_level configured_min_trust_level = TRUST_UNDEFINED;
 
 struct gpg_format {
@@ -766,10 +766,10 @@ static int git_gpg_config(const char *var, const char *value,
 		return git_config_string_dup(&ssh_default_key_command, var, value);
 
 	if (!strcmp(var, "gpg.ssh.allowedsignersfile"))
-		return git_config_pathname(&ssh_allowed_signers, var, value);
+		return git_config_pathname_dup(&ssh_allowed_signers, var, value);
 
 	if (!strcmp(var, "gpg.ssh.revocationfile"))
-		return git_config_pathname(&ssh_revocation_file, var, value);
+		return git_config_pathname_dup(&ssh_revocation_file, var, value);
 
 	if (!strcmp(var, "gpg.program") || !strcmp(var, "gpg.openpgp.program"))
 		fmtname = "openpgp";
diff --git a/mailmap.c b/mailmap.c
index 9bd11c90e6..b2efe29b3d 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -6,7 +6,7 @@
 #include "object-store-ll.h"
 #include "setup.h"
 
-const char *git_mailmap_file;
+char *git_mailmap_file;
 char *git_mailmap_blob;
 
 struct mailmap_info {
diff --git a/mailmap.h b/mailmap.h
index a1bc019b52..cbda9bc5e0 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -3,7 +3,7 @@
 
 struct string_list;
 
-extern const char *git_mailmap_file;
+extern char *git_mailmap_file;
 extern char *git_mailmap_blob;
 
 int read_mailmap(struct string_list *map);
-- 
2.44.0.872.g288abe5b5b

