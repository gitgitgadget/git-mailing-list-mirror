From: Bill Zaumen <bill.zaumen+git@gmail.com>
Subject: [PATCH 4/6] Add digests to commit objects.
Date: Tue, 20 Dec 2011 23:12:10 -0800
Message-ID: <1324451530.1684.22.camel@yos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 21 08:12:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdGLU-0000HY-6C
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 08:12:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186Ab1LUHMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 02:12:07 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46579 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab1LUHMF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 02:12:05 -0500
Received: by iaeh11 with SMTP id h11so11462089iae.19
        for <git@vger.kernel.org>; Tue, 20 Dec 2011 23:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:subject:from:to:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=qdQYgCg6537qAn++rQ4ui0QTg1wJd0syBdrGuyk+d9k=;
        b=IZPwY8vWJjZ5VcLsKUq/5lOATJ6aC7Fc10MHazBMozJ7vGnNfVqSoFK3VGZ18Ubjqe
         eD/f23Gf0BTtZya0M7H1As1INrQhX5UTjZfm1NvPSs7Xm/P7eIbCK6FaBSsI33YvX7sj
         y3PD6H8ht7oI/b3TA9i361ZXf4hy1vNwf3cFQ=
Received: by 10.50.181.197 with SMTP id dy5mr1617682igc.13.1324451525256;
        Tue, 20 Dec 2011 23:12:05 -0800 (PST)
Received: from [192.168.1.20] (adsl-209-233-20-69.dsl.snfc21.pacbell.net. [209.233.20.69])
        by mx.google.com with ESMTPS id cv10sm22971817igc.0.2011.12.20.23.12.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Dec 2011 23:12:04 -0800 (PST)
X-Mailer: Evolution 2.30.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187554>

When COMMIT_DIGEST is defined in the Makefile, a new
header is added to commits. The header is named 'digest'
and is a digest of the digests associated with the
commit's tree (computed recursively) and parents, and
of the other fields. This digest is included in the
SHA-1 hash computation and the commit's digest.

A function named verify_commit allows the digest to
be recomputed and checked.

Signed-off-by: Bill Zaumen <bill.zaumen+git@gmail.com>
---
 commit.c |  436 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 commit.h |   11 ++
 2 files changed, 443 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index b781274..ac0d492 100644
--- a/commit.c
+++ b/commit.c
@@ -6,11 +6,395 @@
 #include "diff.h"
 #include "revision.h"
 #include "notes.h"
+#ifdef PACKDB
+#include "packdb.h"
+#endif
 
 int save_commit_buffer = 1;
 
 const char *commit_type = "commit";
 
+struct commit_mds_context {
+	unsigned long missing;
+	mdigest_context_t context;
+#ifdef PACKDB
+	int packdb_opened;
+#endif /* PACKDB */
+};
+
+#if defined(COMMIT_DIGEST)||defined(PACKDB_TEST)||defined(COMMIT_DIGEST_TEST)
+static int get_objects_mds_f(const unsigned char *sha1,
+			  const char *basebuf, int baselen,
+			  const char *path, unsigned int mode, int stage,
+			  void *context)
+{
+	struct commit_mds_context *c = (struct commit_mds_context *)context;
+	mdigest_t digest;
+	unsigned long size;
+	int type;
+
+	if (S_ISGITLINK(mode)) {
+		/*
+		 * Submodule entry - SHA-1 of a commit in the submodule
+		 * with no entry in our repository.
+		 */
+		mdigest_Update(&c->context, sha1, 20);
+		return -1;
+	}
+	if (!has_sha1_file(sha1)) {
+		c->missing++;
+		return -1;
+	}
+	if (has_sha1_file_digest(sha1, &digest)) {
+		int wcode = get_mdigest_wcode(&digest);
+		unsigned char ucwcode = (unsigned char) (wcode & 0xff);
+		mdigest_Update(&c->context, &ucwcode, 1);
+		mdigest_Update(&c->context, get_mdigest_buffer(&digest),
+			       get_mdigest_len(&digest));
+#if defined(PACKDB) && defined (PACKDB_TEST)
+		{
+		  static int firsttime = 1;
+		  mdigest_t xdigest;
+		  if (!c->packdb_opened) {
+		    packdb_open();
+		    c->packdb_opened = 1;
+		    firsttime = 0;
+		  }
+		  if (firsttime) {
+		    if (!packdb_lookup(sha1, &xdigest)) {
+		      packdb_process(sha1, &digest);
+		      packdb_lookup(sha1, &xdigest);
+		      if (mdigest_tst(&digest, &xdigest)) {
+			die("digest for %s failed with packdb\n",
+			    sha1_to_hex(sha1));
+		      }
+		    }
+		  }
+		}
+#endif
+	} else {
+		enum object_type xtype;
+		unsigned long xsize;
+		mdigest_t xdigest;
+		unsigned char xsha1[20];
+		int wcode;
+		unsigned char ucwcode;
+#ifdef PACKDB
+		if (!c->packdb_opened) {
+			packdb_open();
+			c->packdb_opened = 1;
+		}
+		if (!packdb_lookup(sha1, &xdigest)) {
+#endif /* PACKDB */
+			void *data = read_sha1_file(sha1, &xtype, &xsize);
+			hash_sha1_file_extended(data, xsize,
+						typename(xtype),
+						xsha1,
+						&xdigest);
+			free(data);
+#ifdef PACKDB
+			packdb_process(sha1, &xdigest);
+		  }
+#endif /* PACKDB */
+		wcode = get_mdigest_wcode(&xdigest);
+		ucwcode = (unsigned char) (wcode & 0xff);
+		mdigest_Update(&c->context, &ucwcode, 1);
+		mdigest_Update(&c->context, get_mdigest_buffer(&xdigest),
+			       get_mdigest_len(&xdigest));
+	}
+	type = sha1_object_info(sha1, &size);
+	switch(type) {
+	case OBJ_TREE:
+	  return (S_ISDIR(mode))? READ_TREE_RECURSIVE: 0;
+	case OBJ_BLOB:
+		return 0;
+	default:
+		if (type <= OBJ_NONE) {
+		  c->missing++;
+		}
+		return 0;
+	}
+}
+
+/*
+ * Works with a tree or a commit sha1 - recursively traverses the trees
+ * and computes the CRC of each blob's CRC. With a commit sha1, the
+ * caller must provide the 'parents' list - we sometimes call this
+ * function with the commit-object's tree before the sha1 value is
+ * computed.
+ */
+static int get_objects_mds(const unsigned char *sha1,
+			   struct commit_list *parents,
+			   const char *author, size_t author_len,
+			   const char *committer, size_t committer_len,
+			   const char *encoding, size_t encoding_len,
+			   struct commit_extra_header *extra,
+			   const char *msg, size_t msg_len,
+			   mdigest_t *digestp)
+{
+	struct commit_mds_context context;
+	struct tree *tree = parse_tree_indirect(sha1);
+	struct pathspec ps;
+	mdigest_t xdigest;
+	struct commit_extra_header *extra_head = extra;
+	mdigest_Init(&context.context, MDIGEST_DEFAULT);
+	context.missing = 0;
+#ifdef PACKDB
+	context.packdb_opened = 0;
+#endif /* PACKDB */
+
+	if (tree == NULL) {
+		return -1;
+	} else {
+		init_pathspec(&ps, NULL);
+		parse_tree(tree);
+		if (has_sha1_file_digest(tree->object.sha1, &xdigest)) {
+			int wcode = get_mdigest_wcode(&xdigest);
+			unsigned char ucwcode =
+				(unsigned char) (wcode & 0xff);
+			mdigest_Update(&context.context, &ucwcode, 1);
+			mdigest_Update(&context.context,
+				       get_mdigest_buffer(&xdigest),
+				       get_mdigest_len(&xdigest));
+		} else {
+			enum object_type xtype;
+			unsigned long xsize;
+			mdigest_t xdigest;
+			unsigned char xsha1[20];
+			int wcode;
+			unsigned char ucwcode;
+#ifdef PACKDB
+			if (!context.packdb_opened) {
+				packdb_open();
+				context.packdb_opened = 1;
+			}
+			if (!packdb_lookup(sha1, &xdigest)) {
+#endif /* PACKDB */
+
+				void *data = read_sha1_file(sha1, &xtype,
+							    &xsize);
+				hash_sha1_file_extended(data, xsize,
+							typename(xtype),
+							xsha1,
+							&xdigest);
+				free(data);
+#ifdef PACKDB
+				packdb_process(sha1, &xdigest);
+			}
+#endif /* PACKDB */
+			wcode = get_mdigest_wcode(&xdigest);
+			ucwcode = (unsigned char)(wcode & 0xff);
+			mdigest_Update(&context.context, &ucwcode, 1);
+			mdigest_Update(&context.context,
+				       get_mdigest_buffer(&xdigest),
+				       get_mdigest_len(&xdigest));
+		}
+		read_tree_recursive(tree, "", 0, 0, &ps, get_objects_mds_f,
+				    &context);
+		while (parents) {
+			/*
+			 * Include the message digests of the parent commits.
+			 */
+			struct commit_list *next = parents->next;
+			if (!has_sha1_file(parents->item->object.sha1)) {
+				return -1;
+			} else if (has_sha1_file_digest
+				   (parents->item->object.sha1, &xdigest)) {
+				int wcode = get_mdigest_wcode(&xdigest);
+				unsigned char ucwcode =
+					(unsigned char) (wcode & 0xff);
+				mdigest_Update(&context.context, &ucwcode, 1);
+				mdigest_Update(&context.context,
+					       get_mdigest_buffer(&xdigest),
+					       get_mdigest_len(&xdigest));
+			} else {
+				enum object_type xtype;
+				unsigned long xsize;
+				mdigest_t xdigest;
+				unsigned char xsha1[20];
+				int wcode;
+				unsigned char ucwcode;
+#ifdef PACKDB
+				if (!context.packdb_opened) {
+					packdb_open();
+					context.packdb_opened = 1;
+				}
+				if (!packdb_lookup(sha1, &xdigest)) {
+#endif /* PACKDB */
+
+					void *data = read_sha1_file(sha1,
+								    &xtype,
+								    &xsize);
+					hash_sha1_file_extended(data, xsize,
+								typename(xtype),
+								xsha1,
+								&xdigest);
+					free(data);
+#ifdef PACKDB
+					packdb_process(sha1, &xdigest);
+				}
+#endif /* PACKDB */
+				wcode = get_mdigest_wcode(&xdigest);
+				ucwcode = (unsigned char)(wcode & 0xff);
+				mdigest_Update(&context.context, &ucwcode, 1);
+				mdigest_Update(&context.context,
+					       get_mdigest_buffer(&xdigest),
+					       get_mdigest_len(&xdigest));
+			}
+			parents = next;
+		}
+#ifdef PACKDB
+		if (context.packdb_opened) packdb_close();
+#endif /* PACKDB */
+		if (msg && author && committer && digestp) {
+			mdigest_Update(&context.context, author, author_len);
+			mdigest_Update(&context.context, committer,
+				       committer_len);
+			if (encoding) mdigest_Update(&context.context, encoding,
+						     encoding_len);
+			while (extra) {
+			  mdigest_Update(&context.context, extra->key,
+					 strlen(extra->key));
+			  mdigest_Update(&context.context, " ", 1);
+			  mdigest_Update(&context.context, extra->value,
+					 extra->len);
+			  mdigest_Update(&context.context, "\n", 1);
+			  extra = extra->next;
+			}
+			free_commit_extra_headers(extra_head);
+			mdigest_Update(&context.context, msg, msg_len);
+		}
+		if (digestp) mdigest_Final(digestp, &context.context);
+		return ((context.missing == 0)? 0: -1);
+	}
+}
+#endif /* defined(COMMIT_DIGEST)||defined(PACKDB_TEST)||defined(COMMIT_DIGEST_TEST) */
+
+int verify_commit(struct commit *commit) {
+#ifdef COMMIT_DIGEST
+	if (save_commit_buffer) {
+		mdigest_t edigest;
+		mdigest_t digest;
+		const char *author = NULL;
+		size_t author_len = 0;
+		const char *committer = NULL;
+		size_t committer_len = 0;
+		const char *encoding = NULL;
+		size_t encoding_len = 0;
+		const char *msg = NULL;
+		size_t msg_len = 0;
+		const char *mdstring = NULL;
+		size_t mdstring_len = 0;
+		const char *bufptr;
+		const char *tail;
+		struct commit_extra_header *extra = NULL;
+
+		parse_commit(commit);
+		extra = read_commit_extra_header_lines(commit->buffer,
+						       commit->buffer_len);
+		bufptr = commit->buffer;
+		tail = bufptr + commit->buffer_len;
+		while (*bufptr != '\n' && bufptr < tail) {
+			if (*bufptr == 'a') {
+				if ((bufptr + 7) < tail) {
+					if (memcmp(bufptr, "author ", 7) == 0) {
+						bufptr += 7;
+						author = bufptr;
+						while (*bufptr != '\n' &&
+						       bufptr < tail) {
+							bufptr++;
+						}
+						author_len = bufptr - author;
+					} else while (*bufptr != '\n' &&
+						      bufptr < tail) bufptr++;
+					if (bufptr < tail) bufptr++;
+				}
+			} else if (*bufptr == 'c') {
+				if ((bufptr + 10) < tail) {
+					if (memcmp(bufptr,
+						   "committer ", 10) == 0) {
+						bufptr += 10;
+						committer = bufptr;
+						while (*bufptr != '\n' &&
+						       bufptr < tail) {
+							bufptr++;
+						}
+						committer_len =
+							bufptr - committer;
+					} else  while (*bufptr != '\n' &&
+						      bufptr < tail) bufptr++;
+					if (bufptr < tail) bufptr++;
+				}
+			} else if(*bufptr == 'e') {
+				if ((bufptr + 9) < tail) {
+					if (memcmp(bufptr,
+						   "encoding ", 9) == 0) {
+						bufptr += 9;
+						encoding = bufptr;
+						while (*bufptr != '\n' &&
+						       bufptr < tail) {
+							bufptr++;
+						}
+						encoding_len =
+							bufptr - encoding;
+					} else  while (*bufptr != '\n' &&
+						      bufptr < tail) bufptr++;
+					if (bufptr < tail) bufptr++;
+				}
+			} else if (*bufptr == 'd') {
+				if ((bufptr + 7) < tail) {
+					if (memcmp(bufptr, "digest ", 7) == 0) {
+						bufptr += 7;
+						mdstring = bufptr;
+						while (*bufptr != '\n' &&
+						       bufptr < tail) {
+							bufptr++;
+						}
+						mdstring_len =
+							bufptr - mdstring;
+					} else  while (*bufptr != '\n' &&
+						      bufptr < tail) bufptr++;
+					if (bufptr < tail) bufptr++;
+				}
+			} else {
+				while (*bufptr != '\n' && bufptr < tail)
+					bufptr++;
+				if (bufptr < tail) bufptr++;
+			}
+		}
+		if (*bufptr == '\n' && bufptr < tail) {
+			bufptr++;
+			msg = bufptr;
+			msg_len = tail - bufptr;
+		}
+		if (mdstring &&
+		    get_mdigest_from_external_hex(&edigest, mdstring) < 0) {
+			return -1;
+		}
+		if (author && committer && msg) {
+			if (mdstring == NULL) return 0;
+			if (get_objects_mds(commit->object.sha1,
+					    commit->parents,
+					    author, author_len,
+					    committer, committer_len,
+					    encoding, encoding_len,
+					    extra,
+					    msg, msg_len,
+					    &digest)) {
+				return -1;
+			}
+			return mdigest_tst(&edigest, &digest);
+		} else {
+			return -1;
+		}
+	} else {
+	  return 0;
+	}
+#else /* COMMIT_DIGEST */
+	return 0;
+#endif /* COMMIT_DIGEST */
+}
+
 static struct commit *check_commit(struct object *obj,
 				   const unsigned char *sha1,
 				   int quiet)
@@ -325,6 +709,9 @@ int parse_commit(struct commit *item)
 	ret = parse_commit_buffer(item, buffer, size);
 	if (save_commit_buffer && !ret) {
 		item->buffer = buffer;
+#ifdef COMMIT_DIGEST
+		item->buffer_len = (size_t) size;
+#endif
 		return 0;
 	}
 	free(buffer);
@@ -916,6 +1303,9 @@ static inline int standard_header_field(const char *field, size_t len)
 {
 	return ((len == 4 && !memcmp(field, "tree ", 5)) ||
 		(len == 6 && !memcmp(field, "parent ", 7)) ||
+#ifdef COMMIT_DIGEST
+		(len == 6 && !memcmp(field, "digest ", 7)) ||
+#endif
 		(len == 6 && !memcmp(field, "author ", 7)) ||
 		(len == 9 && !memcmp(field, "committer ", 10)) ||
 		(len == 8 && !memcmp(field, "encoding ", 9)));
@@ -998,12 +1388,43 @@ int commit_tree_extended(const char *msg, unsigned char *tree,
 	int result;
 	int encoding_is_utf8;
 	struct strbuf buffer;
+	static char committer[1000];
+	const char *encoding = NULL;
+#if defined(COMMIT_DIGEST) || defined (COMMIT_DIGEST_TEST)
+	mdigest_t digest;
+#endif /* defined(COMMIT_DIGEST) || defined(PACKDB_TEST) */
+	/*
+	 * git_committer_info returns a static buffer of size 1000, so
+	 * we have to copy it - assume git_committer_info does necessary
+	 * buffer-overflow tests.
+	 */
+	strcpy (committer, git_committer_info(IDENT_ERROR_ON_NO_NAME));
 
 	assert_sha1_type(tree, OBJ_TREE);
 
 	/* Not having i18n.commitencoding is the same as having utf-8 */
 	encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
+	if (!encoding_is_utf8)
+		encoding = git_commit_encoding;
 
+	/* Person/date information setup*/
+	if (!author)
+		author = git_author_info(IDENT_ERROR_ON_NO_NAME);
+#if defined(COMMIT_DIGEST) || defined(PACKDB_TEST) || defined(COMMIT_DIGEST_TEST)
+	/*
+	 * Have all the pieces so compute the message digest. We do it here
+	 * because the list 'parents' will be destroyed by the following loop.
+	 */
+	if (get_objects_mds(tree, parents,
+			    author, (author? strlen(author): 0),
+			    committer, strlen(committer),
+			    encoding, (encoding? strlen(encoding): 0),
+			    extra,
+			    msg, (msg? strlen(msg): 0),
+			    &digest)) {
+		die("could not compute message digest for commit");
+	}
+#endif /* defined(COMMIT_DIGEST) || defined(PACKDB_TEST)  || defined(COMMIT_DIGEST_TEST)*/
 	strbuf_init(&buffer, 8192); /* should avoid reallocs for the headers */
 	strbuf_addf(&buffer, "tree %s\n", sha1_to_hex(tree));
 
@@ -1023,17 +1444,19 @@ int commit_tree_extended(const char *msg, unsigned char *tree,
 	}
 
 	/* Person/date information */
-	if (!author)
-		author = git_author_info(IDENT_ERROR_ON_NO_NAME);
 	strbuf_addf(&buffer, "author %s\n", author);
-	strbuf_addf(&buffer, "committer %s\n", git_committer_info(IDENT_ERROR_ON_NO_NAME));
+	strbuf_addf(&buffer, "committer %s\n", committer);
+
 	if (!encoding_is_utf8)
 		strbuf_addf(&buffer, "encoding %s\n", git_commit_encoding);
-
 	while (extra) {
 		add_extra_header(&buffer, extra);
 		extra = extra->next;
 	}
+#ifdef COMMIT_DIGEST
+	strbuf_addf(&buffer, "digest %s\n", mdigest_to_external_hex(&digest));
+#endif /* COMMIT_DIGEST */
+
 	strbuf_addch(&buffer, '\n');
 
 	/* And add the comment */
@@ -1045,6 +1468,11 @@ int commit_tree_extended(const char *msg, unsigned char *tree,
 
 	result = write_sha1_file(buffer.buf, buffer.len, commit_type, ret);
 	strbuf_release(&buffer);
+#if defined(COMMIT_DIGEST) && defined (COMMIT_DIGEST_TEST)
+	if (verify_commit(lookup_commit(ret))) {
+	    die("commit verification failed for %s\n", sha1_to_hex(ret));
+	  }
+#endif
 	return result;
 }
 
diff --git a/commit.h b/commit.h
index 3745f12..7a91519 100644
--- a/commit.h
+++ b/commit.h
@@ -5,6 +5,7 @@
 #include "tree.h"
 #include "strbuf.h"
 #include "decorate.h"
+#include "mdigest.h"
 
 struct commit_list {
 	struct commit *item;
@@ -19,6 +20,9 @@ struct commit {
 	struct commit_list *parents;
 	struct tree *tree;
 	char *buffer;
+#ifdef COMMIT_DIGEST
+	size_t buffer_len;
+#endif
 };
 
 extern int save_commit_buffer;
@@ -218,4 +222,11 @@ struct merge_remote_desc {
  */
 struct commit *get_merge_parent(const char *name);
 
+/*
+ * Returns 0 if OK or if save_commit_buffer == 0 or if COMMIT_DIGEST was
+ * not defined during compilation; non-zero otherwise.  If a commit does
+ * not have a digest field, 0 is returned.
+ */
+extern int verify_commit(struct commit *commit);
+
 #endif /* COMMIT_H */
-- 
1.7.1
