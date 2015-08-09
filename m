From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v10 06/13] ref-filter: add option to filter only tags
Date: Sun,  9 Aug 2015 19:41:39 +0530
Message-ID: <1439129506-9989-7-git-send-email-Karthik.188@gmail.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 09 16:12:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZORKv-0006u7-1b
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 16:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933039AbbHIOMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2015 10:12:16 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34706 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543AbbHIOMB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2015 10:12:01 -0400
Received: by pawu10 with SMTP id u10so121413717paw.1
        for <git@vger.kernel.org>; Sun, 09 Aug 2015 07:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Oixd1ZSGCYFDBrNb0t6tCJF9hW8Vuz+COXMWtfl39oE=;
        b=rizvs7a0lH1pqP7zNfOYFg4RoFa5tAHA7zf6ewHb5kkO6H3XiPCcjOmeV3VCsLS/Q7
         9mwfJ7oMQZhrVh/Okiwa222p5Y9K5k4TjuR1AZ3WdGabodRGtS9q+34mrkJkv33xTBhC
         yRgDC0jNZrlCrR64tsBqoS7/Uvs7lzMjh9PEn8F6zqyMXldrBGwlq3DkgvkFrxhdzGkf
         AlXm0CEsMd2NpuryXvIyQ5IVpX+KBIvBubb7SPaJauKF0GSEd/hUwgHupC1zTSxTX19z
         Z8yzpQiq9iF23qsTpDvcYI6nu6IpJRBGFwEyZpciSdb3CtKIkXKE9nEMscM6TKg5MNN4
         htdg==
X-Received: by 10.68.238.231 with SMTP id vn7mr35745041pbc.38.1439129520525;
        Sun, 09 Aug 2015 07:12:00 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id la4sm72920pbc.76.2015.08.09.07.11.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Aug 2015 07:11:59 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275541>

From: Karthik Nayak <karthik.188@gmail.com>

Add a functions called 'for_each_tag_ref_fullpath()' to refs.{c,h}
which iterates through each tag ref without trimming the path.

Add an option in 'filter_refs()' to use 'for_each_tag_ref_fullpath()'
and filter refs. This type checking is done by adding a
'FILTER_REFS_TAGS' in 'ref-filter.h'

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 2 ++
 ref-filter.h | 1 +
 refs.c       | 5 +++++
 refs.h       | 1 +
 4 files changed, 9 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index 57e988c..fb5d74e 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1172,6 +1172,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 		ret = for_each_rawref(ref_filter_handler, &ref_cbdata);
 	else if (type & FILTER_REFS_ALL)
 		ret = for_each_ref(ref_filter_handler, &ref_cbdata);
+	else if (type & FILTER_REFS_TAGS)
+		ret = for_each_tag_ref_fullpath(ref_filter_handler, &ref_cbdata);
 	else if (type)
 		die("filter_refs: invalid type");
 
diff --git a/ref-filter.h b/ref-filter.h
index 144a633..1886baa 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -16,6 +16,7 @@
 
 #define FILTER_REFS_INCLUDE_BROKEN 0x1
 #define FILTER_REFS_ALL 0x2
+#define FILTER_REFS_TAGS 0x4
 
 struct atom_value;
 
diff --git a/refs.c b/refs.c
index 2db2975..0103a88 100644
--- a/refs.c
+++ b/refs.c
@@ -2114,6 +2114,11 @@ int for_each_tag_ref(each_ref_fn fn, void *cb_data)
 	return for_each_ref_in("refs/tags/", fn, cb_data);
 }
 
+int for_each_tag_ref_fullpath(each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref(&ref_cache, "refs/tags/", fn, 0, 0, cb_data);
+}
+
 int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	return for_each_ref_in_submodule(submodule, "refs/tags/", fn, cb_data);
diff --git a/refs.h b/refs.h
index 6a3fa6d..0956255 100644
--- a/refs.h
+++ b/refs.h
@@ -174,6 +174,7 @@ extern int head_ref(each_ref_fn fn, void *cb_data);
 extern int for_each_ref(each_ref_fn fn, void *cb_data);
 extern int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
 extern int for_each_tag_ref(each_ref_fn fn, void *cb_data);
+extern int for_each_tag_ref_fullpath(each_ref_fn fn, void *cb_data);
 extern int for_each_branch_ref(each_ref_fn fn, void *cb_data);
 extern int for_each_remote_ref(each_ref_fn fn, void *cb_data);
 extern int for_each_replace_ref(each_ref_fn fn, void *cb_data);
-- 
2.5.0
