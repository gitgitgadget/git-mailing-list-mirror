From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 08/13] Implement dump_node
Date: Wed,  7 Jul 2010 02:14:48 +0200
Message-ID: <1278461693-3828-9-git-send-email-artagnon@gmail.com>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarb@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, dev@subversion.apache.org
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 07 02:13:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWIGp-0004kM-9p
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 02:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755763Ab0GGANn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 20:13:43 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39519 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755714Ab0GGANl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 20:13:41 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so1968051ewy.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 17:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XthfdSlgywByYOVVqzw9vX+h32Z/SCFmR76vWwpJjbA=;
        b=Euhza8v9suFroO28/aEv2xStqGs1LOCdzYhKcop8SC3BrdltuDP4PZAaXFR+2kbM6u
         kiV0ItRHr73mtX/cCxfnVXcKNAtyn/VHKjv77x7XxIN7fCYc1AbS22GjVeLBaKb9qeQz
         qj5pbdX0J1nHdKG8utHr6AMLuUvbSiC9Dtw5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=l8zRtp0tGV0PkD4wNhDYYOtPxqWN17HQzdq/xBCJQMlwwhCDJx1v95/+EefcPspU/j
         YKDM+jjmo9fHB8RtazWbl3h4VDEk2cn7d/7Dhcvz7v/fJyQgfttQkjO7/MjxxGWbQkhD
         ABueqEsJFNVJNSNqw6O8BXQaMmtd+We7tDvIg=
Received: by 10.213.7.131 with SMTP id d3mr4696770ebd.19.1278461620032;
        Tue, 06 Jul 2010 17:13:40 -0700 (PDT)
Received: from localhost (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id x54sm55868204eeh.17.2010.07.06.17.13.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 17:13:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150426>

Add a new dump_node function to dump node headers Node-path,
Node-kind, Node-action and set the right variables to trigger dumping
properties. Copies are also handled appropriately using eb->is_copy,
copyfrom_path, copyfrom_rev informatino from the caller. Also add a
related dump_props helper function that uses write_hash_to_stringbuf
to dump properties.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 dump_editor.c |  132 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 dumpr_util.c  |   48 +++++++++++++++++++++
 dumpr_util.h  |    5 ++
 3 files changed, 185 insertions(+), 0 deletions(-)

diff --git a/dump_editor.c b/dump_editor.c
index 6e9b0f5..0f7d231 100644
--- a/dump_editor.c
+++ b/dump_editor.c
@@ -15,6 +15,10 @@
 
 #include "dumpr_util.h"
 
+#define ARE_VALID_COPY_ARGS(p,r) ((p) && SVN_IS_VALID_REVNUM(r))
+
+svn_boolean_t must_dump_props = FALSE, must_dump_text = FALSE,
+	dump_props_pending = FALSE;
 
 /* Make a directory baton to represent the directory was path
    (relative to EDIT_BATON's path) is PATH.
@@ -70,6 +74,134 @@ struct dir_baton *make_dir_baton(const char *path,
 
 	return new_db;
 }
+/*
+ * Write out a node record for PATH of type KIND under EB->FS_ROOT.
+ * ACTION describes what is happening to the node (see enum svn_node_action).
+ * Write record to writable EB->STREAM, using EB->BUFFER to write in chunks.
+ *
+ * If the node was itself copied, IS_COPY is TRUE and the
+ * path/revision of the copy source are in CMP_PATH/CMP_REV.  If
+ * IS_COPY is FALSE, yet CMP_PATH/CMP_REV are valid, this node is part
+ * of a copied subtree.
+ */
+svn_error_t *dump_node(struct edit_baton *eb,
+		       const char *path,    /* an absolute path. */
+		       svn_node_kind_t kind,
+		       enum svn_node_action action,
+		       const char *cmp_path,
+		       svn_revnum_t cmp_rev,
+		       apr_pool_t *pool)
+{
+	/* Some pending properties to dump? */
+	SVN_ERR(dump_props(eb, &dump_props_pending, TRUE, pool));
+
+	/* Write out metadata headers for this file node. */
+	SVN_ERR(svn_stream_printf(eb->stream, pool,
+				  SVN_REPOS_DUMPFILE_NODE_PATH ": %s\n",
+				  (*path == '/') ? path + 1 : path));
+
+	if (kind == svn_node_file)
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+		                          SVN_REPOS_DUMPFILE_NODE_KIND ": file\n"));
+	else if (kind == svn_node_dir)
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+		                          SVN_REPOS_DUMPFILE_NODE_KIND ": dir\n"));
+
+	/* Remove leading slashes from copyfrom paths. */
+	if (cmp_path)
+		cmp_path = ((*cmp_path == '/') ? cmp_path + 1 : cmp_path);
+
+	switch (action) {
+		/* Appropriately handle the four svn_node_action actions */
+
+	case svn_node_action_change:
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+		                          SVN_REPOS_DUMPFILE_NODE_ACTION
+		                          ": change\n"));
+		break;
+
+	case svn_node_action_replace:
+		if (!eb->is_copy) {
+			/* a simple delete+add, implied by a single 'replace' action. */
+			SVN_ERR(svn_stream_printf(eb->stream, pool,
+			                          SVN_REPOS_DUMPFILE_NODE_ACTION
+			                          ": replace\n"));
+
+			/* definitely need to dump all content for a replace. */
+			must_dump_props = TRUE;
+			break;
+		}
+		/* More complex case: eb->is_copy is true, and
+		   cmp_path/ cmp_rev are present: delete the original,
+		   and then re-add it */
+
+		/* the path & kind headers have already been printed;  just
+		   add a delete action, and end the current record.*/
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+		                          SVN_REPOS_DUMPFILE_NODE_ACTION
+		                          ": delete\n\n"));
+
+		/* recurse:  print an additional add-with-history record. */
+		SVN_ERR(dump_node(eb, path, kind, svn_node_action_add,
+		                  cmp_path, cmp_rev, pool));
+
+		/* we can leave this routine quietly now, don't need to dump
+		   any content;  that was already done in the second record. */
+		must_dump_props = FALSE;
+		eb->is_copy = FALSE;
+		break;
+
+	case svn_node_action_delete:
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+		                          SVN_REPOS_DUMPFILE_NODE_ACTION
+		                          ": delete\n"));
+
+		/* we can leave this routine quietly now, don't need to dump
+		   any content. */
+		SVN_ERR(svn_stream_printf(eb->stream, pool, "\n\n"));
+		must_dump_props = FALSE;
+		break;
+
+	case svn_node_action_add:
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+		                          SVN_REPOS_DUMPFILE_NODE_ACTION ": add\n"));
+
+		if (!eb->is_copy) {
+			/* If it's a file or directory not copied from
+			   somewhere, wait for change_file_prop or
+			   change_directory_prop */
+			dump_props_pending = TRUE;
+			break;
+		}
+
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+		                          SVN_REPOS_DUMPFILE_NODE_COPYFROM_REV
+		                          ": %ld\n"
+		                          SVN_REPOS_DUMPFILE_NODE_COPYFROM_PATH
+		                          ": %s\n",
+		                          cmp_rev, cmp_path));
+
+		/* Dump the text only if apply_textdelta sets
+		   must_dump_text */
+
+		/* UGLY hack: If a directory was copied from a
+		   previous revision, nothing else can be done, and
+		   close_file won't be called to write two blank
+		   lines; write them here */
+		if (kind == svn_node_dir)
+			SVN_ERR(svn_stream_printf(eb->stream, pool, "\n\n"));
+
+		eb->is_copy = FALSE;
+
+		break;
+	}
+
+	/* Dump property headers */
+	SVN_ERR(dump_props(eb, &must_dump_props, FALSE, pool));
+
+	return SVN_NO_ERROR;
+}
+
 svn_error_t *open_root(void *edit_baton,
                        svn_revnum_t base_revision,
                        apr_pool_t *pool,
diff --git a/dumpr_util.c b/dumpr_util.c
index 41940d4..a3328b6 100644
--- a/dumpr_util.c
+++ b/dumpr_util.c
@@ -62,3 +62,51 @@ void write_hash_to_stringbuf(apr_hash_t *properties,
 		}
 	}
 }
+
+svn_error_t *dump_props(struct edit_baton *eb,
+			svn_boolean_t *trigger_var,
+			svn_boolean_t dump_data_too,
+			apr_pool_t *pool)
+{
+	if (trigger_var && !*trigger_var)
+		return SVN_NO_ERROR;
+
+	/* Build a propstring to print */
+	svn_stringbuf_setempty(eb->propstring);
+	write_hash_to_stringbuf(eb->properties,
+				FALSE,
+				&(eb->propstring), eb->pool);
+	write_hash_to_stringbuf(eb->del_properties,
+				TRUE,
+				&(eb->propstring), eb->pool);
+	svn_stringbuf_appendbytes(eb->propstring, "PROPS-END\n", 10);
+
+	/* prop-delta header */
+	SVN_ERR(svn_stream_printf(eb->stream, pool,
+				  SVN_REPOS_DUMPFILE_PROP_DELTA
+				  ": true\n"));
+
+	/* prop-content-length header */
+	SVN_ERR(svn_stream_printf(eb->stream, pool,
+				  SVN_REPOS_DUMPFILE_PROP_CONTENT_LENGTH
+				  ": %" APR_SIZE_T_FMT "\n", eb->propstring->len));
+
+	if (dump_data_too) {
+		/* content-length header */
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+					  SVN_REPOS_DUMPFILE_CONTENT_LENGTH
+					  ": %" APR_SIZE_T_FMT "\n\n",
+					  eb->propstring->len));
+
+		/* the properties themselves */
+		SVN_ERR(svn_stream_write(eb->stream, eb->propstring->data,
+					 &(eb->propstring->len)));
+
+		/* Cleanup so that data is never dumped twice */
+		apr_hash_clear(eb->properties);
+		apr_hash_clear(eb->del_properties);
+		if (trigger_var)
+			*trigger_var = FALSE;
+	}
+	return SVN_NO_ERROR;
+}
diff --git a/dumpr_util.h b/dumpr_util.h
index 96670ff..79de1ab 100644
--- a/dumpr_util.h
+++ b/dumpr_util.h
@@ -66,4 +66,9 @@ void write_hash_to_stringbuf(apr_hash_t *properties,
 			     svn_stringbuf_t **strbuf,
 			     apr_pool_t *pool);
 
+svn_error_t *dump_props(struct edit_baton *eb,
+			svn_boolean_t *trigger_var,
+			svn_boolean_t dump_data_too,
+			apr_pool_t *pool);
+
 #endif
-- 
1.7.1
