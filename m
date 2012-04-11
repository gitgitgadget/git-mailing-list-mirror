From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/4] fast-import: allow object_table to grow dynamically
Date: Wed, 11 Apr 2012 07:13:42 -0500
Message-ID: <20120411121342.GC19568@burratino>
References: <1301572798-9973-1-git-send-email-david.barr@cordelta.com>
 <20120411121259.GB19568@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 14:13:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHwQr-00080V-UM
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 14:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758860Ab2DKMNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 08:13:49 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48650 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945Ab2DKMNt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 08:13:49 -0400
Received: by iagz16 with SMTP id z16so1197388iag.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 05:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XvlclcjXgFoUnA5q4jDH1X8uzStGN8ngwKzYVadQ/YE=;
        b=ijp4pykHNMtdZRgcKY7MYPQnTLz8LmN/nZtXVLocQL4Ycs4juVVeGc4fBc4/BeBz6l
         TpAdpsHiHcLG0f3Ywh92zvKXeQy4EJ6Md3Ba0y4Su7qkm63dN8UsfMHuyiGEwzn3kZ4I
         4HUi7NxBHbc8ho/RbsJfTiVG0iCJcqOQO/Qfu3T+OjTUIv64+JzPxmho3HgH+twLLeqe
         jdhN2fuPw+rEeQat5+265v5blEA+2c4vPAmik7zbVQhWtgtjL0j72w2R9V1WN5PZlErv
         ehnSqhCCNxfHmB3eFrg3Yk6eBhCo40VGpGBvSAoOiOnSBRU27hu3TcEi2z6NQ8rH6Aoo
         d9Zg==
Received: by 10.50.194.194 with SMTP id hy2mr1692126igc.52.1334146428653;
        Wed, 11 Apr 2012 05:13:48 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id cw5sm24858077igc.17.2012.04.11.05.13.47
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 05:13:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120411121259.GB19568@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195172>

From: David Barr <david.barr@cordelta.com>
Date: Thu, 31 Mar 2011 22:59:58 +1100

The current custom hash tables in fast-import.c do not grow.  This
causes poor performance for very large imports.

Shawn O. Pearce writes:

> I can tell you why its fixed size... when I wrote fast-import to
> support the Mozilla repository import, we had an estimate on the
> number of objects that we needed fast-import to handle in a given run.
> From that estimate we concluded that a table of 2^16 was sufficiently
> large enough, as the hash chains would only be some small N long given
> the total number of objects we needed to handle for Mozilla.  Doubling
> that into 2^17 or larger wasn't useful, and using a smaller table like
> 2^14 produced too long of a chain.
>
> Once this code was working, we moved on to other features, and never
> reconsidered the table size.  This table should be growing if the
> initial 2^16 isn't big enough.  Its just that nobody has ever noticed
> that I hardcoded the size.  :-)

Fortunately, we have struct hash_table and friends so there's no need
to write cumbersome hash table growth code.

[jn: using native endianness for hash, new commit message; with
 init_hash call, even though it's not currently needed]

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 fast-import.c |   27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 78d97868..a79a1260 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -313,7 +313,7 @@ static off_t pack_size;
 /* Table of objects we've written. */
 static unsigned int object_entry_alloc = 5000;
 static struct object_entry_pool *blocks;
-static struct object_entry *object_table[1 << 16];
+static struct hash_table object_table;
 static struct mark_set *marks;
 static const char *export_marks_file;
 static const char *import_marks_file;
@@ -553,11 +553,18 @@ static struct object_entry *new_object(unsigned char *sha1)
 	return e;
 }
 
+static unsigned int hash_sha1(const unsigned char *sha1)
+{
+	unsigned int h;
+	memcpy(&h, sha1, sizeof(unsigned int));
+	return h;
+}
+
 static struct object_entry *find_object(unsigned char *sha1)
 {
-	unsigned int h = sha1[0] << 8 | sha1[1];
+	unsigned int h = hash_sha1(sha1);
 	struct object_entry *e;
-	for (e = object_table[h]; e; e = e->next)
+	for (e = lookup_hash(h, &object_table); e; e = e->next)
 		if (!hashcmp(sha1, e->idx.sha1))
 			return e;
 	return NULL;
@@ -565,8 +572,9 @@ static struct object_entry *find_object(unsigned char *sha1)
 
 static struct object_entry *insert_object(unsigned char *sha1)
 {
-	unsigned int h = sha1[0] << 8 | sha1[1];
-	struct object_entry *e = object_table[h];
+	unsigned int h = hash_sha1(sha1);
+	struct object_entry *e = lookup_hash(h, &object_table);
+	void **pos;
 
 	while (e) {
 		if (!hashcmp(sha1, e->idx.sha1))
@@ -575,9 +583,13 @@ static struct object_entry *insert_object(unsigned char *sha1)
 	}
 
 	e = new_object(sha1);
-	e->next = object_table[h];
+	e->next = NULL;
 	e->idx.offset = 0;
-	object_table[h] = e;
+	pos = insert_hash(h, e, &object_table);
+	if (pos) {
+		e->next = *pos;
+		*pos = e;
+	}
 	return e;
 }
 
@@ -3261,6 +3273,7 @@ int main(int argc, const char **argv)
 	atom_table = xcalloc(atom_table_sz, sizeof(struct atom_str*));
 	branch_table = xcalloc(branch_table_sz, sizeof(struct branch*));
 	avail_tree_table = xcalloc(avail_tree_table_sz, sizeof(struct avail_tree_content*));
+	init_hash(&object_table);
 	marks = pool_calloc(1, sizeof(struct mark_set));
 
 	global_argc = argc;
-- 
1.7.10
