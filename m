From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [WIP PATCH 6/7] Add file_baton and trigger dump_node in change_file_prop
Date: Wed, 23 Jun 2010 18:22:19 +0200
Message-ID: <1277310140-16891-7-git-send-email-artagnon@gmail.com>
References: <1277310140-16891-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <daniel@shahaf.name>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 23 18:21:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORShu-0001OF-U7
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 18:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850Ab0FWQV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 12:21:28 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:46926 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224Ab0FWQVV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 12:21:21 -0400
Received: by mail-ww0-f46.google.com with SMTP id 33so1178857wwc.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 09:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=CNchtolY2gMQOjvhLmLH75P3YSBCwt/bybe7DqWGpe0=;
        b=Rqip6lKvcErTwob8TDMFehCgxEQzYm1opPJUHARzaejN+H59M7DcSB5jlBsoiz4JCo
         7jg7CdCch3ESNppDS6F3dWmfIXzuC7u4VH84wY5mO9xnWOHnn5kFsofWTaDBCM8yWHEf
         4tYkImFS856ml3tmD86graW4FG2zsjYVpJXfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HB6msQhIFfynKXZTVs9joh/dV5eVNpfwfdYnHIx2AYVQoRhB1x0MSgujIYpp7AFGoY
         ATi8V0+NSUaMwTgw5/mYe86Q3drQBcyIHCveLwScsSf3ZZfvDez8X2N2HQbMB5FhpjGC
         f46KK4Nj0OeQdFAq1LWc+u2V/Q4h3pqIQ0esI=
Received: by 10.227.134.16 with SMTP id h16mr7868642wbt.69.1277310080866;
        Wed, 23 Jun 2010 09:21:20 -0700 (PDT)
Received: from localhost (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id p17sm47397796wbe.14.2010.06.23.09.21.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jun 2010 09:21:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1277310140-16891-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149517>

Add a file_baton structure, and fill it in in open_file and add_file
functions. It is to be used by apply_textdelta and change_file_prop
functions. Trigger dump_node in change_file_prop. Dump the actual
properties along with the property lengths.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 dump_editor.c |  100 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 89 insertions(+), 11 deletions(-)

diff --git a/dump_editor.c b/dump_editor.c
index a80d711..7bd00a4 100644
--- a/dump_editor.c
+++ b/dump_editor.c
@@ -15,7 +15,6 @@
 
 #define ARE_VALID_COPY_ARGS(p,r) ((p) && SVN_IS_VALID_REVNUM(r))
 
-static svn_boolean_t must_dump_text = FALSE, must_dump_props = FALSE;
 static svn_boolean_t text_changed = FALSE, props_changed = FALSE;
 
 struct edit_baton {
@@ -66,9 +65,16 @@ struct dir_baton {
 	apr_pool_t *pool;
 };
 
+struct file_baton {
+	/* Store the path of the file */
+	const char *path;
+	struct edit_baton *eb;
+};
+
 static void write_hash_to_stringbuf(apr_hash_t *hash,
                                     svn_stringbuf_t **strbuf,
-                                    apr_pool_t *pool) {
+                                    apr_pool_t *pool)
+{
 	apr_hash_index_t *this;
 	*strbuf = svn_stringbuf_create("", pool);
 
@@ -120,7 +126,8 @@ struct dir_baton *make_dir_baton(const char *path,
                                  void *edit_baton,
                                  void *parent_dir_baton,
                                  svn_boolean_t added,
-                                 apr_pool_t *pool) {
+                                 apr_pool_t *pool)
+{
 	struct edit_baton *eb = edit_baton;
 	struct dir_baton *pb = parent_dir_baton;
 	struct dir_baton *new_db = apr_pcalloc(pool, sizeof(*new_db));
@@ -156,6 +163,18 @@ struct dir_baton *make_dir_baton(const char *path,
 	return new_db;
 }
 
+struct file_baton *make_file_baton(struct edit_baton *eb,
+                                   const char *path,
+                                   apr_pool_t *pool)
+{
+	struct file_baton *new_fb = apr_pcalloc(pool, sizeof(struct file_baton));
+	new_fb->path = apr_pcalloc(pool, sizeof(const char *));
+	new_fb->path = path;
+	new_fb->eb = eb;
+
+	return new_fb;
+}
+
 static svn_error_t *dump_node(struct edit_baton *eb,
                               const char *path,    /* an absolute path. */
                               svn_node_kind_t kind,
@@ -170,6 +189,7 @@ static svn_error_t *dump_node(struct edit_baton *eb,
 	svn_revnum_t compare_rev = eb->current_rev - 1;
 	svn_stringbuf_t *propstring;
 	svn_filesize_t content_length = 0;
+	svn_boolean_t must_dump_text = FALSE, must_dump_props = FALSE;
 
 	/* Write out metadata headers for this file node. */
 	SVN_ERR(svn_stream_printf(eb->stream, pool,
@@ -310,10 +330,44 @@ static svn_error_t *dump_node(struct edit_baton *eb,
 		                          SVN_REPOS_DUMPFILE_PROP_CONTENT_LENGTH
 		                          ": %" APR_SIZE_T_FMT "\n", proplen));
 	}
+
+	/* If we are supposed to dump text, write out a text length header
+	   here, and an MD5 checksum (if available). */
 	if (must_dump_text && (kind == svn_node_file)) {
-		/* svn_stream_t *contents; */
 		;
 	}
+
+	/* 'Content-length:' is the last header before we dump the content,
+	   and is the sum of the text and prop contents lengths.  We write
+	   this only for the benefit of non-Subversion RFC-822 parsers. */
+	SVN_ERR(svn_stream_printf(eb->stream, pool,
+	                          SVN_REPOS_DUMPFILE_CONTENT_LENGTH
+	                          ": %" SVN_FILESIZE_T_FMT "\n\n",
+	                          content_length));
+
+	/* Now dump the text and properties */
+	if (must_dump_props)
+	{
+		len = propstring->len;
+		SVN_ERR(svn_stream_write(eb->stream, propstring->data, &len));
+	}
+	/* if (must_dump_text && (kind == svn_node_file)) */
+	/* { */
+	/* 	svn_stream_t *contents; */
+
+	/* 	if (delta_file) */
+	/* 	{ */
+	/* 		/\* Make sure to close the underlying file when the stream is */
+	/* 		   closed. *\/ */
+	/* 		contents = svn_stream_from_aprfile2(delta_file, FALSE, pool); */
+	/* 	} */
+	/* 	else */
+	/* 		SVN_ERR(svn_fs_file_contents(&contents, eb->fs_root, path, pool)); */
+
+	/* 	SVN_ERR(svn_stream_copy3(contents, svn_stream_disown(eb->stream, pool), */
+	/* 	                         NULL, NULL, pool)); */
+	/* } */
+
 	return SVN_NO_ERROR;
 }
 svn_error_t *open_root(void *edit_baton,
@@ -467,12 +521,12 @@ svn_error_t *add_file(const char *path,
 		/* delete the path, it's now been dumped. */
 		apr_hash_set(pb->deleted_entries, path, APR_HASH_KEY_STRING, NULL);
 
-	/* TODO: Store the delta in file_baton */
-	*file_baton = NULL;
+	/* Build a nice file baton to pass to change_file_prop and apply_textdelta */
+	*file_baton = make_file_baton(eb, path, pool);
+
 	return SVN_NO_ERROR;
 }
 
-
 svn_error_t *open_file(const char *path,
                        void *parent_baton,
                        svn_revnum_t ancestor_revision,
@@ -497,9 +551,10 @@ svn_error_t *open_file(const char *path,
 	SVN_ERR(dump_node(eb, path,
 	                  svn_node_file, svn_node_action_change,
 	                  FALSE, cmp_path, cmp_rev, pool));
-
-	/* TODO: Store the delta in file_baton */
-	*file_baton = NULL;
+	
+	/* Build a nice file baton to pass to change_file_prop and apply_textdelta */
+	*file_baton = make_file_baton(eb, path, pool);
+	
 	return SVN_NO_ERROR;
 }
 
@@ -532,6 +587,29 @@ svn_error_t *change_dir_prop(void *parent_baton,
 	return SVN_NO_ERROR;
 }
 
+svn_error_t *change_file_prop(void *file_baton,
+                              const char *name,
+                              const svn_string_t *value,
+                              apr_pool_t *pool)
+{
+	struct file_baton *fb = file_baton;
+	
+	if (svn_property_kind(NULL, name) != svn_prop_regular_kind)
+		return SVN_NO_ERROR;
+
+	value ? apr_hash_set(fb->eb->properties, apr_pstrdup(pool, name),
+	                     APR_HASH_KEY_STRING, svn_string_dup(value, pool)) :
+		apr_hash_set(fb->eb->del_properties, apr_pstrdup(pool, name),
+		             APR_HASH_KEY_STRING, (void *)0x1);
+	props_changed = TRUE;
+	
+	SVN_ERR(dump_node(fb->eb, fb->path,
+	                  svn_node_dir, svn_node_action_change,
+	                  FALSE, NULL, 0, pool));
+
+	return SVN_NO_ERROR;
+}
+
 svn_error_t *get_dump_editor(const svn_delta_editor_t **editor,
                              void **edit_baton,
                              svn_revnum_t to_rev,
@@ -545,7 +623,6 @@ svn_error_t *get_dump_editor(const svn_delta_editor_t **editor,
 	eb->current_rev = to_rev;
 	eb->properties = apr_hash_make(pool);
 	eb->del_properties = apr_hash_make(pool);
-	eb->delta_text = apr_pcalloc(pool, sizeof(const char *));
 
 	dump_editor->open_root = open_root;
 	dump_editor->delete_entry = delete_entry;
@@ -553,6 +630,7 @@ svn_error_t *get_dump_editor(const svn_delta_editor_t **editor,
 	dump_editor->open_directory = open_directory;
 	dump_editor->close_directory = close_directory;
 	dump_editor->change_dir_prop = change_dir_prop;
+	dump_editor->change_file_prop = change_file_prop;	
 	dump_editor->add_file = add_file;
 	dump_editor->open_file = open_file;
 
-- 
1.7.1
