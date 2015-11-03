From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 23/25] files_log_ref_write: new function
Date: Tue,  3 Nov 2015 08:40:07 +0100
Message-ID: <5b305c7ef25dc53e5b6ee11169c16fdbeda4ad86.1446534991.git.mhagger@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:48:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWKe-0006Bb-6e
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbbKCHs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:48:29 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:61774 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752793AbbKCHs0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:48:26 -0500
X-AuditID: 1207440e-f79516d0000012b3-f5-563864faa38e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 88.37.04787.AF468365; Tue,  3 Nov 2015 02:40:42 -0500 (EST)
Received: from michael.fritz.box (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37eDdK016391
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:40:41 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1446534991.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqPsrxSLM4O40XYv5m04wWnRd6Way
	aOi9wmxxe8V8ZgcWj7/vPzB5XLyk7LHg+X12j8+b5AJYorhtkhJLyoIz0/P07RK4M2a1v2Ip
	OMBXcfnsP5YGxv/cXYwcHBICJhITNuR1MXICmWISF+6tZ+ti5OIQErjMKPH4wyJmCOcYk8Tr
	r1PYQKrYBHQlFvU0M4HYIgJqEhPbDrGADGIWKJK4068DEhYWsJZom9rPDGKzCKhKvPr2mQXE
	5hWIkmia9o0FYpmcxJT77WBjOAUsJB7c/cMOYgsJmEtsureMbQIj7wJGhlWMcok5pbm6uYmZ
	OcWpybrFyYl5ealFusZ6uZkleqkppZsYIcHDt4Oxfb3MIUYBDkYlHt4FS8zDhFgTy4orcw8x
	SnIwKYnyrouxCBPiS8pPqcxILM6ILyrNSS0+xCjBwawkwlsQCJTjTUmsrEotyodJSXOwKInz
	qi1R9xMSSE8sSc1OTS1ILYLJynBwKEnwzk4GahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0kt
	SiwtyYgHxUV8MTAyQFI8QHsTUkD2Fhck5gJFIVpPMSpKifNOBpkrAJLIKM2DGwtLCa8YxYG+
	FOYNA6niAaYTuO5XQIOZgAaHbzMFGVySiJCSamCM/VlkrLnwzUXjylUvXAKkd0XYP3ebEveJ
	3efDYybBr1c1DovqFFz9ukGJPbDijKPSfP/dCy+e/d6xKS1R4MRlxhDe0AP+n01/rJz0ID6w
	Tj3ccE3tc5s1E3u4z7OwyFwMMLqxYGPv1fz8EinbJfxPv08P2GGRbG3mGfyWWzr+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280779>

From: David Turner <dturner@twopensource.com>

Because HEAD and stash are per-worktree, every refs backend needs to
go through the files backend to write these refs.

So create a new function, files_log_ref_write, and add it to
refs/refs-internal.h. Later, we will use this to handle reflog updates
for per-worktree symbolic refs (HEAD).

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 8 ++++++++
 refs/refs-internal.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7dc68b8..20e2924 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2733,6 +2733,14 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 			 const unsigned char *new_sha1, const char *msg,
 			 int flags, struct strbuf *err)
 {
+	return files_log_ref_write(refname, old_sha1, new_sha1, msg, flags,
+				   err);
+}
+
+int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
+			const unsigned char *new_sha1, const char *msg,
+			int flags, struct strbuf *err)
+{
 	struct strbuf sb = STRBUF_INIT;
 	int ret = log_ref_write_1(refname, old_sha1, new_sha1, msg, &sb, flags,
 				  err);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index d854d9e..5f447d4 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -157,4 +157,8 @@ extern int should_autocreate_reflog(const char *refname);
  */
 int copy_reflog_msg(char *buf, const char *msg);
 
+int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
+			const unsigned char *new_sha1, const char *msg,
+			int flags, struct strbuf *err);
+
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.6.2
