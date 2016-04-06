From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 05/11] rerere: allow multiple variants to exist
Date: Wed,  6 Apr 2016 16:05:29 -0700
Message-ID: <1459983935-25267-6-git-send-email-gitster@pobox.com>
References: <1459204942-26601-1-git-send-email-gitster@pobox.com>
 <1459983935-25267-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 01:05:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anwWG-0008M9-NV
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 01:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149AbcDFXFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 19:05:47 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54148 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752574AbcDFXFq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 19:05:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CA34D5372D;
	Wed,  6 Apr 2016 19:05:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=k+Tq
	zzXVpbyoU2MNEux5P9rdrtE=; b=Gi408zenF2hNaTuSRbr6RY9dHzu3V9biRV3A
	GRgqwMF0OpDNvzxUXCpjGwQ95BweCrOsn3i5vtWS9GkU1i0eD13i8y5asV4i6QxT
	4Xj4md7xQFM43VfHtso6dFLslncP5KNDvPcMGTNmXUSFPkY3OqWtFFYdJjkSZY5G
	gBb/rBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ZHA60t
	tW2h3Fz2sQnPb8ZfE7K3p3p1LwJbkn49IVWuwB8Wuj9yAogY/abPCC/5FMt81Wm+
	pfiEIMJyUHXICdCYqoKiVYKUBkdQcntYkK88v5OkPLTYqC+fefjA9ni/XOuuVt8U
	tUlgLg7Et8WvTDD4wAfX4RiIT6Dbii0UTTWT0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C1B695372C;
	Wed,  6 Apr 2016 19:05:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 30CDD53728;
	Wed,  6 Apr 2016 19:05:45 -0400 (EDT)
X-Mailer: git-send-email 2.3.8-32-g0ce02b3
In-Reply-To: <1459983935-25267-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 17D3BBD8-FC4C-11E5-97DF-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290890>

The shape of the conflict in a path determines the conflict ID.  The
preimage and postimage pair that was recorded for the conflict ID
previously may or may not replay well for the conflict we just saw.

Currently, we punt when the previous resolution does not cleanly
replay, but ideally we should then be able to record the currently
conflicted path by assigning a new 'variant', and then record the
resolution the user is going to make.

Introduce a mechanism to have more than one variant for a given
conflict ID; we do not actually assign any variant other than 0th
variant yet at this step.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 127 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 rerere.h |   1 +
 2 files changed, 106 insertions(+), 22 deletions(-)

diff --git a/rerere.c b/rerere.c
index 33b1348..0cf857b 100644
--- a/rerere.c
+++ b/rerere.c
@@ -30,14 +30,17 @@ static int rerere_dir_alloc;
 #define RR_HAS_PREIMAGE 2
 static struct rerere_dir {
 	unsigned char sha1[20];
-	unsigned char status;
+	int status_alloc, status_nr;
+	unsigned char *status;
 } **rerere_dir;
 
 static void free_rerere_dirs(void)
 {
 	int i;
-	for (i = 0; i < rerere_dir_nr; i++)
+	for (i = 0; i < rerere_dir_nr; i++) {
+		free(rerere_dir[i]->status);
 		free(rerere_dir[i]);
+	}
 	free(rerere_dir);
 	rerere_dir_nr = rerere_dir_alloc = 0;
 	rerere_dir = NULL;
@@ -53,17 +56,59 @@ static const char *rerere_id_hex(const struct rerere_id *id)
 	return sha1_to_hex(id->collection->sha1);
 }
 
+static void fit_variant(struct rerere_dir *rr_dir, int variant)
+{
+	variant++;
+	ALLOC_GROW(rr_dir->status, variant, rr_dir->status_alloc);
+	if (rr_dir->status_nr < variant) {
+		memset(rr_dir->status + rr_dir->status_nr,
+		       '\0', variant - rr_dir->status_nr);
+		rr_dir->status_nr = variant;
+	}
+}
+
+static void assign_variant(struct rerere_id *id)
+{
+	int variant;
+	struct rerere_dir *rr_dir = id->collection;
+
+	variant = id->variant;
+	if (variant < 0) {
+		variant = 0; /* for now */
+	}
+	fit_variant(rr_dir, variant);
+	id->variant = variant;
+}
+
 const char *rerere_path(const struct rerere_id *id, const char *file)
 {
 	if (!file)
 		return git_path("rr-cache/%s", rerere_id_hex(id));
 
-	return git_path("rr-cache/%s/%s", rerere_id_hex(id), file);
+	if (id->variant <= 0)
+		return git_path("rr-cache/%s/%s", rerere_id_hex(id), file);
+
+	return git_path("rr-cache/%s/%s.%d",
+			rerere_id_hex(id), file, id->variant);
 }
 
-static int is_rr_file(const char *name, const char *filename)
+static int is_rr_file(const char *name, const char *filename, int *variant)
 {
-	return !strcmp(name, filename);
+	const char *suffix;
+	char *ep;
+
+	if (!strcmp(name, filename)) {
+		*variant = 0;
+		return 1;
+	}
+	if (!skip_prefix(name, filename, &suffix) || *suffix != '.')
+		return 0;
+
+	errno = 0;
+	*variant = strtol(suffix + 1, &ep, 10);
+	if (errno || *ep)
+		return 0;
+	return 1;
 }
 
 static void scan_rerere_dir(struct rerere_dir *rr_dir)
@@ -74,10 +119,15 @@ static void scan_rerere_dir(struct rerere_dir *rr_dir)
 	if (!dir)
 		return;
 	while ((de = readdir(dir)) != NULL) {
-		if (is_rr_file(de->d_name, "postimage"))
-			rr_dir->status |= RR_HAS_POSTIMAGE;
-		else if (is_rr_file(de->d_name, "preimage"))
-			rr_dir->status |= RR_HAS_PREIMAGE;
+		int variant;
+
+		if (is_rr_file(de->d_name, "postimage", &variant)) {
+			fit_variant(rr_dir, variant);
+			rr_dir->status[variant] |= RR_HAS_POSTIMAGE;
+		} else if (is_rr_file(de->d_name, "preimage", &variant)) {
+			fit_variant(rr_dir, variant);
+			rr_dir->status[variant] |= RR_HAS_PREIMAGE;
+		}
 	}
 	closedir(dir);
 }
@@ -100,7 +150,9 @@ static struct rerere_dir *find_rerere_dir(const char *hex)
 	if (pos < 0) {
 		rr_dir = xmalloc(sizeof(*rr_dir));
 		hashcpy(rr_dir->sha1, sha1);
-		rr_dir->status = 0;
+		rr_dir->status = NULL;
+		rr_dir->status_nr = 0;
+		rr_dir->status_alloc = 0;
 		pos = -1 - pos;
 
 		/* Make sure the array is big enough ... */
@@ -118,19 +170,27 @@ static struct rerere_dir *find_rerere_dir(const char *hex)
 static int has_rerere_resolution(const struct rerere_id *id)
 {
 	const int both = RR_HAS_POSTIMAGE|RR_HAS_PREIMAGE;
+	int variant = id->variant;
 
-	return ((id->collection->status & both) == both);
+	if (variant < 0)
+		return 0;
+	return ((id->collection->status[variant] & both) == both);
 }
 
 static int has_rerere_preimage(const struct rerere_id *id)
 {
-	return (id->collection->status & RR_HAS_PREIMAGE);
+	int variant = id->variant;
+
+	if (variant < 0)
+		return 0;
+	return (id->collection->status[variant] & RR_HAS_PREIMAGE);
 }
 
 static struct rerere_id *new_rerere_id_hex(char *hex)
 {
 	struct rerere_id *id = xmalloc(sizeof(*id));
 	id->collection = find_rerere_dir(hex);
+	id->variant = -1; /* not known yet */
 	return id;
 }
 
@@ -157,16 +217,26 @@ static void read_rr(struct string_list *rr)
 		char *path;
 		unsigned char sha1[20];
 		struct rerere_id *id;
+		int variant;
 
 		/* There has to be the hash, tab, path and then NUL */
 		if (buf.len < 42 || get_sha1_hex(buf.buf, sha1))
 			die("corrupt MERGE_RR");
 
-		if (buf.buf[40] != '\t')
+		if (buf.buf[40] != '.') {
+			variant = 0;
+			path = buf.buf + 40;
+		} else {
+			errno = 0;
+			variant = strtol(buf.buf + 41, &path, 10);
+			if (errno)
+				die("corrupt MERGE_RR");
+		}
+		if (*(path++) != '\t')
 			die("corrupt MERGE_RR");
 		buf.buf[40] = '\0';
-		path = buf.buf + 41;
 		id = new_rerere_id_hex(buf.buf);
+		id->variant = variant;
 		string_list_insert(rr, path)->util = id;
 	}
 	strbuf_release(&buf);
@@ -187,9 +257,16 @@ static int write_rr(struct string_list *rr, int out_fd)
 		id = rr->items[i].util;
 		if (!id)
 			continue;
-		strbuf_addf(&buf, "%s\t%s%c",
-			    rerere_id_hex(id),
-			    rr->items[i].string, 0);
+		assert(id->variant >= 0);
+		if (0 < id->variant)
+			strbuf_addf(&buf, "%s.%d\t%s%c",
+				    rerere_id_hex(id), id->variant,
+				    rr->items[i].string, 0);
+		else
+			strbuf_addf(&buf, "%s\t%s%c",
+				    rerere_id_hex(id),
+				    rr->items[i].string, 0);
+
 		if (write_in_full(out_fd, buf.buf, buf.len) != buf.len)
 			die("unable to write rerere record");
 
@@ -752,7 +829,12 @@ static void do_rerere_one_path(struct string_list_item *rr_item,
 			       struct string_list *update)
 {
 	const char *path = rr_item->string;
-	const struct rerere_id *id = rr_item->util;
+	struct rerere_id *id = rr_item->util;
+	int variant;
+
+	if (id->variant < 0)
+		assign_variant(id);
+	variant = id->variant;
 
 	if (!has_rerere_preimage(id)) {
 		/*
@@ -761,13 +843,13 @@ static void do_rerere_one_path(struct string_list_item *rr_item,
 		 * the "preimage" file.
 		 */
 		handle_file(path, NULL, rerere_path(id, "preimage"));
-		if (id->collection->status & RR_HAS_POSTIMAGE) {
+		if (id->collection->status[variant] & RR_HAS_POSTIMAGE) {
 			const char *path = rerere_path(id, "postimage");
 			if (unlink(path))
 				die_errno("cannot unlink stray '%s'", path);
-			id->collection->status &= ~RR_HAS_POSTIMAGE;
+			id->collection->status[variant] &= ~RR_HAS_POSTIMAGE;
 		}
-		id->collection->status |= RR_HAS_PREIMAGE;
+		id->collection->status[variant] |= RR_HAS_PREIMAGE;
 		fprintf(stderr, "Recorded preimage for '%s'\n", path);
 		return;
 	} else if (has_rerere_resolution(id)) {
@@ -784,7 +866,7 @@ static void do_rerere_one_path(struct string_list_item *rr_item,
 	} else if (!handle_file(path, NULL, NULL)) {
 		/* The user has resolved it. */
 		copy_file(rerere_path(id, "postimage"), path, 0666);
-		id->collection->status |= RR_HAS_POSTIMAGE;
+		id->collection->status[variant] |= RR_HAS_POSTIMAGE;
 		fprintf(stderr, "Recorded resolution for '%s'.\n", path);
 	} else {
 		return;
@@ -919,6 +1001,7 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 
 	/* Nuke the recorded resolution for the conflict */
 	id = new_rerere_id(sha1);
+	id->variant = 0; /* for now */
 	filename = rerere_path(id, "postimage");
 	if (unlink(filename))
 		return (errno == ENOENT
diff --git a/rerere.h b/rerere.h
index faf5a23..64d38d9 100644
--- a/rerere.h
+++ b/rerere.h
@@ -18,6 +18,7 @@ extern void *RERERE_RESOLVED;
 struct rerere_dir;
 struct rerere_id {
 	struct rerere_dir *collection;
+	int variant;
 };
 
 extern int setup_rerere(struct string_list *, int);
-- 
2.8.1-273-ga2cd0f9
