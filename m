From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 12/13] Implement close_file
Date: Wed,  7 Jul 2010 02:14:52 +0200
Message-ID: <1278461693-3828-13-git-send-email-artagnon@gmail.com>
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
X-From: dev-return-4822-gcvsd-dev=m.gmane.org@subversion.apache.org Wed Jul 07 02:14:23 2010
Return-path: <dev-return-4822-gcvsd-dev=m.gmane.org@subversion.apache.org>
Envelope-to: gcvsd-dev@lo.gmane.org
Received: from hermes.apache.org ([140.211.11.3] helo=mail.apache.org)
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <dev-return-4822-gcvsd-dev=m.gmane.org@subversion.apache.org>)
	id 1OWIHN-00053B-74
	for gcvsd-dev@lo.gmane.org; Wed, 07 Jul 2010 02:14:21 +0200
Received: (qmail 99012 invoked by uid 500); 7 Jul 2010 00:14:19 -0000
Mailing-List: contact dev-help@subversion.apache.org; run by ezmlm
Precedence: bulk
List-Help: <mailto:dev-help@subversion.apache.org>
List-Unsubscribe: <mailto:dev-unsubscribe@subversion.apache.org>
List-Post: <mailto:dev@subversion.apache.org>
List-Id: <dev.subversion.apache.org>
Delivered-To: mailing list dev@subversion.apache.org
Received: (qmail 99004 invoked by uid 99); 7 Jul 2010 00:14:19 -0000
Received: from nike.apache.org (HELO nike.apache.org) (192.87.106.230)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 07 Jul 2010 00:14:19 +0000
X-ASF-Spam-Status: No, hits=0.0 required=10.0
	tests=FREEMAIL_FROM,SPF_PASS
X-Spam-Check-By: apache.org
Received-SPF: pass (nike.apache.org: domain of artagnon@gmail.com designates 209.85.215.43 as permitted sender)
Received: from [209.85.215.43] (HELO mail-ew0-f43.google.com) (209.85.215.43)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 07 Jul 2010 00:14:10 +0000
Received: by mail-ew0-f43.google.com with SMTP id 1so2219808ewy.16
        for <dev@subversion.apache.org>; Tue, 06 Jul 2010 17:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OhRFhxI+O+P5LTpaieKzSjZ/Y+1P+Az5bH00F3jy3XA=;
        b=aD8+XB8YXFyFEtEHJnoooiRBp0aSjuIa18vGLQAb5C2Iv7xY8xLFAZ3YVLqBieCx3z
         a8dJZ6+Xqi4708eB1eZW/h+VJB0+mBSZsyAWAdEkidHdx97hlxb2WfNTQkRTJ8+8F7dF
         /qeJILsF3msmMCayohlm5IARz3oRJ4bAFTC+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BtV2r3PJzQakHne5b0STKXPg2Of0/v8937jgSaoHUFIqvlmMytIFblxTpWkM2fshfV
         j8caZU5n3qC1Ml9T1d0a+S3nQE1JPlygDVZxd/D2x0ybBMwQuwG1szF77vf0O9Kwxt/B
         p3XspsxD7lAJGtlwyGAsDz3W3CXaPnOdGcVv0=
Received: by 10.213.8.134 with SMTP id h6mr5098178ebh.40.1278461630250;
        Tue, 06 Jul 2010 17:13:50 -0700 (PDT)
Received: from localhost (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id v8sm55843067eeh.20.2010.07.06.17.13.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 17:13:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
X-Virus-Checked: Checked by ClamAV on apache.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150431>

close_file measures the length of the temporary file to write text
headers and full text before cleaning up the temporary file. It also
writes props and prop deltas if necessary.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 dump_editor.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/dump_editor.c b/dump_editor.c
index 51d5ebe..6f74af9 100644
--- a/dump_editor.c
+++ b/dump_editor.c
@@ -522,6 +522,82 @@ svn_error_t *close_file(void *file_baton,
 			const char *text_checksum,
 			apr_pool_t *pool)
 {
+	struct edit_baton *eb = file_baton;
+	apr_file_t *temp_file;
+	svn_stream_t *temp_filestream;
+	apr_finfo_t *info = apr_pcalloc(pool, sizeof(apr_finfo_t));
+
+	/* We didn't write the property headers because we were
+	   waiting for file_prop_change; write them now */
+	SVN_ERR(dump_props(eb, &dump_props_pending, FALSE, pool));
+
+	/* The prop headers have already been dumped in dump_node */
+	/* Dump the text headers */
+	if (must_dump_text) {
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
+					   ": %s\n",
+					  text_checksum));
+	}
+
+	/* content-length header: if both text and props are absent,
+	   skip this block */
+	if (must_dump_props || dump_props_pending)
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+					  SVN_REPOS_DUMPFILE_CONTENT_LENGTH
+					  ": %ld\n\n",
+					  (unsigned long)info->size + eb->propstring->len));
+	else if (must_dump_text)
+		SVN_ERR(svn_stream_printf(eb->stream, pool,
+					  SVN_REPOS_DUMPFILE_CONTENT_LENGTH
+					  ": %ld\n\n",
+					  (unsigned long)info->size));
+
+	/* Dump the props; the propstring should have already been
+	   written in dump_node or above */
+	if (must_dump_props || dump_props_pending) {
+		SVN_ERR(svn_stream_write(eb->stream, eb->propstring->data,
+					 &(eb->propstring->len)));
+
+		/* Cleanup */
+		must_dump_props = dump_props_pending = FALSE;
+		apr_hash_clear(eb->properties);
+		apr_hash_clear(eb->del_properties);
+	}
+
+	/* Dump the text */
+	if (must_dump_text) {
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
+		must_dump_text = FALSE;
+	}
+
+	SVN_ERR(svn_stream_printf(eb->stream, pool, "\n\n"));
+
 	return SVN_NO_ERROR;
 }
 
-- 
1.7.1
