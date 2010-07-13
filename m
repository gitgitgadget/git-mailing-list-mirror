From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 7/9] Implement file-related functions
Date: Wed, 14 Jul 2010 01:36:14 +0200
Message-ID: <1279064176-6645-8-git-send-email-artagnon@gmail.com>
References: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarab@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Will Palmer <wpalmer@gmail.com>, Greg Stein <gstein@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 14 01:36:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYp1t-0008BW-Be
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 01:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757296Ab0GMXgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 19:36:41 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40859 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757241Ab0GMXgf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 19:36:35 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so1272372ewy.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 16:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=JL4f0GHCmN++KX0y/gSkF/cLQ7aoNdzVIoVWOTcdVTw=;
        b=Yb7omAn4LipwTUMwnfUqGQD6CDiQGy53LHM1MWCK8E8n+d49ySlyhwmgGv09yai9UH
         HF8TT9SbM8TlUzlEz5VNOWbvRMSQBrWLHzneYkAwZaS8IJ3oOY2/rH4zOgqZVZIFsOmD
         s/WQjC3QL2kny+sdvyyVzllSBF/JTxi6UZlU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gQbVc6asgOsDEkQTa0a/iENw724jzFkyPmJAzJ259CBZ2yW5Dna6Ryh6/z1xrSQSwb
         DHKsqWtvDNrBbq50gHKWGwt1pAlifXHGZXgbqw9yJ757BpFFZO0iBU8gk11RHedeCGbx
         bBsw+0+3lYSj16XTyc+oEyrvDm69Aylxo8bww=
Received: by 10.213.21.203 with SMTP id k11mr5586135ebb.57.1279064194450;
        Tue, 13 Jul 2010 16:36:34 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id z55sm51476748eeh.9.2010.07.13.16.36.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 16:36:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150948>

Implement add_file, open_file and change_file_prop. All of them
involve dumping the corresponding node information and setting up the
file_baton for apply_textdelta and close_file to use.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 dump_editor.c |  127 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 dumpr_util.h  |   15 +++++++
 2 files changed, 138 insertions(+), 4 deletions(-)

diff --git a/dump_editor.c b/dump_editor.c
index 7fafa8b..8b0a830 100644
--- a/dump_editor.c
+++ b/dump_editor.c
@@ -342,7 +342,34 @@ static svn_error_t *add_file(const char *path,
 			     apr_pool_t *pool,
 			     void **file_baton)
 {
-	*file_baton = NULL;
+	struct dir_baton *pb = parent_baton;
+	void *val;
+
+	/* Some pending properties to dump? */
+	SVN_ERR(dump_props(pb->eb, &(pb->eb->dump_props_pending), TRUE, pool));
+
+	/* This might be a replacement -- is the path already deleted? */
+	val = apr_hash_get(pb->deleted_entries, path, APR_HASH_KEY_STRING);
+
+	/* Detect add-with-history. */
+	pb->eb->is_copy = ARE_VALID_COPY_ARGS(copyfrom_path, copyfrom_rev);
+
+	/* Dump the node. */
+	SVN_ERR(dump_node(pb->eb, path,
+	                  svn_node_file,
+	                  val ? svn_node_action_replace : svn_node_action_add,
+	                  pb->eb->is_copy ? copyfrom_path : NULL,
+	                  pb->eb->is_copy ? copyfrom_rev : SVN_INVALID_REVNUM,
+	                  pool));
+
+	if (val)
+		/* delete the path, it's now been dumped. */
+		apr_hash_set(pb->deleted_entries, path, APR_HASH_KEY_STRING, NULL);
+
+	/* Build a nice file baton to pass to change_file_prop and apply_textdelta */
+	pb->eb->changed_path = path;
+	*file_baton = pb->eb;
+
 	return SVN_NO_ERROR;
 }
 
@@ -352,7 +379,31 @@ static svn_error_t *open_file(const char *path,
 			      apr_pool_t *pool,
 			      void **file_baton)
 {
-	*file_baton = NULL;
+	struct dir_baton *pb = parent_baton;
+	const char *cmp_path = NULL;
+	svn_revnum_t cmp_rev = SVN_INVALID_REVNUM;
+
+	/* Some pending properties to dump? */
+	SVN_ERR(dump_props(pb->eb, &(pb->eb->dump_props_pending), TRUE, pool));
+
+	apr_array_header_t *compose_path = apr_array_make(pool, 2, sizeof(const char *));
+	/* If the parent directory has explicit comparison path and rev,
+	   record the same for this one. */
+	if (pb && ARE_VALID_COPY_ARGS(pb->cmp_path, pb->cmp_rev)) {
+		APR_ARRAY_PUSH(compose_path, const char *) = pb->cmp_path;
+		APR_ARRAY_PUSH(compose_path, const char *) = svn_relpath_basename(path, pool);
+		cmp_path = svn_path_compose(compose_path, pool);
+		cmp_rev = pb->cmp_rev;
+	}
+
+	SVN_ERR(dump_node(pb->eb, path,
+	                  svn_node_file, svn_node_action_change,
+	                  cmp_path, cmp_rev, pool));
+
+	/* Build a nice file baton to pass to change_file_prop and apply_textdelta */
+	pb->eb->changed_path = path;
+	*file_baton = pb->eb;
+
 	return SVN_NO_ERROR;
 }
 
@@ -397,6 +448,44 @@ static svn_error_t *change_file_prop(void *file_baton,
 				     const svn_string_t *value,
 				     apr_pool_t *pool)
 {
+	struct dump_edit_baton *eb = file_baton;
+
+	if (svn_property_kind(NULL, name) != svn_prop_regular_kind)
+		return SVN_NO_ERROR;
+
+	apr_hash_set(eb->properties, apr_pstrdup(pool, name),
+		     APR_HASH_KEY_STRING, value ?
+		     svn_string_dup(value, pool): (void *)0x1);
+
+	/* Dump the property headers and wait; close_file might need
+	   to write text headers too depending on whether
+	   apply_textdelta is called */
+	eb->dump_props_pending = TRUE;
+
+	return SVN_NO_ERROR;
+}
+
+static svn_error_t *window_handler(svn_txdelta_window_t *window, void *baton)
+{
+	struct handler_baton *hb = baton;
+	struct dump_edit_baton *eb = hb->eb;
+	static svn_error_t *err;
+
+	err = hb->apply_handler(window, hb->apply_baton);
+	if (window != NULL && !err)
+		return SVN_NO_ERROR;
+
+	if (err)
+		SVN_ERR(err);
+
+	/* Write information about the filepath to hb->eb */
+	eb->temp_filepath = apr_pstrdup(eb->pool,
+					hb->temp_filepath);
+
+	/* Cleanup */
+	SVN_ERR(svn_io_file_close(hb->temp_file, hb->pool));
+	SVN_ERR(svn_stream_close(hb->temp_filestream));
+	svn_pool_destroy(hb->pool);
 	return SVN_NO_ERROR;
 }
 
@@ -405,8 +494,38 @@ static svn_error_t *apply_textdelta(void *file_baton, const char *base_checksum,
 				    svn_txdelta_window_handler_t *handler,
 				    void **handler_baton)
 {
-	*handler = svn_delta_noop_window_handler;
-	*handler_baton = NULL;
+	struct dump_edit_baton *eb = file_baton;
+	apr_status_t apr_err;
+	const char *tempdir;
+
+	/* Custom handler_baton allocated in a separate pool */
+	apr_pool_t *handler_pool = svn_pool_create(pool);
+	struct handler_baton *hb = apr_pcalloc(handler_pool, sizeof(*hb));
+	hb->pool = handler_pool;
+	hb->eb = eb;
+
+	/* Use a temporary file to measure the text-content-length */
+	SVN_ERR(svn_io_temp_dir(&tempdir, hb->pool));
+
+	hb->temp_filepath = svn_dirent_join(tempdir, "XXXXXX", hb->pool);
+	apr_err = apr_file_mktemp(&(hb->temp_file), hb->temp_filepath,
+				  APR_CREATE | APR_READ | APR_WRITE | APR_EXCL,
+				  hb->pool);
+	if (apr_err != APR_SUCCESS)
+		SVN_ERR(svn_error_wrap_apr(apr_err, NULL));
+
+	hb->temp_filestream = svn_stream_from_aprfile2(hb->temp_file, TRUE, hb->pool);
+
+	/* Prepare to write the delta to the temporary file */
+	svn_txdelta_to_svndiff2(&(hb->apply_handler), &(hb->apply_baton),
+	                        hb->temp_filestream, 0, hb->pool);
+	eb->must_dump_text = TRUE;
+
+	/* The actual writing takes place when this function has finished */
+	/* Set the handler and handler_baton */
+	*handler = window_handler;
+	*handler_baton = hb;
+
 	return SVN_NO_ERROR;
 }
 
diff --git a/dumpr_util.h b/dumpr_util.h
index 4b0d5b0..9870b0d 100644
--- a/dumpr_util.h
+++ b/dumpr_util.h
@@ -64,6 +64,21 @@ struct dir_baton {
 	apr_pool_t *pool;
 };
 
+struct handler_baton
+{
+	svn_txdelta_window_handler_t apply_handler;
+	void *apply_baton;
+	apr_pool_t *pool;
+
+	/* Information about the path of the tempoarary file used */
+	char *temp_filepath;
+	apr_file_t *temp_file;
+	svn_stream_t *temp_filestream;
+
+	/* To fill in the edit baton fields */
+	struct dump_edit_baton *eb;
+};
+
 void write_hash_to_stringbuf(apr_hash_t *properties,
 			     svn_boolean_t deleted,
 			     svn_stringbuf_t **strbuf,
-- 
1.7.1
