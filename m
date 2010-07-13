From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/9] Implement directory-related functions
Date: Wed, 14 Jul 2010 01:36:13 +0200
Message-ID: <1279064176-6645-7-git-send-email-artagnon@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Jul 14 01:36:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYp1s-0008BW-Ci
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 01:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757262Ab0GMXgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 19:36:37 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43675 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757226Ab0GMXge (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 19:36:34 -0400
Received: by mail-ey0-f174.google.com with SMTP id 25so898848eya.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 16:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=YqfPItKc1CGkIgJDe9Ofc36G3qoPEr40l9hcxd7wDpk=;
        b=h/4X13ZsvpwGH+VWJv1RUFFFGUS4IdZjLnMHU5fWPzQ1oYOwq5THCBTjNeo6eKBsGb
         j1s3MJRP4zUvhQ+Wl42lFM4K2w0q2SNdkx735kfzqYzsQVLmGsz/tUz/OhL1o/GQj1ao
         tMod2+EoJYyv4LdSBxt6yg0Z/qe0pbeuCNteI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TJsesn5NtmQTSp+WYTYH2DZ1mT8r/YH7F13pGVaVINPUfIY/jxMqD3ExQPU0oGdFGU
         wEGDsWwhXttre4WS3jtnVhQh4BLny0ZM7zFL75wAaZL/uG7zjSdzLwcTy6JIUnJHJOH2
         k53cIkk/lAPOEbfXsu7tcV4GsujPXQaLY/sRY=
Received: by 10.213.19.211 with SMTP id c19mr467898ebb.93.1279064191905;
        Tue, 13 Jul 2010 16:36:31 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id z55sm51443278eeh.21.2010.07.13.16.36.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 16:36:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150944>

Implement open_directory, add_directory, change_dir_prop and
close_directory. All of them involve adding and removing entries from
the directory_baton and dumping the related node information. Note
that open_directory doesn't need any corresponding node information to
be printed.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 dump_editor.c |  112 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/dump_editor.c b/dump_editor.c
index 0506966..7fafa8b 100644
--- a/dump_editor.c
+++ b/dump_editor.c
@@ -225,6 +225,15 @@ static svn_error_t *delete_entry(const char *path,
 				 void *parent_baton,
 				 apr_pool_t *pool)
 {
+	struct dir_baton *pb = parent_baton;
+	const char *mypath = apr_pstrdup(pb->pool, path);
+
+	/* Some pending properties to dump? */
+	SVN_ERR(dump_props(pb->eb, &(pb->eb->dump_props_pending), TRUE, pool));
+
+	/* remember this path needs to be deleted */
+	apr_hash_set(pb->deleted_entries, mypath, APR_HASH_KEY_STRING, pb);
+
 	return SVN_NO_ERROR;
 }
 
@@ -235,7 +244,35 @@ static svn_error_t *add_directory(const char *path,
 				  apr_pool_t *pool,
 				  void **child_baton)
 {
-	*child_baton = NULL;
+	struct dir_baton *pb = parent_baton;
+	void *val;
+	struct dir_baton *new_db
+		= make_dir_baton(path, copyfrom_path, copyfrom_rev, pb->eb, pb, TRUE, pool);
+
+	/* Some pending properties to dump? */
+	SVN_ERR(dump_props(pb->eb, &(pb->eb->dump_props_pending), TRUE, pool));
+
+	/* This might be a replacement -- is the path already deleted? */
+	val = apr_hash_get(pb->deleted_entries, path, APR_HASH_KEY_STRING);
+
+	/* Detect an add-with-history */
+	pb->eb->is_copy = ARE_VALID_COPY_ARGS(copyfrom_path, copyfrom_rev);
+
+	/* Dump the node */
+	SVN_ERR(dump_node(pb->eb, path,
+	                  svn_node_dir,
+	                  val ? svn_node_action_replace : svn_node_action_add,
+	                  pb->eb->is_copy ? copyfrom_path : NULL,
+	                  pb->eb->is_copy ? copyfrom_rev : SVN_INVALID_REVNUM,
+	                  pool));
+
+	if (val)
+		/* Delete the path, it's now been dumped */
+		apr_hash_set(pb->deleted_entries, path, APR_HASH_KEY_STRING, NULL);
+
+	new_db->written_out = TRUE;
+
+	*child_baton = new_db;
 	return SVN_NO_ERROR;
 }
 
@@ -245,13 +282,56 @@ static svn_error_t *open_directory(const char *path,
 				   apr_pool_t *pool,
 				   void **child_baton)
 {
-	*child_baton = NULL;
+	struct dir_baton *pb = parent_baton;
+	struct dir_baton *new_db;
+	const char *cmp_path = NULL;
+	svn_revnum_t cmp_rev = SVN_INVALID_REVNUM;
+	apr_array_header_t *compose_path = apr_array_make(pool, 2, sizeof(const char *));
+
+	/* Some pending properties to dump? */
+	SVN_ERR(dump_props(pb->eb, &(pb->eb->dump_props_pending), TRUE, pool));
+
+	/* If the parent directory has explicit comparison path and rev,
+	   record the same for this one. */
+	if (pb && ARE_VALID_COPY_ARGS(pb->cmp_path, pb->cmp_rev)) {
+		APR_ARRAY_PUSH(compose_path, const char *) = pb->cmp_path;
+		APR_ARRAY_PUSH(compose_path, const char *) = svn_relpath_basename(path, pool);
+		cmp_path = svn_path_compose(compose_path, pool);
+		cmp_rev = pb->cmp_rev;
+	}
+
+	new_db = make_dir_baton(path, cmp_path, cmp_rev, pb->eb, pb, FALSE, pool);
+	*child_baton = new_db;
 	return SVN_NO_ERROR;
 }
 
 static svn_error_t *close_directory(void *dir_baton,
 				    apr_pool_t *pool)
 {
+	struct dir_baton *db = dir_baton;
+	struct dump_edit_baton *eb = db->eb;
+	apr_hash_index_t *hi;
+	apr_pool_t *subpool = svn_pool_create(pool);
+
+	/* Some pending properties to dump? */
+	SVN_ERR(dump_props(eb, &(eb->dump_props_pending), TRUE, pool));
+
+	/* Dump the directory entries */
+	for (hi = apr_hash_first(pool, db->deleted_entries); hi;
+	     hi = apr_hash_next(hi)) {
+		const void *key;
+		const char *path;
+		apr_hash_this(hi, &key, NULL, NULL);
+		path = key;
+
+		svn_pool_clear(subpool);
+
+		SVN_ERR(dump_node(db->eb, path,
+		                  svn_node_unknown, svn_node_action_delete,
+		                  NULL, SVN_INVALID_REVNUM, subpool));
+	}
+
+	svn_pool_destroy(subpool);
 	return SVN_NO_ERROR;
 }
 
@@ -281,6 +361,34 @@ static svn_error_t *change_dir_prop(void *parent_baton,
 				    const svn_string_t *value,
 				    apr_pool_t *pool)
 {
+	struct dir_baton *db = parent_baton;
+
+	if (svn_property_kind(NULL, name) != svn_prop_regular_kind)
+		return SVN_NO_ERROR;
+
+	value ? apr_hash_set(db->eb->properties, apr_pstrdup(pool, name),
+	                     APR_HASH_KEY_STRING, svn_string_dup(value, pool)) :
+		apr_hash_set(db->eb->del_properties, apr_pstrdup(pool, name),
+		             APR_HASH_KEY_STRING, (void *)0x1);
+
+	/* This function is what distinguishes between a directory that is
+	   opened to merely get somewhere, vs. one that is opened because it
+	   actually changed by itself  */
+	if (! db->written_out) {
+		/* If eb->dump_props_pending was set, it means that the
+		   node information corresponding to add_directory has already
+		   been written; just don't unset it and dump_node will dump
+		   the properties before doing anything else. If it wasn't
+		   set, node information hasn't been written yet: so dump the
+		   node itself before dumping the props */
+
+		SVN_ERR(dump_node(db->eb, db->path,
+		                  svn_node_dir, svn_node_action_change,
+		                  db->cmp_path, db->cmp_rev, pool));
+
+		SVN_ERR(dump_props(db->eb, NULL, TRUE, pool));
+		db->written_out = TRUE;
+	}
 	return SVN_NO_ERROR;
 }
 
-- 
1.7.1
