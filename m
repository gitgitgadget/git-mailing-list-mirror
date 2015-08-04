From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v9 04/11] ref-filter: add option to filter only tags
Date: Tue,  4 Aug 2015 18:13:01 +0530
Message-ID: <1438692188-14367-4-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZSBMk9y1VGTVKSVsGMdYuPtjhPADciVUaEVwESRdSvWZg@mail.gmail.com>
 <1438692188-14367-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 14:43:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMbZ6-0004Ip-TW
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 14:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756224AbbHDMnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 08:43:24 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:32949 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755854AbbHDMnW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 08:43:22 -0400
Received: by padck2 with SMTP id ck2so8000737pad.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 05:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IOOmNRcmRr4/dfuBl0HPlu9st27xpqxnsii+tTwoBH8=;
        b=bY7zY6ZKSNCNlC8BEuqrxjt3cbgqJucJNGcAWUr2waaahTu/tOi8veZVSTmAqJ71MD
         e3b3NpgmAPE2FEWcg6lPmFeSyNWRWK0CDkQDyq1eEV5MtG/tuQMBE+Y1RvVKv9UQa0H/
         qdR/wdSxzCBwtzS76v5nQPbD/qZlXOIVC+Zll2YsGFH+eZRaJPWoGcmNf/gujP6WViDe
         rfetLN/b8EujAYcos3hvbiqjyd4a5VItwi8NK5DeJPk+zqDqKxRdJA8FOKN5OLhl3vgO
         LYkS8SBn2saGqNYsltxhne9rdmAtmWnYCBs1lm8f5oYwkXkxuyiLP0k6WmpPz8A9I+BB
         qlbw==
X-Received: by 10.68.166.196 with SMTP id zi4mr7327878pbb.83.1438692201675;
        Tue, 04 Aug 2015 05:43:21 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id m2sm1359951pdr.64.2015.08.04.05.43.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 05:43:21 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1438692188-14367-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275256>

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
index d123299..7c9c51d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1161,6 +1161,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 		ret = for_each_rawref(ref_filter_handler, &ref_cbdata);
 	else if (type & FILTER_REFS_ALL)
 		ret = for_each_ref(ref_filter_handler, &ref_cbdata);
+	else if (type & FILTER_REFS_TAGS)
+		ret = for_each_tag_ref_fullpath(ref_filter_handler, &ref_cbdata);
 	else if (type)
 		die("filter_refs: invalid type");
 
diff --git a/ref-filter.h b/ref-filter.h
index 81de1e2..3412dce 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -15,6 +15,7 @@
 
 #define FILTER_REFS_INCLUDE_BROKEN 0x1
 #define FILTER_REFS_ALL 0x2
+#define FILTER_REFS_TAGS 0x4
 
 #define ALIGN_LEFT 0x01
 #define ALIGN_RIGHT 0x02
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
