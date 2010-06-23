From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [WIP PATCH 5/7] Trigger dump_node in change_dir_prop
Date: Wed, 23 Jun 2010 18:22:18 +0200
Message-ID: <1277310140-16891-6-git-send-email-artagnon@gmail.com>
References: <1277310140-16891-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <daniel@shahaf.name>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 23 18:21:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORShb-000170-QK
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 18:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296Ab0FWQVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 12:21:22 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60555 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041Ab0FWQVR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 12:21:17 -0400
Received: by mail-wy0-f174.google.com with SMTP id 11so931197wyi.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 09:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=iBQLLxFZ/0PSH6w9j85bQUOfLT33DbKdoIqeyYVHFiU=;
        b=aB38y5MiUh78JKqH6FNaKrfmidBvRBc0V1ESFecs5Hz/XcOc2cFu21nuKnVdLtgsgL
         f8Bhm2Ly7NTDwAivHHhSQ9thvxWKy0mnYv7rjHMr9BkpQNuU6V3SCMZP38piofoIFnzR
         g/8Q7WT0CUgzSPVnyw2YDUaxpOhRKVAVaCUy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=a70ZF+vwn+bzunMFT/kghxbmkA4R6GPAr2dkCTrsSQd5blVpN1jJ2l1AMlBjISpnOP
         vmSogx8BLzy4vEOLMuEkIzQjuWIyw3iL9Fyzl5//wP1ZdsC9NrEQ8lvNyQ7HM43YFFWr
         wWuVCBtdu6xx/5TrgVl6S2MMoMs8hYr7Hd2cU=
Received: by 10.227.138.148 with SMTP id a20mr7980455wbu.91.1277310076406;
        Wed, 23 Jun 2010 09:21:16 -0700 (PDT)
Received: from localhost (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id w28sm10414weq.47.2010.06.23.09.21.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jun 2010 09:21:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1277310140-16891-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149511>

Trigger dump_node to dump property length in change_dir_prop. Use the
edit_baton to store the changed property before dumping it.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 dump_editor.c |  111 +++++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 89 insertions(+), 22 deletions(-)

diff --git a/dump_editor.c b/dump_editor.c
index 00c838a..a80d711 100644
--- a/dump_editor.c
+++ b/dump_editor.c
@@ -15,12 +15,22 @@
 
 #define ARE_VALID_COPY_ARGS(p,r) ((p) && SVN_IS_VALID_REVNUM(r))
 
+static svn_boolean_t must_dump_text = FALSE, must_dump_props = FALSE;
+static svn_boolean_t text_changed = FALSE, props_changed = FALSE;
+
 struct edit_baton {
 	/* The stream to dump to: stdout */
 	svn_stream_t *stream;
 	
 	svn_revnum_t current_rev;
 	
+	/* Store the properties that changed */
+	apr_hash_t *properties;
+	apr_hash_t *del_properties; /* Value is always 0x1 */
+
+	/* Store the text delta */
+	const char *delta_text;
+
 	/* reusable buffer for writing file contents */
 	char buffer[SVN__STREAM_CHUNK_SIZE];
 	apr_size_t bufsize;
@@ -56,6 +66,41 @@ struct dir_baton {
 	apr_pool_t *pool;
 };
 
+static void write_hash_to_stringbuf(apr_hash_t *hash,
+                                    svn_stringbuf_t **strbuf,
+                                    apr_pool_t *pool) {
+	apr_hash_index_t *this;
+	*strbuf = svn_stringbuf_create("", pool);
+
+	for (this = apr_hash_first(pool, hash); this; this = apr_hash_next(this))
+	{
+		const void *key;
+		void *val;
+		apr_ssize_t keylen;
+		svn_string_t *value;
+
+		/* Get this key and val. */
+		apr_hash_this(this, &key, &keylen, &val);
+		value = val;
+
+		/* Output name length, then name. */
+		svn_stringbuf_appendcstr(*strbuf,
+		                         apr_psprintf(pool, "K %" APR_SSIZE_T_FMT "\n",
+		                                      keylen));
+
+		svn_stringbuf_appendbytes(*strbuf, (const char *) key, keylen);
+		svn_stringbuf_appendbytes(*strbuf, "\n", 1);
+
+		/* Output value length, then value. */
+		svn_stringbuf_appendcstr(*strbuf,
+		                         apr_psprintf(pool, "V %" APR_SIZE_T_FMT "\n",
+		                                      value->len));
+
+		svn_stringbuf_appendbytes(*strbuf, value->data, value->len);
+		svn_stringbuf_appendbytes(*strbuf, "\n", 1);
+	}
+	svn_stringbuf_appendbytes(*strbuf, "PROPS-END\n", 10);
+}
 
 /* Make a directory baton to represent the directory was path
    (relative to EDIT_BATON's path) is PATH.
@@ -120,10 +165,11 @@ static svn_error_t *dump_node(struct edit_baton *eb,
                               svn_revnum_t cmp_rev,
                               apr_pool_t *pool)
 {
-	apr_size_t len;
-	svn_boolean_t must_dump_text = TRUE, must_dump_props = TRUE;
+	apr_size_t len, proplen;
 	const char *compare_path = path;
 	svn_revnum_t compare_rev = eb->current_rev - 1;
+	svn_stringbuf_t *propstring;
+	svn_filesize_t content_length = 0;
 
 	/* Write out metadata headers for this file node. */
 	SVN_ERR(svn_stream_printf(eb->stream, pool,
@@ -153,13 +199,10 @@ static svn_error_t *dump_node(struct edit_baton *eb,
 		SVN_ERR(svn_stream_printf(eb->stream, pool,
 		                          SVN_REPOS_DUMPFILE_NODE_ACTION
 		                          ": change\n"));
-
-		/* either the text or props changed, or possibly both. */
-		/* SVN_ERR(svn_props_changed(&must_dump_props, */
-		/*                           compare_path, path, pool)); */
+		
+		must_dump_props = props_changed;
 		if (kind == svn_node_file)
-			/* SVN_ERR(svn_contents_changed(&must_dump_text, */
-			/*                              compare_path, path, pool)); */
+			must_dump_text = text_changed;
 		break;
       
 	case svn_node_action_replace:
@@ -223,28 +266,24 @@ static svn_error_t *dump_node(struct edit_baton *eb,
 		                          ": %s\n",
 		                          cmp_rev, cmp_path));
 
-		/* Need to decide if the copied node had any extra textual or
-		   property mods as well.  */
-		/* SVN_ERR(svn_fs_props_changed(&must_dump_props, */
-		/*                              compare_path, path, pool)); */
-		/* if (kind == svn_node_file) */
-		/* { */
+		must_dump_props = props_changed;
+		/* if (kind == svn_node_file) { */
 		/* 	svn_checksum_t *checksum; */
 		/* 	const char *hex_digest; */
-		/* 	SVN_ERR(svn_fs_contents_changed(&must_dump_text, */
-		/* 	                                compare_root, compare_path, */
-		/* 	                                eb->fs_root, path, pool)); */
+		/* 	must_dump_text = text_changed; */
 
-		/* 	SVN_ERR(svn_fs_file_checksum(&checksum, svn_checksum_md5, */
-		/* 	                             compare_root, compare_path, */
-		/* 	                             TRUE, pool)); */
+		/* 	/\* MD5 checksum *\/ */
+		/* 	SVN_ERR(svn_checksum(&checksum, svn_checksum_md5, */
+		/* 	                     compare_root, compare_path, */
+		/* 	                     TRUE, pool)); */
 		/* 	hex_digest = svn_checksum_to_cstring(checksum, pool); */
 		/* 	if (hex_digest) */
 		/* 		SVN_ERR(svn_stream_printf(eb->stream, pool, */
 		/* 		                          SVN_REPOS_DUMPFILE_TEXT_COPY_SOURCE_MD5 */
 		/* 		                          ": %s\n", hex_digest)); */
 
-		/* 	SVN_ERR(svn_fs_file_checksum(&checksum, svn_checksum_sha1, */
+		/* 	/\* SHA1 checksum *\/ */
+		/* 	SVN_ERR(svn_checksum(&checksum, svn_checksum_sha1, */
 		/* 	                             compare_root, compare_path, */
 		/* 	                             TRUE, pool)); */
 		/* 	hex_digest = svn_checksum_to_cstring(checksum, pool); */
@@ -257,7 +296,23 @@ static svn_error_t *dump_node(struct edit_baton *eb,
 	}
 	if (!must_dump_text && !must_dump_props) {
 		len = 2;
-		return svn_stream_write(eb->stream, "\n\n", &len); /* ### needed? */
+		return svn_stream_write(eb->stream, "\n\n", &len);
+	}
+
+	/* If we are supposed to dump properties, write out a property
+	   length header and generate a stringbuf that contains those
+	   property values here. */
+	if (must_dump_props) {
+		write_hash_to_stringbuf(eb->properties, &propstring, pool);
+		proplen = propstring->len;
+		content_length += proplen;
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+		                          SVN_REPOS_DUMPFILE_PROP_CONTENT_LENGTH
+		                          ": %" APR_SIZE_T_FMT "\n", proplen));
+	}
+	if (must_dump_text && (kind == svn_node_file)) {
+		/* svn_stream_t *contents; */
+		;
 	}
 	return SVN_NO_ERROR;
 }
@@ -456,6 +511,15 @@ svn_error_t *change_dir_prop(void *parent_baton,
 	struct dir_baton *db = parent_baton;
 	struct edit_baton *eb = db->edit_baton;
 
+	if (svn_property_kind(NULL, name) != svn_prop_regular_kind)
+		return SVN_NO_ERROR;
+
+	value ? apr_hash_set(eb->properties, apr_pstrdup(pool, name),
+	                     APR_HASH_KEY_STRING, svn_string_dup(value, pool)) :
+		apr_hash_set(eb->del_properties, apr_pstrdup(pool, name),
+		             APR_HASH_KEY_STRING, (void *)0x1);
+	props_changed = TRUE;
+	
 	/* This function is what distinguishes between a directory that is
 	   opened to merely get somewhere, vs. one that is opened because it
 	   *actually* changed by itself.  */
@@ -479,6 +543,9 @@ svn_error_t *get_dump_editor(const svn_delta_editor_t **editor,
 	svn_stream_for_stdout(&(eb->stream), pool);
 	eb->bufsize = sizeof(eb->buffer);
 	eb->current_rev = to_rev;
+	eb->properties = apr_hash_make(pool);
+	eb->del_properties = apr_hash_make(pool);
+	eb->delta_text = apr_pcalloc(pool, sizeof(const char *));
 
 	dump_editor->open_root = open_root;
 	dump_editor->delete_entry = delete_entry;
-- 
1.7.1
