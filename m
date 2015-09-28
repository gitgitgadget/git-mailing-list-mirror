From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 17/43] refs.c: move head_ref_namespaced to the common code
Date: Mon, 28 Sep 2015 18:01:52 -0400
Message-ID: <1443477738-32023-18-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:04:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggXR-0002Y7-Fq
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754946AbbI1WEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:04:43 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35011 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754172AbbI1WDO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:14 -0400
Received: by qkap81 with SMTP id p81so74441596qka.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vIzpuvTQzx+6IhRzi5HnQqY//1WjsvF3gmsNpW9WMnk=;
        b=ByjbAxZ4xVAIk/PJu+LZSLhydmal1u53NnLYow10naq9hgqAMqDfU2gfP8q813JCis
         sTDx/Y4uk5i0IIojuVF6YADgdpXFvIXm/4ozN2qFpJ1Xb1cCL0qw1A+lH0RhpL/9vbz8
         SeZVr9v2xDECV2XBYjuWKQI6gSmKePwKRkSnNE1zRXr/nFqHgvlFBGIDgq0nzmnifFa0
         nE1Wy22Pfq5/JiC4RTPnrDVM+qN1qZaQn3yqaoRhIHV5GF3Cnonmn7FMPZGuMjVRcwaj
         R4pwWppCufTgWJVRVrLmV+vIB8T9JX14GsiZBfVPnvFYGJ5PPRHZEEHJiDziRB/Hr9Yk
         4ggQ==
X-Gm-Message-State: ALoCoQk/hUpSj/6m+2Y1q+/EweexPsLL7/1necZ9imBJwQnnwDOQ6JEPuHiEqj/SkOjZujEtF5S0
X-Received: by 10.55.23.9 with SMTP id i9mr25926791qkh.22.1443477793775;
        Mon, 28 Sep 2015 15:03:13 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:13 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278788>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c | 15 ---------------
 refs.c          | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 5a7e406..05a4b88 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1951,21 +1951,6 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
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
