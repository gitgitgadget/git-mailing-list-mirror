From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH 3/3] git over TLS (gits://) support (part 3)
Date: Sat,  1 May 2010 20:09:51 +0300
Message-ID: <1272733791-11341-4-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1272733791-11341-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 01 19:12:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8GFK-0005xf-Qr
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 19:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864Ab0EARMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 13:12:48 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:38748 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab0EARMd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 13:12:33 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 9312213B788
	for <git@vger.kernel.org>; Sat,  1 May 2010 20:12:30 +0300 (EEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A0695E871E1; Sat, 01 May 2010 20:12:30 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 104C62BD45
	for <git@vger.kernel.org>; Sat,  1 May 2010 20:12:28 +0300 (EEST)
X-Mailer: git-send-email 1.7.1.rc2.10.g714149
In-Reply-To: <1272733791-11341-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146092>

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 git-over-tls/pem.c          |  362 ++++++++++++++++++++++++
 git-over-tls/pem.h          |   16 +
 git-over-tls/pem_decrypt.c  |  203 ++++++++++++++
 git-over-tls/pem_decrypt.h  |    9 +
 git-over-tls/ssh.c          |  635 +++++++++++++++++++++++++++++++++++++++++++
 git-over-tls/ssh.h          |   18 ++
 git-over-tls/ssh_localkey.c |  435 +++++++++++++++++++++++++++++
 git-over-tls/ssh_localkey.h |   18 ++
 8 files changed, 1696 insertions(+), 0 deletions(-)
 create mode 100644 git-over-tls/pem.c
 create mode 100644 git-over-tls/pem.h
 create mode 100644 git-over-tls/pem_decrypt.c
 create mode 100644 git-over-tls/pem_decrypt.h
 create mode 100644 git-over-tls/ssh.c
 create mode 100644 git-over-tls/ssh.h
 create mode 100644 git-over-tls/ssh_localkey.c
 create mode 100644 git-over-tls/ssh_localkey.h

diff --git a/git-over-tls/pem.c b/git-over-tls/pem.c
new file mode 100644
index 0000000..3e4f366
--- /dev/null
+++ b/git-over-tls/pem.c
@@ -0,0 +1,362 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2010
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "pem.h"
+#include "pem_decrypt.h"
+#include "base64.h"
+#include <string.h>
+#ifdef USE_COMPAT_H
+#include "compat.h"
+#else
+#include "git-compat-util.h"
+#endif
+
+void dump_blob(const char *name, const unsigned char *blob, size_t bloblen);
+
+static const unsigned char *strstr_n(const unsigned char *haystack,
+	const unsigned char *needle, size_t haystack_size)
+{
+	size_t maxpos, i;
+	size_t needle_size;
+	needle_size = strlen((const char*)needle);
+	if (haystack_size < needle_size)
+		return NULL;
+	maxpos = haystack_size - needle_size;
+	for (i = 0; i < maxpos; i++)
+		if (!strncmp((const char*)(haystack + i),
+			(const char*)needle, needle_size))
+			return haystack + i;
+	return NULL;
+}
+
+static const unsigned char *strchrs_n(const unsigned char *str,
+	const char *chars, size_t str_len)
+{
+	while (str_len > 0) {
+		if (strchr(chars, (char)str[0]))
+			return str;
+		str++;
+		str_len--;
+	}
+	return NULL;
+}
+
+const unsigned char *find_base64_start(const unsigned char *start,
+	const unsigned char *end, char **dek_info)
+{
+	const unsigned char *startaddr;
+	const unsigned char *dekline;
+	size_t remaining = end - start;
+	startaddr = base64_blob_start(start, &remaining);
+	if (!startaddr) {
+		error("Malformed PEM: No BASE64 section found");
+		return NULL;
+	}
+	dekline = strstr_n(start, (const unsigned char*)"DEK-Info: ",
+		startaddr - start);
+	if (!dekline)
+		*dek_info = NULL;
+	else {
+		const unsigned char *term;
+		const unsigned char *dekstart = dekline + 10;
+		while (dekstart < startaddr && (*dekstart == ' ' ||
+			*dekstart == '\t'))
+			dekstart++;
+
+		term = strchrs_n(dekstart, "\r\n", startaddr - dekstart);
+		if(!term) {
+			error("Malformed PEM: No BASE64 section found");
+			return NULL;
+		}
+		*dek_info = xstrndup((const char*)dekstart, term - dekstart);
+	}
+	return startaddr;
+}
+
+size_t decode_asn1_length_tag(const unsigned char **file, size_t *left)
+{
+	if (*left < 1)
+		goto eof;
+
+	if (**file < 0x80) {
+		(*left)--;
+		(*file)++;
+		return (*file)[-1];
+	} else if (**file == 0x80) {
+		error("Malformed PEM: Bad length tag");
+		*file = NULL;
+		return 0;
+	} else if (**file == 0x81) {
+		if (*left < 2)
+			goto eof;
+		*left -= 2;
+		(*file) += 2;
+		return (*file)[-1];
+	} else if (**file == 0x82) {
+		if (*left < 3)
+			goto eof;
+		*left -= 3;
+		(*file) += 3;
+		return (((size_t)(*file)[-2]) << 8) |
+			((size_t)(*file)[-1]);
+	} else if (**file == 0x83) {
+		if (*left < 4)
+			goto eof;
+		*left -= 4;
+		(*file) += 4;
+		return (((size_t)(*file)[-3]) << 16) |
+			(((size_t)(*file)[-2]) << 8) |
+			((size_t)(*file)[-1]);
+	} else {
+		error("Unreadable PEM: Size too large");
+		*file = NULL;
+		return 0;
+	}
+eof:
+	error("Malformed PEM: Expected length tag, got EOF");
+	*file = NULL;
+	return 0;
+}
+
+size_t asn1_integers_size(const unsigned char *seq, size_t seq_len,
+	int low, int high, size_t *k2size)
+{
+	int component = 0;
+	size_t size = 0;
+	for (component = 0; component < high; component++) {
+		size_t clen = 0;
+		if (seq_len < 1) {
+			error("Malformed PEM: Expected tag, got EOF");
+			return 0;
+		}
+		if (*seq != 0x02) {
+			error("Malformed PEM: Expected INTEGER");
+			return 0;
+		}
+		seq++;
+		seq_len--;
+		clen = decode_asn1_length_tag(&seq, &seq_len);
+		if (!seq)
+			return 0;
+		if (seq_len < clen) {
+			error("Malformed PEM: Truncated integer");
+			return 0;
+		}
+		seq += clen;
+		seq_len -= clen;
+		if (component == 2 && k2size)
+			*k2size = (4 + clen);
+		if (component >= low) {
+			size += (4 + clen);
+		}
+	}
+	return size;
+}
+
+unsigned char *handle_asn1_sequence(const unsigned char *seq, size_t seq_len,
+	size_t *keysize, int keytype)
+{
+	int low;
+	int high;
+	size_t kslow;
+	size_t toffset = 0;
+	size_t foffset = 0;
+	int component = 0;
+	size_t offset = 0;
+	size_t k2size = 0;
+	unsigned char *ret = NULL;
+
+	if (keytype == 1) {
+		low = 1;
+		high = 4;
+		kslow = 11;
+	} else if (keytype == 2) {
+		low = 1;
+		high = 6;
+		kslow = 11;
+	} else {
+		error("Unknown PEM key type");
+		return NULL;
+	}
+	*keysize = kslow + asn1_integers_size(seq, seq_len, low, high,
+		&k2size);
+	if (*keysize <= kslow)
+		return NULL;
+	ret = xmalloc(*keysize);
+
+	if (keytype == 1) {
+		ret[0] = 0;
+		ret[1] = 0;
+		ret[2] = 0;
+		ret[3] = 7;
+		memcpy(ret + 4, "ssh-rsa", 7);
+		offset = 11;
+	} else if (keytype == 2) {
+		ret[0] = 0;
+		ret[1] = 0;
+		ret[2] = 0;
+		ret[3] = 7;
+		memcpy(ret + 4, "ssh-dss", 7);
+		offset = 11;
+	}
+
+	/*
+	 * Hack warning: The e and n are in "wrong" order in PEM
+	 * RSA keys, so swap those.
+	 */
+	for (component = 0; component < high; component++) {
+		size_t clen = 0;
+		seq++;
+		seq_len--;
+		clen = decode_asn1_length_tag(&seq, &seq_len);
+		if(component >= low) {
+			if (keytype == 1 && component == 1) {
+				toffset = offset;
+				foffset = offset + 4 + clen;
+				offset += k2size;
+			}
+			ret[offset + 0] = (unsigned char)(clen >> 24);
+			ret[offset + 1] = (unsigned char)(clen >> 16);
+			ret[offset + 2] = (unsigned char)(clen >> 8);
+			ret[offset + 3] = (unsigned char)(clen);
+			memcpy(ret + offset + 4, seq, clen);
+			offset += (4 + clen);
+			if (keytype == 1 && component == 1)
+				offset = toffset;
+			if (keytype == 1 && component == 2)
+				offset = foffset + k2size;
+		}
+		seq += clen;
+		seq_len -= clen;
+	}
+
+	return ret;
+}
+
+
+#define RSA_START_MARKER "-----BEGIN RSA PRIVATE KEY-----"
+#define DSA_START_MARKER "-----BEGIN DSA PRIVATE KEY-----"
+#define START_MARKER_LEN 31
+#define RSA_END_MARKER "-----END RSA PRIVATE KEY-----"
+#define DSA_END_MARKER "-----END DSA PRIVATE KEY-----"
+
+unsigned char *pem_decode(const unsigned char *file, size_t filesize,
+	const char *keyname, size_t *keysize)
+{
+	int type = 0;
+	const unsigned char *start;
+	const unsigned char *end;
+	unsigned char *binary;
+	unsigned char *ret;
+	const unsigned char *binary_c;
+	size_t binary_c_size;
+	size_t binary_size;
+	size_t length;
+	char *dek_info;
+
+	while(filesize > 0 && (*file == '\n' || *file == '\r')) {
+		filesize--;
+		file++;
+	}
+
+	if (filesize < 64)
+		return NULL;
+
+	if (!strncmp((const char*)file, RSA_START_MARKER "\r",
+		START_MARKER_LEN + 1)) {
+		start = file + START_MARKER_LEN + 1;
+		type = 1;
+	} else if (!strncmp((const char*)file,
+		DSA_START_MARKER "\r", START_MARKER_LEN + 1)) {
+		start = file + START_MARKER_LEN + 1;
+		type = 2;
+	} else if (!strncmp((const char*)file,
+		RSA_START_MARKER "\n", START_MARKER_LEN + 1)) {
+		start = file + START_MARKER_LEN + 1;
+		type = 1;
+	} else if (!strncmp((const char*)file,
+		DSA_START_MARKER "\n", START_MARKER_LEN + 1)) {
+		start = file + START_MARKER_LEN + 1;
+		type = 2;
+	} else {
+		return NULL;
+	}
+
+	if(type == 1) {
+		end = strstr_n(file, (const unsigned char*)
+			"\r" RSA_END_MARKER, filesize);
+		if (end)
+			goto ok;
+		end = strstr_n(file, (const unsigned char*)
+			"\n" RSA_END_MARKER, filesize);
+		if (end)
+			goto ok;
+		error("Malformed PEM: No end marker (type 1)");
+		return NULL;
+	} else if(type == 2) {
+		end = strstr_n(file, (const unsigned char*)
+			"\r" DSA_END_MARKER, filesize);
+		if (end)
+			goto ok;
+		end = strstr_n(file, (const unsigned char*)
+			"\n" DSA_END_MARKER, filesize);
+		if (end)
+			goto ok;
+		error("Malformed PEM: No end marker (type 2)");
+		return NULL;
+	} else {
+		error("Unknown PEM key type");
+		return NULL;
+	}
+ok:
+	start = find_base64_start(start, end, &dek_info);
+	binary = decode_base64_chunk(start, end - start, &binary_size);
+	if (!binary) {
+		free(dek_info);
+		return NULL;
+	}
+	if (dek_info) {
+		unsigned char *decrypted;
+		size_t decrypted_len;
+		decrypted = decrypt_key(binary, binary_size, dek_info,
+			keyname, &decrypted_len);
+		free(dek_info);
+		free(binary);
+		if (!decrypted)
+			return NULL;
+		binary = decrypted;
+		binary_size = decrypted_len;
+	}
+	if (binary_size < 1)
+		goto invalid_seq;
+	if (binary[0] != 0x30) {
+		error("Malformed PEM: First element must be SEQUENCE");
+		goto error_decoded;
+	}
+	binary_c = binary + 1;
+	binary_c_size = binary_size -1;
+	length = decode_asn1_length_tag(&binary_c, &binary_c_size);
+	if (!binary_c) {
+		error("Malformed PEM: Bad length for SEQUENCE");
+		goto error_decoded;
+	}
+	if (length < binary_c_size) {
+		error("Malformed PEM: Garbage after end");
+		goto error_decoded;
+	} else if (length > binary_c_size) {
+		error("Malformed PEM: SEQUENCE overflows file");
+		goto error_decoded;
+	}
+	ret = handle_asn1_sequence(binary_c, binary_c_size, keysize, type);
+	free(binary);
+	return ret;
+invalid_seq:
+	error("Malformed PEM: No valid sequence");
+error_decoded:
+	free(binary);
+	return NULL;
+}
diff --git a/git-over-tls/pem.h b/git-over-tls/pem.h
new file mode 100644
index 0000000..df202e5
--- /dev/null
+++ b/git-over-tls/pem.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2010
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _pem__h__included__
+#define _pem__h__included__
+
+#include <stdlib.h>
+
+unsigned char *pem_decode(const unsigned char *file, size_t filesize,
+	const char* keyname, size_t *keysize);
+
+#endif
diff --git a/git-over-tls/pem_decrypt.c b/git-over-tls/pem_decrypt.c
new file mode 100644
index 0000000..46effcf
--- /dev/null
+++ b/git-over-tls/pem_decrypt.c
@@ -0,0 +1,203 @@
+#include "pem_decrypt.h"
+#include "srp_askpass.h"
+#include <string.h>
+#include <gcrypt.h>
+#ifdef USE_COMPAT_H
+#include "compat.h"
+#else
+#include "git-compat-util.h"
+#endif
+
+#define BUFFERSIZE 16384
+#define IVSIZE 128
+
+unsigned char hexdecode(char c)
+{
+	switch(c) {
+	case '0':	return 0;
+	case '1':	return 1;
+	case '2':	return 2;
+	case '3':	return 3;
+	case '4':	return 4;
+	case '5':	return 5;
+	case '6':	return 6;
+	case '7':	return 7;
+	case '8':	return 8;
+	case '9':	return 9;
+	case 'a':	return 10;
+	case 'b':	return 11;
+	case 'c':	return 12;
+	case 'd':	return 13;
+	case 'e':	return 14;
+	case 'f':	return 15;
+	case 'A':	return 10;
+	case 'B':	return 11;
+	case 'C':	return 12;
+	case 'D':	return 13;
+	case 'E':	return 14;
+	case 'F':	return 15;
+	default:	die("Bad hexadecimal character");
+	}
+	return 0;
+}
+
+unsigned char hexpairdecode(const char* hexpair)
+{
+	return hexdecode(hexpair[0]) * 16 + hexdecode(hexpair[1]);
+}
+
+void decode_iv(unsigned char *iv, const char *dek_tail, size_t correct_len)
+{
+	int i;
+	if (strchr(dek_tail, ' ') != dek_tail + 2 * correct_len &&
+		strlen(dek_tail) != 2 * correct_len)
+		die("IV field in key encryption wrong length");
+
+	for (i = 0; i < correct_len; i++)
+		iv[i] = hexpairdecode(dek_tail + 2 * i);
+}
+
+#define MD5LEN 16
+#define SALTLEN 8
+
+void derive_key(unsigned char *key, size_t keylen, const unsigned char *iv,
+	const char *passphrase)
+{
+	size_t passphrase_len;
+	int derived;
+	unsigned char* md5 = NULL;
+	unsigned char md5copy[MD5LEN];
+	gcry_md_hd_t handle;
+	int i;
+
+	if (gcry_md_open(&handle, GCRY_MD_MD5, 0))
+		die("Can't gcry_md_open(..., GCRY_MD_MD5, ...).");
+
+	passphrase_len = strlen(passphrase);
+	for (derived = 0; derived < keylen;) {
+		gcry_md_reset(handle);
+
+		if (md5)
+			gcry_md_write(handle, md5copy, MD5LEN);
+		gcry_md_write(handle, passphrase, passphrase_len);
+		gcry_md_write(handle, iv, SALTLEN);
+
+		md5 = gcry_md_read(handle, 0);
+		memcpy(md5copy, md5, MD5LEN);
+		for (i = 0; i < 16 && derived < keylen; i++) {
+			key[derived++] = md5[i];
+		}
+	}
+	gcry_md_close(handle);
+}
+
+unsigned char *decrypt_key(const unsigned char *cipher, size_t cipher_size,
+	const char *dek_info, const char *keyname, size_t *decrypted_len)
+{
+	char *passphrase;
+	static char *stored_passphrase = NULL;
+	static char lastkeyname[BUFFERSIZE];
+	unsigned char iv[IVSIZE];
+	unsigned char key[IVSIZE];
+	size_t ivlen;
+	size_t keylen;
+	int algo;
+	int mode;
+	size_t i;
+	int cipher_inited = 0;
+	gcry_cipher_hd_t cipherh;
+	unsigned char *ret = NULL;
+
+	if (strlen(keyname) + 1 > BUFFERSIZE)
+		die("Keyname insanely long");
+
+	if (stored_passphrase && !strcmp(keyname, lastkeyname)) {
+		passphrase = stored_passphrase;
+		goto reuse_passphrase;
+	}
+
+	passphrase = get_ssh_password(keyname);
+	stored_passphrase = passphrase;
+reuse_passphrase:
+	if (!prefixcmp(dek_info, "DES-EDE3-CBC,")) {
+		/* 3DES-CBC */
+		ivlen = 8;
+		keylen = 24;
+		algo = GCRY_CIPHER_3DES;
+		mode = GCRY_CIPHER_MODE_CBC;
+	} else if (!prefixcmp(dek_info, "DES-CBC,")) {
+		/* DES-CBC (INSECURE!!!) */
+		ivlen = 8;
+		keylen = 8;
+		algo = GCRY_CIPHER_DES;
+		mode = GCRY_CIPHER_MODE_CBC;
+	} else if (!prefixcmp(dek_info, "AES-128-CBC,")) {
+		/* AES-128-CBC */
+		ivlen = 16;
+		keylen = 16;
+		algo = GCRY_CIPHER_AES128;
+		mode = GCRY_CIPHER_MODE_CBC;
+	} else if (!prefixcmp(dek_info, "AES-192-CBC,")) {
+		/* AES-192-CBC */
+		ivlen = 16;
+		keylen = 24;
+		algo = GCRY_CIPHER_AES192;
+		mode = GCRY_CIPHER_MODE_CBC;
+	} else if (!prefixcmp(dek_info, "AES-256-CBC,")) {
+		/* AES-256-CBC */
+		ivlen = 16;
+		keylen = 32;
+		algo = GCRY_CIPHER_AES256;
+		mode = GCRY_CIPHER_MODE_CBC;
+	} else {
+		error("Key encryption type not supported (%s)", dek_info);
+		goto error_exit;
+	}
+	decode_iv(iv, strchr(dek_info, ',') + 1, ivlen);
+	derive_key(key, keylen, iv, passphrase);
+
+	if (gcry_cipher_open(&cipherh, algo, mode, 0)) {
+		error("gcry_cipher_open() failed (DEK=%s; unsupported algorithm?)", dek_info);
+		goto error_exit;
+	}
+	cipher_inited = 1;
+
+	if (gcry_cipher_setkey(cipherh, key, keylen)) {
+		error("gcry_cipher_setkey() failed (DEK=%s)", dek_info);
+		goto error_exit;
+	}
+
+	if (gcry_cipher_setiv(cipherh, iv, ivlen)) {
+		error("gcry_cipher_setiv() failed (DEK=%s)", dek_info);
+		goto error_exit;
+	}
+
+	ret = xmalloc(cipher_size);
+	if (gcry_cipher_decrypt(cipherh, ret, cipher_size, cipher,
+		cipher_size)) {
+		error("gcry_cipher_decrypt() failed (DEK=%s, wrong passphrase?)", dek_info);
+		goto error_exit;
+	}
+
+	*decrypted_len = cipher_size - ret[cipher_size - 1];
+	for(i = *decrypted_len; i < cipher_size; i++) {
+		if(ret[i] != ret[cipher_size - 1]) {
+			error("Incorrect passphrase or key corrupt");
+			goto error_exit;
+		}
+	}
+
+	strcpy(lastkeyname, keyname);
+	stored_passphrase = passphrase;
+	gcry_cipher_close(cipherh);
+	return ret;
+error_exit:
+	if (cipher_inited)
+		gcry_cipher_close(cipherh);
+	if (stored_passphrase)
+		free(stored_passphrase);
+	if (ret)
+		free(ret);
+	stored_passphrase = NULL;
+	return NULL;
+}
diff --git a/git-over-tls/pem_decrypt.h b/git-over-tls/pem_decrypt.h
new file mode 100644
index 0000000..ab132bf
--- /dev/null
+++ b/git-over-tls/pem_decrypt.h
@@ -0,0 +1,9 @@
+#ifndef _pem_decrypt__h__included__
+#define _pem_decrypt__h__included__
+
+#include <stdlib.h>
+
+unsigned char *decrypt_key(const unsigned char *cipher, size_t cipher_size,
+	const char *dek_info, const char *keyname, size_t *decrypted_len);
+
+#endif
diff --git a/git-over-tls/ssh.c b/git-over-tls/ssh.c
new file mode 100644
index 0000000..1d7426f
--- /dev/null
+++ b/git-over-tls/ssh.c
@@ -0,0 +1,635 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2010
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "ssh.h"
+#include "ssh_localkey.h"
+#include "home.h"
+#include "base64.h"
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/un.h>
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <gcrypt.h>
+#ifdef USE_COMPAT_H
+#include "compat.h"
+#else
+#include "git-compat-util.h"
+#endif
+#include <stdlib.h>
+
+#define SSH2_AGENTC_SIGN_REQUEST 13
+#define SSH_AGENT_FAILURE 5
+#define SSH_AGENT_SUCCESS 6
+#define SSH2_AGENT_SIGN_RESPONSE 14
+
+#define MAX_REPLY_SIZE 1048576
+
+/* Decode uint32. */
+static unsigned long decode_uint32(const unsigned char *ptr)
+{
+	unsigned long v = 0;
+	v |= ((unsigned long)ptr[0] << 24);
+	v |= ((unsigned long)ptr[1] << 16);
+	v |= ((unsigned long)ptr[2] << 8);
+	v |= ((unsigned long)ptr[3]);
+	return v;
+}
+
+/*
+ * Extract actual signature from ssh-agent reply. The return value should be
+ * freed. The reply has the component lengths present.
+ */
+static unsigned char *extract_actual_key(const unsigned char *keyreply,
+	size_t keyreply_len, const char *expected_type, size_t *key_len)
+{
+	unsigned long rlen;
+
+	if (keyreply_len < 1) {
+		error("Malformed reply from SSH agent: No packet type present");
+		return NULL;
+	}
+	if (keyreply[0] == SSH_AGENT_FAILURE) {
+		error("SSH agent failed to sign the challenge");
+		return NULL;
+	}
+	if (keyreply[0] != SSH2_AGENT_SIGN_RESPONSE) {
+		error("SSH agent is confused: Returned packet type %u when type %u was expected",
+			keyreply[0], SSH2_AGENT_SIGN_RESPONSE);
+		return NULL;
+	}
+	if (keyreply_len < 5) {
+		error("Malformed signature reply from SSH agent: Signature length incomplete");
+		return NULL;
+	}
+	rlen = decode_uint32(keyreply + 1);
+
+	if (keyreply_len < 5 + rlen) {
+		error("Malformed signature reply from SSH agent: Signature incomplete");
+		return NULL;
+	}
+	/* Strip packet header. */
+	keyreply += 5;
+	keyreply_len = rlen;
+
+	if (keyreply_len < 4) {
+		error("Malformed signature reply from SSH agent: Keytype header incomplete");
+		return NULL;
+	}
+	rlen = decode_uint32(keyreply);
+	if (keyreply_len < 4 + rlen) {
+		error("Malformed signature reply from SSH agent: Keytype incomplete");
+		return NULL;
+	}
+	if (rlen != strlen(expected_type) || memcmp(keyreply + 4,
+		expected_type, rlen)) {
+		error("SSH agent returned signature of wrong type: Expected '%s', got '%.*s'",
+			expected_type, (int)rlen, keyreply + 4);
+		return NULL;
+	}
+	/* Strip key type. */
+	keyreply += 4 + rlen;
+	keyreply_len -= 4 + rlen;
+
+	if (keyreply_len < 4) {
+		error("Malformed signature reply from SSH agent: Signature blob length incomplete");
+		return NULL;
+	}
+	rlen = decode_uint32(keyreply);
+	if (keyreply_len < 4 + rlen) {
+		error("Malformed signature reply from SSH agent: Signature blob incomplete");
+		return NULL;
+	}
+
+	/* Extract the signature blob. */
+	keyreply += 4;
+	keyreply_len = rlen;
+
+	if (!strcmp(expected_type, "ssh-rsa")) {
+		unsigned char *ret;
+
+		ret = xmalloc(keyreply_len + 5);
+		if (keyreply[0] > 128) {
+			/* Zero-pad to avoid negative value. */
+			encode_uint32(ret, keyreply_len + 1);
+			ret[4] = 0;
+			memcpy(ret + 5, keyreply, keyreply_len);
+			*key_len = 5 + keyreply_len;
+		} else {
+			encode_uint32(ret, keyreply_len);
+			memcpy(ret + 4, keyreply, keyreply_len);
+			*key_len = 4 + keyreply_len;
+		}
+		return ret;
+	} else if (!strcmp(expected_type, "ssh-dss")) {
+		unsigned char *ret;
+		unsigned offset = 0;
+
+		ret = xmalloc(keyreply_len + 10);
+		if (keyreply_len % 2) {
+			error("Malformed DSA signature, length is odd.");
+			free(ret);
+			return NULL;
+		}
+
+		/* Encode r. */
+		if (keyreply[0] > 128) {
+			/* Zero-pad to avoid negative value. */
+			encode_uint32(ret, keyreply_len / 2 + 1);
+			ret[offset + 4] = 0;
+			offset += 5;
+		} else {
+			encode_uint32(ret, keyreply_len / 2);
+			offset += 4;
+		}
+		memcpy(ret + offset, keyreply, keyreply_len / 2);
+		offset += keyreply_len / 2;
+
+		/* Encode s. */
+		if (keyreply[keyreply_len / 2] > 128) {
+			/* Zero-pad to avoid negative value. */
+			encode_uint32(ret + offset, keyreply_len / 2 + 1);
+			ret[offset + 4] = 0;
+			offset += 5;
+		} else {
+			encode_uint32(ret + offset, keyreply_len / 2);
+			offset += 4;
+		}
+		memcpy(ret + offset, keyreply + keyreply_len / 2,
+			keyreply_len / 2);
+		offset += keyreply_len / 2;
+
+		*key_len = offset;
+		return ret;
+	} else {
+		error("Unknown signature type '%s'", expected_type);
+		return NULL;
+	}
+
+	return NULL;
+}
+
+
+/* Extract SecSH public key. */
+static unsigned char *extract_secsh_pubkey(const unsigned char *file,
+	size_t file_len, size_t *key_len)
+{
+	const unsigned char *file2;
+	size_t file_len2;
+
+	/* Skip to begin line. */
+	if (*file == '\r' || *file == '\n') {
+		/* Skip the empty lines. */
+		file = next_line(file, &file_len);
+		if (!file) {
+			error("Malformed SecSH public key (no header)");
+			return NULL;
+		}
+	}
+	file = next_line(file, &file_len);
+	if (!file) {
+		error("Malformed SecSH public key (no header)");
+		return NULL;
+	}
+
+	file = base64_blob_start(file, &file_len);
+	file2 = file;
+	file_len2 = file_len;
+
+	if (file_len2 == 29 && !memcmp(file2,
+		"---- END SSH2 PUBLIC KEY ----", 29)) {
+		error("Malformed SecSH public key (no encoded blob)");
+		return NULL;
+	}
+	if (!memcmp(file2, "---- END SSH2 PUBLIC KEY ----\r", 30)) {
+		error("Malformed SecSH public key (no encoded blob)");
+		return NULL;
+	}
+	if (!memcmp(file2, "---- END SSH2 PUBLIC KEY ----\n", 30)) {
+		error("Malformed SecSH public key (no encoded blob)");
+		return NULL;
+	}
+	while(1) {
+		file2 = next_line(file2, &file_len2);
+		if (!file2) {
+			error("Malformed SecSH public key (no trailer)");
+			return NULL;
+		}
+		if (file_len2 == 29 && !memcmp(file2,
+			"---- END SSH2 PUBLIC KEY ----", 29)) {
+			file_len = file2 - file;
+			break;
+		}
+		if (!memcmp(file2, "---- END SSH2 PUBLIC KEY ----\r", 30)) {
+			file_len = file2 - file;
+			break;
+		}
+		if (!memcmp(file, "---- END SSH2 PUBLIC KEY ----\n", 30)) {
+			file_len = file2 - file;
+			break;
+		}
+	}
+	return decode_base64_chunk(file, file_len, key_len);
+}
+
+/* Is SecSH format key? */
+static int is_secsh_pubkey(const unsigned char *file, size_t file_len)
+{
+	if (file_len < 32)
+		return 0;
+	if (!memcmp(file, "---- BEGIN SSH2 PUBLIC KEY ----\r", 32))
+		return 1;
+	if (!memcmp(file, "---- BEGIN SSH2 PUBLIC KEY ----\n", 32))
+		return 1;
+	file = next_line(file, &file_len);
+	if (file_len < 32)
+		return 0;
+	if (!memcmp(file, "---- BEGIN SSH2 PUBLIC KEY ----\r", 32))
+		return 1;
+	if (!memcmp(file, "---- BEGIN SSH2 PUBLIC KEY ----\n", 32))
+		return 1;
+	return 0;
+}
+
+/* Extract OpenSSH public key. */
+static unsigned char *extract_openssh_pubkey(const unsigned char *file,
+	size_t file_len, size_t *key_len)
+{
+	const unsigned char *base;
+	const unsigned char *sep2;
+	size_t blob_size;
+	base = (const unsigned char*)strchr((const char*)file, ' ');
+	if (!base) {
+		error("Malformed OpenSSH pubkey file");
+		return NULL;
+	}
+	base++;
+
+	sep2 = (const unsigned char*)strchr((const char*)base, ' ');
+	if (!sep2)
+		blob_size = strlen((const char*)base);
+	else
+		blob_size = sep2 - base;
+
+	return decode_base64_chunk(base, blob_size, key_len);
+}
+
+/* Is OpenSSH format key? */
+static int is_openssh_pubkey(const unsigned char *file, size_t file_len)
+{
+	if (file_len < 8)
+		return 0;
+	if (!memcmp(file, "ssh-rsa ", 8))
+		return 1;
+	if (!memcmp(file, "ssh-dss ", 8))
+		return 1;
+	return 0;
+}
+
+/*
+ * Extract actual key blob from encoded key. The return value should be
+ * freed. The reply has the component lengths present.
+ */
+unsigned char *extract_key_from_file(const unsigned char *file,
+	size_t file_len, size_t *key_len)
+{
+	if (is_openssh_pubkey(file, file_len))
+		return extract_openssh_pubkey(file, file_len, key_len);
+	if (is_secsh_pubkey(file, file_len))
+		return extract_secsh_pubkey(file, file_len, key_len);
+	error("Unknown public key file format");
+	return NULL;
+}
+
+void dump_blob(const char *name, const unsigned char *blob, size_t bloblen)
+{
+
+	size_t i;
+	fprintf(stderr, "------- START %s (%u bytes) ------\n", name, (unsigned)bloblen);
+	for(i = 0; i < bloblen; i++) {
+		fprintf(stderr, "%02X ", blob[i]);
+		if (i % 16 == 15)
+			fprintf(stderr, "\n");
+	}
+	if (i % 16)
+		fprintf(stderr, "\n");
+	fprintf(stderr, "-------- END %s -------\n", name);
+
+}
+
+int write_to_agent(int fd, const unsigned char *ptr, size_t size)
+{
+	while (size > 0) {
+		ssize_t r;
+		r = write(fd, ptr, size);
+		if (r > 0) {
+			ptr += r;
+			size -= r;
+		} else if (r == 0) {
+			error("Connection to ssh-agent unexpectedly lost");
+			return -1;
+		}
+		else if (errno == EINTR || errno == EAGAIN)
+			continue;
+		else {
+			error("Error writing to ssh-agent: %s",
+				strerror(errno));
+			return -1;
+		}
+	}
+	return 0;
+}
+
+int read_in_agent(int fd, unsigned char *ptr, size_t size)
+{
+	while (size > 0) {
+		ssize_t r;
+		r = read(fd, ptr, size);
+		if (r > 0) {
+			ptr += r;
+			size -= r;
+		} else if (r == 0) {
+			error("Connection to ssh-agent unexpectedly lost");
+			return -1;
+		}
+		else if (errno == EINTR || errno == EAGAIN)
+			continue;
+		else {
+			error("Error reading from ssh-agent: %s",
+				strerror(errno));
+			return -1;
+		}
+	}
+	return 0;
+}
+
+int write_packet_to_agent(int fd, const unsigned char *payload, size_t len)
+{
+	unsigned char tmp[4];
+	encode_uint32(tmp, len);
+	if (write_to_agent(fd, tmp, 4) < 0)
+		return -1;
+	if (write_to_agent(fd, payload, len) < 0)
+		return -1;
+	return 0;
+}
+
+unsigned char *read_packet_from_agent(int fd, size_t *len)
+{
+	unsigned char *ret;
+	unsigned char tmp[4];
+	if (read_in_agent(fd, tmp, 4) < 0)
+		return NULL;
+	*len = decode_uint32(tmp);
+	if (*len > MAX_REPLY_SIZE) {
+		error("Reply from SSH agent too large (size %zu, maximum allowed %zu)",
+			*len, (size_t)MAX_REPLY_SIZE);
+		return NULL;
+	}
+	ret = xmalloc(*len);
+	if (read_in_agent(fd, ret, *len) < 0) {
+		free(ret);
+		return NULL;
+	}
+	return ret;
+}
+
+static unsigned char *agent_do_io_cycle(int fd, const unsigned char *payload,
+	size_t payload_len, size_t *reply_len)
+{
+	if (write_packet_to_agent(fd, payload, payload_len) < 0)
+		return NULL;
+	return read_packet_from_agent(fd, reply_len);
+}
+
+int ssh_agent_sock = -1;
+
+int init_ssh_agent()
+{
+	const char *agentpath;
+	struct sockaddr_un addr;
+
+	if (ssh_agent_sock >= 0)
+		return 0;
+	if (ssh_agent_sock < -1)
+		return -1;
+
+	agentpath = getenv("SSH_AUTH_SOCK");
+	if (!agentpath) {
+		ssh_agent_sock = -2;
+		return -1;
+	}
+
+	addr.sun_family = AF_UNIX;
+	strcpy(addr.sun_path, agentpath);
+
+	ssh_agent_sock = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (ssh_agent_sock < 0) {
+		error("Can't create socket: %s",
+			strerror(errno));
+		ssh_agent_sock = -2;
+		return -1;
+	}
+
+	if (connect(ssh_agent_sock, (struct sockaddr*)&addr, sizeof(addr)) < 0) {
+		error("Can't connect to ssh-agent(%s): %s", agentpath,
+		strerror(errno));
+		close(ssh_agent_sock);
+		ssh_agent_sock = -2;
+		return -1;
+	}
+	return 0;
+}
+
+unsigned char *sign_using_ssh_agent(const char *keyname,
+	const unsigned char *kblob, size_t kblob_size,
+	const unsigned char *challenge, size_t challenge_size,
+	size_t *signature_length, const char *type)
+{
+	unsigned char *request;
+	unsigned char *reply;
+	size_t reply_length;
+	size_t request_length;
+	unsigned char *signblocks = NULL;
+
+	/* 43 = 1 (type) + 8 (2 lengths) + 4 (flags) */
+	request = xmalloc(13 + kblob_size + challenge_size);
+	request_length = 13 + kblob_size + challenge_size;
+
+	request[0] = SSH2_AGENTC_SIGN_REQUEST;
+	encode_uint32(request + 1, kblob_size);
+	memcpy(request + 5, kblob, kblob_size);
+	encode_uint32(request + 5 + kblob_size, challenge_size);
+	memcpy(request + 9 + kblob_size, challenge, challenge_size);
+	encode_uint32(request + 9 + kblob_size + challenge_size, 0);
+
+	if (init_ssh_agent() < 0)
+		goto out_request;
+
+	reply = agent_do_io_cycle(ssh_agent_sock, request, request_length,
+		&reply_length);
+	if (!reply)
+		goto out_request;
+
+	signblocks = extract_actual_key(reply, reply_length, type,
+		signature_length);
+	/* extract_actual_key can fail, but we don't print any error for that. */
+
+	free(reply);
+out_request:
+	free(request);
+	return signblocks;
+}
+
+static const char *check_blob(const unsigned char* blob, size_t blob_size)
+{
+	size_t offset = 0;
+	unsigned round = 0;
+	unsigned rounds = 1;
+	const char *type = NULL;
+
+	for (round = 0; round < rounds; round++) {
+		unsigned long len;
+		if (offset + 4 < offset || blob_size < offset + 4) {
+			error("Component length header incomplete (component=%u/%u, blob_size=%zu, offset=%zu",
+				round + 1, rounds, blob_size, offset);
+			return NULL;
+		}
+		len = decode_uint32(blob + offset);
+		if (offset + len + 4 < offset + 4 || blob_size < offset + len + 4) {
+			error("Component incomplete (component=%u/%u, blob_size=%zu, offset=%zu, len=%lu)",
+				round + 1, rounds, blob_size, offset, len);
+			return NULL;
+		}
+		if (round == 0 && len == 7 && !memcmp(blob + offset + 4,
+			"ssh-rsa", 7)) {
+			rounds = 3;
+			type = "ssh-rsa";
+		} else if (round == 0 && len == 7 && !memcmp(blob + offset + 4,
+			"ssh-dss", 7)) {
+			rounds = 5;
+			type = "ssh-dss";
+		} else if (round == 0) {
+			error("Read key has unknown key type (neither ssh-rsa nor ssh-dss)");
+			return NULL;
+		}
+		offset += len + 4;
+	}
+	if (offset != blob_size) {
+		error("Garbage after end of key");
+		return NULL;
+	}
+	return type;
+}
+
+#define MAXPATH 4096
+#define MAXKEY 65536
+#define DATABLOCK 32
+#define HASHALGO GCRY_MD_SHA256
+#define HASHLEN 32
+
+void do_ssh_preauth(const char *ssh_user)
+{
+	send_ssh_authentication(NULL, ssh_user);
+}
+
+void send_ssh_authentication(struct user *dispatcher, const char *ssh_user)
+{
+	unsigned char *x = NULL;
+	size_t i;
+	FILE* filp;
+	char *path;
+	char pathtemplate[MAXPATH];
+	unsigned char key[MAXKEY];
+	size_t keysize;
+	unsigned char block[DATABLOCK] = {0};
+
+	unsigned char *signature = NULL;
+	size_t signature_length;
+	const char *type;
+
+	if (strlen(ssh_user) > MAXPATH - 32)
+		die("Key name too long");
+	sprintf(pathtemplate, "~/.ssh/%s.pub", ssh_user);
+	path = expand_path(pathtemplate);
+
+	if (!x) {
+		/* Read the pubkey file. */
+		filp = fopen(path, "r");
+		if (!filp) {
+			error("Can't open '%s'", path);
+			goto out_readfile;
+		}
+		keysize = fread(key, 1, MAXKEY, filp);
+		if (ferror(filp)) {
+			error("Can't read '%s'", path);
+			goto out_readfile;
+		}
+		if (!feof(filp)) {
+			error("Keyfile '%s' too large", path);
+			goto out_readfile;
+		}
+		fclose(filp);
+
+		x = extract_key_from_file(key, keysize, &i);
+	}
+out_readfile:
+	if (!x)
+		die("Can't read any public key named '%s'",
+			ssh_user);
+
+	type = check_blob(x, i);
+	if (!type)
+		die("Malformed public key for '%s'", ssh_user);
+
+	if (dispatcher) {
+		int s;
+		gnutls_session_t session;
+		unsigned char hash[HASHLEN];
+		const gnutls_datum_t *cert;
+		unsigned int lsize;
+		session = user_get_tls(dispatcher);
+		if (!session)
+			die("SSH auth requires TLS");
+		cert = gnutls_certificate_get_peers(session, &lsize);
+		if (!cert)
+			die("Unable to get server certificate (server didn't send one?)");
+
+		gcry_md_hash_buffer(HASHALGO, hash, cert->data, cert->size);
+		s = gnutls_prf(session, 14, "ssh-key-verify", 0, HASHLEN,
+			(const char*)hash, DATABLOCK, (char*)block);
+		if (s < 0)
+			die("Can't compute challenge: %s",
+				gnutls_strerror(s));
+	}
+	if (!signature)
+		signature = sign_using_ssh_agent(ssh_user,
+			x, i, block, DATABLOCK, &signature_length,
+			type);
+	if (!signature)
+		signature = sign_using_local_key(ssh_user,
+			x, i, block, DATABLOCK, &signature_length,
+			type);
+	if (!signature)
+		die("Can't sign using key '%s'", ssh_user);
+
+	if (dispatcher) {
+		struct cbuffer* in;
+		char tmp[5];
+		in = user_get_red_in(dispatcher);
+		sprintf(tmp, "%04x", (unsigned)(8 + i + signature_length));
+		cbuffer_write(in, (const unsigned char*)tmp, 4);
+		cbuffer_write(in, (const unsigned char*)"ssh ", 4);
+		cbuffer_write(in, x, i);
+		cbuffer_write(in, signature, signature_length);
+	}
+
+	free(signature);
+	free(x);
+}
diff --git a/git-over-tls/ssh.h b/git-over-tls/ssh.h
new file mode 100644
index 0000000..3ee5daf
--- /dev/null
+++ b/git-over-tls/ssh.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2010
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _ssh__h__included__
+#define _ssh__h__included__
+
+#include "user.h"
+
+void do_ssh_preauth(const char *ssh_user);
+void send_ssh_authentication(struct user *dispatcher, const char *ssh_user);
+unsigned char *extract_key_from_file(const unsigned char *file,
+	size_t file_len, size_t *key_len);
+
+#endif
diff --git a/git-over-tls/ssh_localkey.c b/git-over-tls/ssh_localkey.c
new file mode 100644
index 0000000..f27ee9b
--- /dev/null
+++ b/git-over-tls/ssh_localkey.c
@@ -0,0 +1,435 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2010
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include "pem.h"
+#include "base64.h"
+#include "home.h"
+#include <gcrypt.h>
+#ifdef USE_COMPAT_H
+#include "compat.h"
+#else
+#include "git-compat-util.h"
+#endif
+
+static int validate_key(const unsigned char *key, size_t keysize,
+	size_t *offsets, size_t *lengths, int components)
+{
+	size_t offset = 0;
+	int c;
+
+	for(c = 0; c < components; c++) {
+		size_t len = 0;
+		if (offset + 4 < offset || offset + 4 > keysize)
+			return -1;
+		offsets[c] = offset + 4;
+		len |= ((size_t)key[offset] << 24);
+		len |= ((size_t)key[offset + 1] << 16);
+		len |= ((size_t)key[offset + 2] << 8);
+		len |= ((size_t)key[offset + 3]);
+		lengths[c] = len;
+		if (offset + 4 + len < offset + 4 ||
+			offset + 4 + len > keysize)
+			return -1;
+		offset += (4 + len);
+	}
+	if (offset != keysize)
+		return -1;
+	return 0;
+}
+
+typedef void* voidptr;
+
+static unsigned char *sign_rsa(const unsigned char *key, size_t keysize,
+	const unsigned char *challenge, size_t challenge_size,
+	size_t *signature_size)
+{
+	unsigned char *ret = NULL;
+	size_t offsets[4];
+	size_t lengths[4];
+	gcry_mpi_t rsa_e;
+	gcry_mpi_t rsa_n;
+	gcry_mpi_t rsa_d;
+	gcry_error_t err;
+	gcry_sexp_t _key;
+	gcry_sexp_t tosign;
+	gcry_sexp_t signature;
+	gcry_sexp_t sval;
+	gcry_sexp_t rsas_s;
+	const unsigned char *rsa_s;
+	size_t rsa_s_len;
+	int hashalgo = GCRY_MD_SHA256;
+	const char *algo = "sha256";
+	int hashlen = 32;
+	unsigned char hashbuffer[128];
+	voidptr params[3];
+	if (validate_key(key, keysize, offsets, lengths, 4) < 0) {
+		error("Bad RSA private key");
+		return NULL;
+	}
+	err = gcry_mpi_scan(&rsa_e, GCRYMPI_FMT_STD, key + offsets[1],
+		lengths[1], NULL);
+	if (err) {
+		error("Can't read RSA e: %s/%s", gcry_strsource(err),
+			gcry_strerror(err));
+		goto out;
+	}
+	err = gcry_mpi_scan(&rsa_n, GCRYMPI_FMT_STD, key + offsets[2],
+		lengths[2], NULL);
+	if (err) {
+		error("Can't read RSA n: %s/%s", gcry_strsource(err),
+			gcry_strerror(err));
+		goto out_e;
+	}
+	err = gcry_mpi_scan(&rsa_d, GCRYMPI_FMT_STD, key + offsets[3],
+		lengths[3], NULL);
+	if (err) {
+		error("Can't read RSA d: %s/%s", gcry_strsource(err),
+			gcry_strerror(err));
+		goto out_n;
+	}
+	params[0] = &rsa_n;
+	params[1] = &rsa_e;
+	params[2] = &rsa_d;
+	err = gcry_sexp_build_array(&_key, NULL, "(private-key (rsa (n %m) (e %m) (d %m)))",
+		params);
+	if (err) {
+		error("Can't build key: %s/%s", gcry_strsource(err),
+			gcry_strerror(err));
+		goto out_d;
+	}
+
+	gcry_md_hash_buffer(hashalgo, hashbuffer, challenge,
+		challenge_size);
+
+	err = gcry_sexp_build(&tosign, NULL, "(data (flags pkcs1) (hash %s %b))",
+		algo, hashlen, hashbuffer);
+	if (err) {
+		error("Can't build data to sign: %s/%s", gcry_strsource(err),
+			gcry_strerror(err));
+		goto out_key;
+	}
+
+	err = gcry_pk_sign(&signature, tosign, _key);
+	if (err) {
+		error("Can't sign data: %s/%s", gcry_strsource(err),
+			gcry_strerror(err));
+		goto out_tosign;
+	}
+
+	sval = gcry_sexp_nth(signature, 1);
+	if(!sval) {
+		error("DSA signature output faulty");
+		goto out_signature;
+	}
+	rsas_s = gcry_sexp_nth(sval, 1);
+	if(!rsas_s) {
+		error("RSA signature output faulty (no s)");
+		goto out_sval;
+	}
+	rsa_s = (const unsigned char*)gcry_sexp_nth_data(rsas_s, 1, &rsa_s_len);
+	if(!rsa_s) {
+		error("RSA signature output faulty (no real s)");
+		goto out_s;
+	}
+
+	*signature_size = 4 + rsa_s_len;
+	ret = xmalloc(*signature_size);
+	encode_uint32(ret, rsa_s_len);
+	memcpy(ret + 4, rsa_s, rsa_s_len);
+
+out_s:
+	gcry_sexp_release(rsas_s);
+out_sval:
+	gcry_sexp_release(sval);
+out_signature:
+	gcry_sexp_release(signature);
+out_tosign:
+	gcry_sexp_release(tosign);
+out_key:
+	gcry_sexp_release(_key);
+out_d:
+	gcry_mpi_release(rsa_d);
+out_n:
+	gcry_mpi_release(rsa_n);
+out_e:
+	gcry_mpi_release(rsa_e);
+out:
+	return ret;
+}
+
+static unsigned char *sign_dsa(const unsigned char *key, size_t keysize,
+	const unsigned char *challenge, size_t challenge_size,
+	size_t *signature_size)
+{
+	unsigned char *ret = NULL;
+	size_t offsets[6];
+	size_t lengths[6];
+	gcry_mpi_t dsa_p;
+	gcry_mpi_t dsa_q;
+	gcry_mpi_t dsa_g;
+	gcry_mpi_t dsa_y;
+	gcry_mpi_t dsa_x;
+	gcry_mpi_t dsa_e;
+	int hashalgo;
+	const char *algo;
+	int hashlen;
+	unsigned char hashbuffer[128];
+	voidptr params[5];
+	gcry_sexp_t _key;
+	gcry_sexp_t tosign;
+	gcry_sexp_t signature;
+	gcry_sexp_t sval;
+	gcry_sexp_t dsas_r;
+	gcry_sexp_t dsas_s;
+	const unsigned char *dsa_r;
+	size_t dsa_r_len;
+	const unsigned char *dsa_s;
+	size_t dsa_s_len;
+	gcry_error_t err;
+	int sbits;
+
+	if (validate_key(key, keysize, offsets, lengths, 6) < 0) {
+		error("Bad DSA private key");
+		return NULL;
+	}
+
+	err = gcry_mpi_scan(&dsa_p, GCRYMPI_FMT_STD, key + offsets[1],
+		lengths[1], NULL);
+	if (err) {
+		error("Can't read DSA p: %s/%s", gcry_strsource(err),
+			gcry_strerror(err));
+		goto out;
+	}
+	err = gcry_mpi_scan(&dsa_q, GCRYMPI_FMT_STD, key + offsets[2],
+		lengths[2], NULL);
+	if (err) {
+		error("Can't read DSA q: %s/%s", gcry_strsource(err),
+			gcry_strerror(err));
+		goto out_p;
+	}
+	err = gcry_mpi_scan(&dsa_g, GCRYMPI_FMT_STD, key + offsets[3],
+		lengths[3], NULL);
+	if (err) {
+		error("Can't read DSA g: %s/%s", gcry_strsource(err),
+			gcry_strerror(err));
+		goto out_q;
+	}
+	err = gcry_mpi_scan(&dsa_y, GCRYMPI_FMT_STD, key + offsets[4],
+		lengths[4], NULL);
+	if (err) {
+		error("Can't read DSA y: %s/%s", gcry_strsource(err),
+			gcry_strerror(err));
+		goto out_g;
+	}
+	err = gcry_mpi_scan(&dsa_x, GCRYMPI_FMT_STD, key + offsets[5],
+		lengths[5], NULL);
+	if (err) {
+		error("Can't read DSA x: %s/%s", gcry_strsource(err),
+			gcry_strerror(err));
+		goto out_y;
+	}
+
+	params[0] = &dsa_p;
+	params[1] = &dsa_q;
+	params[2] = &dsa_g;
+	params[3] = &dsa_y;
+	params[4] = &dsa_x;
+	err = gcry_sexp_build_array(&_key, NULL, "(private-key (dsa (p %m) (q %m) (g %m) (y %m) (x %m)))",
+		params);
+	if (err) {
+		error("Can't build key: %s/%s", gcry_strsource(err),
+			gcry_strerror(err));
+		goto out_x;
+	}
+
+	sbits = gcry_mpi_get_nbits(dsa_q);
+	if(sbits <= 160) {
+		algo = "sha1";
+		hashalgo = GCRY_MD_SHA1;
+		hashlen = 20;
+	} else if(sbits <= 224) {
+		algo = "sha224";
+		hashalgo = GCRY_MD_SHA224;
+		hashlen = 28;
+	} else if(sbits <= 256) {
+		algo = "sha256";
+		hashalgo = GCRY_MD_SHA256;
+		hashlen = 32;
+	} else if(sbits <= 384) {
+		algo = "sha384";
+		hashalgo = GCRY_MD_SHA384;
+		hashlen = 48;
+	} else if(sbits <= 512) {
+		algo = "sha512";
+		hashalgo = GCRY_MD_SHA512;
+		hashlen = 64;
+	} else {
+		error("DSA parameter q out of range (2^512 or larger)");
+		goto out_key;
+	}
+
+	gcry_md_hash_buffer(hashalgo, hashbuffer, challenge,
+		challenge_size);
+	err = gcry_mpi_scan(&dsa_e, GCRYMPI_FMT_USG, hashbuffer,
+		hashlen, NULL);
+	if (err) {
+		error("Can't read DSA e: %s/%s", gcry_strsource(err),
+			gcry_strerror(err));
+		goto out_key;
+	}
+
+	err = gcry_sexp_build(&tosign, NULL, "(%m)",
+		dsa_e);
+	if (err) {
+		error("Can't build data to sign: %s/%s", gcry_strsource(err),
+			gcry_strerror(err));
+		goto out_e;
+	}
+
+	err = gcry_pk_sign(&signature, tosign, _key);
+	if (err) {
+		error("Can't sign data: %s/%s", gcry_strsource(err),
+			gcry_strerror(err));
+		goto out_tosign;
+	}
+
+	sval = gcry_sexp_nth(signature, 1);
+	if(!sval) {
+		error("DSA signature output faulty (no sval)");
+		goto out_signature;
+	}
+	dsas_r = gcry_sexp_nth(sval, 1);
+	if(!dsas_r) {
+		error("DSA signature output faulty (no r)");
+		goto out_sval;
+	}
+	dsa_r = (const unsigned char*)gcry_sexp_nth_data(dsas_r, 1, &dsa_r_len);
+	if(!dsa_r) {
+		error("DSA signature output faulty (no real r)");
+		goto out_r;
+	}
+	dsas_s = gcry_sexp_nth(sval, 2);
+	if(!dsas_s) {
+		error("DSA signature output faulty (no s)");
+		goto out_r;
+	}
+	dsa_s = (const unsigned char*)gcry_sexp_nth_data(dsas_s, 1, &dsa_s_len);
+	if(!dsa_s) {
+		error("DSA signature output faulty (no real s)");
+		goto out_s;
+	}
+
+	*signature_size = 8 + dsa_r_len + dsa_s_len;
+	ret = xmalloc(*signature_size);
+	encode_uint32(ret, dsa_r_len);
+	memcpy(ret + 4, dsa_r, dsa_r_len);
+	encode_uint32(ret + 4 + dsa_r_len, dsa_s_len);
+	memcpy(ret + 8 + dsa_r_len, dsa_s, dsa_s_len);
+
+out_s:
+	gcry_sexp_release(dsas_s);
+out_r:
+	gcry_sexp_release(dsas_r);
+out_sval:
+	gcry_sexp_release(sval);
+out_signature:
+	gcry_sexp_release(signature);
+out_tosign:
+	gcry_sexp_release(tosign);
+out_e:
+	gcry_mpi_release(dsa_e);
+out_key:
+	gcry_sexp_release(_key);
+out_x:
+	gcry_mpi_release(dsa_x);
+out_y:
+	gcry_mpi_release(dsa_y);
+out_g:
+	gcry_mpi_release(dsa_g);
+out_q:
+	gcry_mpi_release(dsa_q);
+out_p:
+	gcry_mpi_release(dsa_p);
+out:
+	return ret;
+}
+
+#define MAXPATH 4096
+#define MAXKEY 65536
+
+unsigned char *sign_using_local_key(const char *keyname,
+	const unsigned char *kblob, size_t kblob_size,
+	const unsigned char *challenge, size_t challenge_size,
+	size_t *signature_length, const char *type)
+{
+	FILE* filp;
+	unsigned char *ret = NULL;
+
+	char *path;
+	char pathtemplate[MAXPATH];
+	unsigned char key[MAXKEY];
+	size_t keysize;
+	int readkey_flag = 0;
+
+	unsigned char *x;
+	size_t i;
+
+	if (strlen(keyname) > MAXPATH - 32)
+		die("Key name too long");
+	sprintf(pathtemplate, "~/.ssh/%s", keyname);
+	path = expand_path(pathtemplate);
+
+	/* Read the privkey file. */
+	filp = fopen(path, "r");
+	if (!filp) {
+		error("Can't open '%s'", path);
+		goto out_readfile;
+	}
+	keysize = fread(key, 1, MAXKEY, filp);
+	if (ferror(filp)) {
+		error("Can't read '%s'", path);
+		goto out_readfile_handle;
+	}
+	if (!feof(filp)) {
+		error("Keyfile '%s' too large", path);
+		goto out_readfile_handle;
+	}
+	readkey_flag = 1;
+out_readfile_handle:
+	fclose(filp);
+out_readfile:
+	free(path);
+	if (!readkey_flag) {
+		error("Can't read any private key named '%s'", keyname);
+		return NULL;
+	}
+
+	x = pem_decode(key, keysize, keyname, &i);
+	if (!x) {
+		error("Can't decode key '%s'", keyname);
+		return NULL;
+	}
+	if (kblob_size > i || memcmp(kblob, x, kblob_size)) {
+		free(x);
+		error("Pubic and private keys for '%s' are inconsistent",
+			keyname);
+		return NULL;
+	}
+	if (!strcmp(type, "ssh-rsa"))
+		ret = sign_rsa(x, i, challenge, challenge_size,
+			signature_length);
+	else if (!strcmp(type, "ssh-dss"))
+		ret = sign_dsa(x, i, challenge, challenge_size,
+			signature_length);
+	else
+		error("Key '%s' is of unknown type", keyname);
+	free(x);
+	return ret;
+}
diff --git a/git-over-tls/ssh_localkey.h b/git-over-tls/ssh_localkey.h
new file mode 100644
index 0000000..223b97f
--- /dev/null
+++ b/git-over-tls/ssh_localkey.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2010
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _ssh_localkey__h__include__
+#define _ssh_localkey__h__include__
+
+#include <stdlib.h>
+
+unsigned char *sign_using_local_key(const char *keyname,
+	const unsigned char *kblob, size_t kblob_size,
+	const unsigned char *challenge, size_t challenge_size,
+	size_t *signature_length, const char *type);
+
+#endif
-- 
1.7.1.rc2.10.g714149
