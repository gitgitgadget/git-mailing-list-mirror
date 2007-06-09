From: Johan Herland <johan@herland.net>
Subject: [PATCH 1/7] Softrefs: Add softrefs header file with API documentation
Date: Sat, 09 Jun 2007 20:21:43 +0200
Message-ID: <200706092021.43314.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
 <200706092019.13185.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 20:21:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx5ZQ-0004GN-8H
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 20:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755250AbXFISVv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 14:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755219AbXFISVv
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 14:21:51 -0400
Received: from smtp.getmail.no ([84.208.20.33]:40694 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754213AbXFISVu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 14:21:50 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJD00L03SCDUN00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:21:49 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJD00JLCSC8IC00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:21:44 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJD000GISC7V660@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:21:44 +0200 (CEST)
In-reply-to: <200706092019.13185.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49593>

See patch for documentation.

Signed-off-by: Johan Herland <johan@herland.net>
---
 softrefs.h |  188 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 188 insertions(+), 0 deletions(-)
 create mode 100644 softrefs.h

diff --git a/softrefs.h b/softrefs.h
new file mode 100644
index 0000000..db0f8b9
--- /dev/null
+++ b/softrefs.h
@@ -0,0 +1,188 @@
+#ifndef SOFTREFS_H
+#define SOFTREFS_H
+
+/*
+ * Softrefs is a general mechanism for declaring a relationship between two
+ * existing arbitrary objects in the repo. Softrefs differ from the existing
+ * reachability relationship in that a softref may be created after _both_ of
+ * the involved objects have been added to the repo. In contrast, the regular
+ * reachability relationship depends on the reachable object's name being
+ * stored _inside_ the other object. A reachability relationship can therefore
+ * not be created at a later time without violating the immutability of git
+ * objects.
+ *
+ * Softrefs are defined as going _from_ one object _to_ another object. Once
+ * a softref between two objects has been created, the "to" object is
+ * considered reachable from the "from" object.
+ *
+ * Also, softrefs are stored in a way that makes it easy and quick to find all
+ * the "to" objects reachable from a given "from" object.
+ *
+ * The softrefs db consists of two files: .git/softrefs.unsorted and
+ * .git/softrefs.sorted. Both files use the same format; one softref per line
+ * of the form "<from-sha1> <to-sha1>\n". Each sha1 sum is 40 bytes long; this
+ * makes each entry exactly 82 bytes long (including the space between the sha1
+ * sums and the terminating linefeed).
+ *
+ * The entries in .git/softrefs.sorted are sorted on <from-sha1>, in order to
+ * make lookup fast.
+ *
+ * The entries in .git/softrefs.unsorted are _not_ sorted. This is to make
+ * insertion fast.
+ *
+ * When softrefs are created (by calling add_softref()/add_softrefs()), they
+ * are appended to .git/softrefs.unsorted. When .git/softrefs.unsorted reach a
+ * certain number of entries (determined by MAX_UNSORTED_ENTRIES), all the
+ * entries in .git/softrefs.unsorted are merged into .git/softrefs.sorted.
+ *
+ * Soft references are used as a reverse mapping between tag objects and their
+ * corresponding tagged objects. For each tag object, a soft reference _to_
+ * the tag object _from_ the tagged object is created. Given an arbitrary
+ * object X in the database, softrefs allow for easy lookup of which tag
+ * objects that point to object X.
+ */
+
+/*
+ * Simple list of softrefs
+ */
+struct softref_list {
+	struct softref_list *next;
+	unsigned char from_sha1[20];
+	unsigned char   to_sha1[20];
+};
+
+/* Callback function type; used as parameter to for_each_softref()
+ *
+ * The functions takes the following arguments:
+ * - from_sha1 - The SHA1 of the 'from' object in the current softref
+ * - to_sha1   - The SHA1 of the 'to' object in the current softref
+ * - cb_data   - as passed to for_each_softref()
+ *
+ * Return non-zero to stop for_each_softref() from iterating through.
+ */
+typedef int each_softref_fn(
+	const unsigned char *from_sha1,
+	const unsigned char *to_sha1,
+	void *cb_data);
+
+/*
+ * Invoke 'fn' with 'cb_data' for each object pointed to by 'from_sha1'
+ *
+ * If 'from_sha1' is NULL, 'fn' is invoked for _all_ softrefs in the db.
+ *
+ * If 'fn' returns non-zero for any given softref, iteration is stopped and the
+ * same return value is returned from this function. If other problems are
+ * encountered while iterating, -1 is returned. If all matching entries were
+ * iterated successfully, and 'fn' returned 0 for all of them, 0 is returned.
+ */
+extern int for_each_softref_with_from(
+	const unsigned char *from_sha1, each_softref_fn fn, void *cb_data);
+
+/*
+ * Invoke 'fn' with 'cb_data' for each softref stored in the db
+ *
+ * This function is identical to calling for_each_softref_with_from() with
+ * NULL as the first parameter.
+ */
+extern int for_each_softref(each_softref_fn fn, void *cb_data);
+
+/*
+ * Initialize/prepare the softrefs db for a lot of read-only access
+ *
+ * You may call this function before doing repeated calls to accessor functions
+ * such as:
+ * - for_each_softref_with_from()
+ * - for_each_softref()
+ * - lookup_softref()
+ * - has_softref()
+ *
+ * This function is purely optional, although it may improve performance when
+ * accessor functions are called repeatedly. The change in performance is
+ * caused by:
+ *  1. Merging unsorted softref entries into the sorted db file,
+ *  2. Doing open() and mmap() on the sorted db file (in order to avoid doing
+ *     this on each subsequent call to an accessor function).
+ *
+ * When done accessing the softrefs db, the caller _must_ call
+ * deinit_softrefs_access() to properly deinitialize internal structures.
+ */
+extern void init_softrefs_access();
+
+/*
+ * Deinitialize internal structures associated with init_softrefs_access()
+ *
+ * Call this function when finished accessing softrefs after a call to
+ * init_softrefs_access().
+ */
+extern void deinit_softrefs_access();
+
+/*
+ * Look up the given object id in the softrefs db
+ *
+ * Returns a list of all the matching softrefs, i.e. softrefs whose from_sha1
+ * is identical to the given. If the given from_sha1 is NULL, all softrefs are
+ * returned.
+ *
+ * The entired softref_list returned (i.e. all elements retrievable by
+ * following the next pointer) must be free()d by the caller.
+ *
+ * You should consider using one of the for_each_softref*() functions instead,
+ * as those might save you some memory.
+ */
+extern struct softref_list *lookup_softref(const unsigned char *from_sha1);
+
+/*
+ * Delete (i.e. free()) all elements in the given softref_list
+ */
+extern void delete_softref_list(struct softref_list *list);
+
+/*
+ * Return 1 if there exists a softref between 'from_sha1' and 'to_sha1'
+ *
+ * Otherwise, return 0.
+ */
+extern int has_softref(
+	const unsigned char *from_sha1, const unsigned char *to_sha1);
+
+/*
+ * Add all the softrefs given in the given 'list' to the db.
+ *
+ * Returns the number of softrefs added, or -1 on failure to add any softrefs.
+ */
+extern int add_softrefs(const struct softref_list *list);
+
+/*
+ * Add a softref between 'from_sha1' and 'to_sha1'
+ *
+ * 'from_sha1' and 'to_sha1' are two 20-byte object ids.
+ * Returns 0 on success, 1 if the softref already exists, -1 on failure.
+ */
+extern int add_softref(
+	const unsigned char *from_sha1, const unsigned char *to_sha1);
+
+/*
+ * Merge softrefs found in the given unsorted softrefs file into the sorted db
+ *
+ * If 'unsorted_file' is NULL, the internal unsorted db file is merged.
+ *
+ * Note that this routine is automatically invoked by add_softrefs() and
+ * add_softref() to control the size of the unsorted db file.
+ *
+ * If 'unsorted_file' is NULL, the merging is only done if the number of
+ * softrefs in the unsorted db file exceed a fixed threshold (see
+ * MAX_UNSORTED_ENTRIES). However, if 'force' is set, the merging will be done
+ * regardless. Passing anything other than NULL for 'unsorted_file'
+ * automatically turns on 'force'.
+ *
+ * Returns 0 on success; non-zero if problems were encountered.
+ */
+extern int merge_unsorted_softrefs(const char *unsorted_file, int force);
+
+/*
+ * Merge softrefs found in the given sorted softrefs file into the sorted db
+ *
+ * Returns 0 on success; non-zero if problems were encountered.
+ */
+extern int merge_sorted_softrefs(const char *sorted_file);
+
+#endif /* SOFTREFS_H */
-- 
1.5.2.1.144.gabc40
