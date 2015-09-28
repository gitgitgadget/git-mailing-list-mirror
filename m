From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 21/43] refs-be-files.c: add method for for_each_reftype_...
Date: Mon, 28 Sep 2015 18:01:56 -0400
Message-ID: <1443477738-32023-22-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:04:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggXE-0002Ea-3J
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353AbbI1WDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:03:21 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:36382 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754279AbbI1WDT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:19 -0400
Received: by qkcf65 with SMTP id f65so74207939qkc.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Tk4AYDvP0iB83AqNkweX4WEYFuMB1wmG3YmZL4gb17I=;
        b=PqOkA6pJRZLHkopyG4CVwasv33NMiiAOUEofAIFPQUh4tDJZnKef1lKQvHo5HZgeAK
         7nTMfLuH77xcWIBEnhZBYXCQRwPE/GxqkYY6hUnTtihFPak561+R/90xdbc27mHfp1r6
         2/9bcNiXz49OeWqn8uopoonHekR5jsqGa4gePL7j376Gqk/7WiDZczxGL0LSskolo9N+
         9kU24BT5Rc4mOsAOYLVbaHxIgyVcaCtkPiuV4dhyJUx8D3iD1mQxrobHam/Hv3eQ0pVT
         atwERP97Aj8K23YxlopBGN4CAWrNWr3PazPzBRPb36x7V8TJ56sGRDg7pOPPAyRfNqsw
         u1qw==
X-Gm-Message-State: ALoCoQmIQnKYrPxyDONg7j+8SDDRb8GTn6oZUUFFpdSXRy0+Gz+hvrxtE5sQ0oh55xlch6IicseS
X-Received: by 10.55.198.28 with SMTP id b28mr25314666qkj.34.1443477798249;
        Mon, 28 Sep 2015 15:03:18 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:17 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278783>

Add method for for_each_reftype_fullpath.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 11 +++++++++++
 refs.c          |  7 +++++++
 refs.h          |  3 +++
 3 files changed, 21 insertions(+)

diff --git a/refs-be-files.c b/refs-be-files.c
index 9b45468..eb18a20 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1961,6 +1961,16 @@ static int files_for_each_replace_ref(each_ref_fn fn, void *cb_data)
 			       strlen(git_replace_ref_base), 0, cb_data);
 }
 
+static int files_for_each_reftype_fullpath(each_ref_fn fn, char *type,
+					   unsigned int broken, void *cb_data)
+{
+	unsigned int flag = 0;
+
+	if (broken)
+		flag = DO_FOR_EACH_INCLUDE_BROKEN;
+	return do_for_each_ref(&ref_cache, type, fn, 0, flag, cb_data);
+}
+
 static int files_for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -3863,4 +3873,5 @@ struct ref_be refs_be_files = {
 	files_for_each_rawref,
 	files_for_each_namespaced_ref,
 	files_for_each_replace_ref,
+	files_for_each_reftype_fullpath,
 };
diff --git a/refs.c b/refs.c
index 0375bb5..c6112ac 100644
--- a/refs.c
+++ b/refs.c
@@ -1056,3 +1056,10 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
 	return the_refs_backend->for_each_replace_ref(fn, cb_data);
 }
+
+int for_each_reftype_fullpath(each_ref_fn fn, char *type, unsigned int broken,
+			      void *cb_data)
+{
+	return the_refs_backend->for_each_reftype_fullpath(fn, type, broken,
+							   cb_data);
+}
diff --git a/refs.h b/refs.h
index b26cffc..5875fe5 100644
--- a/refs.h
+++ b/refs.h
@@ -580,6 +580,8 @@ typedef int (*for_each_ref_in_submodule_fn)(const char *submodule,
 typedef int (*for_each_rawref_fn)(each_ref_fn fn, void *cb_data);
 typedef int (*for_each_namespaced_ref_fn)(each_ref_fn fn, void *cb_data);
 typedef int (*for_each_replace_ref_fn)(each_ref_fn fn, void *cb_data);
+typedef int (*for_each_reftype_fullpath_fn)(each_ref_fn fn, char *type,
+					    unsigned int broken, void *cb_data);
 
 struct ref_be {
 	struct ref_be *next;
@@ -607,6 +609,7 @@ struct ref_be {
 	for_each_rawref_fn for_each_rawref;
 	for_each_namespaced_ref_fn for_each_namespaced_ref;
 	for_each_replace_ref_fn for_each_replace_ref;
+	for_each_reftype_fullpath_fn for_each_reftype_fullpath;
 };
 
 
-- 
2.4.2.644.g97b850b-twtrsrc
