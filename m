From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 09/13] Implement directory-related functions
Date: Wed,  7 Jul 2010 02:14:49 +0200
Message-ID: <1278461693-3828-10-git-send-email-artagnon@gmail.com>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	avarb@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	dev@subversion.apache.org
To: Git Mailing List <git@vger.kernel.org>
X-From: dev-return-4828-gcvsd-dev=m.gmane.org@subversion.apache.org Wed Jul 07 02:15:07 2010
Return-path: <dev-return-4828-gcvsd-dev=m.gmane.org@subversion.apache.org>
Envelope-to: gcvsd-dev@lo.gmane.org
Received: from hermes.apache.org ([140.211.11.3] helo=mail.apache.org)
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <dev-return-4828-gcvsd-dev=m.gmane.org@subversion.apache.org>)
	id 1OWII2-0005PA-Dc
	for gcvsd-dev@lo.gmane.org; Wed, 07 Jul 2010 02:15:02 +0200
Received: (qmail 2139 invoked by uid 500); 7 Jul 2010 00:15:01 -0000
Mailing-List: contact dev-help@subversion.apache.org; run by ezmlm
Precedence: bulk
List-Help: <mailto:dev-help@subversion.apache.org>
List-Unsubscribe: <mailto:dev-unsubscribe@subversion.apache.org>
List-Post: <mailto:dev@subversion.apache.org>
List-Id: <dev.subversion.apache.org>
Delivered-To: mailing list dev@subversion.apache.org
Received: (qmail 2131 invoked by uid 99); 7 Jul 2010 00:15:01 -0000
Received: from nike.apache.org (HELO nike.apache.org) (192.87.106.230)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 07 Jul 2010 00:15:01 +0000
X-ASF-Spam-Status: No, hits=0.0 required=10.0
	tests=FREEMAIL_FROM,SPF_PASS
X-Spam-Check-By: apache.org
Received-SPF: pass (nike.apache.org: domain of artagnon@gmail.com designates 209.85.215.43 as permitted sender)
Received: from [209.85.215.43] (HELO mail-ew0-f43.google.com) (209.85.215.43)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 07 Jul 2010 00:14:51 +0000
Received: by ewy1 with SMTP id 1so2219892ewy.16
        for <dev@subversion.apache.org>; Tue, 06 Jul 2010 17:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=653m5Z8+Htc8qV2lT0QMb3ZxIg1mN65JCiVDc0vpvTY=;
        b=L6SrBHReRXtLKaSOe6t7/Y69RJH+DwV4+vCXmfr/fqL5z84RGNhrsyzut4hcexRWgF
         5GyVleGHe1DH3rhmO5TSf7uebWi93r0MqpDxAw5t/FSHM+txY6WGC6lnP+78HNW9dYYw
         IGnQvfLjtByy5/BNXNMB+Nc67AK+3TvHOr4Uw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Z91AndhMK5WXyFqRmdtnapcP1tIDL23mYwwaCJHxwX8wgXRot9fISdJrmnhHlKhwxg
         YGn/SLsQkBiTBPeqR8MhBrts2wMtL0ZS0SXFCYOD+HK6TeWq1b8FlbG+c5aIFfAtZaDk
         vDrzcRLjwL8KidXNSWqymxxtaTDEIj2ruszn4=
Received: by 10.213.98.71 with SMTP id p7mr5052209ebn.18.1278461622595;
        Tue, 06 Jul 2010 17:13:42 -0700 (PDT)
Received: from localhost (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id x54sm55866062eeh.11.2010.07.06.17.13.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 17:13:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
X-Virus-Checked: Checked by ClamAV on apache.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150435>

Implement open_directory, add_directory, change_dir_prop and
close_directory. All of them involve adding and removing entries from
the directory_baton and dumping the related node information. Note
that open_directory doesn't need any corresponding node information to
be printed.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 dump_editor.c |  101 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 101 insertions(+), 0 deletions(-)

diff --git a/dump_editor.c b/dump_editor.c
index 0f7d231..6077e5c 100644
--- a/dump_editor.c
+++ b/dump_editor.c
@@ -226,6 +226,12 @@ svn_error_t *delete_entry(const char *path,
                           void *parent_baton,
                           apr_pool_t *pool)
 {
+	struct dir_baton *pb = parent_baton;
+	const char *mypath = apr_pstrdup(pb->pool, path);
+
+	/* remember this path needs to be deleted */
+	apr_hash_set(pb->deleted_entries, mypath, APR_HASH_KEY_STRING, pb);
+
 	return SVN_NO_ERROR;
 }
 
@@ -236,6 +242,32 @@ svn_error_t *add_directory(const char *path,
                            apr_pool_t *pool,
                            void **child_baton)
 {
+	struct dir_baton *pb = parent_baton;
+	void *val;
+	struct dir_baton *new_db
+		= make_dir_baton(path, copyfrom_path, copyfrom_rev, pb->eb, pb, TRUE, pool);
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
 
@@ -245,12 +277,53 @@ svn_error_t *open_directory(const char *path,
                             apr_pool_t *pool,
                             void **child_baton)
 {
+	struct dir_baton *pb = parent_baton;
+	struct dir_baton *new_db;
+	const char *cmp_path = NULL;
+	svn_revnum_t cmp_rev = SVN_INVALID_REVNUM;
+	apr_array_header_t *compose_path = apr_array_make(pool, 2, sizeof(const char *));
+
+	/* If the parent directory has explicit comparison path and rev,
+	   record the same for this one. */
+	if (pb && ARE_VALID_COPY_ARGS(pb->cmp_path, pb->cmp_rev)) {
+		APR_ARRAY_PUSH(compose_path, const char *) = pb->cmp_path;
+		APR_ARRAY_PUSH(compose_path, const char *) = svn_dirent_basename(path, pool);
+		cmp_path = svn_path_compose(compose_path, pool);
+		cmp_rev = pb->cmp_rev;
+	}
+
+	new_db = make_dir_baton(path, cmp_path, cmp_rev, pb->eb, pb, FALSE, pool);
+	*child_baton = new_db;
 	return SVN_NO_ERROR;
 }
 
 svn_error_t *close_directory(void *dir_baton,
                              apr_pool_t *pool)
 {
+	struct dir_baton *db = dir_baton;
+	struct edit_baton *eb = db->eb;
+	apr_hash_index_t *hi;
+	apr_pool_t *subpool = svn_pool_create(pool);
+
+	/* Some pending properties to dump? */
+	SVN_ERR(dump_props(eb, &dump_props_pending, TRUE, pool));
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
 
@@ -278,6 +351,34 @@ svn_error_t *change_dir_prop(void *parent_baton,
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
+		SVN_ERR(dump_node(db->eb, db->path,
+		                  svn_node_dir, svn_node_action_change,
+		                  db->cmp_path, db->cmp_rev, pool));
+
+		/* If dump_props_pending was set, it means that the
+		   node information corresponding to add_directory has already
+		   been written; just don't unset it and dump_node will dump
+		   the properties before doing anything else. If it wasn't
+		   set, node information hasn't been written yet: so dump the
+		   node itself before dumping the props */
+
+		SVN_ERR(dump_props(db->eb, NULL, TRUE, pool));
+		db->written_out = TRUE;
+	}
 	return SVN_NO_ERROR;
 }
 
-- 
1.7.1
