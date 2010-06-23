From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [WIP PATCH 7/7] Dump the text delta
Date: Wed, 23 Jun 2010 18:22:20 +0200
Message-ID: <1277310140-16891-8-git-send-email-artagnon@gmail.com>
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
	id 1ORShu-0001OF-ES
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 18:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770Ab0FWQV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 12:21:27 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:46926 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041Ab0FWQVY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 12:21:24 -0400
Received: by mail-ww0-f46.google.com with SMTP id 33so1178857wwc.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 09:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=RzTpyDxzoc+vOurLdFscRpKQ3Fm/KFmb8kGU80ZMhc0=;
        b=kBELj355UOJjTUTor5jMHwz79W3K3okOU4FyNYdH+6Q33qPgkwFFzyfXRooCG6+3V0
         KbTB12DHkxd3YLhmlJvJDLzWjswQHFJT7KgiKxnhzL1FQckN37QMCJBJPqK5xuSPB6XN
         JPCp6/EyR5zHaNUDDosgzC+WmIKAxOZ+W/Y7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YUj3uH+Re2cQKjPtZFU1tO8rmVP1KWwNud5Le26A3sf1nW/rVUPIcUEDs6mT7COFWl
         8Ez+AVjTpCAuoE2WcfJYiWdwRcLpbg9Suy+rijLKDt/L3DGlz0sCsm89ojy74sTuUiYd
         FEcTydywEuuj7NYqh3rLc3X0bXOXIzryhT+Xo=
Received: by 10.216.172.83 with SMTP id s61mr2765008wel.1.1277310083755;
        Wed, 23 Jun 2010 09:21:23 -0700 (PDT)
Received: from localhost ([130.226.133.98])
        by mx.google.com with ESMTPS id g17sm787636wee.29.2010.06.23.09.21.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jun 2010 09:21:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1277310140-16891-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149516>

Add a handler and handler_baton to handle text deltas in the editor
baton. Currently, program exits with code 01 because delta source ends
unexpectedly.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 dump_editor.c |   51 +++++++++++++++++++++++++++++++--------------------
 1 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/dump_editor.c b/dump_editor.c
index 7bd00a4..2192177 100644
--- a/dump_editor.c
+++ b/dump_editor.c
@@ -27,12 +27,13 @@ struct edit_baton {
 	apr_hash_t *properties;
 	apr_hash_t *del_properties; /* Value is always 0x1 */
 
-	/* Store the text delta */
-	const char *delta_text;
-
 	/* reusable buffer for writing file contents */
 	char buffer[SVN__STREAM_CHUNK_SIZE];
 	apr_size_t bufsize;
+
+	/* The txdelta handler and handler baton */
+	svn_txdelta_window_handler_t *handler;
+	void **handler_baton;
 };
 
 struct dir_baton {
@@ -351,22 +352,9 @@ static svn_error_t *dump_node(struct edit_baton *eb,
 		len = propstring->len;
 		SVN_ERR(svn_stream_write(eb->stream, propstring->data, &len));
 	}
-	/* if (must_dump_text && (kind == svn_node_file)) */
-	/* { */
-	/* 	svn_stream_t *contents; */
-
-	/* 	if (delta_file) */
-	/* 	{ */
-	/* 		/\* Make sure to close the underlying file when the stream is */
-	/* 		   closed. *\/ */
-	/* 		contents = svn_stream_from_aprfile2(delta_file, FALSE, pool); */
-	/* 	} */
-	/* 	else */
-	/* 		SVN_ERR(svn_fs_file_contents(&contents, eb->fs_root, path, pool)); */
-
-	/* 	SVN_ERR(svn_stream_copy3(contents, svn_stream_disown(eb->stream, pool), */
-	/* 	                         NULL, NULL, pool)); */
-	/* } */
+	if (must_dump_text && (kind == svn_node_file) && eb->handler) {
+		svn_txdelta_to_svndiff2(eb->handler, eb->handler_baton, eb->stream, 0, pool);
+	}
 
 	return SVN_NO_ERROR;
 }
@@ -610,6 +598,28 @@ svn_error_t *change_file_prop(void *file_baton,
 	return SVN_NO_ERROR;
 }
 
+svn_error_t *apply_textdelta(void *file_baton, const char *base_checksum,
+                             apr_pool_t *pool,
+                             svn_txdelta_window_handler_t *handler,
+                             void **handler_baton)
+{
+	struct file_baton *fb = file_baton;
+	svn_stream_t *source_stream = svn_stream_empty(pool);
+	svn_txdelta_apply(source_stream, fb->eb->stream,
+	                  NULL, fb->path, pool, handler,
+	                  handler_baton);
+	fb->eb->handler = handler;
+	fb->eb->handler_baton = handler_baton;
+
+	text_changed = TRUE;
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
@@ -630,7 +640,8 @@ svn_error_t *get_dump_editor(const svn_delta_editor_t **editor,
 	dump_editor->open_directory = open_directory;
 	dump_editor->close_directory = close_directory;
 	dump_editor->change_dir_prop = change_dir_prop;
-	dump_editor->change_file_prop = change_file_prop;	
+	dump_editor->change_file_prop = change_file_prop;
+	dump_editor->apply_textdelta = apply_textdelta;
 	dump_editor->add_file = add_file;
 	dump_editor->open_file = open_file;
 
-- 
1.7.1
