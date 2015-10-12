From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 22/44] refs-be-files.c: add method for for_each_reftype_...
Date: Mon, 12 Oct 2015 17:51:43 -0400
Message-ID: <1444686725-27660-24-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:52:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll1S-0004bL-Ha
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbbJLVwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:52:40 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:36398 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbbJLVwi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:38 -0400
Received: by qgx61 with SMTP id 61so129595853qgx.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DxED3U1y+8VCDkfJzz86FtAm3RpsTnDyZgzuFgCZcvU=;
        b=fF/layHdNE730n6izzFM9is58auZSx5dop8wxb03AlaVeGomzCnOIVez++6CHDYHn0
         plBWMSezxoa9evClIHrsP0CPHgjfVDk9we6u9FFTQOO9qrSSDVda0qMSAoHusASOKOTD
         jqWXCPtQ5GKQ9jRYbG4v+GzXBZ6yvp4/cLwYXgWTNUMIc+u+qdm3lNGWPonoc3Y7Rl0c
         mWBPNCkAqZCaN2qXpEOJ3GFDiJLBXaaMiaPTxB8f/Oov+hFLu2f9HT93a0aB2I7u6IOP
         mlPppxOKyUK4qdEQXG0SmA/0mvL7Xy6/t3ByhwfKmV7t24kbNNW1WX4tbFKr8ZLyW83U
         DswQ==
X-Gm-Message-State: ALoCoQkS6PN3znpY/yyYRTMAMfPVvpVuUJZ7eOT8sui/S7c1TnNbvQiCEBszUHIEozj5AGyoVd6p
X-Received: by 10.140.107.119 with SMTP id g110mr34782104qgf.17.1444686757697;
        Mon, 12 Oct 2015 14:52:37 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:36 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279430>

Add method for for_each_reftype_fullpath.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 11 +++++++++++
 refs.c          |  7 +++++++
 refs.h          |  3 +++
 3 files changed, 21 insertions(+)

diff --git a/refs-be-files.c b/refs-be-files.c
index 2e2399e..c99319f 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1914,6 +1914,16 @@ static int files_for_each_replace_ref(each_ref_fn fn, void *cb_data)
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
@@ -3652,4 +3662,5 @@ struct ref_be refs_be_files = {
 	files_for_each_rawref,
 	files_for_each_namespaced_ref,
 	files_for_each_replace_ref,
+	files_for_each_reftype_fullpath,
 };
diff --git a/refs.c b/refs.c
index 657ab73..e627d74 100644
--- a/refs.c
+++ b/refs.c
@@ -1105,3 +1105,10 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
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
index 6dec0da..491aa1d 100644
--- a/refs.h
+++ b/refs.h
@@ -653,6 +653,8 @@ typedef int for_each_ref_in_submodule_fn(const char *submodule,
 typedef int for_each_rawref_fn(each_ref_fn fn, void *cb_data);
 typedef int for_each_namespaced_ref_fn(each_ref_fn fn, void *cb_data);
 typedef int for_each_replace_ref_fn(each_ref_fn fn, void *cb_data);
+typedef int for_each_reftype_fullpath_fn(each_ref_fn fn, char *type,
+					 unsigned int broken, void *cb_data);
 
 struct ref_be {
 	struct ref_be *next;
@@ -674,6 +676,7 @@ struct ref_be {
 	for_each_rawref_fn *for_each_rawref;
 	for_each_namespaced_ref_fn *for_each_namespaced_ref;
 	for_each_replace_ref_fn *for_each_replace_ref;
+	for_each_reftype_fullpath_fn *for_each_reftype_fullpath;
 };
 
 
-- 
2.4.2.644.g97b850b-twtrsrc
