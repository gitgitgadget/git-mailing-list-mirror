From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 11/13] Implement apply_textdelta
Date: Wed,  7 Jul 2010 02:14:51 +0200
Message-ID: <1278461693-3828-12-git-send-email-artagnon@gmail.com>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarb@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, dev@subversion.apache.org
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 07 02:14:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWIHW-00057s-HW
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 02:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756020Ab0GGANv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 20:13:51 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39519 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755910Ab0GGANs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 20:13:48 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so1968051ewy.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 17:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8jI/FJv0lOZsk7BPOTnzKR0/6DuYpi86YU2Ac9A/XRY=;
        b=dq9sXIZFZs+ggEpEG/LgXV+C6iwqHidOBUZnelRA5SShOAbmQA7v1/fqWkI4RGfOJA
         sIFCbkXjIuXZaz6i8rX3NBErxByrxb59mjfoJtweA/2fnahdD84H0BQdGmPt1VB2FO8i
         OUCL0h+Vgo3GFcIn+8Kd2OkInCLBPVogWcrXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QhoSqIL1tlBO5scID0EhPHMa2y1eZ4RIuyVqjW8ZXrSYJXsfiKjFN2p2gFAoDMYm9v
         ZT7FpBWCXAF0oEJz7prpPMkVYMkW3W3we3utrDwfr8+t1eTjXPm6vrR08376HMrrFHhr
         ARy2tqfiOtvlSwg2sHzGQUIj95js8zmSs+aGc=
Received: by 10.213.32.197 with SMTP id e5mr5112177ebd.92.1278461627779;
        Tue, 06 Jul 2010 17:13:47 -0700 (PDT)
Received: from localhost (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id v59sm55867795eeh.16.2010.07.06.17.13.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 17:13:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150433>

apply_textdelta picks up information from the file_baton (set by
add_file or open_file) and sets handler/ handler_baton to write a text
delta. It uses a temporary file because the content length of the
delta needs to be determined. Also add a related window_handler helper
function gets the path of the temporary file written and cleans up
after apply_textdelta. The text and prop deltas will finally be dumped
in close_file.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 dump_editor.c |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 dumpr_util.h  |   15 ++++++++++++++
 2 files changed, 74 insertions(+), 1 deletions(-)

diff --git a/dump_editor.c b/dump_editor.c
index 7006a2c..51d5ebe 100644
--- a/dump_editor.c
+++ b/dump_editor.c
@@ -452,11 +452,69 @@ svn_error_t *change_file_prop(void *file_baton,
 	return SVN_NO_ERROR;
 }
 
+svn_error_t *window_handler(svn_txdelta_window_t *window, void *baton)
+{
+	struct handler_baton *hb = baton;
+	struct edit_baton *eb = hb->eb;
+	svn_error_t *err;
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
+	return SVN_NO_ERROR;
+}
+
 svn_error_t *apply_textdelta(void *file_baton, const char *base_checksum,
                              apr_pool_t *pool,
                              svn_txdelta_window_handler_t *handler,
                              void **handler_baton)
 {
+	svn_stream_t *source_stream;
+	struct edit_baton *eb = file_baton;
+	apr_status_t apr_err;
+
+	/* Custom handler_baton allocated in a separate pool */
+	apr_pool_t *handler_pool = svn_pool_create(pool);
+	struct handler_baton *hb = apr_pcalloc(handler_pool, sizeof(*hb));
+	hb->pool = handler_pool;
+	hb->eb = eb;
+
+	/* Unset both handlers: To be set by two different functions later */
+	hb->apply_handler = NULL;
+
+	/* Use a temporary file to measure the text-content-length */
+	hb->temp_filepath = apr_psprintf(eb->pool, "/tmp/svn-fe/XXXXXX");
+	apr_err = apr_file_mktemp(&(hb->temp_file), hb->temp_filepath,
+				  APR_CREATE | APR_READ | APR_WRITE | APR_EXCL,
+				  hb->pool);
+	if (apr_err != APR_SUCCESS)
+		SVN_ERR(svn_error_wrap_apr(apr_err, NULL));
+
+	hb->temp_filestream = svn_stream_from_aprfile2(hb->temp_file, TRUE, hb->pool);
+	source_stream = svn_stream_empty(hb->pool);
+
+	/* Prepare to write the delta to the temporary file */
+	svn_txdelta_to_svndiff2(&(hb->apply_handler), &(hb->apply_baton),
+	                        hb->temp_filestream, 0, hb->pool);
+	must_dump_text = TRUE;
+
+	/* The actual writing takes place when this function has finished */
+	/* Set the handler and handler_baton */
+	*handler = window_handler;
+	*handler_baton = hb;
+
 	return SVN_NO_ERROR;
 }
 
@@ -493,7 +551,7 @@ svn_error_t *get_dump_editor(const svn_delta_editor_t **editor,
 	de->close_directory = close_directory;
 	de->change_dir_prop = change_dir_prop;
 	de->change_file_prop = change_file_prop;
-	/* de->apply_textdelta = apply_textdelta; */
+	de->apply_textdelta = apply_textdelta;
 	de->add_file = add_file;
 	de->open_file = open_file;
 	de->close_file = close_file;
diff --git a/dumpr_util.h b/dumpr_util.h
index 79de1ab..3830a1d 100644
--- a/dumpr_util.h
+++ b/dumpr_util.h
@@ -61,6 +61,21 @@ struct dir_baton {
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
+	struct edit_baton *eb;
+};
+
 void write_hash_to_stringbuf(apr_hash_t *properties,
 			     svn_boolean_t deleted,
 			     svn_stringbuf_t **strbuf,
-- 
1.7.1
