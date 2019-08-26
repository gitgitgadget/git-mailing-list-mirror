Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EFB01F461
	for <e@80x24.org>; Mon, 26 Aug 2019 19:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387737AbfHZT6Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 15:58:16 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:52292 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733174AbfHZT6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 15:58:16 -0400
Date:   Mon, 26 Aug 2019 19:58:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=proton;
        t=1566849486; bh=4vak4HDlH0sDUl09rtlzG7s4XMchL59qmKkILe06HhU=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=RrSLQmBb7AkzFvEwWrVs/8T1WFfAEWidaK6jvlqGTPenrRwSiAzwHJee9UGGtpU7G
         j0R/qVvCcB1FRS2kSJXpTG33uLjid+eWTxslTjL84p1Lvoi5B7ExZRnJsnU3eUShhN
         tBiIgU2TA8P5HOpMyWApLZmiEawhXSm/vS6i/dhB5E5VcB4aJgA2/b0S4FpQa1xhAR
         IIy90KYdNXyHHgwOwPf4jHDXi4sI7HhYqDfoyYCpBDdQCqUaxGZos80YfiKrBGKEWz
         Nm9CZmyg8TkphKxA0IGsIUwYdTJcY4bffnf4WQ7erNGhpHQtURD8EEVnGGlCIYJ44j
         2qgqZlinG7K5Q==
To:     git@vger.kernel.org
From:   Ibrahim El <ibrahim.el@pm.me>
Cc:     Ibrahim El Rhezzali <ibrahim.el@pm.me>
Reply-To: Ibrahim El <ibrahim.el@pm.me>
Subject: [PATCH 2/5] Signing API: Added new signing interface API
Message-ID: <CkxnpIEi2c1o1FmI2ZJP8CJQybGMZFbL6uQAd3w7ApKdaki4vcCrlgbTWmPMrrfIedBSvLV56q6txzvCo7bnO1wHlS6cB3bUYpYfNW80w_s=@pm.me>
Feedback-ID: RXIF8gqyi_fC5k95OfXmu3uPk6ALUZ4LT1y2TXMvXkIlhKcvgGbg1qhMCvct9LiRFa1gVJ9p8_D_liW8QUFSlg==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ibrahim El Rhezzali <ibrahim.el@pm.me>

7e3e6c9e4 Added new signing interface API

Adding files for the new signing interface and also support drivers for the=
 two existing GPG and GPGSM X.509 tools

Signed-off-by: Ibrahim El <ibrahim.el@pm.me>
---
 Makefile               |   3 +
 signing-interface.c    | 487 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 signing-interface.h    | 151 +++++++++++++++
 signing-tool-openpgp.c | 409 +++++++++++++++++++++++++++++++++++++++++
 signing-tool-x509.c    | 383 ++++++++++++++++++++++++++++++++++++++
 signing-tool.h         |  35 ++++
 6 files changed, 1468 insertions(+)
 create mode 100644 signing-interface.c
 create mode 100644 signing-interface.h
 create mode 100644 signing-tool-openpgp.c
 create mode 100644 signing-tool-x509.c
 create mode 100644 signing-tool.h

diff --git a/Makefile b/Makefile
index f58bf14c7..244540e8d 100644
--- a/Makefile
+++ b/Makefile
@@ -978,6 +978,9 @@ LIB_OBJS +=3D sha1-name.o
 LIB_OBJS +=3D shallow.o
 LIB_OBJS +=3D sideband.o
 LIB_OBJS +=3D sigchain.o
+LIB_OBJS +=3D signing-interface.o
+LIB_OBJS +=3D signing-tool-openpgp.o
+LIB_OBJS +=3D signing-tool-x509.o
 LIB_OBJS +=3D split-index.o
 LIB_OBJS +=3D strbuf.o
 LIB_OBJS +=3D streaming.o
diff --git a/signing-interface.c b/signing-interface.c
new file mode 100644
index 000000000..c744ef499
--- /dev/null
+++ b/signing-interface.c
@@ -0,0 +1,487 @@
+#include <sys/types.h>
+#include <unistd.h>
+#include "cache.h"
+#include "config.h"
+#include "run-command.h"
+#include "strbuf.h"
+#include "signing-interface.h"
+#include "signing-tool.h"
+#include "sigchain.h"
+#include "tempfile.h"
+
+extern const struct signing_tool openpgp_tool;
+extern const struct signing_tool x509_tool;
+
+static const struct signing_tool *signing_tools[SIGNATURE_TYPE_COUNT] =3D =
{
+=09&openpgp_tool,
+=09&x509_tool,
+};
+
+enum signature_type default_type =3D SIGNATURE_TYPE_DEFAULT;
+static const char* unknown_signature_type =3D "unknown signature type";
+static char* default_signing_key =3D NULL;
+
+static void add_signature(struct signatures *sigs, struct signature *sig) =
{
+=09if (!sigs || !sig)
+=09=09return;
+=09ALLOC_GROW(sigs->sigs, sigs->nsigs + 1, sigs->alloc);
+=09sigs->sigs[sigs->nsigs++] =3D sig;
+}
+
+void signatures_clear(struct signatures *sigs)
+{
+=09size_t i;
+=09struct signature *psig;
+
+=09if (!sigs) return;
+=09
+=09for (i =3D 0; i < sigs->nsigs; i++) {
+=09=09psig =3D sigs->sigs[i];
+=09=09strbuf_release(&(psig->sig));
+=09=09strbuf_release(&(psig->output));
+=09=09strbuf_release(&(psig->status));
+=09=09FREE_AND_NULL(psig->signer);
+=09=09FREE_AND_NULL(psig->key);
+=09=09FREE_AND_NULL(psig->fingerprint);
+=09=09FREE_AND_NULL(psig->key);
+=09=09FREE_AND_NULL(psig);
+=09}
+=09FREE_AND_NULL(sigs->sigs);
+=09sigs->nsigs =3D 0;
+=09sigs->alloc =3D 0;
+}
+
+void signature_clear(struct signature *sigc)
+{
+=09FREE_AND_NULL(sigc->sig.buf);
+=09FREE_AND_NULL(sigc->output.buf);
+=09FREE_AND_NULL(sigc->status.buf);
+=09FREE_AND_NULL(sigc->signer);
+=09FREE_AND_NULL(sigc->key);
+=09FREE_AND_NULL(sigc->fingerprint);
+=09FREE_AND_NULL(sigc->primary_key_fingerprint);
+}
+
+int sign_payload(const char *payload, size_t size, struct signatures *sigs=
,
+=09=09enum signature_type st, const char *signing_key)
+{
+=09const struct signing_tool *tool;
+=09struct signature *psig =3D xmalloc(sizeof(struct signature));
+=09int ret;
+
+=09fflush(stdout);
+
+=09if (!sigs)
+=09=09return error("invalid signatures passed to sign function");
+
+=09if (!VALID_SIGNATURE_TYPE(st))
+=09=09return error("unsupported signature type: %d", st);
+
+=09tool =3D signing_tools[st];
+
+=09if (!tool || !tool->sign)
+=09=09BUG("signing tool %s undefined", signature_type_name(st));
+
+=09ret =3D tool->sign(payload, size, &psig, signing_key);
+=09if (!ret)
+=09=09add_signature(sigs, psig);
+=09else
+
+=09=09return error("signing operation failed");
+
+=09return 0;
+}
+
+int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const cha=
r *signing_key)
+{
+=09struct signatures sigs =3D SIGNATURES_INIT;
+=09enum signature_type st =3D default_type;
+
+=09int ret =3D sign_payload(buffer->buf, buffer->len, &sigs, st, signing_k=
ey);
+
+=09if (!ret)
+=09{
+=09=09strbuf_addstr(signature, sigs.sigs[0]->sig.buf);
+=09}
+
+=09return ret;
+}
+
+size_t parse_signatures(const char *payload, size_t size,=20
+=09=09struct signatures *sigs)
+{
+=09enum signature_type st;
+=09size_t first;
+=09size_t begin =3D 0;
+=09const struct signing_tool *tool;
+=09struct signature *psig =3D NULL;
+
+=09first =3D size;
+=09for (st =3D SIGNATURE_TYPE_FIRST; st < SIGNATURE_TYPE_LAST; st++) {
+=09=09tool =3D signing_tools[st];
+
+=09=09if (!tool || !tool->parse)
+=09=09=09BUG("signing tool %s undefined", signature_type_name(st));
+
+=09=09begin =3D tool->parse(payload, size, &psig);
+=09=09if (begin < size) {
+=09=09=09if (sigs)
+=09=09=09=09add_signature(sigs, psig);
+=09=09=09else
+=09=09=09=09FREE_AND_NULL(psig);
+
+=09=09=09first =3D begin;
+=09=09=09continue;
+=09=09}
+=09}
+
+=09return first;
+}
+
+size_t parse_signature(const char *buf, size_t size)
+{
+=09size_t match;
+=09struct signatures sigs =3D SIGNATURES_INIT;
+
+=09if ( !buf || !size )
+=09=09return size;
+
+=09match =3D parse_signatures(buf, size, &sigs);
+
+=09return match;
+}
+
+int verify_buffer_signatures(const char *payload, size_t size,
+=09=09struct signatures *sigs)
+{
+=09int ret =3D 0;
+=09size_t i;
+=09const struct signing_tool *tool;
+=09struct signature *psig;
+
+=09if (!sigs)
+=09=09error("invalid signatures passed to verify function");
+
+=09for (i =3D 0; i < sigs->nsigs; i++) {
+=09=09psig =3D sigs->sigs[i];
+=09=09tool =3D signing_tools[psig->st];
+
+=09=09if (!tool || !tool->verify)
+=09=09=09BUG("signing tool %s undefined", signature_type_name(psig->st));
+
+=09=09ret |=3D tool->verify(payload, size, psig);
+=09}
+
+=09return ret;
+}
+
+int verify_signed_buffer(const char *payload, size_t payload_size,
+=09=09=09 const char *signature, size_t signature_size,
+=09=09=09 struct strbuf *output, struct strbuf *status)
+{
+=09int ret;
+=09enum signature_type st;
+=09struct signature sig =3D SIGNATURE_INIT;
+=09struct signatures sigs =3D SIGNATURES_INIT;
+
+=09if ( !payload || !signature )
+=09=09return error("invalid payload or signature sent !");
+
+=09strbuf_addstr(&(sig.sig), signature);
+=09add_signature(&sigs, &sig);
+
+=09ret =3D verify_buffer_signatures(payload, payload_size, &sigs);
+
+=09/*  Some how gpg.format is not sometimes applied, temporary fix to loop=
 and STs */
+=09if (ret)
+=09{
+=09=09for (st =3D SIGNATURE_TYPE_FIRST; st < SIGNATURE_TYPE_LAST; st++)
+=09=09{
+=09=09=09sig.st =3D st;
+=09=09=09ret =3D verify_buffer_signatures(payload, payload_size, &sigs);
+=09=09=09if (!ret || sig.result !=3D '0')
+=09=09=09=09break;
+=09=09}
+=09}
+
+=09if (output)
+=09=09strbuf_addstr(output, sig.output.buf);
+=09if (status)
+=09=09strbuf_addstr(status, sig.status.buf);
+
+=09return ret;
+}
+
+int check_signature(const char *payload, size_t plen, const char *signatur=
e,
+=09size_t slen, struct signature *sigc)
+{
+=09int status;
+=09enum signature_type st;
+=09struct signatures sigs =3D SIGNATURES_INIT;
+=09struct signature sig =3D SIGNATURE_INIT;
+=09
+=09if (!payload || !signature || !sigc)
+=09=09BUG("invalid payload or signature sent !");
+
+=09strbuf_addstr(&(sig.sig), signature);
+=09sig.result =3D 'N';
+=09sig.st =3D default_type;
+
+=09add_signature(&sigs, &sig);
+
+=09status =3D verify_buffer_signatures(payload, plen, &sigs);
+
+=09/*  Some how gpg.format is not sometimes applied, temporary fix to loop=
 and STs */
+=09if (status)
+=09{
+=09=09for (st =3D SIGNATURE_TYPE_FIRST; st < SIGNATURE_TYPE_LAST; st++)
+=09=09{
+=09=09=09sig.st =3D st;
+=09=09=09status =3D verify_buffer_signatures(payload, plen, &sigs);
+=09=09=09if (!status || sig.result !=3D 'N')
+=09=09=09=09break;
+=09=09}
+=09}
+=09status |=3D sig.result !=3D 'G' && sig.result !=3D 'U';
+
+=09if (sig.signer && !sigc->signer)
+=09=09sigc->signer =3D xstrdup(sig.signer);
+=09if (sig.key && !sigc->key)
+=09=09sigc->key =3D xstrdup(sig.key);
+=09if (sig.fingerprint && !sigc->fingerprint)
+=09=09sigc->fingerprint =3D xstrdup(sig.fingerprint);
+=09if (sig.primary_key_fingerprint && !sigc->primary_key_fingerprint)
+=09=09sigc->primary_key_fingerprint =3D xstrdup(sig.primary_key_fingerprin=
t);=09
+
+=09sigc->st =3D sig.st;
+=09sigc->result =3D sig.result;
+=09
+=09strbuf_addstr(&(sigc->sig), payload);
+=09strbuf_addstr(&(sigc->output), sig.output.buf);
+=09strbuf_addstr(&(sigc->status), sig.status.buf);
+
+=09return !!status;
+}
+
+size_t strbuf_append_signatures(struct strbuf *buf, const struct signature=
s *sigs)
+{
+=09size_t i;
+=09struct signature *psig;
+
+=09if (!buf)
+=09=09BUG("invalid buffer passed to signature append function");
+
+=09if (!sigs)
+=09=09return 0;
+
+=09for (i =3D 0; i < sigs->nsigs; i++) {
+=09=09psig =3D sigs->sigs[i];
+=09=09strbuf_addbuf(buf, &(psig->sig));
+=09}
+
+=09return sigs->nsigs;
+}
+
+void print_signatures(const struct signatures *sigs, unsigned flags)
+{
+=09size_t i;
+=09const struct signing_tool *tool;
+=09const struct signature *psig;
+
+=09if (!sigs)
+=09=09error("invalid signatures passed to verify function");
+
+=09for (i =3D 0; i < sigs->nsigs; i++) {
+=09=09psig =3D sigs->sigs[i];
+=09=09tool =3D signing_tools[psig->st];
+
+=09=09if (!tool || !tool->print)
+=09=09=09BUG("signing tool %s undefined", signature_type_name(psig->st));
+
+=09=09tool->print(psig, flags);
+=09}
+}
+
+void print_signature_buffer(const struct signature *sigc, unsigned flags)
+{
+=09const struct signing_tool *tool;
+
+=09if (!sigc)
+=09=09error("invalid signatures passed to verify function");
+
+=09tool =3D signing_tools[default_type];
+
+=09if (!tool || !tool->print)
+=09=09BUG("signing tool %s undefined", signature_type_name(sigc->st));
+
+=09tool->print(sigc, flags);
+}
+
+enum signature_type signature_type_by_name(const char *name)
+{
+=09enum signature_type st;
+
+=09if (!name)
+=09=09return default_type;
+
+=09for (st =3D SIGNATURE_TYPE_FIRST; st < SIGNATURE_TYPE_LAST; st++)
+=09=09if (!strcmp(signing_tools[st]->name, name))
+=09=09=09return st;
+
+=09return error("unknown signature type: %s", name);
+}
+
+const char *signature_type_name(enum signature_type st)
+{
+=09if (!VALID_SIGNATURE_TYPE(st))
+=09=09return unknown_signature_type;
+
+=09return signing_tools[st]->name;
+}
+
+int git_signing_config(const char *var, const char *value, void *cb)
+{
+=09int ret =3D 0;
+=09char *t1, *t2, *t3, *buf;
+=09enum signature_type st;
+=09const struct signing_tool *tool;
+
+=09/* user.signingkey is a deprecated alias for signing.<signing.default>.=
key */
+=09if (!strcmp(var, "user.signingkey")) {
+=09=09if (!value)
+=09=09=09return config_error_nonbool(var);
+=09=09
+=09=09set_signing_key(value, default_type);
+
+=09=09return 0;
+=09}
+
+=09/* gpg.format is a deprecated alias for signing.default */
+=09if (!strcmp(var, "gpg.format") || !strcmp(var, "signing.default")) {
+=09=09if (!value)
+=09=09=09return config_error_nonbool(var);
+
+=09=09if (!VALID_SIGNATURE_TYPE((st =3D signature_type_by_name(value))))
+=09=09=09return config_error_nonbool(var);
+
+=09=09set_signature_type(st);
+
+=09=09return 0;
+=09}
+
+=09/* gpg.program is a deprecated alias for signing.openpgp.program */
+=09if (!strcmp(var, "gpg.program") || !strcmp(var, "signing.openpgp.progra=
m")) {
+=09=09ret =3D signing_tools[OPENPGP_SIGNATURE]->config(
+=09=09=09=09"program", value, cb);
+
+=09=09return ret;
+=09}
+
+=09/* gpg.x509.program is a deprecated alias for signing.x509.program */
+=09if (!strcmp(var, "gpg.x509.program") || !strcmp(var, "signing.x509.prog=
ram")) {
+=09=09ret =3D signing_tools[X509_SIGNATURE]->config(
+=09=09=09=09"program", value, cb);
+
+=09=09return ret;
+=09}
+
+=09buf =3D xstrdup(var);
+=09t1 =3D strtok(buf, ".");
+=09t2 =3D strtok(NULL, ".");
+=09t3 =3D strtok(NULL, ".");
+
+=09/* gpg.<format>.* is a deprecated alias for signing.<format>.* */
+=09if (!strcmp(t1, "gpg") || !strcmp(t1, "signing")) {
+=09=09if (!VALID_SIGNATURE_TYPE((st =3D signature_type_by_name(t2)))) {
+=09=09=09free(buf);
+=09=09=09return error("unsupported variable: %s", var);
+=09=09}
+
+=09=09tool =3D signing_tools[st];
+=09=09if (!tool || !tool->config) {
+=09=09=09free(buf);
+=09=09=09BUG("signing tool %s undefined", signature_type_name(tool->st));
+=09=09}
+
+=09=09ret =3D tool->config(t3, value, cb);
+=09}
+
+=09free(buf);
+=09return ret;
+}
+
+void set_signing_key(const char *key, enum signature_type st)
+{
+=09/*
+=09 * Make sure we track the latest default signing key so that if the
+=09 * default signing format changes after this, we can make sure the
+=09 * default signing tool knows the key to use.
+=09 */
+=09free(default_signing_key);
+=09default_signing_key =3D xstrdup(key);
+
+=09if (!VALID_SIGNATURE_TYPE(st))
+=09=09signing_tools[default_type]->set_key(key);
+=09else
+=09=09signing_tools[st]->set_key(key);
+}
+
+const char *get_signing_key(enum signature_type st)
+{
+=09if (!VALID_SIGNATURE_TYPE(st))
+=09=09return signing_tools[default_type]->get_key();
+
+=09return signing_tools[default_type]->get_key();
+}
+
+void set_signing_program(const char *signing_program, enum signature_type =
st)
+{
+=09/*
+=09 * Make sure we track the latest default signing program so that if the
+=09 * default signing format changes after this, we can make sure the
+=09 * default signing tool knows the program to use.
+=09 */
+
+=09if (!VALID_SIGNATURE_TYPE(st))
+=09=09signing_tools[default_type]->set_program(signing_program);
+=09else
+=09=09signing_tools[st]->set_program(signing_program);
+}
+
+const char *get_signing_program(enum signature_type st)
+{
+=09const char *signing_program =3D NULL;
+
+=09if (!VALID_SIGNATURE_TYPE(st)) {
+=09=09signing_program =3D signing_tools[default_type]->get_program();
+
+=09=09return signing_program;
+=09}
+
+=09signing_program =3D signing_tools[st]->get_program();
+
+=09return signing_program;
+}
+
+void set_signature_type(enum signature_type st)
+{
+=09if (!VALID_SIGNATURE_TYPE(st))
+=09=09return;
+
+=09default_type =3D st;
+
+=09/*=20
+=09 * If the signing key has been set, then make sure the new default
+=09 * signing tool knows about it. this fixes the order of operations
+=09 * error of parsing the default signing key and default signing
+=09 * format in arbitrary order.
+=09 */
+=09if (default_signing_key) {
+=09=09set_signing_key(default_signing_key, default_type);
+=09}
+}
+
+enum signature_type get_signature_type(void)
+{
+=09return default_type;
+}
\ No newline at end of file
diff --git a/signing-interface.h b/signing-interface.h
new file mode 100644
index 000000000..b55edbdb8
--- /dev/null
+++ b/signing-interface.h
@@ -0,0 +1,151 @@
+#ifndef SIGNING_INTERFACE_H
+#define SIGNING_INTERFACE_H
+
+struct strbuf;
+
+#define OUTPUT_VERBOSE=09=091
+#define OUTPUT_RAW=09=09=092
+#define OUTPUT_OMIT_STATUS=094
+
+enum signature_type {
+=09OPENPGP_SIGNATURE,
+=09X509_SIGNATURE,
+
+=09SIGNATURE_TYPE_LAST,
+=09SIGNATURE_TYPE_FIRST =3D OPENPGP_SIGNATURE,
+=09SIGNATURE_TYPE_COUNT =3D SIGNATURE_TYPE_LAST - SIGNATURE_TYPE_FIRST,
+=09SIGNATURE_TYPE_DEFAULT =3D OPENPGP_SIGNATURE,
+=09SIGNATURE_TYPE_UNKNOWN =3D -1
+};
+enum signature_type default_type;
+
+#define VALID_SIGNATURE_TYPE(x) \
+=09((x >=3D SIGNATURE_TYPE_FIRST) && (x < SIGNATURE_TYPE_LAST))
+
+struct signature {
+=09struct strbuf sig;
+=09struct strbuf output;
+=09struct strbuf status;
+=09enum signature_type st;
+
+=09/*
+=09 * possible "result":
+=09 * 0 (not checked)
+=09 * N (checked but no further result)
+=09 * U (untrusted good)
+=09 * G (good)
+=09 * B (bad)
+=09 */
+=09char result;
+=09char *signer;
+=09char *key;
+=09char *fingerprint;
+=09char *primary_key_fingerprint;
+};
+
+struct signatures {
+=09size_t nsigs;
+=09size_t alloc;
+=09struct signature **sigs;
+};
+
+#define SIGNATURES_INIT  { .nsigs =3D 0, .alloc =3D 0, .sigs =3D NULL }
+#define SIGNATURE_INIT  { .sig =3D STRBUF_INIT, .output =3D STRBUF_INIT, .=
status =3D STRBUF_INIT, .st =3D OPENPGP_SIGNATURE, .result =3D '0', .signer=
 =3D NULL, .key =3D NULL }
+
+void signatures_clear(struct signatures *sigs);
+void signature_clear(struct signature *sig);
+
+/*
+ * Create a detached signature for the contents of "payload" and append
+ * it to the list of signatures in "sigs". The signature type determines w=
hich
+ * type of signature to create and the optional "signing_key" specifies
+ * the key. If no signing key is specified the default key from the
+ * config will be used. If no default is found, then an error is
+ * returned. If the signing operation fails an error is returned.
+ */
+int sign_payload(const char *payload, size_t size, struct signatures *sigs=
,
+=09=09enum signature_type st, const char *signing_key);
+
+/*
+ * Bridge function to be called by the git code for buffer signature
+ */
+int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const cha=
r *signing_key);
+
+/*=20
+ * Look at the signed content (e.g. a signed tag object), whose payload
+ * is followed by one or more detached signatures. Return the offset of
+ * the first signature, or the size of the buf when there are no=20
+ * signatures. If a valid signatures struct is passed in, the signatures=
=20
+ * will be parsed and copied into its array of sigs.
+ */
+size_t parse_signatures(const char *payload, size_t size,
+=09=09struct signatures *sigs);
+
+/*
+ * Bridge function to be called by the git code for parsing signatures in =
a buffer
+ */
+size_t parse_signature(const char *buf, size_t size);
+
+/*
+ * Run the signature verification tools to see if the payload matches
+ * the detached signatures. The output and status of the of the checks
+ * is recorded in the signatures struct. The caller must use
+ * parse_signatures or sign_buffer to initialize the signatures struct
+ * before calling this function.
+ */
+int verify_signed_buffer(const char *payload, size_t payload_size,
+=09=09=09 const char *signature, size_t signature_size,
+=09=09=09 struct strbuf *output, struct strbuf *status);
+
+/*
+ * Verify multiple signatures in a single buffer
+ */
+int verify_buffer_signatures(const char *payload, size_t size,
+=09=09struct signatures *sigs);
+
+/*
+ * Bridge function to be called by the git code to verify a signed payload
+ */
+int check_signature(const char *payload, size_t plen, const char *signatur=
e,
+=09size_t slen, struct signature *sigc);
+
+/*
+ * Prints the results of either signing or verifying the payload in the
+ * signatures struct. If the OUTPUT_VERBOSE flag is specified, then the
+ * payload is printed to stdout. If the OUTPUT_RAW flag is specified,=20
+ * the raw status output from the signing tool is printed to stderr,=20
+ * otherwise, the nice results from the tool is printed to stderr.
+ */
+void print_signatures(const struct signatures *sigs, unsigned flags);
+
+/*
+ * Bridge function to be called by the git code to print a signature
+ */
+void print_signature_buffer(const struct signature *sigc, unsigned flags);
+
+/*
+ * Appends each of the detached signatures to the end of the strbuf
+ * passed in. Returns the number of signatures appended to the buffer.
+ */
+size_t strbuf_append_signatures(struct strbuf *buf, const struct signature=
s *sigs);
+
+/*
+ * Translate the name of the signature tool into the enumerated value
+ * for the signature type.
+ */
+enum signature_type signature_type_by_name(const char *name);
+const char *signature_type_name(enum signature_type st);
+
+/*
+ * Config related functions
+ */
+int git_signing_config(const char *var, const char *value, void *cb);
+void set_signing_key(const char *key, enum signature_type st);
+const char *get_signing_key(enum signature_type st);
+void set_signing_program(const char *program, enum signature_type st);
+const char *get_signing_program(enum signature_type st);
+void set_signature_type(enum signature_type st);
+enum signature_type get_signature_type(void);
+
+#endif
+
diff --git a/signing-tool-openpgp.c b/signing-tool-openpgp.c
new file mode 100644
index 000000000..93b63b36d
--- /dev/null
+++ b/signing-tool-openpgp.c
@@ -0,0 +1,409 @@
+#include "cache.h"
+#include "config.h"
+#include "run-command.h"
+#include "strbuf.h"
+#include "signing-interface.h"
+#include "signing-tool.h"
+#include "sigchain.h"
+#include "tempfile.h"
+
+static int openpgp_sign(const char *payload, size_t size,
+=09=09struct signature **sig, const char *key);
+static size_t openpgp_parse(const char *payload, size_t size,
+=09=09struct signature **sig);
+static int openpgp_verify(const char *payload, size_t size,
+=09=09struct signature *sig);
+static void openpgp_print(const struct signature *sig, unsigned flags);
+static int openpgp_config(const char *, const char *, void *);
+static void openpgp_set_key(const char *);
+static const char *openpgp_get_key(void);
+static void openpgp_set_program(const char *);
+static const char *openpgp_get_program(void);
+
+const struct signing_tool openpgp_tool =3D {
+=09.st =3D OPENPGP_SIGNATURE,
+=09.name =3D "openpgp",
+=09.sign =3D &openpgp_sign,
+=09.parse =3D &openpgp_parse,
+=09.verify =3D &openpgp_verify,
+=09.print =3D &openpgp_print,
+=09.config =3D &openpgp_config,
+=09.set_key =3D &openpgp_set_key,
+=09.get_key =3D &openpgp_get_key,
+=09.set_program =3D &openpgp_set_program,
+=09.get_program =3D &openpgp_get_program
+};
+
+static const char *program =3D "gpg";
+static const char *signing_key =3D NULL;
+static const char *keyring =3D NULL;
+static int no_default_keyring =3D 0;
+struct regex_pattern {
+=09const char * begin;
+=09const char * end;
+};
+static struct regex_pattern patterns[2] =3D {
+=09{ "^-----BEGIN PGP SIGNATURE-----\n", "-----END PGP SIGNATURE-----\n" }=
,
+=09{ "^-----BEGIN PGP MESSAGE-----\n", "-----END PGP MESSAGE-----\n" }
+};
+
+static int openpgp_sign(const char *payload, size_t size,
+=09=09struct signature **sig, const char *key)
+{
+=09struct child_process gpg =3D CHILD_PROCESS_INIT;
+=09struct signature *psig;
+=09struct strbuf *psignature, *pstatus;
+=09int ret;
+=09size_t i, j;
+=09const char *skey =3D (!key || !*key) ? signing_key : key;
+
+=09/*
+=09 * Create the signature.
+=09 */
+=09if (sig) {
+=09=09psig =3D *sig;
+=09=09strbuf_init(&(psig->sig), 0);
+=09=09strbuf_init(&(psig->output), 0);
+=09=09strbuf_init(&(psig->status), 0);
+=09=09psig->st =3D OPENPGP_SIGNATURE;
+=09=09psig->result =3D 0;
+=09=09psig->signer =3D NULL;
+=09=09psig->key =3D NULL;
+=09=09psignature =3D &(psig->sig);
+=09=09pstatus =3D &(psig->status);
+=09} else {
+=09=09psignature =3D NULL;
+=09=09pstatus =3D NULL;
+=09}
+
+=09argv_array_pushl(&gpg.args,
+=09=09=09program,
+=09=09=09"--status-fd=3D2",
+=09=09=09"-bsau", skey,
+=09=09=09NULL);
+
+=09/*
+=09 * When the username signingkey is bad, program could be terminated
+=09 * because gpg exits without reading and then write gets SIGPIPE.
+=09 */
+=09sigchain_push(SIGPIPE, SIG_IGN);
+=09ret =3D pipe_command(&gpg, payload, size,
+=09=09=09psignature, 1024, pstatus, 0);
+=09sigchain_pop(SIGPIPE);
+
+=09if (!sig)
+=09=09return !!ret;
+
+=09/* Check for success status from gpg */
+=09ret |=3D !strstr(pstatus->buf, "\n[GNUPG:] SIG_CREATED ");
+
+=09if (ret)
+=09=09return error(_("gpg failed to sign the data"));
+
+=09/* Mark the signature as good */
+=09psig->result =3D 'G';
+
+=09/* Strip CR from the line endings, in case we are on Windows. */
+=09for (i =3D j =3D 0; i < psig->sig.len; i++)
+=09=09if (psig->sig.buf[i] !=3D '\r') {
+=09=09=09if (i !=3D j)
+=09=09=09=09psig->sig.buf[j] =3D psig->sig.buf[i];
+=09=09=09j++;
+=09=09}
+=09strbuf_setlen(&(psig->sig), j);
+
+=09/* Store the key we used */
+=09psig->key =3D xstrdup(skey);
+
+=09return 0;
+}
+
+/*
+ * To get all OpenPGP signatures in a payload, repeatedly call this functi=
on
+ * giving it the remainder of the payload as the payload pointer. The retu=
rn
+ * value is the index of the first char of the signature in the payload. I=
f
+ * no signature is found, size is returned.
+ */
+static size_t openpgp_parse(const char *payload, size_t size,
+=09=09struct signature **sig)
+{
+=09int i, ret;
+=09regex_t rbegin;
+=09regex_t rend;
+=09regmatch_t bmatch;
+=09regmatch_t ematch;
+=09size_t begin, end;
+=09struct signature *psig;
+=09static char errbuf[1024];
+
+=09if (size =3D=3D 0)
+=09=09return size;
+
+=09/*
+=09 * Figure out if any OpenPGP signatures are in the payload and which
+=09 * begin pattern matches the first signature in the payload.
+=09 */
+=09for (i =3D 0; i < ARRAY_SIZE(patterns); i++) {
+=09=09if ((ret =3D regcomp(&rbegin, patterns[i].begin, REG_EXTENDED|REG_NE=
WLINE))) {
+=09=09=09regerror(ret, &rbegin, errbuf, 1024);
+=09=09=09BUG("Failed to compile regex: %s\n", errbuf);
+
+=09=09=09return size;
+=09=09}
+=09=09if ((ret =3D regcomp(&rend, patterns[i].end, REG_EXTENDED|REG_NEWLIN=
E))) {
+=09=09=09regerror(ret, &rend, errbuf, 1024);
+=09=09=09BUG("Failed to compile regex: %s\n", errbuf);
+
+=09=09=09return size;
+=09=09}
+
+=09=09begin =3D end =3D 0;
+=09=09if (regexec(&rbegin, payload, 1, &bmatch, 0) ||
+=09=09=09regexec(&rend, payload, 1, &ematch, 0)) {
+=09=09=09begin =3D size;
+=09=09=09continue;
+=09=09}
+=09=09begin =3D bmatch.rm_so;
+=09=09end =3D ematch.rm_eo;
+
+=09=09break;
+=09}
+=09if (begin =3D=3D size)
+=09=09goto next;
+
+=09/*
+=09 * Create the signature.
+=09 */
+=09if (sig) {
+=09=09psig =3D *sig;
+=09=09psig =3D xmalloc(sizeof(struct signature));
+=09=09strbuf_init(&(psig->sig), end - begin);
+=09=09strbuf_add(&(psig->sig), payload + begin, end - begin);
+=09=09strbuf_init(&(psig->output), 0);
+=09=09strbuf_init(&(psig->status), 0);
+=09=09psig->st =3D OPENPGP_SIGNATURE;
+=09=09psig->result =3D 0;
+=09=09psig->signer =3D NULL;
+=09=09psig->key =3D NULL;
+=09}
+=09next:
+=09=09regfree(&rbegin);
+=09=09regfree(&rend);
+
+=09return begin;
+}
+
+/* An exclusive status -- only one of them can appear in output */
+#define GPG_STATUS_EXCLUSIVE=09(1<<0)
+/* The status includes key identifier */
+#define GPG_STATUS_KEYID=09(1<<1)
+/* The status includes user identifier */
+#define GPG_STATUS_UID=09=09(1<<2)
+/* The status includes key fingerprints */
+#define GPG_STATUS_FINGERPRINT=09(1<<3)
+
+/* Short-hand for standard exclusive *SIG status with keyid & UID */
+#define GPG_STATUS_STDSIG=09(GPG_STATUS_EXCLUSIVE|GPG_STATUS_KEYID|GPG_STA=
TUS_UID)
+
+static struct {
+=09char result;
+=09const char *check;
+=09unsigned int flags;
+} sigcheck_gpg_status[] =3D {
+=09{ 'G', "GOODSIG ", GPG_STATUS_STDSIG },
+=09{ 'B', "BADSIG ", GPG_STATUS_STDSIG },
+=09{ 'U', "TRUST_NEVER", 0 },
+=09{ 'U', "TRUST_UNDEFINED", 0 },
+=09{ 'E', "ERRSIG ", GPG_STATUS_EXCLUSIVE|GPG_STATUS_KEYID },
+=09{ 'X', "EXPSIG ", GPG_STATUS_STDSIG },
+=09{ 'Y', "EXPKEYSIG ", GPG_STATUS_STDSIG },
+=09{ 'R', "REVKEYSIG ", GPG_STATUS_STDSIG },
+=09{ 0, "VALIDSIG ", GPG_STATUS_FINGERPRINT },
+};
+
+static void parse_output(struct signature *sigc)
+{
+=09const char *buf =3D sigc->status.buf;
+=09const char *line, *next;
+=09int i, j;
+=09int seen_exclusive_status =3D 0;
+
+=09/* Iterate over all lines */
+=09for (line =3D buf; *line; line =3D strchrnul(line+1, '\n')) {
+=09=09while (*line =3D=3D '\n')
+=09=09=09line++;
+=09=09/* Skip lines that don't start with GNUPG status */
+=09=09if (!skip_prefix(line, "[GNUPG:] ", &line))
+=09=09=09continue;
+
+=09=09/* Iterate over all search strings */
+=09=09for (i =3D 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
+=09=09=09if (skip_prefix(line, sigcheck_gpg_status[i].check, &line)) {
+=09=09=09=09if (sigcheck_gpg_status[i].flags & GPG_STATUS_EXCLUSIVE) {
+=09=09=09=09=09if (seen_exclusive_status++)
+=09=09=09=09=09=09goto found_duplicate_status;
+=09=09=09=09}
+
+=09=09=09=09if (sigcheck_gpg_status[i].result)
+=09=09=09=09=09sigc->result =3D sigcheck_gpg_status[i].result;
+=09=09=09=09/* Do we have key information? */
+=09=09=09=09if (sigcheck_gpg_status[i].flags & GPG_STATUS_KEYID) {
+=09=09=09=09=09next =3D strchrnul(line, ' ');
+=09=09=09=09=09free(sigc->key);
+=09=09=09=09=09sigc->key =3D xmemdupz(line, next - line);
+=09=09=09=09=09/* Do we have signer information? */
+=09=09=09=09=09if (*next && (sigcheck_gpg_status[i].flags & GPG_STATUS_UID=
)) {
+=09=09=09=09=09=09line =3D next + 1;
+=09=09=09=09=09=09next =3D strchrnul(line, '\n');
+=09=09=09=09=09=09free(sigc->signer);
+=09=09=09=09=09=09sigc->signer =3D xmemdupz(line, next - line);
+=09=09=09=09=09}
+=09=09=09=09}
+=09=09=09=09/* Do we have fingerprint? */
+=09=09=09=09if (sigcheck_gpg_status[i].flags & GPG_STATUS_FINGERPRINT) {
+=09=09=09=09=09next =3D strchrnul(line, ' ');
+=09=09=09=09=09free(sigc->fingerprint);
+=09=09=09=09=09sigc->fingerprint =3D xmemdupz(line, next - line);
+
+=09=09=09=09=09/* Skip interim fields */
+=09=09=09=09=09for (j =3D 9; j > 0; j--) {
+=09=09=09=09=09=09if (!*next)
+=09=09=09=09=09=09=09break;
+=09=09=09=09=09=09line =3D next + 1;
+=09=09=09=09=09=09next =3D strchrnul(line, ' ');
+=09=09=09=09=09}
+
+=09=09=09=09=09next =3D strchrnul(line, '\n');
+=09=09=09=09=09free(sigc->primary_key_fingerprint);
+=09=09=09=09=09sigc->primary_key_fingerprint =3D xmemdupz(line, next - lin=
e);
+=09=09=09=09}
+
+=09=09=09=09break;
+=09=09=09}
+=09=09}
+=09}
+=09return;
+
+found_duplicate_status:
+=09/*
+=09 * GOODSIG, BADSIG etc. can occur only once for each signature.
+=09 * Therefore, if we had more than one then we're dealing with multiple
+=09 * signatures.  We don't support them currently, and they're rather
+=09 * hard to create, so something is likely fishy and we should reject
+=09 * them altogether.
+=09 */
+=09sigc->result =3D 'E';
+=09/* Clear partial data to avoid confusion */
+=09FREE_AND_NULL(sigc->primary_key_fingerprint);
+=09FREE_AND_NULL(sigc->fingerprint);
+=09FREE_AND_NULL(sigc->signer);
+=09FREE_AND_NULL(sigc->key);
+}
+
+static int openpgp_verify(const char *payload, size_t size,
+=09=09struct signature *sig)
+{
+=09struct child_process gpg =3D CHILD_PROCESS_INIT;
+=09struct tempfile *temp;
+=09int ret;
+
+=09temp =3D mks_tempfile_t(".git_vtag_tmpXXXXXX");
+=09if (!temp)
+=09=09return error_errno(_("could not create temporary file"));
+=09if (write_in_full(temp->fd, sig->sig.buf, sig->sig.len) < 0 ||
+=09    close_tempfile_gently(temp) < 0) {
+=09=09error_errno(_("failed writing detached signature to '%s'"),
+=09=09=09=09temp->filename.buf);
+=09=09delete_tempfile(&temp);
+=09=09return -1;
+=09}
+
+=09argv_array_push(&gpg.args, program);
+=09if (keyring)
+=09=09argv_array_pushl(&gpg.args, "--keyring", keyring, NULL);
+=09if (no_default_keyring)
+=09=09argv_array_push(&gpg.args, "--no-default-keyring");
+=09argv_array_pushl(&gpg.args,
+=09=09=09"--keyid-format=3Dlong",
+=09=09=09"--status-fd=3D1",
+=09=09=09"--verify", temp->filename.buf, "-",
+=09=09=09NULL);
+
+=09strbuf_reset(&(sig->status));
+=09strbuf_reset(&(sig->output));
+
+=09sigchain_push(SIGPIPE, SIG_IGN);
+=09ret =3D pipe_command(&gpg, payload, size,
+=09=09=09&(sig->status), 0, &(sig->output), 0);
+=09sigchain_pop(SIGPIPE);
+
+=09delete_tempfile(&temp);
+
+=09ret |=3D !strstr(sig->status.buf, "\n[GNUPG:] GOODSIG ");
+
+=09if (ret && !sig->output.len)
+=09=09return !!ret;
+
+=09parse_output(sig);
+
+=09ret |=3D sig->result !=3D 'G' && sig->result !=3D 'U';
+
+=09return !!ret;
+}
+
+static void openpgp_print(const struct signature *sig, unsigned flags)
+{
+=09const char *output =3D flags & OUTPUT_RAW ?
+=09=09sig->status.buf : sig->output.buf;
+
+=09if (flags & OUTPUT_VERBOSE && sig->sig.buf)
+=09=09fputs(sig->sig.buf, stdout);
+
+=09if (output)
+=09=09fputs(output, stderr);
+}
+
+static int openpgp_config(const char *var, const char *value, void *cb)
+{
+=09if (!strcmp(var, "program"))
+=09=09return git_config_string(&program, var, value);
+
+=09if (!strcmp(var, "key"))
+=09=09return git_config_string(&signing_key, var, value);
+
+=09if (!strcmp(var, "keyring"))
+=09=09return git_config_string(&keyring, var, value);
+
+=09if (!strcmp(var, "nodefaultkeyring")) {
+=09=09no_default_keyring =3D git_config_bool(var, value);
+=09=09return 0;
+=09}
+=09return 0;
+}
+
+static void openpgp_set_key(const char *key)
+{
+=09free((void*)signing_key);
+=09signing_key =3D xstrdup(key);
+}
+
+static const char *openpgp_get_key(void)
+{
+=09if (signing_key)
+=09=09return signing_key;
+=09return git_committer_info(IDENT_STRICT|IDENT_NO_DATE);
+}
+
+static void openpgp_set_program(const char *signing_program)
+{
+=09free((void*)program);
+=09program =3D xstrdup(signing_program);
+}
+
+
+static const char *openpgp_get_program(void)
+{
+=09if (program)
+=09=09return program;
+=09return git_committer_info(IDENT_STRICT|IDENT_NO_DATE);
+}
\ No newline at end of file
diff --git a/signing-tool-x509.c b/signing-tool-x509.c
new file mode 100644
index 000000000..b7de56924
--- /dev/null
+++ b/signing-tool-x509.c
@@ -0,0 +1,383 @@
+#include "cache.h"
+#include "config.h"
+#include "run-command.h"
+#include "strbuf.h"
+#include "signing-interface.h"
+#include "signing-tool.h"
+#include "sigchain.h"
+#include "tempfile.h"
+
+static int x509_sign(const char *payload, size_t size,
+=09=09struct signature **sig, const char *key);
+static size_t x509_parse(const char *payload, size_t size,
+=09=09struct signature **sig);
+static int x509_verify(const char *payload, size_t size,
+=09=09struct signature *sig);
+static void x509_print(const struct signature *sig, unsigned flags);
+static int x509_config(const char *, const char *, void *);
+static void x509_set_key(const char *);
+static const char *x509_get_key(void);
+static void x509_set_program(const char *);
+static const char *x509_get_program(void);
+
+const struct signing_tool x509_tool =3D {
+=09.st =3D X509_SIGNATURE,
+=09.name =3D "x509",
+=09.sign =3D &x509_sign,
+=09.parse =3D &x509_parse,
+=09.verify =3D &x509_verify,
+=09.print =3D &x509_print,
+=09.config =3D &x509_config,
+=09.set_key =3D &x509_set_key,
+=09.get_key =3D &x509_get_key,
+=09.set_program =3D &x509_set_program,
+=09.get_program =3D &x509_get_program
+};
+
+static const char *program =3D "gpgsm";
+static const char *signing_key =3D NULL;
+struct regex_pattern {
+=09const char * begin;
+=09const char * end;
+};
+static struct regex_pattern pattern =3D {
+=09"^-----BEGIN SIGNED MESSAGE-----\n",
+=09"^-----END SIGNED MESSAGE-----\n"
+};
+
+static int x509_sign(const char *payload, size_t size,
+=09=09struct signature **sig, const char *key)
+{
+=09struct child_process gpgsm =3D CHILD_PROCESS_INIT;
+=09struct signature *psig;
+=09struct strbuf *psignature, *pstatus;
+=09int ret;
+=09size_t i, j;
+=09const char *skey =3D (!key || !*key) ? signing_key : key;
+
+=09/*
+=09 * Create the signature.
+=09 */
+=09if (sig) {
+=09=09psig =3D *sig;
+=09=09strbuf_init(&(psig->sig), 0);
+=09=09strbuf_init(&(psig->output), 0);
+=09=09strbuf_init(&(psig->status), 0);
+=09=09psig->st =3D X509_SIGNATURE;
+=09=09psig->result =3D 0;
+=09=09psig->signer =3D NULL;
+=09=09psig->key =3D NULL;
+=09=09psignature =3D &(psig->sig);
+=09=09pstatus =3D &(psig->status);
+=09} else {
+=09=09psignature =3D NULL;
+=09=09pstatus =3D NULL;
+=09}
+
+=09argv_array_pushl(&gpgsm.args,
+=09=09=09program,
+=09=09=09"--status-fd=3D2",
+=09=09=09"-bsau", skey,
+=09=09=09NULL);
+
+=09/*
+=09 * When the username signingkey is bad, program could be terminated
+=09 * because gpgsm exits without reading and then write gets SIGPIPE.
+=09 */
+=09sigchain_push(SIGPIPE, SIG_IGN);
+=09ret =3D pipe_command(&gpgsm, payload, size,
+=09=09=09psignature, 1024, pstatus, 0);
+=09sigchain_pop(SIGPIPE);
+
+=09if (!sig)
+=09=09return !!ret;
+
+=09ret |=3D !strstr(pstatus->buf, "\n[GNUPG:] SIG_CREATED ");
+=09if (ret)
+=09=09return error(_("gpgsm failed to sign the data"));
+
+=09/* Mark the signature as good. */
+=09psig->result =3D 'G';
+
+=09/* Strip CR from the line endings, in case we are on Windows. */
+=09for (i =3D j =3D 0; i < psig->sig.len; i++)
+=09=09if (psig->sig.buf[i] !=3D '\r') {
+=09=09=09if (i !=3D j)
+=09=09=09=09psig->sig.buf[j] =3D psig->sig.buf[i];
+=09=09=09j++;
+=09=09}
+=09strbuf_setlen(&(psig->sig), j);
+
+=09/* Store the key we used */
+=09psig->key =3D xstrdup(skey);
+
+=09return 0;
+}
+
+static size_t x509_parse(const char *payload, size_t size,
+=09=09struct signature **sig)
+{
+=09int ret;
+=09regex_t rbegin;
+=09regex_t rend;
+=09regmatch_t bmatch;
+=09regmatch_t ematch;
+=09size_t begin, end;
+=09struct signature *psig;
+=09static char errbuf[1024];
+
+=09if (size =3D=3D 0)
+=09=09return size;
+
+=09/*
+=09 * Find the first x509 signature in the payload and copy it into the
+=09 * signature struct.
+=09 */
+=09if ((ret =3D regcomp(&rbegin, pattern.begin, REG_EXTENDED|REG_NEWLINE))=
) {
+=09=09regerror(ret, &rbegin, errbuf, 1024);
+=09=09BUG("Failed to compile regex: %s\n", errbuf);
+
+=09=09return size;
+=09}
+=09if ((ret =3D regcomp(&rend, pattern.end, REG_EXTENDED|REG_NEWLINE))) {
+=09=09regerror(ret, &rend, errbuf, 1024);
+=09=09BUG("Failed to compile regex: %s\n", errbuf);
+
+=09=09return size;
+=09}
+
+=09begin =3D end =3D 0;
+=09if (regexec(&rbegin, payload, 1, &bmatch, 0) ||
+=09=09regexec(&rend, payload, 1, &ematch, 0)) {
+=09=09begin =3D size;
+=09}
+=09if (begin =3D=3D size)
+=09=09goto next;
+
+=09begin =3D bmatch.rm_so;
+=09end =3D ematch.rm_eo;
+
+=09/*
+=09 * Create the signature.
+=09 */
+=09if (sig) {
+=09=09psig =3D *sig;
+=09=09psig =3D xmalloc(sizeof(struct signature));
+=09=09strbuf_init(&(psig->sig), end - begin);
+=09=09strbuf_add(&(psig->sig), payload + begin, end - begin);
+=09=09strbuf_init(&(psig->output), 0);
+=09=09strbuf_init(&(psig->status), 0);
+=09=09psig->st =3D X509_SIGNATURE;
+=09=09psig->result =3D 0;
+=09=09psig->signer =3D NULL;
+=09=09psig->key =3D NULL;
+=09}
+
+=09next:
+=09=09regfree(&rbegin);
+=09=09regfree(&rend);
+
+=09return begin;
+}
+
+/* An exclusive status -- only one of them can appear in output */
+#define GPG_STATUS_EXCLUSIVE=09(1<<0)
+/* The status includes key identifier */
+#define GPG_STATUS_KEYID=09(1<<1)
+/* The status includes user identifier */
+#define GPG_STATUS_UID=09=09(1<<2)
+/* The status includes key fingerprints */
+#define GPG_STATUS_FINGERPRINT=09(1<<3)
+
+/* Short-hand for standard exclusive *SIG status with keyid & UID */
+#define GPG_STATUS_STDSIG=09(GPG_STATUS_EXCLUSIVE|GPG_STATUS_KEYID|GPG_STA=
TUS_UID)
+
+static struct {
+=09char result;
+=09const char *check;
+=09unsigned int flags;
+} sigcheck_gpg_status[] =3D {
+=09{ 'G', "GOODSIG ", GPG_STATUS_STDSIG },
+=09{ 'B', "BADSIG ", GPG_STATUS_STDSIG },
+=09{ 'U', "TRUST_NEVER", 0 },
+=09{ 'U', "TRUST_UNDEFINED", 0 },
+=09{ 'E', "ERRSIG ", GPG_STATUS_EXCLUSIVE|GPG_STATUS_KEYID },
+=09{ 'X', "EXPSIG ", GPG_STATUS_STDSIG },
+=09{ 'Y', "EXPKEYSIG ", GPG_STATUS_STDSIG },
+=09{ 'R', "REVKEYSIG ", GPG_STATUS_STDSIG },
+=09{ 0, "VALIDSIG ", GPG_STATUS_FINGERPRINT },
+};
+
+static void parse_output(struct signature *sigc)
+{
+=09const char *buf =3D sigc->status.buf;
+=09const char *line, *next;
+=09int i, j;
+=09int seen_exclusive_status =3D 0;
+
+=09/* Iterate over all lines */
+=09for (line =3D buf; *line; line =3D strchrnul(line+1, '\n')) {
+=09=09while (*line =3D=3D '\n')
+=09=09=09line++;
+=09=09/* Skip lines that don't start with GNUPG status */
+=09=09if (!skip_prefix(line, "[GNUPG:] ", &line))
+=09=09=09continue;
+
+=09=09/* Iterate over all search strings */
+=09=09for (i =3D 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
+=09=09=09if (skip_prefix(line, sigcheck_gpg_status[i].check, &line)) {
+=09=09=09=09if (sigcheck_gpg_status[i].flags & GPG_STATUS_EXCLUSIVE) {
+=09=09=09=09=09if (seen_exclusive_status++)
+=09=09=09=09=09=09goto found_duplicate_status;
+=09=09=09=09}
+
+=09=09=09=09if (sigcheck_gpg_status[i].result)
+=09=09=09=09=09sigc->result =3D sigcheck_gpg_status[i].result;
+=09=09=09=09/* Do we have key information? */
+=09=09=09=09if (sigcheck_gpg_status[i].flags & GPG_STATUS_KEYID) {
+=09=09=09=09=09next =3D strchrnul(line, ' ');
+=09=09=09=09=09free(sigc->key);
+=09=09=09=09=09sigc->key =3D xmemdupz(line, next - line);
+=09=09=09=09=09/* Do we have signer information? */
+=09=09=09=09=09if (*next && (sigcheck_gpg_status[i].flags & GPG_STATUS_UID=
)) {
+=09=09=09=09=09=09line =3D next + 1;
+=09=09=09=09=09=09next =3D strchrnul(line, '\n');
+=09=09=09=09=09=09free(sigc->signer);
+=09=09=09=09=09=09sigc->signer =3D xmemdupz(line, next - line);
+=09=09=09=09=09}
+=09=09=09=09}
+=09=09=09=09/* Do we have fingerprint? */
+=09=09=09=09if (sigcheck_gpg_status[i].flags & GPG_STATUS_FINGERPRINT) {
+=09=09=09=09=09next =3D strchrnul(line, ' ');
+=09=09=09=09=09free(sigc->fingerprint);
+=09=09=09=09=09sigc->fingerprint =3D xmemdupz(line, next - line);
+
+=09=09=09=09=09/* Skip interim fields */
+=09=09=09=09=09for (j =3D 9; j > 0; j--) {
+=09=09=09=09=09=09if (!*next)
+=09=09=09=09=09=09=09break;
+=09=09=09=09=09=09line =3D next + 1;
+=09=09=09=09=09=09next =3D strchrnul(line, ' ');
+=09=09=09=09=09}
+
+=09=09=09=09=09next =3D strchrnul(line, '\n');
+=09=09=09=09=09free(sigc->primary_key_fingerprint);
+=09=09=09=09=09sigc->primary_key_fingerprint =3D xmemdupz(line, next - lin=
e);
+=09=09=09=09}
+
+=09=09=09=09break;
+=09=09=09}
+=09=09}
+=09}
+=09return;
+
+found_duplicate_status:
+=09/*
+=09 * GOODSIG, BADSIG etc. can occur only once for each signature.
+=09 * Therefore, if we had more than one then we're dealing with multiple
+=09 * signatures.  We don't support them currently, and they're rather
+=09 * hard to create, so something is likely fishy and we should reject
+=09 * them altogether.
+=09 */
+=09sigc->result =3D 'E';
+=09/* Clear partial data to avoid confusion */
+=09FREE_AND_NULL(sigc->primary_key_fingerprint);
+=09FREE_AND_NULL(sigc->fingerprint);
+=09FREE_AND_NULL(sigc->signer);
+=09FREE_AND_NULL(sigc->key);
+}
+
+static int x509_verify(const char *payload, size_t size,
+=09=09struct signature *sig)
+{
+=09struct child_process gpgsm =3D CHILD_PROCESS_INIT;
+=09struct tempfile *temp;
+=09int ret;
+
+=09temp =3D mks_tempfile_t(".git_vtag_tmpXXXXXX");
+=09if (!temp)
+=09=09return error_errno(_("could not create temporary file"));
+=09if (write_in_full(temp->fd, sig->sig.buf, sig->sig.len) < 0 ||
+=09    close_tempfile_gently(temp) < 0) {
+=09=09error_errno(_("failed writing detached signature to '%s'"),
+=09=09=09=09temp->filename.buf);
+=09=09delete_tempfile(&temp);
+=09=09return -1;
+=09}
+
+=09argv_array_push(&gpgsm.args, program);
+=09argv_array_pushl(&gpgsm.args,
+=09=09=09"--status-fd=3D1",
+=09=09=09"--verify", temp->filename.buf, "-",
+=09=09=09NULL);
+
+=09strbuf_reset(&(sig->status));
+=09strbuf_reset(&(sig->output));
+
+=09sigchain_push(SIGPIPE, SIG_IGN);
+=09ret =3D pipe_command(&gpgsm, payload, size,
+=09=09=09&(sig->status), 0, &(sig->output), 0);
+=09sigchain_pop(SIGPIPE);
+
+=09delete_tempfile(&temp);
+
+=09ret |=3D !strstr(sig->status.buf, "\n[GNUPG:] GOODSIG ");
+
+=09if (ret && !sig->output.len)
+=09=09return !!ret;
+
+=09parse_output(sig);
+
+=09ret |=3D sig->result !=3D 'G' && sig->result !=3D 'U';
+
+=09return !!ret;
+}
+
+static void x509_print(const struct signature *sig, unsigned flags)
+{
+=09const char *output =3D flags & OUTPUT_RAW ?
+=09=09sig->status.buf : sig->output.buf;
+
+=09if (flags & OUTPUT_VERBOSE && sig->sig.buf)
+=09=09fputs(sig->sig.buf, stdout);
+
+=09if (output)
+=09=09fputs(output, stderr);
+}
+
+static int x509_config(const char *var, const char *value, void *cb)
+{
+=09if (!strcmp(var, "program"))
+=09=09return git_config_string(&program, var, value);
+
+=09if (!strcmp(var, "key"))
+=09=09return git_config_string(&signing_key, var, value);
+
+=09return 0;
+}
+
+static void x509_set_key(const char *key)
+{
+=09free((void*)signing_key);
+=09signing_key =3D xstrdup(key);
+}
+
+static const char *x509_get_key(void)
+{
+=09if (signing_key)
+=09=09return signing_key;
+=09return git_committer_info(IDENT_STRICT|IDENT_NO_DATE);
+}
+
+static void x509_set_program(const char *signing_program)
+{
+=09free((void*)program);
+=09program =3D xstrdup(signing_program);
+}
+
+static const char *x509_get_program(void)
+{
+=09if (program)
+=09=09return program;
+=09return git_committer_info(IDENT_STRICT|IDENT_NO_DATE);
+}
\ No newline at end of file
diff --git a/signing-tool.h b/signing-tool.h
new file mode 100644
index 000000000..ee7ccc7a5
--- /dev/null
+++ b/signing-tool.h
@@ -0,0 +1,35 @@
+#ifndef SIGNING_TOOL_H
+#define SIGNING_TOOL_H
+
+struct strbuf;
+struct signature;
+
+typedef int (*sign_fn)(const char *payload, size_t size,
+=09struct signature **sig, const char *key);
+typedef size_t (*parse_fn)(const char *payload, size_t size,
+=09struct signature **sig);
+typedef int (*verify_fn)(const char *payload, size_t size,
+=09struct signature *sig);
+typedef void (*print_fn)(const struct signature *sig, unsigned flags);
+typedef int (*config_fn)(const char *var, const char *value, void *cb);
+typedef void (*set_key_fn)(const char *key);
+typedef const char *(*get_key_fn)(void);
+typedef void (*set_program_fn)(const char *signing_program);
+typedef const char *(*get_program_fn)(void);
+
+struct signing_tool {
+=09const enum signature_type st;
+=09const char* name;
+=09sign_fn sign;
+=09parse_fn parse;
+=09verify_fn verify;
+=09print_fn print;
+=09config_fn config;
+=09set_key_fn set_key;
+=09get_key_fn get_key;
+=09set_program_fn set_program;
+=09get_program_fn get_program;
+};
+
+#endif
+
--=20
2.11.0


