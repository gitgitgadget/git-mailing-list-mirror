From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 17/44] refs.c: move head_ref_namespaced to the common code
Date: Mon, 12 Oct 2015 17:51:37 -0400
Message-ID: <1444686725-27660-18-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:52:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll1N-0004UF-BV
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454AbbJLVwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:52:39 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:34926 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275AbbJLVwb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:31 -0400
Received: by qkap81 with SMTP id p81so63250388qka.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1//+6mtq2Xym4G8imY9M9AM1xecvpu7uHR7G5NXJP8w=;
        b=PEv4L/HBG3tB/H4tMmQPfjHI+Iesg9IZwwhE/V0v5fUs16c1WMLhVRb7WtHg4ZcW+1
         7oQZwmzVt5DTGx2IQyqsSzDN3J2q+s2dI1cL7G7FOv49GUD+a9Axbj0/DBs4QVZ5NxNK
         8wP6ZEdRE1XWzAVFCa/2Fq3HwpzQgpyNavP5GpwNf4yBde+5mSWXnOQzenCDDJb5Kd1y
         oc0qQ75qj1U14Fbxc3IUiEo5NM5tyB2ViTFU6C4hjBv6K5mCyFb1vFXvYKAAQ/NmE63r
         RXpDlweWnaGnu/JuYni4cPssBw3top+werMIaQlRH5XlYtTHU9Y692wQEu6t+f2/C3FN
         kOTw==
X-Gm-Message-State: ALoCoQnAobMHMUHuhVO/h2tMjmHkVt47Smm64yqkCVHqIjvsaPf9Y8M8TE51MiBYcW8yiCou5gIL
X-Received: by 10.55.23.83 with SMTP id i80mr35513522qkh.5.1444686750877;
        Mon, 12 Oct 2015 14:52:30 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:30 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279429>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c | 15 ---------------
 refs.c          | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 46fa43c..34ed220 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1939,21 +1939,6 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 			       strlen(git_replace_ref_base), 0, cb_data);
 }
 
-int head_ref_namespaced(each_ref_fn fn, void *cb_data)
-{
-	struct strbuf buf = STRBUF_INIT;
-	int ret = 0;
-	struct object_id oid;
-	int flag;
-
-	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
-	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, oid.hash, &flag))
-		ret = fn(buf.buf, &oid, flag, cb_data);
-	strbuf_release(&buf);
-
-	return ret;
-}
-
 int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/refs.c b/refs.c
index 7714dad..0f4e19a 100644
--- a/refs.c
+++ b/refs.c
@@ -862,3 +862,18 @@ int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *c
 {
 	return for_each_ref_in_submodule(submodule, "refs/remotes/", fn, cb_data);
 }
+
+int head_ref_namespaced(each_ref_fn fn, void *cb_data)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int ret = 0;
+	struct object_id oid;
+	int flag;
+
+	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
+	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, oid.hash, &flag))
+		ret = fn(buf.buf, &oid, flag, cb_data);
+	strbuf_release(&buf);
+
+	return ret;
+}
-- 
2.4.2.644.g97b850b-twtrsrc
