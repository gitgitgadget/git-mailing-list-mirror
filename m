From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH/RFC v4 10/16] vcs-svn: add fast_export_note to create notes
Date: Fri, 17 Aug 2012 22:25:51 +0200
Message-ID: <1345235157-702-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345235157-702-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 22:27:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2T8t-0006N3-EP
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 22:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196Ab2HQU10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 16:27:26 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34025 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758895Ab2HQU1B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 16:27:01 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr14so2001782wib.1
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 13:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=vAFOST64AB6xXkSpJ33xknC9dc3y1wRiGEdbAtdkQR0=;
        b=LGBL7bM1NBHLJNV/J7RByK/hAj8PLP4XsKn3DNvab/GDsuFwrbwL6jAmtNN71CXfNT
         rA9k5VaOeDDwPjlI6ECEFokMNUxfxZB0BiOkIJj97fwsHbS1bsf2kAtTrf2Af1IDo4fo
         GEzFzUmDH3r4XtycDbBoREL9YNZizoX9rmjh74lTwEqFmNhxhaJ7OMG4qsMiXb3URIK3
         ZVjwBHkWp1s1Nf94i5hpmQ9WGerszbdDwMUzxELeY2dN0FQsVOij+HBgsw3l1fFwElEQ
         bPgYArhqwF1QG3FxOGF/Fxvw/8KEVZN1UansXOWyHWB7VikeFKCIAFkwRdJajz5rsGpL
         uUlw==
Received: by 10.216.93.6 with SMTP id k6mr3367317wef.86.1345235220698;
        Fri, 17 Aug 2012 13:27:00 -0700 (PDT)
Received: from flobuntu.lan (91-115-81-15.adsl.highway.telekom.at. [91.115.81.15])
        by mx.google.com with ESMTPS id k2sm17372232wiz.7.2012.08.17.13.26.59
        (version=SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 13:26:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345235157-702-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203653>

From: Dmitry Ivankov <divanorama@gmail.com>

fast_export lacked a method to writes notes to fast-import stream.
Add two new functions fast_export_note which is similar to
fast_export_modify. And also add fast_export_buf_to_data to be able
to write inline blobs that don't come from a line_buffer or from delta
application.

To be used like this:
fast_export_begin_commit("refs/notes/somenotes", ...)

fast_export_note("refs/heads/master", "inline")
fast_export_buf_to_data(&data)
or maybe
fast_export_note("refs/heads/master", sha1)

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 vcs-svn/fast_export.c |   12 ++++++++++++
 vcs-svn/fast_export.h |    2 ++
 2 files changed, 14 insertions(+)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 11f8f94..1ecae4b 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -68,6 +68,11 @@ void fast_export_modify(const char *path, uint32_t mode, const char *dataref)
 	putchar('\n');
 }
 
+void fast_export_note(const char *committish, const char *dataref)
+{
+	printf("N %s %s\n", dataref, committish);
+}
+
 static char gitsvnline[MAX_GITSVN_LINE_LEN];
 void fast_export_begin_commit(uint32_t revision, const char *author,
 			const struct strbuf *log,
@@ -222,6 +227,13 @@ static long apply_delta(off_t len, struct line_buffer *input,
 	return ret;
 }
 
+void fast_export_buf_to_data(const struct strbuf *data)
+{
+	printf("data %"PRIuMAX"\n", (uintmax_t)data->len);
+	fwrite(data->buf, data->len, 1, stdout);
+	fputc('\n', stdout);
+}
+
 void fast_export_data(uint32_t mode, off_t len, struct line_buffer *input)
 {
 	assert(len >= 0);
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index 17eb13b..9b32f1e 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -9,11 +9,13 @@ void fast_export_deinit(void);
 
 void fast_export_delete(const char *path);
 void fast_export_modify(const char *path, uint32_t mode, const char *dataref);
+void fast_export_note(const char *committish, const char *dataref);
 void fast_export_begin_commit(uint32_t revision, const char *author,
 			const struct strbuf *log, const char *uuid,
 			const char *url, unsigned long timestamp, const char *local_ref);
 void fast_export_end_commit(uint32_t revision);
 void fast_export_data(uint32_t mode, off_t len, struct line_buffer *input);
+void fast_export_buf_to_data(const struct strbuf *data);
 void fast_export_blob_delta(uint32_t mode,
 			uint32_t old_mode, const char *old_data,
 			off_t len, struct line_buffer *input);
-- 
1.7.9.5
