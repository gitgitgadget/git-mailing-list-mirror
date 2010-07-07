From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 07/13] Implement open_root and close_edit
Date: Wed,  7 Jul 2010 02:14:47 +0200
Message-ID: <1278461693-3828-8-git-send-email-artagnon@gmail.com>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarb@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, dev@subversion.apache.org
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 07 02:13:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWIGo-0004kM-QM
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 02:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755701Ab0GGANj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 20:13:39 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39519 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754425Ab0GGANh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 20:13:37 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so1968051ewy.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 17:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Ih5X3WyoQCTqQu3UbHNPXQ5Tye46gjzG3My0RHgbJig=;
        b=HdN+AuAPMIgfwWCPOmUmMsZADxVpPUinNw/qGBimBXPcqJtPfOPB5nSa9GIZYe0HvB
         5pUnbWULxD5jRXnxgcaqTQuhg5evtfu50dp99BrZ6YMiPK5p7ZmiRzf5wdz7cYb1y0LU
         sYgsZKyf5HMx8yWOlaUXF4JgRNTEhNFfaF3KQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SQwAE7lPX7oCgKjUoYpx+40Zhdj6lBSWpHpfuydx/MnzlCmnrMss1bVerkIvY3NMvH
         QUTrYPXxbG5JjDXV/IdZ8LBt3cyTcM1lN+D6c/usS4NCnvB6Ili+U6VsMt49pBLbFDN7
         5ME2Rr1iyRZZWk6LcLGDssRHaw1kqsHgyUh/k=
Received: by 10.213.112.212 with SMTP id x20mr1428543ebp.53.1278461616579;
        Tue, 06 Jul 2010 17:13:36 -0700 (PDT)
Received: from localhost (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id v8sm55893967eeh.2.2010.07.06.17.13.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 17:13:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150424>

open_root first creates a special edit_baton pool, and then allocates
memory from that pool to various items in edit_baton. Then it creates
a new directory baton to set as the root_baton. close_edit destroys
the special edit_baton pool (hence destroying all the items that were
allocated there), and increments current_rev. Add related
make_dir_baton function and dir_baton_t structure.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 dump_editor.c |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 dumpr_util.h  |   30 ++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 0 deletions(-)

diff --git a/dump_editor.c b/dump_editor.c
index 70d6c0b..6e9b0f5 100644
--- a/dump_editor.c
+++ b/dump_editor.c
@@ -15,11 +15,77 @@
 
 #include "dumpr_util.h"
 
+
+/* Make a directory baton to represent the directory was path
+   (relative to EDIT_BATON's path) is PATH.
+
+   CMP_PATH/CMP_REV are the path/revision against which this directory
+   should be compared for changes.  If either is omitted (NULL for the
+   path, SVN_INVALID_REVNUM for the rev), just compare this directory
+   PATH against itself in the previous revision.
+
+   PARENT_DIR_BATON is the directory baton of this directory's parent,
+   or NULL if this is the top-level directory of the edit.  ADDED
+   indicated if this directory is newly added in this revision.
+   Perform all allocations in POOL.  */
+struct dir_baton *make_dir_baton(const char *path,
+                                 const char *cmp_path,
+                                 svn_revnum_t cmp_rev,
+                                 void *edit_baton,
+                                 void *parent_dir_baton,
+                                 svn_boolean_t added,
+                                 apr_pool_t *pool)
+{
+	struct edit_baton *eb = edit_baton;
+	struct dir_baton *pb = parent_dir_baton;
+	struct dir_baton *new_db = apr_pcalloc(pool, sizeof(*new_db));
+	const char *full_path;
+	apr_array_header_t *compose_path = apr_array_make(pool, 2, sizeof(const char *));
+
+	/* A path relative to nothing?  I don't think so. */
+	SVN_ERR_ASSERT_NO_RETURN(!path || pb);
+
+	/* Construct the full path of this node. */
+	if (pb) {
+		APR_ARRAY_PUSH(compose_path, const char *) = "/";
+		APR_ARRAY_PUSH(compose_path, const char *) = path;
+		full_path = svn_path_compose(compose_path, pool);
+	}
+	else
+		full_path = apr_pstrdup(pool, "/");
+
+	/* Remove leading slashes from copyfrom paths. */
+	if (cmp_path)
+		cmp_path = ((*cmp_path == '/') ? cmp_path + 1 : cmp_path);
+
+	new_db->eb = eb;
+	new_db->parent_dir_baton = pb;
+	new_db->path = full_path;
+	new_db->cmp_path = cmp_path ? apr_pstrdup(pool, cmp_path) : NULL;
+	new_db->cmp_rev = cmp_rev;
+	new_db->added = added;
+	new_db->written_out = FALSE;
+	new_db->deleted_entries = apr_hash_make(pool);
+	new_db->pool = pool;
+
+	return new_db;
+}
 svn_error_t *open_root(void *edit_baton,
                        svn_revnum_t base_revision,
                        apr_pool_t *pool,
                        void **root_baton)
 {
+	/* Allocate a special pool for the edit_baton to avoid pool
+	   lifetime issues */
+	struct edit_baton *eb = edit_baton;
+	eb->pool = svn_pool_create(pool);
+	eb->properties = apr_hash_make(eb->pool);
+	eb->del_properties = apr_hash_make(eb->pool);
+	eb->propstring = svn_stringbuf_create("", eb->pool);
+	eb->is_copy = FALSE;
+
+	*root_baton = make_dir_baton(NULL, NULL, SVN_INVALID_REVNUM,
+	                             edit_baton, NULL, FALSE, pool);
 	return SVN_NO_ERROR;
 }
 
@@ -108,6 +174,10 @@ svn_error_t *close_file(void *file_baton,
 
 svn_error_t *close_edit(void *edit_baton, apr_pool_t *pool)
 {
+	struct edit_baton *eb = edit_baton;
+	svn_pool_destroy(eb->pool);
+	(eb->current_rev) ++;
+
 	return SVN_NO_ERROR;
 }
 
diff --git a/dumpr_util.h b/dumpr_util.h
index 1a5752b..96670ff 100644
--- a/dumpr_util.h
+++ b/dumpr_util.h
@@ -31,6 +31,36 @@ struct edit_baton {
 	svn_checksum_t *checksum;
 };
 
+struct dir_baton {
+	struct edit_baton *eb;
+	struct dir_baton *parent_dir_baton;
+
+	/* is this directory a new addition to this revision? */
+	svn_boolean_t added;
+
+	/* has this directory been written to the output stream? */
+	svn_boolean_t written_out;
+
+	/* the absolute path to this directory */
+	const char *path;
+
+	/* the comparison path and revision of this directory.  if both of
+	   these are valid, use them as a source against which to compare
+	   the directory instead of the default comparison source of PATH in
+	   the previous revision. */
+	const char *cmp_path;
+	svn_revnum_t cmp_rev;
+
+	/* hash of paths that need to be deleted, though some -might- be
+	   replaced.  maps const char * paths to this dir_baton.  (they're
+	   full paths, because that's what the editor driver gives us.  but
+	   really, they're all within this directory.) */
+	apr_hash_t *deleted_entries;
+
+	/* pool to be used for deleting the hash items */
+	apr_pool_t *pool;
+};
+
 void write_hash_to_stringbuf(apr_hash_t *properties,
 			     svn_boolean_t deleted,
 			     svn_stringbuf_t **strbuf,
-- 
1.7.1
