From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 10/13] Implement file-related functions
Date: Wed,  7 Jul 2010 02:14:50 +0200
Message-ID: <1278461693-3828-11-git-send-email-artagnon@gmail.com>
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
X-From: dev-return-4821-gcvsd-dev=m.gmane.org@subversion.apache.org Wed Jul 07 02:14:17 2010
Return-path: <dev-return-4821-gcvsd-dev=m.gmane.org@subversion.apache.org>
Envelope-to: gcvsd-dev@lo.gmane.org
Received: from hermes.apache.org ([140.211.11.3] helo=mail.apache.org)
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <dev-return-4821-gcvsd-dev=m.gmane.org@subversion.apache.org>)
	id 1OWIHJ-00051r-08
	for gcvsd-dev@lo.gmane.org; Wed, 07 Jul 2010 02:14:17 +0200
Received: (qmail 98157 invoked by uid 500); 7 Jul 2010 00:14:15 -0000
Mailing-List: contact dev-help@subversion.apache.org; run by ezmlm
Precedence: bulk
List-Help: <mailto:dev-help@subversion.apache.org>
List-Unsubscribe: <mailto:dev-unsubscribe@subversion.apache.org>
List-Post: <mailto:dev@subversion.apache.org>
List-Id: <dev.subversion.apache.org>
Delivered-To: mailing list dev@subversion.apache.org
Received: (qmail 97951 invoked by uid 99); 7 Jul 2010 00:14:15 -0000
Received: from nike.apache.org (HELO nike.apache.org) (192.87.106.230)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 07 Jul 2010 00:14:15 +0000
X-ASF-Spam-Status: No, hits=0.0 required=10.0
	tests=FREEMAIL_FROM,SPF_PASS
X-Spam-Check-By: apache.org
Received-SPF: pass (nike.apache.org: domain of artagnon@gmail.com designates 209.85.215.171 as permitted sender)
Received: from [209.85.215.171] (HELO mail-ey0-f171.google.com) (209.85.215.171)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 07 Jul 2010 00:14:05 +0000
Received: by mail-ey0-f171.google.com with SMTP id 7so174601eyg.16
        for <dev@subversion.apache.org>; Tue, 06 Jul 2010 17:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wmLOt6CbXR5ZPzxCb2F7MZ8n6znBA77VtziEgHyS+hE=;
        b=gXV+0pufMZfR9+6HP0v32/bX2364qmIHrWzA9JPudFSt8HOlyz+nDgfVmtjlwkebZV
         t9NyqfRmeJhXQK4fBJhpYN3lE9XyfntcpboXC2ZMixT9hECwumrv0IGuBGQiLJVZEK7p
         YG+iARpWxsktsiExQgka0KtrINZ/laXipGShE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tpSOiHRnS3/WUQE5ip8wQE0FHXaUPNgk9ZDS6TAFih6E+mhlAKYni5GlCOi9MniFnA
         rMHXAlJOKHjrQuBsv65B7AV4QJLLL9KVhQ0Aq+pyGYxxkAslm/M6V2c+x3OuP7TISFAr
         RejN1bKDX/bPHaeVdsa8ygLJ3e2tXdsYhzdwU=
Received: by 10.213.26.70 with SMTP id d6mr4909921ebc.2.1278461625270;
        Tue, 06 Jul 2010 17:13:45 -0700 (PDT)
Received: from localhost (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id v8sm55856974eeh.14.2010.07.06.17.13.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 17:13:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
X-Virus-Checked: Checked by ClamAV on apache.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150430>

Implement add_file, open_file and change_file_prop. All of them
involve dumping the corresponding node information and setting up the
file_baton for apply_textdelta and close_file to use.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 dump_editor.c |   62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/dump_editor.c b/dump_editor.c
index 6077e5c..7006a2c 100644
--- a/dump_editor.c
+++ b/dump_editor.c
@@ -334,6 +334,31 @@ svn_error_t *add_file(const char *path,
                       apr_pool_t *pool,
                       void **file_baton)
 {
+	struct dir_baton *pb = parent_baton;
+	void *val;
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
 
@@ -343,6 +368,28 @@ svn_error_t *open_file(const char *path,
                        apr_pool_t *pool,
                        void **file_baton)
 {
+	struct dir_baton *pb = parent_baton;
+	const char *cmp_path = NULL;
+	svn_revnum_t cmp_rev = SVN_INVALID_REVNUM;
+
+	apr_array_header_t *compose_path = apr_array_make(pool, 2, sizeof(const char *));
+	/* If the parent directory has explicit comparison path and rev,
+	   record the same for this one. */
+	if (pb && ARE_VALID_COPY_ARGS(pb->cmp_path, pb->cmp_rev)) {
+		APR_ARRAY_PUSH(compose_path, const char *) = pb->cmp_path;
+		APR_ARRAY_PUSH(compose_path, const char *) = svn_dirent_basename(path, pool);
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
 
@@ -387,6 +434,21 @@ svn_error_t *change_file_prop(void *file_baton,
                               const svn_string_t *value,
                               apr_pool_t *pool)
 {
+	struct edit_baton *eb = file_baton;
+
+	if (svn_property_kind(NULL, name) != svn_prop_regular_kind)
+		return SVN_NO_ERROR;
+
+	value ? apr_hash_set(eb->properties, apr_pstrdup(pool, name),
+	                     APR_HASH_KEY_STRING, svn_string_dup(value, pool)) :
+		apr_hash_set(eb->del_properties, apr_pstrdup(pool, name),
+		             APR_HASH_KEY_STRING, (void *)0x1);
+
+	/* Dump the property headers and wait; close_file might need
+	   to write text headers too depending on whether
+	   apply_textdelta is called */
+	dump_props_pending = TRUE;
+
 	return SVN_NO_ERROR;
 }
 
-- 
1.7.1
