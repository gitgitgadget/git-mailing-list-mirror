From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH 08/10] Adding time-stamping helper tool
Date: Thu, 17 Mar 2016 19:46:59 +0100
Message-ID: <1458240421-3593-9-git-send-email-anton.wuerfel@fau.de>
References: <1458240421-3593-1-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, i4passt@cs.fau.de,
	Phillip Raffeck <phillip.raffeck@fau.de>,
	Anton Wuerfel <anton.wuerfel@fau.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 19:48:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agcxi-0007em-ID
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 19:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933182AbcCQSrz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2016 14:47:55 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:43347 "EHLO
	faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933303AbcCQSrn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2016 14:47:43 -0400
Received: from faui49man2 (faui49man2.informatik.uni-erlangen.de [131.188.42.190])
	by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 2BCDB58C4DD;
	Thu, 17 Mar 2016 19:47:40 +0100 (CET)
Received: by faui49man2 (sSMTP sendmail emulation); Thu, 17 Mar 2016 19:47:40 +0100
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1458240421-3593-1-git-send-email-anton.wuerfel@fau.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289147>

This commit adds a helper tool called `git-timestamp-util`, which does =
the
actual RFC3161 time-stamping work. It depends on libssl and libcrypto.

In particular, it is used for creating time-stamp signatures and for ve=
rifying
them.

To create a time-stamp signature, a Time Stamping Query (TSQ) is create=
d and
passed to the helper tool `git-http-timestamp`, which passes it to a Ti=
me
Stamping Authority and outputs a trusted Time Stamping Response (TSR). =
The TSR
is then split into the time-stamp signature itself and the Time Stampin=
g
Autority's certificate. This certificate is stored in a repository-glob=
al TSA
store file called .git_tsa_store, whereas the raw time-stamp signature =
is passed
to the caller to be stored in a git object. Splitting the TSR into the =
TSA's
certificate and the raw time-stamp signature is done to avoid redundanc=
y as the
TSA's certificate will likely not change over years.

To verify a time-stamp signature, a SHA-1 hash of the git object to be =
checked
is passed along with its corresponding time-stamp signature. Identifyin=
g
certificate information like issuer and serial number is extracted from=
 the
time-stamp signature. The tuple of issuer and serial number is then use=
d to find
the actual certificate of the Time Stamping Autority in .git_tsa_store =
file.
The TSA's Certificate and the raw time-stamp signature are merged toget=
her and
verified.

Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
---
 .gitignore       |   1 +
 Makefile         |   7 +
 command-list.txt |   1 +
 timestamp-util.c | 615 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 624 insertions(+)
 create mode 100644 timestamp-util.c

diff --git a/.gitignore b/.gitignore
index a3b270d..08005ca 100644
--- a/.gitignore
+++ b/.gitignore
@@ -160,6 +160,7 @@
 /git-svn
 /git-symbolic-ref
 /git-tag
+/git-timestamp-util
 /git-unpack-file
 /git-unpack-objects
 /git-update-index
diff --git a/Makefile b/Makefile
index c717af7..a0ab96a 100644
--- a/Makefile
+++ b/Makefile
@@ -1142,6 +1142,9 @@ ifndef NO_OPENSSL
 	ifdef NO_HMAC_CTX_CLEANUP
 		BASIC_CFLAGS +=3D -DNO_HMAC_CTX_CLEANUP
 	endif
+
+	PROGRAM_OBJS +=3D timestamp-util.o
+	PROGRAMS +=3D git-timestamp-util$X
 else
 	BASIC_CFLAGS +=3D -DNO_OPENSSL
 	BLK_SHA1 =3D 1
@@ -2025,6 +2028,10 @@ git-http-timestamp$X: http.o http-timestamp.o GI=
T-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) \
 		$(CURL_LIBCURL) $(LIBS)
=20
+git-timestamp-util$X: timestamp-util.o GIT-LDFLAGS $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) \
+		$(LIBS)
+
 $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	$(QUIET_LNCP)$(RM) $@ && \
 	ln $< $@ 2>/dev/null || \
diff --git a/command-list.txt b/command-list.txt
index 3e279c1..07a4cab 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -136,6 +136,7 @@ git-submodule                           mainporcela=
in
 git-svn                                 foreignscminterface
 git-symbolic-ref                        plumbingmanipulators
 git-tag                                 mainporcelain           histor=
y
+git-timestamp-util                      purehelpers
 git-unpack-file                         plumbinginterrogators
 git-unpack-objects                      plumbingmanipulators
 git-update-index                        plumbingmanipulators
diff --git a/timestamp-util.c b/timestamp-util.c
new file mode 100644
index 0000000..fee4fc2
--- /dev/null
+++ b/timestamp-util.c
@@ -0,0 +1,615 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <openssl/bio.h>
+#include <openssl/err.h>
+#include <openssl/pem.h>
+#include <openssl/rand.h>
+#include <openssl/ts.h>
+#include <openssl/bn.h>
+
+#include "cache.h"
+#include "run-command.h"
+#include "strbuf.h"
+
+/*
+ * This code is based on the RFC3161 implementation in OpenSSL
+ * by Zoltan Glozik.
+ */
+
+#define NONCE_LENGTH (64)
+#define ISSUER_LEN (1024)
+
+struct tsr_info {
+	char issuer[ISSUER_LEN];
+	unsigned long serial;
+	X509 *cert;
+};
+
+
+static const char *timesig_cmd =3D "http-timestamp";
+
+static const char *config_ca_key =3D "ts.capath";
+static const char *certstore_file =3D ".git_tsa_store";
+static const char *certstore_header_begin =3D "-----BEGIN ENTRY-----";
+static const char *certstore_header_end =3D "-----END ENTRY-----";
+
+static TS_REQ *create_query(const char *digest);
+static ASN1_INTEGER *create_nonce(int bits);
+static TS_MSG_IMPRINT *create_msg_imprint(const char *digest);
+
+static int output_as_base64(TS_RESP *response);
+static TS_RESP *strip_tsr(TS_RESP *response);
+
+static int do_verify(TS_RESP *response, const char *digest, const char=
 *CApath,
+		     X509 *untrusted);
+static X509_STORE *create_cert_store(const char *CApath);
+static TS_VERIFY_CTX *create_verify_ctx(const char *digest, const char=
 *CApath,
+					X509 *cert);
+
+static int append_certificate_to_store(struct tsr_info *info);
+static X509 *find_certificate_in_store(struct tsr_info *info);
+
+static int extract_info_from_response(struct tsr_info *info, TS_RESP *=
response);
+
+static void usage_and_die(const char *name);
+
+static int create_tsr(const char *sha1);
+static int verify_tsr(const char *sha1);
+
+/*
+ * Request a TSR from a Time Stamping Authority. The TSR includes the
+ * authority's public key. To avoid saving this public key for every
+ * time-stamped git object, the public key is stripped from the TSR an=
d saved
+ * separately. By default, it is stored in .git_tsa_store file.
+ */
+static int create_tsr(const char *sha1)
+{
+	TS_RESP *response =3D NULL;
+	TS_REQ *query =3D NULL;
+	X509 *cert =3D NULL;
+	BIO *out_bio =3D NULL;
+	BIO *in_bio =3D NULL;
+	struct child_process timesig =3D CHILD_PROCESS_INIT;
+	struct tsr_info info;
+	int retval =3D 1;
+	const char *args[] =3D {
+		timesig_cmd,
+		NULL
+	};
+
+	/*
+	 * Invoke git-http-timestamp to receive a TSR from
+	 * the Time Stamping Authority.
+	 */
+	timesig.argv =3D args;
+	timesig.in =3D -1;
+	timesig.out =3D -1;
+	timesig.git_cmd =3D 1;
+
+	query =3D create_query(sha1);
+	if (!query) {
+		ERR_print_errors_fp(stderr);
+		goto end;
+	}
+
+	if (start_command(&timesig))
+		return error(_("could not run git-%s"), timesig_cmd);
+
+	out_bio =3D BIO_new_fd(timesig.in, BIO_NOCLOSE | BIO_FP_TEXT);
+	if (!out_bio)
+		goto end;
+
+	if (!i2d_TS_REQ_bio(out_bio, query))
+		goto end;
+
+	close(timesig.in);
+
+	in_bio =3D BIO_new_fd(timesig.out, BIO_NOCLOSE);
+	if (!in_bio)
+		goto end;
+
+	response =3D d2i_TS_RESP_bio(in_bio, NULL);
+	if (!response)
+		goto end;
+
+	close(timesig.out);
+
+	if (finish_command(&timesig))
+		goto end;
+
+	extract_info_from_response(&info, response);
+
+	/* Add certificate to TSA store if it does not exist yet */
+	cert =3D find_certificate_in_store(&info);
+	if (!cert) {
+		retval =3D append_certificate_to_store(&info);
+		if (retval)
+			goto end;
+	}
+
+	/* Strip certificate from TSR */
+	strip_tsr(response);
+	if (!response)
+		goto end;
+
+	/* Send stripped TSR to stdout */
+	if (output_as_base64(response))
+		goto end;
+
+	retval =3D 0;
+
+end:
+	BIO_free_all(out_bio);
+	BIO_free_all(in_bio);
+	TS_RESP_free(response);
+	TS_REQ_free(query);
+	X509_free(cert);
+	return retval;
+}
+
+/*
+ * Verify a TSR passed via stdin. The base64 encoded TSR is combined w=
ith the
+ * corresponding public key of the Time Stamping Authority (TSA) and t=
hen passed
+ * to the `openssl ts -verify` command.
+ */
+static int verify_tsr(const char *sha1)
+{
+	BIO *b64 =3D NULL;
+	BIO *in =3D NULL;
+	BIO *out =3D NULL;
+	TS_RESP *response =3D NULL;
+	TS_TST_INFO *tst_info =3D NULL;
+	X509 *cert =3D NULL;
+	int retval =3D 1;
+	char *config_ca_path;
+	struct tsr_info info;
+
+	/* get config options */
+	if (git_config_get_pathname(config_ca_key,
+				    (const char **)&config_ca_path))
+		die(_("git config option '%s' must be set"), config_ca_key);
+
+	/* prepare BIO-stdout */
+	out =3D BIO_new_fp(stdout, BIO_NOCLOSE);
+	if (!out)
+		goto end;
+
+	/* read in base64 encoded stripped tsr from stdin */
+	b64 =3D BIO_new(BIO_f_base64());
+	in =3D BIO_new_fp(stdin, BIO_NOCLOSE);
+	if (!in)
+		goto end;
+
+	in =3D BIO_push(b64, in);
+
+	response =3D d2i_TS_RESP_bio(in, NULL);
+	if (!response)
+		goto end;
+
+	extract_info_from_response(&info, response);
+	cert =3D find_certificate_in_store(&info);
+	if (!cert) {
+		error(_("certificate not found in %s"), certstore_file);
+		goto end;
+	}
+
+	if (do_verify(response, sha1, config_ca_path, cert)) {
+		error("BAD time-stamp signature");
+		ERR_print_errors(out);
+		goto end;
+	}
+
+	/* prepare data for output */
+	tst_info =3D TS_RESP_get_tst_info(response);
+
+	BIO_puts(out, "Verified time-stamp: ");
+	ASN1_GENERALIZEDTIME_print(out, tst_info->time);
+	BIO_printf(out, "\nTime Stamping Authority: %s\n",
+		   info.issuer);
+
+	retval =3D 0;
+
+end:
+	TS_RESP_free(response);
+	BIO_free_all(in);
+	BIO_free_all(out);
+	free(config_ca_path);
+
+	return retval;
+}
+
+static int do_verify(TS_RESP *response, const char *digest, const char=
 *CApath,
+		     X509 *cert)
+{
+	TS_VERIFY_CTX *verify_ctx =3D NULL;
+	int ret =3D 0;
+
+	verify_ctx =3D create_verify_ctx(digest, CApath, cert);
+	if (!verify_ctx)
+		goto end;
+
+	ret =3D TS_RESP_verify_response(verify_ctx, response);
+
+end:
+	/*
+	 * TS_VERIFY_CTX_free also cleans up the created X509_STORE, so no
+	 * further action is needed.
+	 */
+	TS_VERIFY_CTX_free(verify_ctx);
+
+	/*
+	 * Invert ret to follow git return semantics. 0 indicates success,
+	 * anything else indicates errors.
+	 */
+	return !ret;
+}
+
+static int append_certificate_to_store(struct tsr_info *info)
+{
+	FILE *store =3D fopen(certstore_file, "a");
+
+	if (!store) {
+		return error(_("Failed to open the certificate store at "
+			       "%s: %s"), certstore_file, strerror(errno));
+	}
+
+	fprintf(store, "%s\nVersion: 1\nSerial: %lu\nIssuer: %s\n\n",
+		certstore_header_begin,
+		info->serial,
+		info->issuer
+	       );
+
+	if (!PEM_write_X509(store, info->cert)) {
+		fclose(store);
+		return 1;
+	}
+
+	fprintf(store, "%s\n", certstore_header_end);
+	fclose(store);
+
+	return 0;
+}
+
+static X509 *find_certificate_in_store(struct tsr_info *info)
+{
+	char buf[1024];
+	char issuer[ISSUER_LEN];
+	X509 *cert =3D NULL;
+	unsigned long serial;
+	FILE *store;
+
+	store =3D fopen(certstore_file, "r");
+	if (!store) {
+		if (errno =3D=3D ENOENT)
+			return NULL;
+		die(_("Failed to open the certificate store at "
+			       "%s: %s"), certstore_file, strerror(errno));
+	}
+
+	while (fgets(buf, 1024, store)) {
+		if (!starts_with(buf, certstore_header_begin))
+			continue;
+
+		serial =3D 0;
+		*issuer =3D 0;
+		/* We are reading in an entry. Read in meta-data.*/
+		while (fgets(buf, 1024, store)) {
+			if (starts_with(buf, "Serial:"))
+				sscanf(buf, "Serial: %lu\n", &serial);
+
+			if (starts_with(buf, "Issuer:"))
+				sscanf(buf, "Issuer: %[^\n]\n", issuer);
+
+			/* A empty line separates meta-data from certificate */
+			if (!strcmp(buf, "\n"))
+			       break;
+			if (starts_with(buf, certstore_header_end)) {
+				serial =3D 0;
+				*issuer =3D 0;
+				break;
+			}
+		}
+
+		/* Check if certificate matches */
+		if (serial !=3D info->serial ||
+		    strcmp(issuer, info->issuer))
+			continue;
+
+		/* Matching certificate found */
+		cert =3D PEM_read_X509(store, NULL, NULL, NULL);
+
+		if (cert)
+			break;
+
+		/* Certificate could not be read. Output a warning. */
+		fprintf(stderr, "Warning: Failed to read certificate with serial: "
+				"%lu and issuer: %s. "
+				"It may be corrupted.\n", serial, issuer);
+	}
+
+	fclose(store);
+	return cert;
+}
+
+/* Extract issuer, serial number and TSA's public key from a TS_RESP s=
truct */
+static int extract_info_from_response(struct tsr_info *info, TS_RESP *=
response)
+{
+	PKCS7 *token;
+	PKCS7_SIGNER_INFO *pksi =3D NULL;
+	PKCS7_ISSUER_AND_SERIAL *pkis =3D NULL;
+
+	token =3D response->token;
+	pksi =3D sk_PKCS7_SIGNER_INFO_value(token->d.sign->signer_info, 0);
+	pkis =3D pksi->issuer_and_serial;
+
+	X509_NAME_get_text_by_NID(pkis->issuer, NID_commonName, info->issuer,
+				  ISSUER_LEN);
+	info->serial =3D ASN1_INTEGER_get(pkis->serial);
+	info->cert =3D sk_X509_value(token->d.sign->cert, 0);
+
+	return 0;
+}
+
+/* Use libssl functions to convert data to base64 and output it via st=
dout */
+static int output_as_base64(TS_RESP *response)
+{
+	BIO *b64 =3D NULL;
+	BIO *out =3D NULL;
+
+	b64 =3D BIO_new(BIO_f_base64());
+	out =3D BIO_new_fp(stdout, BIO_NOCLOSE);
+	out =3D BIO_push(b64, out);
+
+	if (!i2d_TS_RESP_bio(out, response))
+		return 1;
+
+	BIO_flush(out);
+	BIO_free_all(out);
+
+	return 0;
+}
+
+/*
+ * Strip TSR by removing all X509 certificates as they are stored in a=
 dedicated
+ * TSA certificate store.
+ */
+static TS_RESP *strip_tsr(TS_RESP *response)
+{
+	while (sk_X509_num(response->token->d.sign->cert) > 0)
+		sk_X509_pop(response->token->d.sign->cert);
+
+	return response;
+}
+
+static TS_REQ *create_query(const char *digest)
+{
+	int fail =3D 0;
+	TS_REQ *ts_req =3D NULL;
+	TS_MSG_IMPRINT *msg_imprint =3D NULL;
+	ASN1_INTEGER *nonce =3D NULL;
+
+	/* Creating request object. */
+	ts_req =3D TS_REQ_new();
+	if (!ts_req)
+		goto err;
+
+	/* Setting version. */
+	if (!TS_REQ_set_version(ts_req, 1))
+		goto err;
+
+	/* Setting MSG_IMPRINT */
+	msg_imprint =3D create_msg_imprint(digest);
+	if (!msg_imprint)
+		goto err;
+	if (!TS_REQ_set_msg_imprint(ts_req, msg_imprint))
+		goto err;
+
+	/* Setting nonce. */
+	nonce =3D create_nonce(NONCE_LENGTH);
+	if (!nonce)
+		goto err;
+	if (!TS_REQ_set_nonce(ts_req, nonce))
+		goto err;
+
+	/* Set certificate request flag. */
+	if (!TS_REQ_set_cert_req(ts_req, 1))
+		goto err;
+
+	fail =3D 1;
+err:
+	if (!fail) {
+		TS_REQ_free(ts_req);
+		ts_req =3D NULL;
+	}
+
+	TS_MSG_IMPRINT_free(msg_imprint);
+	ASN1_INTEGER_free(nonce);
+	return ts_req;
+}
+
+static TS_MSG_IMPRINT *create_msg_imprint(const char *digest)
+{
+	long len;
+	const EVP_MD *md =3D NULL;
+	TS_MSG_IMPRINT *msg_imprint =3D NULL;
+	X509_ALGOR *algo =3D NULL;
+	unsigned char *data =3D NULL;
+	int fail =3D 1;
+
+	/* Creating MSG_IMPRINT object. */
+	msg_imprint =3D TS_MSG_IMPRINT_new();
+	if (!msg_imprint)
+		goto err;
+
+	data =3D string_to_hex(digest, &len);
+	if (!TS_MSG_IMPRINT_set_msg(msg_imprint, data, len))
+		goto err;
+
+	/* Adding sha1 algorithm. */
+	md =3D EVP_sha1();
+	algo =3D X509_ALGOR_new();
+	if (!algo)
+		goto err;
+	algo->algorithm =3D OBJ_nid2obj(EVP_MD_type(md));
+	if (!algo->algorithm)
+		goto err;
+	algo->parameter =3D ASN1_TYPE_new();
+	if (!algo->parameter)
+		goto err;
+	algo->parameter->type =3D V_ASN1_NULL;
+	if (!TS_MSG_IMPRINT_set_algo(msg_imprint, algo))
+		goto err;
+
+	fail =3D 0;
+
+err:
+	if (fail) {
+		TS_MSG_IMPRINT_free(msg_imprint);
+		msg_imprint =3D NULL;
+	}
+
+	OPENSSL_free(data);
+	X509_ALGOR_free(algo);
+	return msg_imprint;
+}
+
+static ASN1_INTEGER *create_nonce(int bits)
+{
+	unsigned char buf[20];
+	ASN1_INTEGER *nonce =3D NULL;
+	int len =3D (bits - 1) / 8 + 1;
+	int i;
+
+	/* Generating random byte sequence. */
+	if (len > (int) sizeof(buf))
+		goto err;
+	if (RAND_bytes(buf, len) <=3D 0)
+		goto err;
+
+	/* Find the first non-zero byte and creating ASN1_INTEGER object. */
+	for (i =3D 0; i < len && !buf[i]; ++i)
+		;
+	nonce =3D ASN1_INTEGER_new();
+	if (!nonce)
+		goto err;
+	OPENSSL_free(nonce->data);
+
+	/* Allocate at least one byte. */
+	nonce->length =3D len - i;
+	nonce->data =3D OPENSSL_malloc(nonce->length + 1);
+	if (!nonce->data)
+		goto err;
+	memcpy(nonce->data, buf + i, nonce->length);
+
+	return nonce;
+ err:
+	ASN1_INTEGER_free(nonce);
+	return NULL;
+}
+
+static TS_VERIFY_CTX *create_verify_ctx(const char *digest, const char=
 *CApath,
+					X509 *cert)
+{
+	TS_VERIFY_CTX *ctx =3D NULL;
+	unsigned char *sha1 =3D NULL;
+	long imprint_len;
+	int f =3D 0;
+
+	ctx =3D TS_VERIFY_CTX_new();
+	if (!ctx)
+		goto err;
+
+	f =3D TS_VFY_VERSION | TS_VFY_SIGNER | TS_VFY_IMPRINT | TS_VFY_SIGNAT=
URE;
+	sha1 =3D string_to_hex(digest, &imprint_len);
+	if (!sha1)
+		goto err;
+
+	/* Add digest to verification context. */
+	ctx->imprint =3D sha1;
+	ctx->imprint_len =3D imprint_len;
+
+	/* Add the signature verification flag and arguments. */
+	ctx->flags =3D f;
+
+	/* Initialising the X509_STORE object. */
+	ctx->store =3D create_cert_store(CApath);
+	if (!ctx->store)
+		goto err;
+
+	/* Add signing certificate of TSA */
+	ctx->certs =3D sk_X509_new_null();
+	if (!ctx->certs)
+		goto err;
+
+	sk_X509_push(ctx->certs, cert);
+
+
+	return ctx;
+
+err:
+	/*
+	 * TS_VERIFY_CTX also cleans up *sha1 and the created X509 store, so =
no
+	 * further action is needed.
+	 */
+	TS_VERIFY_CTX_free(ctx);
+	return NULL;
+}
+
+static X509_STORE *create_cert_store(const char *CApath)
+{
+	X509_STORE *cert_ctx =3D NULL;
+	X509_LOOKUP *lookup =3D NULL;
+	int ret;
+
+	cert_ctx =3D X509_STORE_new();
+	lookup =3D X509_STORE_add_lookup(cert_ctx, X509_LOOKUP_hash_dir());
+	if (!lookup)
+		goto err;
+
+	ret =3D X509_LOOKUP_add_dir(lookup, CApath, X509_FILETYPE_PEM);
+	if (!ret) {
+		error(_("Error loading directory %s"), CApath);
+		goto err;
+	}
+
+	return cert_ctx;
+
+err:
+	X509_STORE_free(cert_ctx);
+	return NULL;
+}
+
+
+static void usage_and_die(const char *name)
+{
+	fprintf(stderr, "Usage: %s <-c | -v> [<sha1>]\n\n", name);
+	fputs("-c: Create a time-stamp signature for the given SHA1-hash\n",
+	      stderr);
+	fputs("-v: Verify a time-stamp signature from data passed via stdin\n=
",
+	      stderr);
+
+	exit(EXIT_FAILURE);
+}
+
+int main(int argc, char *argv[])
+{
+	CRYPTO_malloc_init();
+	ERR_load_crypto_strings();
+	OpenSSL_add_all_algorithms();
+
+	if (argc !=3D 3)
+		usage_and_die(argv[0]);
+
+	if (!strcmp(argv[1], "-c"))
+		return create_tsr(argv[2]);
+
+	else if (!strcmp(argv[1], "-v"))
+		return verify_tsr(argv[2]);
+
+	else
+		usage_and_die(argv[0]);
+
+	return 0;
+}
--=20
2.8.0.rc0.62.gfc8aefa.dirty
