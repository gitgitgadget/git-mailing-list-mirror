From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 36/44] refs: make files_log_ref_write functions public
Date: Mon, 12 Oct 2015 17:51:57 -0400
Message-ID: <1444686725-27660-38-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:53:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll29-0005Ke-8h
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbbJLVwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:52:54 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35036 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548AbbJLVwx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:53 -0400
Received: by qkap81 with SMTP id p81so63253313qka.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lv2Bny8ZmyQrCg+OVVUSmiTF0F3/xm7gphMMhXmBhPs=;
        b=USgrvL4NTqzJWtLqiBoKhRmeXmmfIa8mUJlkZXHFdo/maOeSIcGcC5d00qQCzv8+iF
         GRWu6VPM0OFvK5LTjtdfbspywkNJ5zVM1+CH7FzV4+AITQNcv6xN0ZZE3qCam0JJXV/A
         PWsm6QacWYbdmI7sC38g/0y4Nnw5pDC2GW++jwggZ6Mvw1+5qjrhEBVmVIvrNaSaBp8Z
         gtgJnKul8jUEnrZnXM/ZJcIbqGuqZl1WZNPhv/RwakZN8AxVi8pZhF7oL/R5pbrZ7MBA
         nvk0oQMBdXhwdrTXCt2xMn2OnkJyvqiyybdDrTyuGZx9VQ17MotcH+pb67g2ErfYodpq
         iVEA==
X-Gm-Message-State: ALoCoQnabyhOUw1DqdVNhI1wmz4Li7T8sPf1atGaJx95AGf2OgDoT23R+RBRSbW9VfAIPTQz+aDb
X-Received: by 10.55.201.217 with SMTP id m86mr35184692qkl.85.1444686772958;
        Mon, 12 Oct 2015 14:52:52 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:52 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279445>

Because HEAD and stash are per-worktree, refs.c needs to go through
the files backend to write these refs.

In this patch, we make one files backend internal functions
public. Later, we will use this to handle reflog updates for
per-worktree symbolic refs (HEAD).

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 8 ++++++++
 refs.h          | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/refs-be-files.c b/refs-be-files.c
index 798a995..8d1ffce 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2710,6 +2710,14 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
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
index 4d8b3bb..3aad3b8 100644
--- a/refs.h
+++ b/refs.h
@@ -633,6 +633,11 @@ enum ref_type ref_type(const char *refname);
 
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
