From: Bill Zaumen <bill.zaumen@gmail.com>
Subject: [PATCH 1/3] Add CRCDB and PACKDB modules for fast collision
 detection
Date: Tue, 29 Nov 2011 21:59:24 -0800
Message-ID: <1322632764.1728.317.camel@yos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 06:59:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVdCl-00013Y-R5
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 06:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314Ab1K3F7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 00:59:34 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63689 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab1K3F7d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 00:59:33 -0500
Received: by iage36 with SMTP id e36so246054iag.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 21:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=BJlI7Wm2/NrPeL7FuvhcY4eeuPb+ovv8hQHZYHhAy1s=;
        b=lgBwwIv+d4LGiTepgRuJJelYZsmJcMna2A8eMvpDHJ9kcyB0dZ/MZva7zAH4ih4Yz4
         c/33bQ/F5TFczQwjwJQ9R+ErB799iTVio/UDj9R+UMo+p/LYFAczj6aFMaAi8qtp+OGD
         DyLbItx6ELv3PLyDryDscybH4dovjimR/Q4v0=
Received: by 10.231.73.142 with SMTP id q14mr152377ibj.3.1322632772472;
        Tue, 29 Nov 2011 21:59:32 -0800 (PST)
Received: from [192.168.1.20] (adsl-209-233-20-69.dsl.snfc21.pacbell.net. [209.233.20.69])
        by mx.google.com with ESMTPS id p16sm3733241ibk.6.2011.11.29.21.59.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Nov 2011 21:59:31 -0800 (PST)
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186103>

The CRCDB module maintains a persistent mapping from SHA-1 hashes
to CRCs or message digests for Git objects. The current implementation
uses one file per CRC.  Documentation is in the header file crcdb.h
and there is a preprocessor directive CRCDB that should be set to 0
or 1, with the current choice being 0.

The PACKDB module (normally not turned on but can be conditionally
compiled) can be turned on for debugging/testing. This module
allows a CRC for an object to always be found, computing it from
scratch and storing it in a GDBM database.  It is intended for
use while building index files.  Testing seems to show that it is
not necessary as the needed information is always there.

Signed-off-by: Bill Zaumen <bill.zaumen+git@gmail.com>
---
 crcdb.h       |  191 +++++++++++++++++++++++++++++++++
 gdbm-packdb.c |  247 +++++++++++++++++++++++++++++++++++++++++++
 objd-crcdb.c  |  324 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 packdb.h      |  107 +++++++++++++++++++
 4 files changed, 869 insertions(+), 0 deletions(-)
 create mode 100644 crcdb.h
 create mode 100644 gdbm-packdb.c
 create mode 100644 objd-crcdb.c
 create mode 100644 packdb.h

diff --git a/crcdb.h b/crcdb.h
new file mode 100644
index 0000000..6eabb4f
--- /dev/null
+++ b/crcdb.h
@@ -0,0 +1,191 @@
+#ifndef CRCDB_H
+#define CRCDB_H
+
+/**
+ * CRC Database Support.
+ *
+ * This module uses GDBM to maintain a database mapping SHA-1 object keys
+ * to a 32-bit CRC for purposes of detecting hash collisions.  The CRCs
+ * are stored in the database in network byte order (i.e., as big-endian
+ * 32-bit unsigned integers).  The functions allow for initialization,
+ * queries, adding new entries (with a collision check), and managing
+ * access to alternate databases.
+ *
+ * The preprocessor symbol CRCDB determines the implementation of the
+ * module.
+ * Values:
+ *   0, 1 - implement using directories and files - the first byte of a
+ *       SHA1 hash determines a subdirectory of ../objects/crcs, and
+ *       the remaining bytes determine the file name, with the names
+ *       consisting of the hexadecimal representation of each byte's
+n *       value. The files then contain 32-bit CRCs stored in network
+ *       byte order.  A large number of 4-byte files is a poor use of
+ *       disk space, but may be useful for testing.  A value of 1 implies
+ *       that packdb will also be used.
+ */
+
+#include<stdint.h>
+
+#include "cache.h"
+
+#if (CRCDB == 0) || (CRCDB == 1)
+/**
+ * Opaque data type - because the typedef is for a pointer, we
+ * don't need the structure defined in files that use the pointer.
+ * We do need it defined somewhere, in this case in the file
+ * objd-crcdb.c, which is the only place the fields are used.
+ */
+typedef struct objd_crcdb *crcdb_t;
+#endif
+
+/**
+ *  Initialize the database.
+ *  This opens a database file in the objects directory named crcs,
+ *  used to store CRCS of objects (uncompressed, excluding the header)
+ *  for hash-collision detection.
+ */
+extern void crcdb_init(void);
+
+/**
+ * Check if the database has been initialized.
+ * Returns:
+ *   1 if crcdb_init has been called; false otherwise.
+ */
+extern int crcdb_initialized(void);
+
+/**
+ * Initializes alternative databases by adding them to a table with
+ * these databases closed.
+ */
+extern void crcdb_init_alts();
+
+
+/**
+ * Open a database file.
+ *
+ * The default database can be read or written. alternate database
+ * files are read-only databases.  Multiple calls without intervening
+ * calls to crcdb_close for a given argument will result in the same
+ * object being returned each successive time.  The pathname must match
+ * one stored by a call to crcdb_init_alts.
+ *
+ * Arguments:
+ *    pathname - the pathname of the file; NULL for the default db;
+ *
+ * Returns:
+ *    the database (NULL indicates the default)
+ */
+extern crcdb_t crcdb_open(char *pathname);
+
+/**
+ * Open a database file given an alterate object database pointer.
+ *
+ * The default database can be read or written. alternate database
+ * files are read-only databases.  Multiple calls without intervening
+ * calls to crcdb_close for a given argument will result in the same
+ * object being returned each successive time The argument must match
+ * an alternate object database pointer stored by a precding call to
+ * crcdb_init_alts.
+ *
+ * Arguments:
+ *    alt - an alternate object database pointer (which provides the
+ *          pathname).
+ *
+ * Returns:
+ *    the database (NULL indicates the default)
+ */
+extern crcdb_t crcdb_open_alt(struct alternate_object_database *alt);
+
+/**
+ * Lookup a CRC from a database.
+ *
+ * Arguments:
+ *        dbf - the CRC database; NULL for the default database
+ *       sha1 - the key for the lookup (a 20-byte SHA1 digest)
+ *  objcrc32p - a pointer to a uint32_t to store the returned value when
+ *              an entry in the database exists.
+ *
+ * Returns:
+ *   0 if no entry, 1 if there is an existing entry.
+ */
+extern int crcdb_lookup(crcdb_t dbf, const unsigned char *sha1,
+			uint32_t *objcrc32p);
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
+extern int crcdb_remove(crcdb_t dbf, const unsigned char *sha1);
+
+/**
+ * Process a CRC for a SHA-1 key.
+ *
+ * Arguments:
+ *        dbf - the CRC database; NULL for the default database
+ *       sha1 - the key for the lookup (a 20-byte SHA1 digest)
+ *   objcrc32 - the crc to store.
+ *
+ * Returns:
+ *   0 if this is a new entry; 1 if it is an existing entry, -1 if
+ *   an entry cannot be added ot the database.
+ *
+ * Errors:
+ *   Will call 'die' and exit if there is a hash collision. Will call
+ *   'error' if the value cannot be entered.
+ */
+extern int crcdb_process(crcdb_t dbf, const unsigned char *sha1,
+			 uint32_t objcrc32);
+
+/**
+ * Reorganize a CRC database.
+ *
+ * Arguments:
+ *        dbf - the CRC database; NULL for the default database
+ * Returns:
+ *   0 on success; -1 on failure
+ */
+extern int crcdb_reorganize(crcdb_t dbf);
+
+
+/**
+ * Close a  database file.
+ *
+ * If the same database was opened multiple times, a reference count is
+ * decremented and the the database will not be closed until the count
+ * reaches zero.  Calls to crcdb_open or crcdb_open_alt must be balanced
+ * by calls to crcdb_close or crcdb_close_alt.
+ *
+ * Arguments:
+ *        dbf - the CRC database.
+ */
+extern void crcdb_close(crcdb_t dbf);
+
+/**
+ * Close a database file given an alternate object database pointer.
+ *
+ * If the same database was opened multiple times, a reference count is
+ * decremented and the the database will not be closed until the count
+ * reaches zero.  Calls to crcdb_open or crcdb_open_alt must be balanced
+ * by calls to crcdb_close or crcdb_close_alt.
+ *
+ * Arguments:
+ *       alt - a pointer ot an alternate object database
+ */
+extern void crcdb_close_alt(struct alternate_object_database *alt);
+
+/**
+ * Shutdown the database files.
+ * This will shut down the default database and the cached alternative
+ * databases.  All others should be closed by calling crcb_alt_close
+ * explicitly
+ */
+extern void crcdb_finish(void);
+
+#endif /*CRCDB_H */
diff --git a/gdbm-packdb.c b/gdbm-packdb.c
new file mode 100644
index 0000000..0115f87
--- /dev/null
+++ b/gdbm-packdb.c
@@ -0,0 +1,247 @@
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
+#include "crcdb.h"
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
+int packdb_lookup(const unsigned char *sha1, uint32_t *objcrc32p) {
+	datum key;
+	datum ovalue;
+	uint32_t oldcrc;
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
+	oldcrc = *(uint32_t *)(ovalue.dptr);
+	free(ovalue.dptr);
+	if (objcrc32p) *objcrc32p = (oldcrc);
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
+int packdb_process(const unsigned char *sha1, uint32_t objcrc32) {
+	datum key;
+	datum nvalue;
+	datum ovalue;
+	uint32_t newcrc = (objcrc32);
+	uint32_t oldcrc;
+	pthread_mutex_lock(&gdbm_mutex);
+	if ((!initialized) || dbf == NULL) {
+		pthread_mutex_unlock(&gdbm_mutex);
+		return -1;
+	}
+	key.dptr = (char *)sha1;
+	key.dsize = 20;
+
+	nvalue.dptr = (char *)&newcrc;
+	nvalue.dsize = sizeof(uint32_t);
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
+		packdb_close_nolock();
+		pthread_mutex_unlock(&gdbm_mutex);
+
+		oldcrc = *(uint32_t *)ovalue.dptr;
+		free(ovalue.dptr);
+		/*
+		 * Both oldcrc and newcrc are in network byte order.
+		 */
+		if (oldcrc != newcrc) {
+			die("SHA1  COLLISION WHEN INSERTING OBJECT %s",
+			    sha1_to_hex(sha1));
+			return -1;
+		}
+		return 1;
+	}
+}
+
+int packdb_store(unsigned char *sha1) {
+	int status;
+	uint32_t objcrc32;
+	status = crcdb_lookup(NULL, sha1, &objcrc32);
+	if (status == 1) {
+		return packdb_process(sha1, objcrc32);
+	} else if (status == 0) {
+	  return packdb_lookup(sha1, &objcrc32)? 1: -1;
+	} else {
+	  return -1;
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
diff --git a/objd-crcdb.c b/objd-crcdb.c
new file mode 100644
index 0000000..2bf6fd9
--- /dev/null
+++ b/objd-crcdb.c
@@ -0,0 +1,324 @@
+#include<sys/types.h>
+#include "cache.h"
+#include "crcdb.h"
+
+struct objd_crcdb {
+  char *root;
+};
+
+static struct objd_crcdb db;
+
+static crcdb_t no_dbf = (crcdb_t) 4;
+
+static crcdb_t dbf = NULL;
+
+#define ALT_DBF_LIMIT  512
+
+
+struct alt_map {
+	struct objd_crcdb db;
+	struct alternate_object_database *alt;
+	struct alt_map *refer;
+};
+
+struct alt_map alt_map[ALT_DBF_LIMIT];
+static int alt_in_use = 0;
+static int initialized = 0;
+
+
+void crcdb_init(void) {
+	if (initialized) {
+		return;
+	}
+	dbf = &db;
+	db.root = get_object_crc_node();
+	initialized = 1;
+}
+
+int crcdb_initialized(void) {
+	return initialized;
+}
+
+static int setup_alt(struct alternate_object_database *alt, void *param) {
+	static char buffer[PATH_MAX];
+	int i;
+	int lim = alt->name - alt->base;
+	memcpy(buffer, alt->base, lim);
+	memcpy(buffer, alt->base, lim);
+	memcpy(buffer+lim, "crcs", 4);
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
+void crcdb_init_alts(void){
+	if (alt_initialized) return;
+	foreach_alt_odb(setup_alt, NULL);
+	alt_initialized = 1;
+}
+
+
+crcdb_t crcdb_open(char *name) {
+	int i;
+	if (name == NULL) return NULL;
+	for (i = 0; i < alt_in_use; i++) {
+		if (strcmp(alt_map[i].db.root, name) == 0) {
+			if (alt_map[i].refer) {
+				i = (alt_map[i].refer - alt_map);
+			}
+			return (crcdb_t)&(alt_map[i].db);
+		}
+	}
+	return no_dbf;
+}
+
+crcdb_t crcdb_open_alt(struct alternate_object_database *alt) {
+	int i;
+	for (i = 0; i < alt_in_use; i++) {
+		if (alt_map[i].alt == alt) {
+			return (crcdb_t)&(alt_map[i].db);
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
+	const char *objcrcdir;
+	int len;
+
+	objcrcdir = path;
+	len = strlen(objcrcdir);
+
+	/* '/' + sha1(2) + '/' + sha1(38) + '\0' */
+	if (len + 43 > PATH_MAX)
+		die("insanely long object crc directory %s", objcrcdir);
+	memcpy(buf, objcrcdir, len);
+	buf[len] = '/';
+	buf[len+3] = '/';
+	buf[len+42] = '\0';
+	fill_sha1_path(buf + len + 1, sha1);
+	return buf;
+}
+
+static int crcdb_lookup_aux(char *path, uint32_t *objcrc32p)
+{
+	if (!access(path, F_OK)) {
+		if (objcrc32p) {
+			int fd = open(path, O_RDONLY);
+			if (fd < 0) {
+				return 0;
+			}
+			if(read_in_full(fd, objcrc32p, sizeof(uint32_t))
+			   != sizeof (uint32_t)) {
+				close(fd);
+				return 0;
+			}
+			close(fd);
+			*objcrc32p = (*objcrc32p);
+		}
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+
+int crcdb_lookup(crcdb_t gdbf, const unsigned char *sha1, uint32_t *objcrc32p) {
+	char *path;
+
+	if (!initialized || gdbf == no_dbf) {
+	  return -1;
+	}
+	if (gdbf == NULL) gdbf = dbf;
+
+	path = crc32_file_name(gdbf->root, sha1);
+	return crcdb_lookup_aux(path, objcrc32p);
+}
+
+int crcdb_remove(crcdb_t gdbf, const unsigned char *sha1) {
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
+int crcdb_process(crcdb_t gdbf, const unsigned char *sha1, uint32_t objcrc32) {
+	uint32_t oldcrc;
+	int has_oldcrc = 0;
+	char *path;
+	if (!initialized || gdbf == no_dbf) {
+	  return -1;
+	}
+	if (gdbf == NULL) gdbf = dbf;
+	path = crc32_file_name(gdbf->root, sha1);
+	has_oldcrc = crcdb_lookup_aux(path, &oldcrc);
+	if (gdbf == dbf && !has_oldcrc) {
+		uint32_t crc;
+		static char ctmpfile[PATH_MAX];
+		int fdc = create_tmpfile(ctmpfile, sizeof(ctmpfile), path);
+		if (fdc < 0) {
+		  return -1;
+		}
+		crc = (objcrc32);
+		if (fdc >= 0 && write_buffer(fdc, &crc, sizeof (crc)) < 0) {
+			close_sha1_file(fdc);
+			return -1;
+		}
+		if (fdc >= 0) {
+			close_sha1_file(fdc);
+			return (move_temp_to_file(ctmpfile, path) == 0)?
+				0: -1;
+		}
+		return -1;
+	} else if (has_oldcrc) {
+		if (oldcrc != objcrc32) {
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
+void crcdb_close(crcdb_t gdbf) {
+	return;
+}
+
+void crcdb_close_alt(struct alternate_object_database *alt) {
+	return;
+}
+
+
+
+int crcdb_reorganize(crcdb_t gdbf) {
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
+void crcdb_finish(void) {
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
index 0000000..c4320ac
--- /dev/null
+++ b/packdb.h
@@ -0,0 +1,107 @@
+#ifndef PACKDB_H
+#define PACKDB_H
+
+#include<stdint.h>
+
+/**
+ *  Initialize the database.
+ *  This opens a database file in the objects directory named crcs,
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
+extern int packdb_process(const unsigned char *sha1, uint32_t objcrc32);
+
+/**
+ * Lookup a CRC from a database.
+ *
+ * Arguments:
+ *        dbf - the CRC database; NULL for the default database
+ *       sha1 - the key for the lookup (a 20-byte SHA1 digest)
+ *  objcrc32p - a pointer to a uint32_t to store the returned value when
+ *              an entry in the database exists.
+ * Returns:
+ *   0 if no entry, 1 if there is an existing entry.
+ */
+extern int packdb_lookup(const unsigned char *sha1, uint32_t *objcrc32p);
+
+/**
+ * Moves a crc into the persistent database for creating pack index files.
+ * This will delete the entry from the 'loose-object' crc database.
+ *
+ * Arguments:
+ *   sha1 - the key for the entry (a 20-byte sha1 hash)
+ * Returns:
+ *   0 if we stored an entry in the crcdb database, 1 if the entry already
+ *     existed in the packdb database, -1 on error or if there was no entry
+ *     to store.
+ */
+extern int packdb_store(unsigned char *sha1);
+
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
