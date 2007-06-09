From: Johan Herland <johan@herland.net>
Subject: [PATCH] Change softrefs file format from text (82 bytes per entry) to
 binary (40 bytes per entry)
Date: Sat, 09 Jun 2007 20:25:30 +0200
Message-ID: <200706092025.30156.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
 <200706092019.13185.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 20:25:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx5d2-0004tq-S6
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 20:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756687AbXFISZf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 14:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756681AbXFISZf
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 14:25:35 -0400
Received: from smtp.getmail.no ([84.208.20.33]:55929 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756678AbXFISZe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 14:25:34 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJD00C05SILDI00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:25:33 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJD00BH0SIIAL00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:25:30 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJD000UESIIVD50@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:25:30 +0200 (CEST)
In-reply-to: <200706092019.13185.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49600>

The text-based softrefs file format uses 82 bytes per entry (40 bytes
from_sha1 in hex, 1 byte SP, 40 bytes to_sha1 in hex, 1 byte LF).

The binary softrefs file format uses 40 bytes per entry (20 bytes
from_sha1, 20 bytes to_sha1).

Moving to a binary format increases performance slightly, but sacrifices
easy readability of the softrefs files.

Signed-off-by: Johan Herland <johan@herland.net>
---

To illustrate the change in performance from changing the softrefs file
format, I prepared a linux repo (holding 57274 commits) with 10 tag
objects, and created softrefs from every commit to every tag object
(572740 softrefs in total). The resulting softrefs db was 46964680 bytes
when using the text format, and 22909600 bytes when using the binary
format. The experiment was done on a 32-bit Intel Pentium 4
(3 GHz w/HyperThreading) with 1 GB RAM:


========
Operations on unsorted softrefs:
(572740 (10 per commit) entries in random/unsorted order)
========

Listing all softrefs
(sequential reading of unsorted softrefs file)
--------
[text format]
$ /usr/bin/time git softref --list > /dev/null
0.44user 0.02system 0:00.47elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+11786minor)pagefaults 0swaps
[binary format]
$ /usr/bin/time git softref --list > /dev/null
0.35user 0.01system 0:00.38elapsed 97%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+5913minor)pagefaults 0swaps

Listing HEAD's softrefs
(sequential reading of unsorted softrefs file)
--------
[text format]
$ /usr/bin/time git softref --list HEAD > /dev/null
0.11user 0.01system 0:00.14elapsed 94%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+11790minor)pagefaults 0swaps
[binary format]
$ /usr/bin/time git softref --list HEAD > /dev/null
0.02user 0.01system 0:00.03elapsed 97%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+5918minor)pagefaults 0swaps

Sorting softrefs
--------
[text format]
$ /usr/bin/time git softref --merge-unsorted
2.73user 4.97system 0:07.77elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+15833minor)pagefaults 0swaps
[binary format]
$ /usr/bin/time git softref --merge-unsorted
1.78user 5.00system 0:06.79elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+9961minor)pagefaults 0swaps

Sorting softrefs into existing sorted file
(throwing away duplicates)
--------
[text format]
$ /usr/bin/time git softref --merge-unsorted
3.49user 5.12system 0:08.64elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+27300minor)pagefaults 0swaps
[binary format]
$ /usr/bin/time git softref --merge-unsorted
2.03user 4.92system 0:07.05elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+15556minor)pagefaults 0swaps


========
Operations on sorted softrefs:
(572740 (10 per commit) entries in sorted order)
========

Listing all softrefs
(sequential reading of sorted softrefs file)
--------
[text format]
$ /usr/bin/time git softref --list > /dev/null
0.43user 0.02system 0:00.48elapsed 96%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+11786minor)pagefaults 0swaps
[binary format]
$ /usr/bin/time git softref --list > /dev/null
0.37user 0.00system 0:00.38elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+5914minor)pagefaults 0swaps

Listing HEAD's softrefs
(256-fanout followed by binary search in sorted softrefs file)
--------
[text format]
$/usr/bin/time git softref --list HEAD > /dev/null
0.00user 0.00system 0:00.00elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+334minor)pagefaults 0swaps
[binary format]
$ /usr/bin/time git softref --list HEAD > /dev/null
0.00user 0.00system 0:00.00elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+333minor)pagefaults 0swaps

Sorting softrefs
(no-op)
--------
[text format]
$ /usr/bin/time git softref --merge-unsorted
0.00user 0.00system 0:00.00elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+312minor)pagefaults 0swaps
[binary format]
$ /usr/bin/time git softref --merge-unsorted
0.00user 0.00system 0:00.00elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+312minor)pagefaults 0swaps


As expected, the binary format almost halved the number of pagefaults for
cases causing the entire softrefs db to be read (the reason for this, of
course, being the halved size of the db).

For the most common use case (looking up a given commit in a sorted db)
the binary format has no measurable effect on performance.


...Johan


 Documentation/git-softref.txt |    6 ++--
 softrefs.c                    |   78 +++++++++++------------------------------
 softrefs.h                    |    7 ++--
 3 files changed, 27 insertions(+), 64 deletions(-)

diff --git a/Documentation/git-softref.txt b/Documentation/git-softref.txt
index 6a3e13b..e21aaf3 100644
--- a/Documentation/git-softref.txt
+++ b/Documentation/git-softref.txt
@@ -93,9 +93,9 @@ Also, softrefs are stored in a way that makes it easy and quick to find all
 the "to" objects reachable from a given "from" object.
 
 The softrefs db consists of two files: `.git/softrefs.unsorted` and
-`.git/softrefs.sorted`. Both files use the same format; one softref per line
-of the form "`<from-sha1> <to-sha1>\n`". Each sha1 sum is 40 bytes long; this
-makes each entry exactly 82 bytes long.
+`.git/softrefs.sorted`. Both files use the same binary format; `<from-sha1>`
+followed by `<to-sha1>` per entry. Each sha1 sum is 20 bytes long; this
+makes each entry exactly 40 bytes long.
 
 The entries in `.git/softrefs.sorted` are sorted on `<from-sha1>`, in order to
 make lookup fast. This file is also known as the "sorted softrefs db".
diff --git a/softrefs.c b/softrefs.c
index c7308c8..8bb3a83 100644
--- a/softrefs.c
+++ b/softrefs.c
@@ -9,10 +9,8 @@ static const unsigned int MAX_UNSORTED_ENTRIES = 1000;
 
 /* softref entry as it appears in a softrefs file */
 struct softrefs_entry {
-	char from_sha1_hex[40];
-	char space;
-	char to_sha1_hex[40];
-	char lf;
+	unsigned char from_sha1[20];
+	unsigned char to_sha1[20];
 };
 
 /* simple encapsulation of a softrefs file */
@@ -106,8 +104,9 @@ static int write_entry(int fd, const struct softrefs_entry *entry)
 	if (write(fd, (const void *) entry, sizeof(struct softrefs_entry))
 		< sizeof(struct softrefs_entry))
 	{
-		return error("Failed to write entry '%.40s -> %.40s' to softrefs file descriptor %i: %s",
-				entry->from_sha1_hex, entry->to_sha1_hex,
+		return error("Failed to write entry '%s -> %s' to softrefs file descriptor %i: %s",
+				sha1_to_hex(entry->from_sha1),
+				sha1_to_hex(entry->to_sha1),
 				fd, strerror(errno));
 	}
 	return 0;
@@ -139,29 +138,13 @@ void deinit_softrefs_access()
 	internal_file = 0;
 }
 
-/* comparison between a SHA1 sum and a softrefs entry */
-static int sha1_to_entry_cmp(
-	const unsigned char *from_sha1, const struct softrefs_entry *entry)
-{
-	unsigned char sha1[20];
-	get_sha1_hex(entry->from_sha1_hex, sha1);
-	return hashcmp(from_sha1, sha1);
-}
-
 /* comparison between softrefs entries */
 static int softrefs_entry_cmp(
 		const struct softrefs_entry *a, const struct softrefs_entry *b)
 {
-	unsigned char sa[20], sb[20];
-	int ret;
-	get_sha1_hex(a->from_sha1_hex, sa);
-	get_sha1_hex(b->from_sha1_hex, sb);
-	ret = hashcmp(sa, sb);
-	if (!ret) {
-		get_sha1_hex(a->to_sha1_hex, sa);
-		get_sha1_hex(b->to_sha1_hex, sb);
-		ret = hashcmp(sa, sb);
-	}
+	int ret = hashcmp(a->from_sha1, b->from_sha1);
+	if (!ret)
+		ret = hashcmp(a->to_sha1, b->to_sha1);
 	return ret;
 }
 
@@ -193,26 +176,15 @@ static int do_for_each_sequential(
 		unsigned long i,
 		int stop_at_first_non_match)
 {
-	unsigned char f_sha1[20], t_sha1[20]; /* Holds sha1 per entry */
 	int ret = 0;
 	for (; i < file->data_len; ++i) { /* Step through file, starting at i */
-		/* sanity check entry */
-		if (file->data[i].space != ' ' || file->data[i].lf != '\n') {
-			ret = error("Entry #%lu in softrefs file %s failed sanity check",
-					i, file->filename);
-			break;
-		}
-		/* retrieve SHA1 values */
-		if (get_sha1_hex(file->data[i].from_sha1_hex, f_sha1) ||
-		    get_sha1_hex(file->data[i].to_sha1_hex,   t_sha1)) {
-			ret = error("Failed to read SHA1 values from entry #%lu in softrefs file %s",
-					i, file->filename);
-			break;
-		}
 		/* Compare to lookup value */
-		if (!from_sha1 || !hashcmp(from_sha1, f_sha1)) {
-			if ((ret = fn(f_sha1, t_sha1, cb_data)))
+		if (!from_sha1 || !hashcmp(from_sha1, file->data[i].from_sha1)) {
+			if ((ret = fn(file->data[i].from_sha1,
+					file->data[i].to_sha1, cb_data)))
+			{
 				break; /* bail out if callback returns != 0 */
+			}
 		}
 		else if (stop_at_first_non_match)
 			break;
@@ -277,7 +249,7 @@ static int do_for_each_sorted(
 	i = (from_sha1[0] * file->data_len) / 256;
 
 	/* Binary search */
-	while ((cmp_result = sha1_to_entry_cmp(from_sha1, &(file->data[i])))) {
+	while ((cmp_result = hashcmp(from_sha1, file->data[i].from_sha1))) {
 		if (right - left <= 1) /* not found; give up */
 			goto done;
 		if (cmp_result > 0) /* go right */
@@ -288,7 +260,7 @@ static int do_for_each_sorted(
 	}
 
 	/* i points to a matching entry, but not necessarily the first */
-	while (i >= 1 && sha1_to_entry_cmp(from_sha1, &(file->data[i - 1])) == 0)
+	while (i >= 1 && !hashcmp(from_sha1, file->data[i - 1].from_sha1))
 		--i;
 
 	/* i points to the first matching entry */
@@ -432,7 +404,6 @@ static int merge_unsorted_into_sorted(
 	while (!ret && (i < unsorted.data_len || j < sorted.data_len)) {
 		/* there are still entries in either list */
 		struct softrefs_entry *cur;
-		unsigned char from_sha1[20], to_sha1[20];
 		if (i < unsorted.data_len && j < sorted.data_len) {
 			/* there are still entries in _both_ lists */
 			/* choose "lowest" entry from either list */
@@ -451,10 +422,8 @@ static int merge_unsorted_into_sorted(
 		prev = cur;
 
 		/* skip writing if softref involves a non-existing object */
-		if (get_sha1_hex(cur->from_sha1_hex, from_sha1) ||
-			!has_sha1_file(from_sha1) ||
-		    get_sha1_hex(cur->to_sha1_hex,     to_sha1) ||
-			!has_sha1_file(  to_sha1))
+		if (!has_sha1_file(cur->from_sha1) ||
+		    !has_sha1_file(cur->to_sha1))
 		{
 			continue;
 		}
@@ -523,7 +492,6 @@ static int merge_sorted_into_sorted(const char *from_file, const char *to_file)
 	while (!ret && (i < file1.data_len || j < file2.data_len)) {
 		/* there are still entries in either list */
 		struct softrefs_entry *cur;
-		unsigned char from_sha1[20], to_sha1[20];
 		if (i < file1.data_len && j < file2.data_len) {
 			/* there are still entries in _both_ lists */
 			/* choose "lowest" entry from either list */
@@ -542,10 +510,8 @@ static int merge_sorted_into_sorted(const char *from_file, const char *to_file)
 		prev = cur;
 
 		/* skip writing if softref involves a non-existing object */
-		if (get_sha1_hex(cur->from_sha1_hex, from_sha1) ||
-			!has_sha1_file(from_sha1) ||
-		    get_sha1_hex(cur->to_sha1_hex,     to_sha1) ||
-			!has_sha1_file(  to_sha1))
+		if (!has_sha1_file(cur->from_sha1) ||
+		    !has_sha1_file(cur->to_sha1))
 		{
 			continue;
 		}
@@ -608,10 +574,8 @@ int add_softrefs(const struct softref_list *list)
 			/* nada */;
 		}
 		else {  /* softref is ok */
-			strcpy(entry.from_sha1_hex, sha1_to_hex(list->from_sha1));
-			strcpy(entry.to_sha1_hex, sha1_to_hex(list->to_sha1));
-			entry.space = ' ';
-			entry.lf = '\n';
+			hashcpy(entry.from_sha1, list->from_sha1);
+			hashcpy(entry.to_sha1, list->to_sha1);
 			if (write_entry(fd, &entry))
 				error("Failed to write entry to softrefs file %s: %s",
 						git_path(UNSORTED_FILENAME),
diff --git a/softrefs.h b/softrefs.h
index db0f8b9..89d25ce 100644
--- a/softrefs.h
+++ b/softrefs.h
@@ -19,10 +19,9 @@
  * the "to" objects reachable from a given "from" object.
  *
  * The softrefs db consists of two files: .git/softrefs.unsorted and
- * .git/softrefs.sorted. Both files use the same format; one softref per line
- * of the form "<from-sha1> <to-sha1>\n". Each sha1 sum is 40 bytes long; this
- * makes each entry exactly 82 bytes long (including the space between the sha1
- * sums and the terminating linefeed).
+ * .git/softrefs.sorted. Both files use the same binary format; <from-sha1>
+ * followed by <to-sha1> per entry. Each sha1 sum is 20 bytes long; this
+ * makes each entry exactly 40 bytes long.
  *
  * The entries in .git/softrefs.sorted are sorted on <from-sha1>, in order to
  * make lookup fast.
-- 
1.5.2.1.144.gabc40
