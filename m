From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 17/26] refs.c: move head_ref_namespaced to the common code
Date: Thu, 15 Oct 2015 15:46:41 -0400
Message-ID: <1444938410-2345-18-git-send-email-dturner@twopensource.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 15 21:48:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmoVL-0007IP-II
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 21:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbbJOTrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 15:47:52 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:33617 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbbJOTrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 15:47:25 -0400
Received: by qgeo38 with SMTP id o38so36980295qge.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YgNsUT6TWX+Lnf3mnztOvyTTtW2kwPqfA/VOhdQmfaw=;
        b=Lod2omwYgfA3eu5ssQ/Jt2ISb7EvdNgQ2ozo3AQEWj7ZFWRiAvI/ck14p0dcfSbkuC
         f+X6I5rJbQ3jCAf79A5E6wrPid7Z6w9nDvPEEOqMTFRmeSRux7X1eIT5JpggI41vkjkd
         Hpe0eAGhZ6f68hJr9PuRwwEtaPRvBP2QNslsnDQlV+nahP5RqLbvlug45mGHJ3iq/ZEa
         e9OXyMNX4IlvHX/HYFr9DHqw9VyOSpUak2Ac/OJm+9g+jrF9ezwtGAiWpYYVQcS/mLN3
         l/rjPzl+tDSTIeYv0eskDEaYeiqW4tYqeobd8cm/mAF6W1ftGCc89yAF0wc/daDIIjTd
         /khQ==
X-Gm-Message-State: ALoCoQnaz/QuxM4qS5rvamGLqkPqDF9CS5IxNnKnHbOXDPmRzVGvNS+iLhlQ48XXBvUx9KrZRWN6
X-Received: by 10.140.151.13 with SMTP id 13mr14607087qhx.41.1444938445329;
        Thu, 15 Oct 2015 12:47:25 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p193sm6054142qha.29.2015.10.15.12.47.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Oct 2015 12:47:24 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279693>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs-be-files.c | 15 ---------------
 refs.c          | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 14319cb..ffc3813 100644
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
index f7aa9b3..ae518a2 100644
--- a/refs.c
+++ b/refs.c
@@ -827,3 +827,18 @@ int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *c
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
