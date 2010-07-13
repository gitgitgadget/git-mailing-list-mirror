From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 8/9] Implement close_file
Date: Wed, 14 Jul 2010 01:36:15 +0200
Message-ID: <1279064176-6645-9-git-send-email-artagnon@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Jul 14 01:36:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYp1s-0008BW-SE
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 01:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757284Ab0GMXgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 19:36:40 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43675 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757245Ab0GMXgh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 19:36:37 -0400
Received: by mail-ey0-f174.google.com with SMTP id 25so898848eya.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 16:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=E86Iys+y7gzE3P/uYTBVf1eo2UHx92uQfAJNMPvBSWU=;
        b=tfcIOPwEk2GJPs8QmQYBQwtfqw/+VVcB4H94Ixw7YURzcBafJNfRrd4XQqnmoryuqn
         D++2a3x9rYfoMvMQKGdlhpzAY1bs0hTf9TmsnvwFDAgj69TWRP+SbbD5cujkIbgTm5G0
         xmDt9N1Rl2ptNt+eYH3N72IXO8SfOryT7dKMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=q2se6+17YghBuxefAIerT6FXrDbCyUUamW24e7nhfstZWuu407VWxdZn3HRrD9mpYc
         03lvGFs2A1orkwjQxZ7hm0NIzVz/vXeMJDig2fU24Yq8/96W6HdZG6RktBwMnW/YgH+t
         ljZ6SAB0VfXeS6M6IDzQhpB+n6lamUdIVbAZc=
Received: by 10.213.13.133 with SMTP id c5mr7502508eba.26.1279064196530;
        Tue, 13 Jul 2010 16:36:36 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id a48sm51516701eei.1.2010.07.13.16.36.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 16:36:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150947>

close_file measures the length of the temporary file to write text
headers and full text before cleaning up the temporary file. It also
writes props and prop deltas if necessary.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 dump_editor.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/dump_editor.c b/dump_editor.c
index 8b0a830..b2fd3d6 100644
--- a/dump_editor.c
+++ b/dump_editor.c
@@ -533,7 +533,82 @@ static svn_error_t *close_file(void *file_baton,
 			       const char *text_checksum,
 			       apr_pool_t *pool)
 {
+	struct dump_edit_baton *eb = file_baton;
+	apr_file_t *temp_file;
+	svn_stream_t *temp_filestream;
+	apr_finfo_t *info = apr_pcalloc(pool, sizeof(apr_finfo_t));
+
+	/* We didn't write the property headers because we were
+	   waiting for file_prop_change; write them now */
+	SVN_ERR(dump_props(eb, &(eb->dump_props_pending), FALSE, pool));
+
+	/* The prop headers have already been dumped in dump_node */
+	/* Dump the text headers */
+	if (eb->must_dump_text) {
+		/* text-delta header */
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+					  SVN_REPOS_DUMPFILE_TEXT_DELTA
+					  ": true\n"));
+
+		/* Measure the length */
+		SVN_ERR(svn_io_stat(info, eb->temp_filepath, APR_FINFO_SIZE, pool));
+
+		/* text-content-length header */
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+					  SVN_REPOS_DUMPFILE_TEXT_CONTENT_LENGTH
+					  ": %lu\n",
+					  (unsigned long)info->size));
+		/* text-content-md5 header */
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+					  SVN_REPOS_DUMPFILE_TEXT_CONTENT_MD5
+					  ": %s\n",
+					  text_checksum));
+	}
+
+	/* content-length header: if both text and props are absent,
+	   skip this block */
+	if (eb->must_dump_props || eb->dump_props_pending)
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+					  SVN_REPOS_DUMPFILE_CONTENT_LENGTH
+					  ": %ld\n\n",
+					  (unsigned long)info->size + eb->propstring->len));
+	else if (eb->must_dump_text)
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+					  SVN_REPOS_DUMPFILE_CONTENT_LENGTH
+					  ": %ld\n\n",
+					  (unsigned long)info->size));
+
+	/* Dump the props; the propstring should have already been
+	   written in dump_node or above */
+	if (eb->must_dump_props || eb->dump_props_pending) {
+		SVN_ERR(svn_stream_write(eb->stream, eb->propstring->data,
+					 &(eb->propstring->len)));
+
+		/* Cleanup */
+		eb->must_dump_props = eb->dump_props_pending = FALSE;
+		apr_hash_clear(eb->properties);
+		apr_hash_clear(eb->del_properties);
+	}
+
+	/* Dump the text */
+	if (eb->must_dump_text) {
+
+		/* Open the temporary file, map it to a stream, copy
+		   the stream to eb->stream, close and delete the
+		   file */
+		SVN_ERR(svn_io_file_open(&temp_file, eb->temp_filepath, APR_READ, 0600, pool));
+		temp_filestream = svn_stream_from_aprfile2(temp_file, TRUE, pool);
+		SVN_ERR(svn_stream_copy3(temp_filestream, eb->stream, NULL, NULL, pool));
+
+		/* Cleanup */
+		SVN_ERR(svn_io_file_close(temp_file, pool));
+		SVN_ERR(svn_stream_close(temp_filestream));
+		SVN_ERR(svn_io_remove_file2(eb->temp_filepath, TRUE, pool));
+		eb->must_dump_text = FALSE;
+	}
+
+	SVN_ERR(svn_stream_printf(eb->stream, pool, "\n\n"));
+
 	return SVN_NO_ERROR;
 }
 
-- 
1.7.1
