From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 06/13] Dump the revprops at the start of every revision
Date: Wed,  7 Jul 2010 02:14:46 +0200
Message-ID: <1278461693-3828-7-git-send-email-artagnon@gmail.com>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarb@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, dev@subversion.apache.org
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 07 02:13:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWIGo-0004kM-Ab
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 02:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755682Ab0GGANh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 20:13:37 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39519 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008Ab0GGANe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 20:13:34 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so1968051ewy.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 17:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wJBUi+UdiwNG216b2i1QU1oWQiI9A8rBs8EQSUias8U=;
        b=jMrx5MjHhplokO46qMBGnKg0EwNHFsNYRPk8Jf4dHdM0MiX+8zx9vyhK3Lkaf5tmN4
         wqhJAZZO/4hwZBQs1nNuNXNuKavclmbi3VGxcdHXQ3BQGBF1UaL+diIql+KOpIJKgDyM
         UkD6b6hebM4khcYLaIobXIK15tcjJwmHSeDrg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nccuWLhN7F5wdSfQ+TawXIn8EQXmE2y6Spnb1ALZCCTTPyId2m/w1wPg3l1CCsbhhz
         MNNv0vZy3ZpSxj0Nx2xwG21lrj4ElpPbeSn1RNa1vpAO9TWiaUQxz712aWz39lLJ73BC
         C08Cw1FzPCbLXHGZNEVakFYbfgD4SHZywqgHI=
Received: by 10.213.90.146 with SMTP id i18mr4826754ebm.7.1278461614048;
        Tue, 06 Jul 2010 17:13:34 -0700 (PDT)
Received: from localhost (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id a48sm55873080eei.13.2010.07.06.17.13.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 17:13:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150427>

Fill in replay_revstart to dump the revprops at the start of every
revision. Add an additional write_hash_to_stringbuf helper function.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Makefile     |    4 +-
 dumpr_util.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 dumpr_util.h |    5 ++++
 svndumpr.c   |   38 ++++++++++++++++++++++++++++++++-
 4 files changed, 107 insertions(+), 4 deletions(-)
 create mode 100644 dumpr_util.c

diff --git a/Makefile b/Makefile
index fea646e..c0b5c8a 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 svndumpr: *.c *.h
-	$(CC) -Wall -Werror -DAPR_POOL_DEBUG -ggdb3 -O0 -o $@ svndumpr.c debug_editor.c dump_editor.c -lsvn_client-1 -I. -I/usr/local/include/subversion-1 -I/usr/include/apr-1.0
+	$(CC) -Wall -Werror -DAPR_POOL_DEBUG -ggdb3 -O0 -o $@ svndumpr.c debug_editor.c dump_editor.c dumpr_util.c -lsvn_client-1 -I. -I/usr/local/include/subversion-1 -I/usr/include/apr-1.0
 
 svndumpr_bench: *.c *.h
-	$(CC) -O2 -o $@ svndumpr.c debug_editor.c dump_editor.c -lsvn_client-1 -I. -I/usr/local/include/subversion-1 -I/usr/include/apr-1.0
+	$(CC) -O2 -o $@ svndumpr.c debug_editor.c dump_editor.c dumpr_util.c -lsvn_client-1 -I. -I/usr/local/include/subversion-1 -I/usr/include/apr-1.0
 
 clean:
 	$(RM) svndumpr svndumpr_bench
diff --git a/dumpr_util.c b/dumpr_util.c
new file mode 100644
index 0000000..41940d4
--- /dev/null
+++ b/dumpr_util.c
@@ -0,0 +1,64 @@
+/* Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#include "svn_pools.h"
+#include "svn_cmdline.h"
+#include "svn_client.h"
+#include "svn_ra.h"
+#include "svn_repos.h"
+
+#include "dumpr_util.h"
+
+void write_hash_to_stringbuf(apr_hash_t *properties,
+			     svn_boolean_t deleted,
+			     svn_stringbuf_t **strbuf,
+			     apr_pool_t *pool)
+{
+	apr_hash_index_t *this;
+	const void *key;
+	void *val;
+	apr_ssize_t keylen;
+	svn_string_t *value;
+	
+	if (!deleted) {
+		for (this = apr_hash_first(pool, properties); this;
+		     this = apr_hash_next(this)) {
+			/* Get this key and val. */
+			apr_hash_this(this, &key, &keylen, &val);
+			value = val;
+
+			/* Output name length, then name. */
+			svn_stringbuf_appendcstr(*strbuf,
+						 apr_psprintf(pool, "K %" APR_SSIZE_T_FMT "\n",
+							      keylen));
+
+			svn_stringbuf_appendbytes(*strbuf, (const char *) key, keylen);
+			svn_stringbuf_appendbytes(*strbuf, "\n", 1);
+
+			/* Output value length, then value. */
+			svn_stringbuf_appendcstr(*strbuf,
+						 apr_psprintf(pool, "V %" APR_SIZE_T_FMT "\n",
+							      value->len));
+
+			svn_stringbuf_appendbytes(*strbuf, value->data, value->len);
+			svn_stringbuf_appendbytes(*strbuf, "\n", 1);
+		}
+	}
+	else {
+		/* Output a "D " entry for each deleted property */
+		for (this = apr_hash_first(pool, properties); this;
+		     this = apr_hash_next(this)) {
+			/* Get this key */
+			apr_hash_this(this, &key, &keylen, NULL);
+
+			/* Output name length, then name */
+			svn_stringbuf_appendcstr(*strbuf,
+						 apr_psprintf(pool, "D %" APR_SSIZE_T_FMT "\n",
+							      keylen));
+
+			svn_stringbuf_appendbytes(*strbuf, (const char *) key, keylen);
+			svn_stringbuf_appendbytes(*strbuf, "\n", 1);
+		}
+	}
+}
diff --git a/dumpr_util.h b/dumpr_util.h
index 166e214..1a5752b 100644
--- a/dumpr_util.h
+++ b/dumpr_util.h
@@ -31,4 +31,9 @@ struct edit_baton {
 	svn_checksum_t *checksum;
 };
 
+void write_hash_to_stringbuf(apr_hash_t *properties,
+			     svn_boolean_t deleted,
+			     svn_stringbuf_t **strbuf,
+			     apr_pool_t *pool);
+
 #endif
diff --git a/svndumpr.c b/svndumpr.c
index 853facd..011941f 100644
--- a/svndumpr.c
+++ b/svndumpr.c
@@ -23,6 +23,37 @@ static svn_error_t *replay_revstart(svn_revnum_t revision,
                                     apr_hash_t *rev_props,
                                     apr_pool_t *pool)
 {
+	/* Editing this revision has just started; dump the revprops
+	   before invoking the editor callbacks */
+	svn_stringbuf_t *propstring = svn_stringbuf_create("", pool);
+	svn_stream_t *stdout_stream;
+
+	/* Create an stdout stream */
+	svn_stream_for_stdout(&stdout_stream, pool);
+
+        /* Print revision number and prepare the propstring */
+	SVN_ERR(svn_stream_printf(stdout_stream, pool,
+				  SVN_REPOS_DUMPFILE_REVISION_NUMBER
+				  ": %ld\n", revision));
+	write_hash_to_stringbuf(rev_props, FALSE, &propstring, pool);
+	svn_stringbuf_appendbytes(propstring, "PROPS-END\n", 10);
+
+	/* prop-content-length header */
+	SVN_ERR(svn_stream_printf(stdout_stream, pool,
+				  SVN_REPOS_DUMPFILE_PROP_CONTENT_LENGTH
+				  ": %" APR_SIZE_T_FMT "\n", propstring->len));
+
+	/* content-length header */
+	SVN_ERR(svn_stream_printf(stdout_stream, pool,
+				  SVN_REPOS_DUMPFILE_CONTENT_LENGTH
+				  ": %" APR_SIZE_T_FMT "\n\n", propstring->len));
+
+	/* Print the revprops now */
+	SVN_ERR(svn_stream_write(stdout_stream, propstring->data,
+				 &(propstring->len)));
+
+	svn_stream_close(stdout_stream);
+
 	/* Extract editor and editor_baton from the replay_baton and
 	   set them so that the editor callbacks can use them */
 	struct replay_baton *rb = replay_baton;
@@ -39,6 +70,9 @@ static svn_error_t *replay_revend(svn_revnum_t revision,
                                   apr_hash_t *rev_props,
                                   apr_pool_t *pool)
 {
+	/* Editor has finished for this revision and close_edit has
+	   been called; do nothing: just continue to the next
+	   revision */
 	return SVN_NO_ERROR;
 }
 
@@ -89,8 +123,8 @@ svn_error_t *replay_range(svn_revnum_t start_revision, svn_revnum_t end_revision
 	                                    dump_baton, pool));
 
 	struct replay_baton *replay_baton = apr_palloc(pool, sizeof(struct replay_baton));
-	replay_baton->editor = debug_editor;
-	replay_baton->baton = debug_baton;
+	replay_baton->editor = dump_editor;
+	replay_baton->baton = dump_baton;
 	SVN_ERR(svn_cmdline_printf(pool, SVN_REPOS_DUMPFILE_MAGIC_HEADER ": %d\n",
 				   SVN_REPOS_DUMPFILE_FORMAT_VERSION));
 	SVN_ERR(svn_ra_replay_range(session, start_revision, end_revision,
-- 
1.7.1
