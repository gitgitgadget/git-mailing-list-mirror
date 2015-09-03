From: David Turner <dturner@twopensource.com>
Subject: [PATCH 17/43] refs.c: move head_ref_namespaced to the common code
Date: Wed,  2 Sep 2015 21:54:47 -0400
Message-ID: <1441245313-11907-18-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:55:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJkg-00065R-IA
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbbICBzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:55:44 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33505 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756209AbbICBzm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:55:42 -0400
Received: by qgev79 with SMTP id v79so18594488qge.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e0h71dVrx0PpQtGcTYNd0CmMzGLE91VDtsnhsv47gds=;
        b=CRtejDUkv5i41rlBlyjlhB2RN8uZzIMAilevyW+rzwIpGjaU8OGjq2Y1RXCKjfmf1W
         zV+4jOy+g9ECl44Fso6G/3KgrtN37dLUJbZ0QUMA3GmEJXPSgt8SzwoppOotPIrrgY5n
         TdbiRZxMgOcZ0qP2rmucL1WNtsgdGpL7jVR0V/+TcQ6xB1w8CthNrPhfuDnjX7V1UToZ
         MCOBdCO4kIdaq9fBWZv6FgD7UshDlCgoAgg9VnA6hpHNjsnELT5Mo3hdjyvrPH1WNxx3
         JpXiXC1egk00ZJP9GQv75P/oBNUrQDhNrZV7oDUq+D/YF8tyvOguD0WdIeCn1NZ2G7ji
         xMyg==
X-Gm-Message-State: ALoCoQlVyoet3gPk1YdxMRySaS8IxswQv8sLIQ1u3zWIMSzc9jk4XLthV28qQ/JJ6ieUsW96dn5o
X-Received: by 10.140.102.193 with SMTP id w59mr2276637qge.93.1441245341897;
        Wed, 02 Sep 2015 18:55:41 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.55.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:55:41 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277141>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c | 15 ---------------
 refs.c          | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index a36568f..21b38cf 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1948,21 +1948,6 @@ int for_each_reftype_fullpath(each_ref_fn fn, char *type, unsigned int broken, v
 	return do_for_each_ref(&ref_cache, type, fn, 0, flag, cb_data);
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
2.0.4.315.gad8727a-twtrsrc
