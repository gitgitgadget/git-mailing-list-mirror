From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 24/26] refs: make files_log_ref_write functions public
Date: Thu, 15 Oct 2015 15:46:48 -0400
Message-ID: <1444938410-2345-25-git-send-email-dturner@twopensource.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 15 21:47:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmoV7-00074w-GK
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 21:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbbJOTrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 15:47:36 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:36276 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053AbbJOTre (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 15:47:34 -0400
Received: by qgx61 with SMTP id 61so80928399qgx.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5uKtyltUUlj0PNxH4GIb+ahT5wRMwouhOtA3QoDd9p4=;
        b=a2pubh8jt8dol8hehcK4IruHQofdKearu8SY9+POA9pQ+i5q/5NHb0Z72OZY4DQRiY
         6mBsV8svNG3ZJplp+UTdtw0evJGlPQUjZAh6n6Da+dbyijk0eocTokSj7ZrlPBPDF2vR
         4h5hFGh268rVzRO4dUu178Qn08TuIi7YYpoecvUNVAEoHjVs7SCmFN7dd0RZefjcujqe
         DNzafIl/Fy3eoCWaLevwsmx2VeKNKvGNoHZiSobp9CW36G9MOmf6gkheh1mdCsL60LjP
         PnUcM4IfmIp4NTPg4jivYlsURO0QxpxzMA1bz9CwJtKXRtDjdzv/zzBk9G5o+26kFCbx
         9GWA==
X-Gm-Message-State: ALoCoQnSZ4aGaZ197gGs7XsWFSB2UnT+rq4bLQ4dSZzsStvws6qBS8Yz8gcF3hpjyxdXEqLGy+y0
X-Received: by 10.140.150.4 with SMTP id 4mr14216375qhw.35.1444938453765;
        Thu, 15 Oct 2015 12:47:33 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p193sm6054142qha.29.2015.10.15.12.47.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Oct 2015 12:47:33 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279689>

Because HEAD and stash are per-worktree, refs.c needs to go through
the files backend to write these refs.

In this patch, we make one files backend internal functions
public. Later, we will use this to handle reflog updates for
per-worktree symbolic refs (HEAD).

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs-be-files.c | 8 ++++++++
 refs.h          | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/refs-be-files.c b/refs-be-files.c
index 7c39afa..1bda3e4 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
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
diff --git a/refs.h b/refs.h
index 3fce9c9..7aed0a2 100644
--- a/refs.h
+++ b/refs.h
@@ -619,6 +619,11 @@ enum ref_type ref_type(const char *refname);
  */
 int copy_reflog_msg(char *buf, const char *msg);
 
+int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
+			const unsigned char *new_sha1, const char *msg,
+			int flags, struct strbuf *err);
+
+
 enum expire_reflog_flags {
 	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
 	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
-- 
2.4.2.644.g97b850b-twtrsrc
