From: Bill Zaumen <bill.zaumen+git@gmail.com>
Subject: [PATCH 1/6] Add the mdigest, mdsdb, and packdb modules.
Date: Tue, 20 Dec 2011 23:08:10 -0800
Message-ID: <1324451290.1684.17.camel@yos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 21 08:08:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdGHe-0007od-QL
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 08:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747Ab1LUHIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 02:08:09 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47230 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab1LUHIH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 02:08:07 -0500
Received: by iaeh11 with SMTP id h11so11457654iae.19
        for <git@vger.kernel.org>; Tue, 20 Dec 2011 23:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:subject:from:to:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=jTYUm5/ATw6oWDhymMw0nfsDp2FWKijEkSvORAXDVnc=;
        b=MIgW2CO56hW3Cy1UzzIx1/jZHDg4U+s7kK8EnYAA0ro0n5KyA0+GkajJx1GN+0SkzD
         0P6K7iEELK9nEMXNYl2L+5Llu4I+IKKoEy1Wpo5U6LtNnVzAKBXxWFZsCgA3YXS+QD6A
         hq5Pwkb7OEfkfeK8/KCZciHblPRaJiOw5XbdM=
Received: by 10.50.190.201 with SMTP id gs9mr1622109igc.1.1324451286738;
        Tue, 20 Dec 2011 23:08:06 -0800 (PST)
Received: from [192.168.1.20] (adsl-209-233-20-69.dsl.snfc21.pacbell.net. [209.233.20.69])
        by mx.google.com with ESMTPS id g34sm13684627ibk.10.2011.12.20.23.08.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Dec 2011 23:08:04 -0800 (PST)
X-Mailer: Evolution 2.30.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187551>

* The mdigest module manipulates and creates message digests. The
files are mdigest.h and mdigest.c. These can be modified to
include additional digests.

* The mdsdb module stores message digests for loose objects. The
files are mdsdb.h and objd-mdsdb.c. The variable MDSDB in the
Makefile selects the implementation (currently only objd-mdsdb.c, which
keeps each digest in its own file).

* The packdb module stores digests in a space-efficient form. It is
intended for unusual conditions (e.g., caching a digest for an object
in an alternative object database that does not support digests). The
implementation provided uses GDBM, however it is easy to add alternative
implementation.  The choice of implementations is determined by the
value of the PACKDB variable in the Makefile (if undefined, packdb is
not used).

These modules are mostly self-contained - there is little interaction
with the rest of git beyond calling functions such as "die" for a few
error conditions.  Documentation for the functions in these modules
is in the header files.

The Makefile changes will be in a subsequent commit.

Signed-off-by: Bill Zaumen <bill.zaumen+git@gmail.com>
---
 gdbm-packdb.c |  249 +++++++++++++++++++++++++++++++++++++++++
 mdigest.c     |  221 +++++++++++++++++++++++++++++++++++++
 mdigest.h     |  334 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mdsdb.h       |  192 ++++++++++++++++++++++++++++++++
 objd-mdsdb.c  |  340 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 packdb.h      |   93 ++++++++++++++++
 6 files changed, 1429 insertions(+), 0 deletions(-)
 create mode 100644 gdbm-packdb.c
 create mode 100644 mdigest.c
 create mode 100644 mdigest.h
 create mode 100644 mdsdb.h
 create mode 100644 objd-mdsdb.c
 create mode 100644 packdb.h

diff --git a/gdbm-packdb.c b/gdbm-packdb.c
new file mode 100644
index 0000000..6443ec5
--- /dev/null
+++ b/gdbm-packdb.c
@@ -0,0 +1,249 @@
+#include<sys/types.h>
+#include<sys/stat.h>
+#include <sys/param.h>
+#include<stdio.h>
+#include<string.h>
+#include<malloc.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <time.h>
+#include <pthread.h>
+#include <errno.h>
+#include <gdbm.h>
+
+#include "cache.h"
+#include "packdb.h"
+
+static void nsleep() {
+#if _POSIX_C_SOURCE >= 199309L
+	struct timespec ts;
+	ts.tv_sec = 0;
+	ts.tv_nsec = 100000;
+	nanosleep(&ts, NULL);
+#else
+	sleep(1);
+#endif
+}
+
+static int initialized = 0;
+
+static GDBM_FILE dbf = NULL;
+char *dbf_name;
+static int dbf_depth = 0;
+
+pthread_mutex_t gdbm_mutex = PTHREAD_MUTEX_INITIALIZER;
+
+static void packdb_close_nolock(void);
+
+void packdb_init(void) {
+	char *last;
+	pthread_mutex_lock(&gdbm_mutex);
+	if (initialized) {
+		pthread_mutex_unlock(&gdbm_mutex);
+		return;
+	}
+	dbf_name = get_object_packdb_node();
+	last = rindex(dbf_name, '/');
+	*last = 0;
+	if (!access(dbf_name, R_OK|W_OK|X_OK)) {
+		initialized = 1;
+	}
+	*last = '/';
+	pthread_mutex_unlock(&gdbm_mutex);
+}
+
+int packdb_initialized(void) {
+  return initialized;
+}
+
+static void packdb_open_nolock(void) {
+	if (dbf_depth == 0) {
+	AGAIN_W:
+		dbf = gdbm_open(dbf_name, 0, GDBM_WRCREAT, PERM_GROUP, NULL);
+		if (dbf == NULL && gdbm_errno == GDBM_CANT_BE_WRITER) {
+			nsleep();
+			goto AGAIN_W;
+		}
+	}
+	dbf_depth++;
+}
+
+void packdb_open(void) {
+	pthread_mutex_lock(&gdbm_mutex);
+	packdb_open_nolock();
+	pthread_mutex_unlock(&gdbm_mutex);
+}
+
+
+int packdb_lookup(const unsigned char *sha1, mdigest_t *digestp) {
+	datum key;
+	datum ovalue;
+	pthread_mutex_lock(&gdbm_mutex);
+
+	if (!initialized) {
+		pthread_mutex_unlock(&gdbm_mutex);
+		return -1;
+	}
+
+	key.dptr = (char *)sha1;
+	key.dsize = 20;
+
+	packdb_open_nolock();
+	if (dbf == NULL) {
+		packdb_close_nolock();
+		pthread_mutex_unlock(&gdbm_mutex);
+		return -1;
+	}
+	ovalue = gdbm_fetch(dbf, key);
+	packdb_close_nolock();
+	pthread_mutex_unlock(&gdbm_mutex);
+
+	if (ovalue.dptr == NULL) return 0;
+	if (digestp) {
+		int len;
+		int wsize = (int) *(unsigned char *)(ovalue.dptr);
+		unsigned char *buffer = (unsigned char *)(ovalue.dptr + 1);
+		len = get_mdigest_required_len(wsize);
+		if (len + 1 > ovalue.dsize)
+			die("existing db entry for %s corrupted [1], len = %d,"
+			    " ovalue.dsize = %d",
+			    sha1_to_hex(sha1), len, ovalue.dsize);
+		mdigest_load(digestp, wsize, buffer);
+	}
+	free(ovalue.dptr);
+	/* if (digestp) *digestp = (old_digest); */
+	return 1;
+}
+
+int packdb_remove(const unsigned char *sha1) {
+	datum key;
+	int result;
+	pthread_mutex_lock(&gdbm_mutex);
+	if ((!initialized)  || dbf == NULL) {
+		pthread_mutex_unlock(&gdbm_mutex);
+		return -1;
+	}
+	key.dptr = (char *)sha1;
+	key.dsize = 20;
+	packdb_open_nolock();
+	result = gdbm_delete(dbf, key);
+	packdb_close_nolock();
+	pthread_mutex_unlock(&gdbm_mutex);
+	return result;
+}
+
+
+int packdb_process(const unsigned char *sha1, mdigest_t *digestp) {
+	datum key;
+	datum nvalue;
+	datum ovalue;
+	mdigest_t newdigest = (*digestp);
+	mdigest_t old_digest;
+	newdigest.hdr.lhdr.wcode = get_mdigest_wcode(digestp);
+	pthread_mutex_lock(&gdbm_mutex);
+	if ((!initialized) || dbf == NULL) {
+		pthread_mutex_unlock(&gdbm_mutex);
+		return -1;
+	}
+	key.dptr = (char *)sha1;
+	key.dsize = 20;
+
+	nvalue.dptr = (char *)&(newdigest.hdr.lhdr.wcode);
+	nvalue.dsize = 1 + get_mdigest_len(digestp);
+
+	packdb_open_nolock();
+	ovalue = gdbm_fetch(dbf, key);
+	if (dbf == dbf && ovalue.dptr == NULL) {
+		int status;
+		status = gdbm_store(dbf, key, nvalue, GDBM_INSERT);
+		packdb_close_nolock();
+		pthread_mutex_unlock(&gdbm_mutex);
+		switch (status) {
+		case 0:
+			return 0;
+		case -1:
+		  error("could not enter crc into database - key = %s",
+		      sha1_to_hex(sha1));
+		      return -1;
+		case 1:
+			return 1;
+		}
+		return -1;	/* should not occur */
+	} else if (ovalue.dptr == NULL) {
+		packdb_close_nolock();
+		pthread_mutex_unlock(&gdbm_mutex);
+		return 0;
+	} else {
+		int wcode, len;
+		unsigned char *buffer;
+		packdb_close_nolock();
+		pthread_mutex_unlock(&gdbm_mutex);
+		wcode = (int) *(unsigned char *)ovalue.dptr;
+		len = get_mdigest_required_len(wcode);
+		if (len + 1 > ovalue.dsize)
+			die("existing db entry for %s corrupted [2]",
+			    sha1_to_hex(sha1));
+		buffer = (unsigned char *) ovalue.dptr + 1;
+		mdigest_load(&old_digest, wcode, buffer);
+		free(ovalue.dptr);
+		/*
+		 * Both old_digest and newdigest are in network byte order.
+		 */
+		if (mdigest_tst(&old_digest, digestp)) {
+			die("SHA1  COLLISION WHEN INSERTING OBJECT %s",
+			    sha1_to_hex(sha1));
+			return -1;
+		}
+		return 1;
+	}
+}
+
+int packdb_reorganize() {
+	int status;
+	pthread_mutex_lock(&gdbm_mutex);
+	if ((!initialized)  || dbf == NULL) {
+		pthread_mutex_unlock(&gdbm_mutex);
+		return -1;
+	}
+	packdb_open_nolock();
+	status = gdbm_reorganize(dbf);
+	packdb_close_nolock();
+	pthread_mutex_unlock(&gdbm_mutex);
+	return status;
+}
+
+
+static void packdb_close_nolock(void) {
+	  if (!initialized) {
+		return;
+	  }
+	  dbf_depth--;
+	  if (dbf_depth == 0 && dbf != NULL) {
+		gdbm_close(dbf);
+		dbf = NULL;
+	  }
+	  if (dbf_depth < 0) {
+		die("packdb dbf_depth %d < 0", dbf_depth);
+	  }
+	  return;
+}
+
+void packdb_close(void) {
+	  pthread_mutex_lock(&gdbm_mutex);
+	  packdb_close_nolock();
+	  pthread_mutex_unlock(&gdbm_mutex);
+}
+
+void packdb_finish(void) {
+	pthread_mutex_lock(&gdbm_mutex);
+	if (!initialized) {
+		pthread_mutex_unlock(&gdbm_mutex);
+		return;
+	}
+	if (dbf != NULL) gdbm_close(dbf);
+	dbf = NULL;
+	dbf_depth = 0;
+	initialized = 0;
+	pthread_mutex_unlock(&gdbm_mutex);
+}
diff --git a/mdigest.c b/mdigest.c
new file mode 100644
index 0000000..94c72a2
--- /dev/null
+++ b/mdigest.c
@@ -0,0 +1,221 @@
+#include "mdigest.h"
+
+struct mdigest_config {
+	const enum mdigest_type mdt; /* table key - must match index */
+	const char *name;		    /* print name */
+	const int wcode;		    /* wsize code for MDS files*/
+	const int wsize;			    /* word size for MDS file entry */
+	const int blen;			    /* byte length of digest (used) */
+};
+
+static const struct mdigest_config mdigest_table[] = {
+	{MDIGEST_CRC, "CRC-32", MDIGEST_CRC_WCODE, 1, 4},
+	{MDIGEST_SHA1, "SHA-1", MDIGEST_SHA1_WCODE, 5, 20},
+	{MDIGEST_SHA256, "SHA-256", MDIGEST_SHA256_WCODE, 8, 32},
+	{MDIGEST_SHA512, "SHA-512", MDIGEST_SHA512_WCODE, 16, 64},
+};
+
+/*
+ * Table indexed by wcode;
+ */
+struct mdigest_config_aux {
+	int wcode;		    /* wcode code for MDS files*/
+	int wsize;		    /* word size for MDS file entry */
+	int blen;		    /* byte length of digest (used) */
+	enum mdigest_type mdt;	    /* message digest type */
+};
+
+static struct mdigest_config_aux *mdigest_aux_table;
+
+void mdigest_init(void) {
+	int i;
+	int n = sizeof(mdigest_table)
+	  / sizeof(struct mdigest_config);
+	int m = 0;
+
+	for (i = 0; i < n; i++) {
+		if (m < mdigest_table[i].wcode)
+			m = mdigest_table[i].wcode;
+	}
+	m += 1;			/* table size is one more than the max index */
+	mdigest_aux_table = (struct mdigest_config_aux *)
+	  xcalloc(m, sizeof (struct mdigest_config_aux));
+
+	for (i = 0; i < n; i++) {
+		int wc, ws, bl;
+		enum mdigest_type mdt;
+		wc = mdigest_table[i].wcode;
+		ws = mdigest_table[i].wsize;
+		bl = mdigest_table[i].blen;
+		mdt = mdigest_table[i].mdt;
+		
+		mdigest_aux_table[wc].wcode = wc;
+		mdigest_aux_table[wc].wsize = ws;
+		mdigest_aux_table[wc].blen = bl;
+		mdigest_aux_table[wc].mdt = mdt;
+	}
+}
+
+int get_mdigest_wsize(mdigest_t *mdigestp) {
+	return mdigest_table[mdigestp->hdr.info.mdt].wsize;
+}
+
+const char *get_mdigest_name(enum mdigest_type mdt)
+{
+	return mdigest_table[mdt].name;
+}
+
+int get_mdigest_wcode(const mdigest_t *digestp) {
+	return mdigest_table[digestp->hdr.info.mdt].wcode;
+}
+
+int get_mdigest_wcode_by_type(enum mdigest_type type) {
+	return mdigest_table[type].wcode;
+}
+
+int get_mdigest_wsize_by_type(enum mdigest_type type) {
+	return mdigest_table[type].wsize;
+}
+
+int get_mdigest_required_len_by_type(enum mdigest_type type) {
+	return mdigest_table[type].blen;
+}
+
+int mdigest_to_buffer(unsigned char *buffer, mdigest_t *digestp, int blen)
+{
+	int len = blen;
+	if (len > digestp->hdr.info.len) len = digestp->hdr.info.len;
+	memcpy(buffer, digestp->buffer.buffer, len);
+	memset(buffer + len, 0, blen - len);
+	return len;
+}
+
+
+int mdigest_tst(mdigest_t *md1p, mdigest_t *md2p)
+{
+	int i, n;
+	int n32;
+	unsigned char *x, *y;
+	uint32_t *x32, *y32;
+#if (_POSIX_V6_LP64_OFF64 || _POSIX_V6_LPBIG_OFFBIG)
+	int n64;
+	uint64_t *x64, *y64;
+#endif	
+	if (md1p->hdr.info.mdt - md2p->hdr.info.mdt) return -1;
+	n = md1p->hdr.info.len;
+#if (_POSIX_V6_LP64_OFF64 || _POSIX_V6_LPBIG_OFFBIG)
+	n64 = n/8;
+	x64 = (md1p->buffer.buffer64);
+	y64 = (md2p->buffer.buffer64);
+	for (i = 0; i < n64; i++) {
+		if (x64[i] != y64[i]) return -1;
+	}
+	i *= 2;
+#else
+	i = 0;
+#endif	
+	n32 = n/4;
+	if (i != n32) {
+		x32 = (md1p->buffer.buffer32);
+		y32 = (md2p->buffer.buffer32);
+		while (i < n32) {
+			if (x32[i] != y32[i]) return -1;
+			i++;
+		}
+		i *= 4;
+		if (i < n) {
+			x = (md1p->buffer.buffer);
+			y = (md2p->buffer.buffer);
+			while (i < n) {
+				if (x[i] != y[i]) return -1;
+				i++;
+			}
+		}
+	}
+	return 0;
+
+}
+
+void mdigest_Init(mdigest_context_t *ctx,
+			 enum mdigest_type mdt)
+{
+	ctx->mdt = mdt;
+	switch (mdt) {
+	case MDIGEST_CRC:
+		ctx->context.crc32 = crc32(0, NULL, 0);
+		break;
+	case MDIGEST_SHA1:
+		git_SHA1_Init(&ctx->context.sha1);
+		break;
+	case MDIGEST_SHA256:
+		EVP_MD_CTX_init(&ctx->context.evp);
+		EVP_DigestInit_ex(&ctx->context.evp, EVP_sha256(), NULL);
+		break;
+	case MDIGEST_SHA512:
+		EVP_MD_CTX_init(&ctx->context.evp);
+		EVP_DigestInit_ex(&ctx->context.evp, EVP_sha512(), NULL);
+		break;
+	}
+}
+
+void mdigest_Update(mdigest_context_t *ctx,
+			   const void *dataIn,
+			   unsigned long len)
+{
+	switch (ctx->mdt) {
+	case MDIGEST_CRC:
+		ctx->context.crc32 = crc32(ctx->context.crc32, dataIn, len);
+		break;
+	case MDIGEST_SHA1:
+		git_SHA1_Update(&(ctx->context.sha1), dataIn, len);
+		break;
+	case MDIGEST_SHA256:
+	case MDIGEST_SHA512:
+		EVP_DigestUpdate(&(ctx->context.evp), dataIn, len);
+		break;
+	}
+}
+
+void mdigest_Final(mdigest_t *digest,
+			  mdigest_context_t *ctx)
+{
+	enum mdigest_type mdt = ctx->mdt;
+	digest->hdr.info.mdt = mdt;
+	digest->hdr.info.len = mdigest_table[mdt].blen;
+	switch (mdt) {
+	case MDIGEST_CRC:
+		digest->buffer.crc32 = htonl(ctx->context.crc32);
+		break;
+	case MDIGEST_SHA1:
+		git_SHA1_Final(digest->buffer.buffer, &(ctx->context.sha1));
+		break;
+	case MDIGEST_SHA256:
+	case MDIGEST_SHA512:
+		EVP_DigestFinal_ex(&(ctx->context.evp),
+				  digest->buffer.buffer, NULL);
+		break;
+	}
+}
+
+int mdigest_load(mdigest_t *digestp, int wcode, unsigned char *buffer)
+{
+	int len;
+	if (mdigest_aux_table[wcode].wcode == 0) return -1;
+	digestp->hdr.info.mdt = mdigest_aux_table[wcode].mdt;
+	len = mdigest_aux_table[wcode].blen;
+	digestp->hdr.info.len = len;
+	/*
+	 * If buffer is NULL, we assume that one has already copied
+	 * the data into the buffer so we only had to set up the
+	 * other fields in the mdigest_t structure.
+	 */
+	if (buffer != NULL)
+		memcpy(digestp->buffer.buffer, buffer, len);
+	return 0;
+}
+
+int get_mdigest_required_len(int wcode) {
+	if (mdigest_aux_table[wcode].wcode == 0) return 0;
+	return mdigest_aux_table[wcode].blen;
+}
+
diff --git a/mdigest.h b/mdigest.h
new file mode 100644
index 0000000..8a1d713
--- /dev/null
+++ b/mdigest.h
@@ -0,0 +1,334 @@
+/*
+ * This file is included in cache.h, so the following is just in
+ * case cache.h is not included at all.
+ */
+#include "cache.h"
+/*
+ * Define here because cache.h needs some of the typedefs below.
+ */
+#ifndef MDIGEST_H
+#define MDIGEST_H
+#include <stdint.h>
+
+/**
+ * Enumeration to list supported message digests.
+ */
+enum mdigest_type {
+	MDIGEST_CRC,
+	MDIGEST_SHA1,
+	MDIGEST_SHA256,
+	MDIGEST_SHA512
+};
+
+/*
+ * Constants defining wcode values.  These are used in external
+ * representations of a digest to code the digest type.  The maximum
+ * number of digests supported is 255 (0 is reserved to indicate an
+ * unknown or uninitialized digest type).
+ */
+#define MDIGEST_CRC_WCODE	1
+#define	MDIGEST_SHA1_WCODE	5
+#define	MDIGEST_SHA256_WCODE	8
+#define	MDIGEST_SHA512_WCODE	16
+
+/*
+ * Standard digest.
+ */
+#ifndef MDIGEST_DEFAULT
+#define MDIGEST_DEFAULT MDIGEST_SHA256
+#endif
+
+#define MAX_DIGEST_LENGTH 64	/* set to maximum length we'll support */
+
+/**
+ * Message digest data structure.
+ * Holds a message digest along with some additional information.
+ * The hdr.info field specifies the digest type and the digest length in bytes.
+ * The hdr.lhdr.wcode field provides a code indicating the digest type
+ * as stored externally (this is set temporarily for a couple of
+ * operations and in general should not be used.
+ * The buffer union allows the buffer to be viewed as an unsigned, 32-bit
+ * integer, an array of unsigned characters, an array of 32-bit unsigned
+ * integers, or an array of 64-bit unsigned integers (on machines that
+ * support 64-bit unsigned integer arithmetic.
+ *
+ * In nearly all cases, one should use the access functions.
+ */
+typedef struct mdigest {
+	union {
+	  	struct mdigest_info {
+			enum mdigest_type mdt;
+			int len;
+		} info;
+#if (_POSIX_V6_LP64_OFF64 || _POSIX_V6_LPBIG_OFFBIG)
+		uint64_t align64; /* to allow 64-bit operations on buffers */
+#define MDIGEST_SPACER_SIZE ((sizeof (struct mdigest_info) > 8)? \
+			     (sizeof (struct mdigest_info) - 1): 7)
+#else
+#define MDIGEST_SPACER_SIZE (sizeof (struct mdigest_info) - 1)
+#endif
+	  	/*
+		 * This is used destructively when a digest is
+		 * about to be written to disk (e.g., for the
+		 * loose object digests). The address of the
+		 * wcode member will provide a buffer prefaced
+		 * by a byte containing a wcode tag to indicate
+		 * the digest type.
+		 */
+		struct {
+			unsigned char spacer[MDIGEST_SPACER_SIZE];
+			unsigned char wcode;
+		} lhdr;		/* header for loose objects */
+	} hdr;
+	union {
+		uint32_t crc32;
+		unsigned char buffer[MAX_DIGEST_LENGTH];
+		uint32_t buffer32[MAX_DIGEST_LENGTH/4];
+#if (_POSIX_V6_LP64_OFF64 || _POSIX_V6_LPBIG_OFFBIG)
+		uint64_t buffer64[MAX_DIGEST_LENGTH/8];
+#endif  
+	} buffer;
+} mdigest_t;
+
+/**
+ * Get the message digest type of a message digest.
+ * Arguments:
+ *     mdp - a pointer to the message digest.
+ *
+ * Returns:
+ *     the type of the message digest.
+ *
+ * Precoditions:
+ *     the message digest must have been created (by calling the function
+ *     mdigest_Final).
+ */
+static inline enum mdigest_type get_mdigest_type(const mdigest_t *mdp) {
+	return mdp->hdr.info.mdt;
+}
+
+/**
+ * Get the length of a message digest.
+ * Arguments:
+ *     mdp - a pointer to the message digest.
+ *
+ * Returns:
+ *    the length in bytes of the message digest
+ *
+ * Precoditions:
+ *     the message digest must have been created (by calling the function
+ *     mdigest_Final).
+ */
+static inline int get_mdigest_len(const mdigest_t *mdp) {
+	return mdp->hdr.info.len;
+}
+
+
+/**
+ * Get the buffer containing a message digest.
+ * Arguments:
+ *     mdp - a pointer to the message digest.
+ *
+ * Returns:
+ *    the buffer (unsigned char array) of the message digest.
+ *
+ * Precoditions:
+ *     the message digest must have been created (by calling the function
+ *     mdigest_Final).
+ */
+static inline const unsigned char *get_mdigest_buffer(const mdigest_t *mdp) {
+  return mdp->buffer.buffer;
+}
+
+/**
+ * Test to see if two message digests are identical.
+ *
+ * Arguments:
+ *       md1p - a pointer to the first digest
+ *       md2p - a pointer to the second digest
+ * Returns:
+ *   0 if the digests match; -1 otherwise
+ */
+extern int mdigest_tst(mdigest_t *md1p, mdigest_t *md2p);
+
+/**
+ * Get the print-name of a message digest.
+ * Arguments:
+ *   mdt  the message digest's type
+ * Returns:
+ *   The name of the digest, suitable for printing or displaying.
+ */
+extern const char *get_mdigest_name(enum mdigest_type mdt);
+
+
+/**
+ * Message digest context.
+ * This is data structure maintains the state of a message-digest
+ * computation.  Each field in the union specifies the context needed
+ * for a particular digest or set of digests.
+ */
+typedef struct  mdigest_context {
+	union {
+  		uint32_t crc32;		/* minimal digest for testing. */
+  		git_SHA_CTX sha1;	/* SHA-1 (git-internal impl) */
+		EVP_MD_CTX evp;		/* For openssl EVP digest functions */
+		/* Add the others later */
+	} context;
+	enum mdigest_type mdt;
+} mdigest_context_t;
+
+/**
+ * Initialize the mdigest module.
+ */
+extern void mdigest_init(void);
+
+/*
+ *  Modeled after Git SHA-1 API, which follows that used by openssl
+ */
+
+/**
+ * Initialize a message digest context.
+ * Arguments:
+ *   ctx - a pointer to the context to initialize
+ *   mdt - the type of the message digest.
+ */
+extern void mdigest_Init(mdigest_context_t *ctx,
+				enum mdigest_type mdt);
+
+
+/**
+ * Update a message digest context
+ * Arguments:
+ *      ctx - a pointer to the context to initialize
+ *   dataIn - the data to add to the digest
+ *      len - the length of dataIn
+ * 
+ */
+extern void mdigest_Update(mdigest_context_t *ctx,
+			   const void *dataIn,
+			   unsigned long len);
+
+/**
+ * Complete and provide a message digest.
+ * Arguments:
+ *   digest - the data structure that will store the message digest.
+ *      ctx - a pointer to the context to initialize
+ */
+extern void mdigest_Final(mdigest_t *digest, mdigest_context_t *ctx);
+
+/**
+ * Initialize a digest given external data representing the digest.
+ *
+ * Arguments:
+ *    digestp - a pointer to the message digest to initialize
+ *      wcode - the code (external representation) representing the 
+ *              message type
+ *     buffer - the digest itself, as a sequence of bytes.
+ *  
+ * Returns:
+ *    0 on success, -1 on error
+ */
+extern int mdigest_load(mdigest_t *digestp, int wcode, unsigned char *buffer);
+
+/**
+ * Get the required message-digest length.
+ * Arguments:
+ *  wcode - a code (external representation) indicating the type of digest.
+ * Returns:
+ *   The message-digest length in bytes; 0 for unrecognized codes
+ */
+extern int get_mdigest_required_len(int wcode);
+
+/**
+ * Get the message-digest code for a message digest.
+ * Arguments:
+ *      digestp - a pointer to the message digest
+ * Return:
+ *    the message digest code
+ */
+extern int get_mdigest_wcode(const mdigest_t *digestp);
+
+
+/**
+ * Get the message-digest code for a message digest type.
+ * Arguments:
+ *      type - the type of a message digest
+ * Return:
+ *    the message digest code
+ */
+extern int get_mdigest_wcode_by_type(enum mdigest_type type);
+
+/**
+ * Get the word size for a digest given the digest type
+ * Arguments:
+ *   type - the type of the message digest
+ * Returns:
+ *  the size in 32-bit words of a message digest of a given type.
+ *
+ */
+extern int get_mdigest_wsize_by_type(enum mdigest_type type);
+
+/**
+ * Get the word size for a digest
+ * Arguments:
+ *   digestp - a pointer to a messag digest.
+ * Returns:
+ *  the size in 32-bit words of a message digest of a given type.
+ */
+extern int get_mdigest_wsize(mdigest_t *digestp);
+
+/**
+ * Get the required message-digest length by type.
+ * Arguments:
+ *   type - the type of the message digest
+ * Returns:
+ *   The message-digest length in bytes
+ */
+extern int get_mdigest_required_len_by_type(enum mdigest_type type);
+
+/**
+ * Copy a digest to a buffer.
+ * If the buffer is longer than required, it will be padded with null
+ * bytes.  If it is shorter than required, only the number of bytes
+ * given by blen will be copied.
+ * Arguments:
+ *    buffer - the buffer to store the digest, represented as a
+ *             sequence of bytes
+ *   digestp - the digest
+ *      blen - the length of the buffer
+ * Returns:
+ *    the number of bytes from the digest copied into the buffer
+ */
+extern int mdigest_to_buffer(unsigned char *buffer, 
+			     mdigest_t *digestp, int blen);
+
+/**
+ * Get the hexadecimal representation of a message digest.
+ * Arguments:
+ *    digestp - a pointer to the digest
+ * Returns:
+ *   a sequence of hexadecimal characters containing the digest
+ */
+extern char *mdigest_to_hex(const mdigest_t *digestp);  /* static buffer result! */
+
+/**
+ * Get the tagged hexadecimal representation of a message digest.
+ * The first two bytes represents the wcode value giving the digest
+ * type.
+ * Arguments:
+ *    digestp - a pointer to the digest
+ * Returns:
+ *   a sequence of hexadecimal characters containing the digest, prefaced
+ *   by two hexadecimal digits representing the type of digest
+ */
+extern char *mdigest_to_external_hex(const mdigest_t *digestp);  /* static buffer result! */
+
+/**
+ * Clear a message digest
+ * Arguments:
+ *   digestp - a pointer to a messag digest.
+ */
+static inline void mdigest_clear(mdigest_t *digestp) {
+	memset(digestp, 0, sizeof(mdigest_t));
+}
+
+#endif /* MDIGEST_H */
diff --git a/mdsdb.h b/mdsdb.h
new file mode 100644
index 0000000..5502985
--- /dev/null
+++ b/mdsdb.h
@@ -0,0 +1,192 @@
+#ifndef MDSDB_H
+#define MDSDB_H
+
+/**
+ * MD (Message Digest) Database Support.
+ *
+ * This module maintains a database mapping SHA-1 object keys to MDs
+ * (Message Digests) for purposes of detecting hash collisions.  The
+ * MDs are stored in the database as a sequence of bytes, prefaced
+ * by a one-byte code giving the MD type).  The functions allow for
+ * initialization, queries, adding new entries (with a collision
+ * check), and managing access to alternate databases.  The entries
+ * in the database correspond to Git loose objects
+ *
+ * The preprocessor symbol MDSDB determines the implementation of the
+ * module.
+ * Values:
+ *   0 - implement using directories and files - the first byte of a
+ *       SHA1 hash determines a subdirectory of ../objects/mdsd, and
+ *       the remaining bytes determine the file name, with the names
+ *       consisting of the hexadecimal representation of each byte's
+ *       value. The files then contain  a one byte code that determines
+*        the type of the MD, followed by the MD itself as a sequence of
+*        bytes. A value of 1 implies that packdb will also be used when
+*        creating pa
+ */
+
+#include<stdint.h>
+
+#include "cache.h"
+
+#if (MDSDB == 0)
+/**
+ * Opaque data type - because the typedef is for a pointer, we
+ * don't need the structure defined in files that use the pointer.
+ * We do need it defined somewhere, in this case in the file
+ * objd-mdsdb.c, which is the only place the fields are used.
+ */
+typedef struct objd_mdsdb *mdsdb_t;
+#endif
+
+/**
+ *  Initialize the database.
+ *  This opens a database file in the objects directory named mdsd,
+ *  used to store MDS of objects (uncompressed, excluding the header)
+ *  for hash-collision detection.
+ */
+extern void mdsdb_init(void);
+
+/**
+ * Check if the database has been initialized.
+ * Returns:
+ *   1 if mdsdb_init has been called; false otherwise.
+ */
+extern int mdsdb_initialized(void);
+
+/**
+ * Initializes alternative databases by adding them to a table with
+ * these databases closed.
+ */
+extern void mdsdb_init_alts();
+
+
+/**
+ * Open a database file.
+ *
+ * The default database can be read or written. alternate database
+ * files are read-only databases.  Multiple calls without intervening
+ * calls to mdsdb_close for a given argument will result in the same
+ * object being returned each successive time.  The pathname must match
+ * one stored by a call to mdsdb_init_alts.
+ *
+ * Arguments:
+ *    pathname - the pathname of the file; NULL for the default db;
+ *
+ * Returns:
+ *    the database (NULL indicates the default)
+ */
+extern mdsdb_t mdsdb_open(char *pathname);
+
+/**
+ * Open a database file given an alterate object database pointer.
+ *
+ * The default database can be read or written. alternate database
+ * files are read-only databases.  Multiple calls without intervening
+ * calls to mdsdb_close for a given argument will result in the same
+ * object being returned each successive time The argument must match
+ * an alternate object database pointer stored by a precding call to
+ * mdsdb_init_alts.
+ *
+ * Arguments:
+ *    alt - an alternate object database pointer (which provides the
+ *          pathname).
+ *
+ * Returns:
+ *    the database (NULL indicates the default)
+ */
+extern mdsdb_t mdsdb_open_alt(struct alternate_object_database *alt);
+
+/**
+ * Lookup a MD from a database.
+ *
+ * Arguments:
+ *        dbf - the MD database; NULL for the default database
+ *       sha1 - the key for the lookup (a 20-byte SHA1 digest)
+ *    digestp - a pointer to a uint32_t to store the returned value when
+ *              an entry in the database exists.
+ *
+ * Returns:
+ *   0 if no entry, 1 if there is an existing entry.
+ */
+extern int mdsdb_lookup(mdsdb_t dbf, const unsigned char *sha1,
+			mdigest_t *digestp);
+
+/**
+ * Remove a MD from a database.
+ *
+ * Arguments:
+ *        dbf - the MD database; NULL for the default database
+ *       sha1 - the key for the lookup (a 20-byte SHA1 digest)
+ *
+ * Returns:
+ *   0 on success; -1 if the entry did not exist or if an entry
+ *   could not be deleted
+ */
+extern int mdsdb_remove(mdsdb_t dbf, const unsigned char *sha1);
+
+/**
+ * Process a MD for a SHA-1 key.
+ *
+ * Arguments:
+ *        dbf - the MD database; NULL for the default database
+ *       sha1 - the key for the lookup (a 20-byte SHA1 digest)
+ *    digestp - the crc to store.
+ *
+ * Returns:
+ *   0 if this is a new entry; 1 if it is an existing entry, -1 if
+ *   an entry cannot be added ot the database.
+ *
+ * Errors:
+ *   Will call 'die' and exit if there is a hash collision. Will call
+ *   'error' if the value cannot be entered.
+ */
+extern int mdsdb_process(mdsdb_t dbf, const unsigned char *sha1,
+			 mdigest_t *digestp);
+
+/**
+ * Reorganize a MD database.
+ *
+ * Arguments:
+ *        dbf - the MD database; NULL for the default database
+ * Returns:
+ *   0 on success; -1 on failure
+ */
+extern int mdsdb_reorganize(mdsdb_t dbf);
+
+
+/**
+ * Close a  database file.
+ *
+ * If the same database was opened multiple times, a reference count is
+ * decremented and the the database will not be closed until the count
+ * reaches zero.  Calls to mdsdb_open or mdsdb_open_alt must be balanced
+ * by calls to mdsdb_close or mdsdb_close_alt.
+ *
+ * Arguments:
+ *        dbf - the MD database.
+ */
+extern void mdsdb_close(mdsdb_t dbf);
+
+/**
+ * Close a database file given an alternate object database pointer.
+ *
+ * If the same database was opened multiple times, a reference count is
+ * decremented and the the database will not be closed until the count
+ * reaches zero.  Calls to mdsdb_open or mdsdb_open_alt must be balanced
+ * by calls to mdsdb_close or mdsdb_close_alt.
+ *
+ * Arguments:
+ *       alt - a pointer ot an alternate object database
+ */
+extern void mdsdb_close_alt(struct alternate_object_database *alt);
+
+/**
+ * Shutdown the database files.
+ * This will shut down the default database and the cached alternative
+ * databases.  All others should be closed by calling crcb_alt_close
+ * explicitly
+ */
+extern void mdsdb_finish(void);
+
+#endif /*MDSDB_H */
diff --git a/objd-mdsdb.c b/objd-mdsdb.c
new file mode 100644
index 0000000..268c5c4
--- /dev/null
+++ b/objd-mdsdb.c
@@ -0,0 +1,340 @@
+#include<sys/types.h>
+#include "cache.h"
+#include "mdsdb.h"
+
+struct objd_mdsdb {
+  char *root;
+};
+
+static struct objd_mdsdb db;
+
+static mdsdb_t no_dbf = (mdsdb_t) 4;
+
+static mdsdb_t dbf = NULL;
+
+#define ALT_DBF_LIMIT  512
+
+
+struct alt_map {
+	struct objd_mdsdb db;
+	struct alternate_object_database *alt;
+	struct alt_map *refer;
+};
+
+struct alt_map alt_map[ALT_DBF_LIMIT];
+static int alt_in_use = 0;
+static int initialized = 0;
+
+
+void mdsdb_init(void) {
+	if (initialized) {
+		return;
+	}
+	dbf = &db;
+	db.root = get_object_mds_directory();
+	initialized = 1;
+}
+
+int mdsdb_initialized(void) {
+	return initialized;
+}
+
+static int setup_alt(struct alternate_object_database *alt, void *param) {
+	static char buffer[PATH_MAX];
+	int i;
+	int lim = alt->name - alt->base;
+	memcpy(buffer, alt->base, lim);
+	memcpy(buffer, alt->base, lim);
+	memcpy(buffer+lim, "mdsd", 4);
+	buffer[lim+4] = 0;
+	for (i = 0; i < alt_in_use; i++) {
+		if (alt_map[i].alt == alt) {
+			/* don't put in the same entry twice */
+			return 0;
+		}
+		if (strcmp(buffer, alt_map[i].db.root) == 0) {
+			break;
+		}
+	}
+	alt_map[alt_in_use].db.root = xstrdup(buffer);
+	alt_map[alt_in_use].alt = alt;
+	if (i < alt_in_use) {
+		alt_map[alt_in_use].refer = alt_map + i;
+	} else {
+		alt_map[alt_in_use].refer = NULL;
+	}
+	alt_in_use++;
+	return 0;
+}
+
+static int alt_initialized = 0;
+
+void mdsdb_init_alts(void){
+	if (alt_initialized) return;
+	foreach_alt_odb(setup_alt, NULL);
+	alt_initialized = 1;
+}
+
+
+mdsdb_t mdsdb_open(char *name) {
+	int i;
+	if (name == NULL) return NULL;
+	for (i = 0; i < alt_in_use; i++) {
+		if (strcmp(alt_map[i].db.root, name) == 0) {
+			if (alt_map[i].refer) {
+				i = (alt_map[i].refer - alt_map);
+			}
+			return (mdsdb_t)&(alt_map[i].db);
+		}
+	}
+	return no_dbf;
+}
+
+mdsdb_t mdsdb_open_alt(struct alternate_object_database *alt) {
+	int i;
+	for (i = 0; i < alt_in_use; i++) {
+		if (alt_map[i].alt == alt) {
+			return (mdsdb_t)&(alt_map[i].db);
+		}
+	}
+	return no_dbf;
+
+}
+/* copied from sha1_file.c */
+static void fill_sha1_path(char *pathbuf, const unsigned char *sha1)
+{
+	int i;
+	for (i = 0; i < 20; i++) {
+		static char hex[] = "0123456789abcdef";
+		unsigned int val = sha1[i];
+		char *pos = pathbuf + i*2 + (i > 0);
+		*pos++ = hex[val >> 4];
+		*pos = hex[val & 0xf];
+	}
+}
+
+/*
+ * Warning: returns a static buffer so be careful about threading.
+ */
+static char *crc32_file_name(const char *path, const unsigned char *sha1)
+{
+	static char buf[PATH_MAX];
+	const char *digestdir;
+	int len;
+
+	digestdir = path;
+	len = strlen(digestdir);
+
+	/* '/' + sha1(2) + '/' + sha1(38) + '\0' */
+	if (len + 43 > PATH_MAX)
+		die("insanely long object crc directory %s", digestdir);
+	memcpy(buf, digestdir, len);
+	buf[len] = '/';
+	buf[len+3] = '/';
+	buf[len+42] = '\0';
+	fill_sha1_path(buf + len + 1, sha1);
+	return buf;
+}
+
+static int mdsdb_lookup_aux(char *path, mdigest_t *digestp)
+{
+	if (!access(path, F_OK)) {
+		if (digestp) {
+			int fd = open(path, O_RDONLY);
+			int wcode, len;
+			unsigned char wsch;
+			unsigned char buffer[MAX_DIGEST_LENGTH];
+			if (fd < 0) {
+				return 0;
+			}
+			if (read_in_full(fd, &wsch, 1) != 1) {
+				close(fd);
+				return 0;
+			}
+			wcode = wsch;
+			len = get_mdigest_required_len(wcode);
+			if(read_in_full(fd, buffer, len)
+			   != len) {
+				close(fd);
+				return 0;
+			}
+			close(fd);
+			mdigest_load(digestp, wcode, buffer);
+		}
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+
+int mdsdb_lookup(mdsdb_t gdbf, const unsigned char *sha1, mdigest_t *digestp) {
+	char *path;
+
+	if (!initialized || gdbf == no_dbf) {
+	  return -1;
+	}
+	if (gdbf == NULL) gdbf = dbf;
+
+	path = crc32_file_name(gdbf->root, sha1);
+	return mdsdb_lookup_aux(path, digestp);
+}
+
+int mdsdb_remove(mdsdb_t gdbf, const unsigned char *sha1) {
+	char *path;
+	if (!initialized || gdbf == no_dbf) {
+	  return -1;
+	}
+
+	if (gdbf == NULL) {
+		gdbf = dbf;
+	} else {
+		return -1;
+	}
+	path = crc32_file_name(gdbf->root, sha1);
+	return unlink(path);
+}
+
+/* copied from sha1_file.c */
+/* Size of directory component, including the ending '/' */
+static inline int directory_size(const char *filename)
+{
+	const char *s = strrchr(filename, '/');
+	if (!s)
+		return 0;
+	return s - filename + 1;
+}
+
+
+/* copied from sha1_file.c */
+static int create_tmpfile(char *buffer, size_t bufsiz, const char *filename)
+{
+	int fd, dirlen = directory_size(filename);
+
+	if (dirlen + 20 > bufsiz) {
+		errno = ENAMETOOLONG;
+		return -1;
+	}
+	memcpy(buffer, filename, dirlen);
+	strcpy(buffer + dirlen, "tmp_obj_XXXXXX");
+	fd = git_mkstemp_mode(buffer, 0444);
+	if (fd < 0 && dirlen && errno == ENOENT) {
+		/* Make sure the directory exists */
+		memcpy(buffer, filename, dirlen);
+		buffer[dirlen-1] = 0;
+		if (mkdir(buffer, 0777) || adjust_shared_perm(buffer))
+			return -1;
+
+		/* Try again */
+		strcpy(buffer + dirlen - 1, "/tmp_obj_XXXXXX");
+		fd = git_mkstemp_mode(buffer, 0444);
+	}
+	return fd;
+}
+
+/* copied from sha1_file.c */
+static int write_buffer(int fd, const void *buf, size_t len)
+{
+	if (write_in_full(fd, buf, len) < 0)
+		return error("file write error (%s)", strerror(errno));
+	return 0;
+}
+
+/* copied from sha1_file.c */
+/* Finalize a file on disk, and close it. */
+static void close_sha1_file(int fd)
+{
+	if (fsync_object_files)
+		fsync_or_die(fd, "sha1 file");
+	if (close(fd) != 0)
+		die_errno("error when closing sha1 file");
+}
+
+
+int mdsdb_process(mdsdb_t gdbf, const unsigned char *sha1,
+		  mdigest_t *digestp)
+{
+	mdigest_t old_digest;
+	int has_old_digest = 0;
+	char *path;
+	if (!initialized || gdbf == no_dbf) {
+	  return -1;
+	}
+	if (gdbf == NULL) gdbf = dbf;
+	path = crc32_file_name(gdbf->root, sha1);
+	has_old_digest = mdsdb_lookup_aux(path, &old_digest);
+	if (gdbf == dbf && !has_old_digest) {
+		mdigest_t crc;
+		int len, wcode;
+		static char ctmpfile[PATH_MAX];
+		int fdc = create_tmpfile(ctmpfile, sizeof(ctmpfile), path);
+		if (fdc < 0) {
+		  return -1;
+		}
+		crc = *(digestp);
+		len = get_mdigest_len(digestp);
+		wcode = get_mdigest_wcode(digestp);
+		crc.hdr.lhdr.wcode = (unsigned char)wcode;
+		if (fdc >= 0 && write_buffer(fdc, &crc.hdr.lhdr.wcode,
+					     len + 1) < 0) {
+			close_sha1_file(fdc);
+			return -1;
+		}
+		if (fdc >= 0) {
+			close_sha1_file(fdc);
+			return (move_temp_to_file(ctmpfile, path) == 0)?
+				0: -1;
+		}
+		return -1;
+	} else if (has_old_digest) {
+	  if (mdigest_tst(&old_digest, digestp)) {
+			die("SHA1 COLLISION WHEN INSERTING OBJECT %s",
+			    sha1_to_hex(sha1));
+			return -1;
+		}
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+
+void mdsdb_close(mdsdb_t gdbf) {
+	return;
+}
+
+void mdsdb_close_alt(struct alternate_object_database *alt) {
+	return;
+}
+
+
+
+int mdsdb_reorganize(mdsdb_t gdbf) {
+	if (!initialized || gdbf == no_dbf) {
+	  return -1;
+	}
+	if (gdbf == NULL) {
+		return 0;
+	} else {
+		return -1;
+	}
+}
+
+
+
+void mdsdb_finish(void) {
+	int i;
+	if (!initialized) {
+		return;
+	}
+	dbf->root = NULL;
+
+	for (i = 0; i < alt_in_use; i++) {
+		free(alt_map[i].db.root);
+		alt_map[i].db.root = NULL;
+	}
+	memset(alt_map, 0, sizeof(struct alt_map) *alt_in_use);
+	alt_in_use = 0;
+	initialized = 0;
+	alt_initialized = 0;
+}
diff --git a/packdb.h b/packdb.h
new file mode 100644
index 0000000..64c1d0a
--- /dev/null
+++ b/packdb.h
@@ -0,0 +1,93 @@
+#ifndef PACKDB_H
+#define PACKDB_H
+
+#include<stdint.h>
+#include "mdigest.h"
+
+/**
+ *  Initialize the database.
+ *  This opens a database file in the objects directory named mdsd,
+ *  used to store CRCS of objects (uncompressed, excluding the header)
+ *  for hash-collision detection.
+ */
+extern void packdb_init(void);
+
+/**
+ * Check if the database has been initialized.
+ * Returns:
+ *   1 if packdb_init has been called; false otherwise.
+ */
+extern int packdb_initialized(void);
+
+/**
+ * Open the persistent database to store a copy of obj CRCs in pack index files.
+ * Nested calls are allowed, but must be balanced by calls to packdb_close.
+ * For nested calls, subsequent ones merely increment a reference count.
+ *
+ * This is used to create space-efficient storage of object CRCs that
+ * are not associated with loose objects (e.g., because they are in pack
+ * files).  Intended for use when building pack files.
+ *
+ * Note:
+ *   Interacting with another process that calls this function on the
+ *   same repository may lead to deadlock unless packdb_close is
+ *   called before that interaction.
+ */
+extern void packdb_open(void);
+
+/**
+ * Store a crc in the persistent database for creating pack index files.
+ *
+ * Arguments:
+ *   sha1 - the key for the entry (a 20-byte sha1 hash)
+ *   crc - the crc to store (the crc of an object's data)
+ * Returns:
+ *   0 if we added a new entry, 1 if the entry already exists, -1 on error
+ */
+extern int packdb_process(const unsigned char *sha1, mdigest_t *digestp);
+
+/**
+ * Lookup a CRC from a database.
+ *
+ * Arguments:
+ *       sha1 - the key for the lookup (a 20-byte SHA1 digest)
+ *    digestp - a pointer to a mdigest_t to store the returned value when
+ *              an entry in the database exists.
+ * Returns:
+ *   0 if no entry, 1 if there is an existing entry.
+ */
+extern int packdb_lookup(const unsigned char *sha1, mdigest_t *digestp);
+
+/**
+ * Remove a CRC from a database.
+ *
+ * Arguments:
+ *        dbf - the CRC database; NULL for the default database
+ *       sha1 - the key for the lookup (a 20-byte SHA1 digest)
+ *
+ * Returns:
+ *   0 on success; -1 if the entry did not exist or if an entry
+ *   could not be deleted
+ */
+extern int packdb_remove(const unsigned char *sha1);
+
+
+/**
+ * Reorganize the database.
+ * Returns:
+ *   0 on success; -1 on failure
+ */
+extern int packdb_reorganize(void);
+
+/**
+ * Close the database file.
+ */
+extern void packdb_close(void);
+
+/**
+ * Close the database if opened and uninitialize the module.
+ * This is intended to be called when the module is no longer needed.
+ */
+extern void packdb_finish(void);
+
+#endif
-- 
1.7.1
