Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4320F1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 19:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387576AbfHZT6N (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 15:58:13 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:56800 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733288AbfHZT6M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 15:58:12 -0400
Date:   Mon, 26 Aug 2019 19:58:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=proton;
        t=1566849488; bh=6GDsF0/zap1eXiCI86XOJ743P4cMA9H6nHPS1HcLlko=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=JAL2v4CH7IauJ3+OGlrwkavDm9CZ0h2KoJa0mDo/w7kx3UOY65gYtTktFcVphzRSW
         cZafZUO8769/gDwcKp+y+Rd5Ow0LcpfdOR52YKfnhRLzyReNYik7crB2U/Y3RBDL1z
         LwTR7rcm9U2E0CUKjtNsYpAbqRshyxVT/sDb720mcLeJth50heElmaW3IlNro+U2Ml
         bW0TxNgjZc7+sAu+VuXhB7eB4BCXFEkV2tpccztT5D5Vc4E3kShitIh64Ds4u2tBGG
         X9TD+aTQRajjtJxchnUUMtUJAB3OIF1K60dVEp3hnR8Oecy1+d0OcAgWJ1cu6Gm1ao
         EkUWjuLkxQ5Yg==
To:     git@vger.kernel.org
From:   Ibrahim El <ibrahim.el@pm.me>
Cc:     Ibrahim El Rhezzali <ibrahim.el@pm.me>
Reply-To: Ibrahim El <ibrahim.el@pm.me>
Subject: [PATCH 3/5] Signing API: Migrated to the new signing interface API
Message-ID: <GSHQf1g8UZwwtt5kzbA3GmLTulyYELqEIes51wFqZMG6FP5WpWZwsfnsV5cx74e5gbGBgRaNGY1B-SVRi3PMUZoIg3APf9XAa3bLMw8HHDw=@pm.me>
Feedback-ID: RXIF8gqyi_fC5k95OfXmu3uPk6ALUZ4LT1y2TXMvXkIlhKcvgGbg1qhMCvct9LiRFa1gVJ9p8_D_liW8QUFSlg==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ibrahim El Rhezzali <ibrahim.el@pm.me>

0affa9e2a Migrated to the new signing interface API

Updating the code to use the new signing interface API. Old GPG interface c=
ode is commented and not used

Signed-off-by: Ibrahim El <ibrahim.el@pm.me>
---
 builtin/am.c            |  3 ++-
 builtin/commit-tree.c   |  4 ++--
 builtin/commit.c        |  4 ++--
 builtin/fmt-merge-msg.c |  2 +-
 builtin/log.c           |  4 ++--
 builtin/merge.c         |  4 ++--
 builtin/push.c          |  3 ++-
 builtin/receive-pack.c  |  4 ++--
 builtin/send-pack.c     |  4 ++--
 builtin/tag.c           | 13 +++++++------
 builtin/verify-commit.c | 12 ++++++------
 builtin/verify-tag.c    | 10 +++++-----
 commit.c                | 13 +++++++------
 commit.h                |  4 ++--
 gpg-interface.c         |  5 ++++-
 gpg-interface.h         |  3 +++
 log-tree.c              |  2 +-
 pretty.c                |  8 ++++----
 ref-filter.c            |  1 +
 send-pack.c             |  5 +++--
 sequencer.c             |  3 ++-
 tag.c                   | 10 +++++-----
 22 files changed, 67 insertions(+), 54 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 78389d08b..a76efdd5d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -34,6 +34,7 @@
 #include "string-list.h"
 #include "packfile.h"
 #include "repository.h"
+#include "signing-interface.h"
=20
 /**
  * Returns the length of the first line of msg.
@@ -2143,7 +2144,7 @@ static int git_am_config(const char *k, const char *v=
, void *cb)
 {
 =09int status;
=20
-=09status =3D git_gpg_config(k, v, NULL);
+=09status =3D git_signing_config(k, v, NULL);
 =09if (status)
 =09=09return status;
=20
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index b866d8395..06bc5016d 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -11,7 +11,7 @@
 #include "tree.h"
 #include "builtin.h"
 #include "utf8.h"
-#include "gpg-interface.h"
+#include "signing-interface.h"
 #include "parse-options.h"
=20
 static const char * const commit_tree_usage[] =3D {
@@ -38,7 +38,7 @@ static void new_parent(struct commit *parent, struct comm=
it_list **parents_p)
=20
 static int commit_tree_config(const char *var, const char *value, void *cb=
)
 {
-=09int status =3D git_gpg_config(var, value, NULL);
+=09int status =3D git_signing_config(var, value, NULL);
 =09if (status)
 =09=09return status;
 =09return git_default_config(var, value, cb);
diff --git a/builtin/commit.c b/builtin/commit.c
index 1c9e8e222..3b446a029 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -29,7 +29,7 @@
 #include "unpack-trees.h"
 #include "quote.h"
 #include "submodule.h"
-#include "gpg-interface.h"
+#include "signing-interface.h"
 #include "column.h"
 #include "sequencer.h"
 #include "mailmap.h"
@@ -1437,7 +1437,7 @@ static int git_commit_config(const char *k, const cha=
r *v, void *cb)
 =09=09return 0;
 =09}
=20
-=09status =3D git_gpg_config(k, v, NULL);
+=09status =3D git_signing_config(k, v, NULL);
 =09if (status)
 =09=09return status;
 =09return git_status_config(k, v, s);
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index a4615587f..2dd0e9367 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -10,7 +10,7 @@
 #include "string-list.h"
 #include "branch.h"
 #include "fmt-merge-msg.h"
-#include "gpg-interface.h"
+#include "signing-interface.h"
 #include "repository.h"
 #include "commit-reach.h"
=20
diff --git a/builtin/log.c b/builtin/log.c
index 7c8767d3b..96507f0d9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -28,7 +28,7 @@
 #include "streaming.h"
 #include "version.h"
 #include "mailmap.h"
-#include "gpg-interface.h"
+#include "signing-interface.h"
 #include "progress.h"
 #include "commit-slab.h"
 #include "repository.h"
@@ -465,7 +465,7 @@ static int git_log_config(const char *var, const char *=
value, void *cb)
=20
 =09if (grep_config(var, value, cb) < 0)
 =09=09return -1;
-=09if (git_gpg_config(var, value, cb) < 0)
+=09if (git_signing_config(var, value, cb) < 0)
 =09=09return -1;
 =09return git_diff_ui_config(var, value, cb);
 }
diff --git a/builtin/merge.c b/builtin/merge.c
index 6e99aead4..67a0bcb35 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -31,7 +31,7 @@
 #include "resolve-undo.h"
 #include "remote.h"
 #include "fmt-merge-msg.h"
-#include "gpg-interface.h"
+#include "signing-interface.h"
 #include "sequencer.h"
 #include "string-list.h"
 #include "packfile.h"
@@ -636,7 +636,7 @@ static int git_merge_config(const char *k, const char *=
v, void *cb)
 =09status =3D fmt_merge_msg_config(k, v, cb);
 =09if (status)
 =09=09return status;
-=09status =3D git_gpg_config(k, v, NULL);
+=09status =3D git_signing_config(k, v, NULL);
 =09if (status)
 =09=09return status;
 =09return git_diff_ui_config(k, v, cb);
diff --git a/builtin/push.c b/builtin/push.c
index 021dd3b1e..74a6758cd 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -14,6 +14,7 @@
 #include "submodule-config.h"
 #include "send-pack.h"
 #include "color.h"
+#include "signing-interface.h"
=20
 static const char * const push_usage[] =3D {
 =09N_("git push [<options>] [<repository> [<refspec>...]]"),
@@ -479,7 +480,7 @@ static int git_push_config(const char *k, const char *v=
, void *cb)
 =09int *flags =3D cb;
 =09int status;
=20
-=09status =3D git_gpg_config(k, v, NULL);
+=09status =3D git_signing_config(k, v, NULL);
 =09if (status)
 =09=09return status;
=20
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 77b712245..1a90dea5a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -19,7 +19,7 @@
 #include "argv-array.h"
 #include "version.h"
 #include "tag.h"
-#include "gpg-interface.h"
+#include "signing-interface.h"
 #include "sigchain.h"
 #include "fsck.h"
 #include "tmp-objdir.h"
@@ -73,7 +73,7 @@ static int shallow_update;
 static const char *alt_shallow_file;
 static struct strbuf push_cert =3D STRBUF_INIT;
 static struct object_id push_cert_oid;
-static struct signature_check sigcheck;
+static struct signature sigcheck;
 static const char *push_cert_nonce;
 static const char *cert_nonce_seed;
=20
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 098ebf22d..ba21fb2df 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -12,7 +12,7 @@
 #include "transport.h"
 #include "version.h"
 #include "sha1-array.h"
-#include "gpg-interface.h"
+#include "signing-interface.h"
 #include "gettext.h"
 #include "protocol.h"
=20
@@ -101,7 +101,7 @@ static void print_helper_status(struct ref *ref)
=20
 static int send_pack_config(const char *k, const char *v, void *cb)
 {
-=09git_gpg_config(k, v, NULL);
+=09git_signing_config(k, v, NULL);
=20
 =09if (!strcmp(k, "push.gpgsign")) {
 =09=09const char *value;
diff --git a/builtin/tag.c b/builtin/tag.c
index ef37dccf8..a52aa54c0 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -16,7 +16,7 @@
 #include "parse-options.h"
 #include "diff.h"
 #include "revision.h"
-#include "gpg-interface.h"
+#include "signing-interface.h"
 #include "sha1-array.h"
 #include "column.h"
 #include "ref-filter.h"
@@ -111,10 +111,10 @@ static int verify_tag(const char *name, const char *r=
ef,
 {
 =09int flags;
 =09const struct ref_format *format =3D cb_data;
-=09flags =3D GPG_VERIFY_VERBOSE;
+=09flags =3D OUTPUT_VERBOSE;
=20
 =09if (format->format)
-=09=09flags =3D GPG_VERIFY_OMIT_STATUS;
+=09=09flags =3D OUTPUT_OMIT_STATUS;
=20
 =09if (gpg_verify_tag(oid, name, flags))
 =09=09return -1;
@@ -127,7 +127,8 @@ static int verify_tag(const char *name, const char *ref=
,
=20
 static int do_sign(struct strbuf *buffer)
 {
-=09return sign_buffer(buffer, buffer, get_signing_key());
+=09extern enum signature_type default_type;
+=09return sign_buffer(buffer, buffer, get_signing_key(default_type));
 }
=20
 static const char tag_template[] =3D
@@ -151,7 +152,7 @@ static int git_tag_config(const char *var, const char *=
value, void *cb)
 =09=09return 0;
 =09}
=20
-=09status =3D git_gpg_config(var, value, cb);
+=09status =3D git_signing_config(var, value, cb);
 =09if (status)
 =09=09return status;
 =09if (!strcmp(var, "tag.forcesignannotated")) {
@@ -447,7 +448,7 @@ int cmd_tag(int argc, const char **argv, const char *pr=
efix)
=20
 =09if (keyid) {
 =09=09opt.sign =3D 1;
-=09=09set_signing_key(keyid);
+=09=09set_signing_key(keyid, default_type);
 =09}
 =09create_tag_object =3D (opt.sign || annotate || msg.given || msgfile);
=20
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 4b9e823f8..0f701ee70 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -14,7 +14,7 @@
 #include "run-command.h"
 #include <signal.h>
 #include "parse-options.h"
-#include "gpg-interface.h"
+#include "signing-interface.h"
=20
 static const char * const verify_commit_usage[] =3D {
 =09=09N_("git verify-commit [-v | --verbose] <commit>..."),
@@ -23,7 +23,7 @@ static const char * const verify_commit_usage[] =3D {
=20
 static int run_gpg_verify(struct commit *commit, unsigned flags)
 {
-=09struct signature_check signature_check;
+=09struct signature signature_check;
 =09int ret;
=20
 =09memset(&signature_check, 0, sizeof(signature_check));
@@ -31,7 +31,7 @@ static int run_gpg_verify(struct commit *commit, unsigned=
 flags)
 =09ret =3D check_commit_signature(commit, &signature_check);
 =09print_signature_buffer(&signature_check, flags);
=20
-=09signature_check_clear(&signature_check);
+=09signature_clear(&signature_check);
 =09return ret;
 }
=20
@@ -55,7 +55,7 @@ static int verify_commit(const char *name, unsigned flags=
)
=20
 static int git_verify_commit_config(const char *var, const char *value, vo=
id *cb)
 {
-=09int status =3D git_gpg_config(var, value, cb);
+=09int status =3D git_signing_config(var, value, cb);
 =09if (status)
 =09=09return status;
 =09return git_default_config(var, value, cb);
@@ -67,7 +67,7 @@ int cmd_verify_commit(int argc, const char **argv, const =
char *prefix)
 =09unsigned flags =3D 0;
 =09const struct option verify_commit_options[] =3D {
 =09=09OPT__VERBOSE(&verbose, N_("print commit contents")),
-=09=09OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), GPG_VER=
IFY_RAW),
+=09=09OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), OUTPUT_=
RAW),
 =09=09OPT_END()
 =09};
=20
@@ -79,7 +79,7 @@ int cmd_verify_commit(int argc, const char **argv, const =
char *prefix)
 =09=09usage_with_options(verify_commit_usage, verify_commit_options);
=20
 =09if (verbose)
-=09=09flags |=3D GPG_VERIFY_VERBOSE;
+=09=09flags |=3D OUTPUT_VERBOSE;
=20
 =09/* sometimes the program was terminated because this signal
 =09 * was received in the process of writing the gpg input: */
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 6fa04b751..d25f47d38 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -12,7 +12,7 @@
 #include "run-command.h"
 #include <signal.h>
 #include "parse-options.h"
-#include "gpg-interface.h"
+#include "signing-interface.h"
 #include "ref-filter.h"
=20
 static const char * const verify_tag_usage[] =3D {
@@ -22,7 +22,7 @@ static const char * const verify_tag_usage[] =3D {
=20
 static int git_verify_tag_config(const char *var, const char *value, void =
*cb)
 {
-=09int status =3D git_gpg_config(var, value, cb);
+=09int status =3D git_signing_config(var, value, cb);
 =09if (status)
 =09=09return status;
 =09return git_default_config(var, value, cb);
@@ -35,7 +35,7 @@ int cmd_verify_tag(int argc, const char **argv, const cha=
r *prefix)
 =09struct ref_format format =3D REF_FORMAT_INIT;
 =09const struct option verify_tag_options[] =3D {
 =09=09OPT__VERBOSE(&verbose, N_("print tag contents")),
-=09=09OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), GPG_VER=
IFY_RAW),
+=09=09OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), OUTPUT_=
RAW),
 =09=09OPT_STRING(0, "format", &format.format, N_("format"), N_("format to =
use for the output")),
 =09=09OPT_END()
 =09};
@@ -48,13 +48,13 @@ int cmd_verify_tag(int argc, const char **argv, const c=
har *prefix)
 =09=09usage_with_options(verify_tag_usage, verify_tag_options);
=20
 =09if (verbose)
-=09=09flags |=3D GPG_VERIFY_VERBOSE;
+=09=09flags |=3D OUTPUT_VERBOSE;
=20
 =09if (format.format) {
 =09=09if (verify_ref_format(&format))
 =09=09=09usage_with_options(verify_tag_usage,
 =09=09=09=09=09   verify_tag_options);
-=09=09flags |=3D GPG_VERIFY_OMIT_STATUS;
+=09=09flags |=3D OUTPUT_OMIT_STATUS;
 =09}
=20
 =09while (i < argc) {
diff --git a/commit.c b/commit.c
index 8fa1883c6..2727c9231 100644
--- a/commit.c
+++ b/commit.c
@@ -10,7 +10,7 @@
 #include "revision.h"
 #include "notes.h"
 #include "alloc.h"
-#include "gpg-interface.h"
+#include "signing-interface.h"
 #include "mergesort.h"
 #include "commit-slab.h"
 #include "prio-queue.h"
@@ -953,8 +953,9 @@ static int do_sign_commit(struct strbuf *buf, const cha=
r *keyid)
 =09else
 =09=09inspos =3D eoh - buf->buf + 1;
=20
-=09if (!keyid || !*keyid)
-=09=09keyid =3D get_signing_key();
+=09if (!keyid || !*keyid) {
+=09=09keyid =3D get_signing_key(default_type);
+=09}
 =09if (sign_buffer(buf, &sig, keyid)) {
 =09=09strbuf_release(&sig);
 =09=09return -1;
@@ -1092,7 +1093,7 @@ static void handle_signed_tag(struct commit *parent, =
struct commit_extra_header
 =09free(buf);
 }
=20
-int check_commit_signature(const struct commit *commit, struct signature_c=
heck *sigc)
+int check_commit_signature(const struct commit *commit, struct signature *=
sigc)
 {
 =09struct strbuf payload =3D STRBUF_INIT;
 =09struct strbuf signature =3D STRBUF_INIT;
@@ -1115,7 +1116,7 @@ int check_commit_signature(const struct commit *commi=
t, struct signature_check *
 void verify_merge_signature(struct commit *commit, int verbosity)
 {
 =09char hex[GIT_MAX_HEXSZ + 1];
-=09struct signature_check signature_check;
+=09struct signature signature_check;
 =09memset(&signature_check, 0, sizeof(signature_check));
=20
 =09check_commit_signature(commit, &signature_check);
@@ -1137,7 +1138,7 @@ void verify_merge_signature(struct commit *commit, in=
t verbosity)
 =09=09printf(_("Commit %s has a good GPG signature by %s\n"),
 =09=09       hex, signature_check.signer);
=20
-=09signature_check_clear(&signature_check);
+=09signature_clear(&signature_check);
 }
=20
 void append_merge_tag_headers(struct commit_list *parents,
diff --git a/commit.h b/commit.h
index f5295ca7f..f5a942fc5 100644
--- a/commit.h
+++ b/commit.h
@@ -5,7 +5,7 @@
 #include "tree.h"
 #include "strbuf.h"
 #include "decorate.h"
-#include "gpg-interface.h"
+#include "signing-interface.h"
 #include "string-list.h"
 #include "pretty.h"
 #include "commit-slab.h"
@@ -370,7 +370,7 @@ int remove_signature(struct strbuf *buf);
  * at all.  This may allocate memory for sig->gpg_output, sig->gpg_status,
  * sig->signer and sig->key.
  */
-int check_commit_signature(const struct commit *commit, struct signature_c=
heck *sigc);
+int check_commit_signature(const struct commit *commit, struct signature *=
sigc);
=20
 /* record author-date for each commit object */
 struct author_date_slab;
diff --git a/gpg-interface.c b/gpg-interface.c
index 8ed274533..5e7dee6fe 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -6,6 +6,7 @@
 #include "sigchain.h"
 #include "tempfile.h"
=20
+#if 0
 static char *configured_signing_key;
 struct gpg_format {
 =09const char *name;
@@ -289,7 +290,7 @@ const char *get_signing_key(void)
 }
=20
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const cha=
r *signing_key)
-{
+{=09
 =09struct child_process gpg =3D CHILD_PROCESS_INIT;
 =09int ret;
 =09size_t i, j, bottom;
@@ -376,3 +377,5 @@ int verify_signed_buffer(const char *payload, size_t pa=
yload_size,
=20
 =09return ret;
 }
+
+#endif
\ No newline at end of file
diff --git a/gpg-interface.h b/gpg-interface.h
index 3e624ec28..c808d1685 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -1,6 +1,7 @@
 #ifndef GPG_INTERFACE_H
 #define GPG_INTERFACE_H
=20
+#if 0
 struct strbuf;
=20
 #define GPG_VERIFY_VERBOSE=09=091
@@ -65,3 +66,5 @@ void print_signature_buffer(const struct signature_check =
*sigc,
 =09=09=09    unsigned flags);
=20
 #endif
+
+#endif
\ No newline at end of file
diff --git a/log-tree.c b/log-tree.c
index 1e56df62a..c13a7e06d 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -11,7 +11,7 @@
 #include "refs.h"
 #include "string-list.h"
 #include "color.h"
-#include "gpg-interface.h"
+#include "signing-interface.h"
 #include "sequencer.h"
 #include "line-log.h"
 #include "help.h"
diff --git a/pretty.c b/pretty.c
index ced048525..f315755c3 100644
--- a/pretty.c
+++ b/pretty.c
@@ -10,7 +10,7 @@
 #include "notes.h"
 #include "color.h"
 #include "reflog-walk.h"
-#include "gpg-interface.h"
+#include "signing-interface.h"
 #include "trailer.h"
=20
 static char *user_format;
@@ -771,7 +771,7 @@ struct format_commit_context {
 =09const struct pretty_print_context *pretty_ctx;
 =09unsigned commit_header_parsed:1;
 =09unsigned commit_message_parsed:1;
-=09struct signature_check signature_check;
+=09struct signature signature_check;
 =09enum flush_type flush_type;
 =09enum trunc_type truncate;
 =09const char *message;
@@ -1292,8 +1292,8 @@ static size_t format_commit_one(struct strbuf *sb, /*=
 in UTF-8 */
 =09=09=09check_commit_signature(c->commit, &(c->signature_check));
 =09=09switch (placeholder[1]) {
 =09=09case 'G':
-=09=09=09if (c->signature_check.gpg_output)
-=09=09=09=09strbuf_addstr(sb, c->signature_check.gpg_output);
+=09=09=09if (c->signature_check.output.buf)
+=09=09=09=09strbuf_addstr(sb, c->signature_check.output.buf);
 =09=09=09break;
 =09=09case '?':
 =09=09=09switch (c->signature_check.result) {
diff --git a/ref-filter.c b/ref-filter.c
index 8500671bc..277fcc04e 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -20,6 +20,7 @@
 #include "commit-slab.h"
 #include "commit-graph.h"
 #include "commit-reach.h"
+#include "signing-interface.h"
=20
 static struct ref_msg {
 =09const char *gone;
diff --git a/send-pack.c b/send-pack.c
index 6dc16c321..6db779964 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -13,7 +13,7 @@
 #include "transport.h"
 #include "version.h"
 #include "sha1-array.h"
-#include "gpg-interface.h"
+#include "signing-interface.h"
 #include "cache.h"
=20
 int option_parse_push_signed(const struct option *opt,
@@ -269,7 +269,8 @@ static int generate_push_cert(struct strbuf *req_buf,
 {
 =09const struct ref *ref;
 =09struct string_list_item *item;
-=09char *signing_key =3D xstrdup(get_signing_key());
+=09extern enum signature_type default_type;
+=09char *signing_key =3D xstrdup(get_signing_key(default_type));
 =09const char *cp, *np;
 =09struct strbuf cert =3D STRBUF_INIT;
 =09int update_seen =3D 0;
diff --git a/sequencer.c b/sequencer.c
index ab74b6baf..e3cfe40d2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -32,6 +32,7 @@
 #include "alias.h"
 #include "commit-reach.h"
 #include "rebase-interactive.h"
+#include "signing-interface.h"
=20
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
=20
@@ -197,7 +198,7 @@ static int git_sequencer_config(const char *k, const ch=
ar *v, void *cb)
 =09=09return 0;
 =09}
=20
-=09status =3D git_gpg_config(k, v, NULL);
+=09status =3D git_signing_config(k, v, NULL);
 =09if (status)
 =09=09return status;
=20
diff --git a/tag.c b/tag.c
index 7445b8f6e..d9bbf5249 100644
--- a/tag.c
+++ b/tag.c
@@ -5,14 +5,14 @@
 #include "tree.h"
 #include "blob.h"
 #include "alloc.h"
-#include "gpg-interface.h"
+#include "signing-interface.h"
 #include "packfile.h"
=20
 const char *tag_type =3D "tag";
=20
 static int run_gpg_verify(const char *buf, unsigned long size, unsigned fl=
ags)
 {
-=09struct signature_check sigc;
+=09struct signature sigc;
 =09size_t payload_size;
 =09int ret;
=20
@@ -21,7 +21,7 @@ static int run_gpg_verify(const char *buf, unsigned long =
size, unsigned flags)
 =09payload_size =3D parse_signature(buf, size);
=20
 =09if (size =3D=3D payload_size) {
-=09=09if (flags & GPG_VERIFY_VERBOSE)
+=09=09if (flags & OUTPUT_VERBOSE)
 =09=09=09write_in_full(1, buf, payload_size);
 =09=09return error("no signature found");
 =09}
@@ -29,10 +29,10 @@ static int run_gpg_verify(const char *buf, unsigned lon=
g size, unsigned flags)
 =09ret =3D check_signature(buf, payload_size, buf + payload_size,
 =09=09=09=09size - payload_size, &sigc);
=20
-=09if (!(flags & GPG_VERIFY_OMIT_STATUS))
+=09if (!(flags & OUTPUT_OMIT_STATUS))
 =09=09print_signature_buffer(&sigc, flags);
=20
-=09signature_check_clear(&sigc);
+=09signature_clear(&sigc);
 =09return ret;
 }
=20
--=20
2.11.0


