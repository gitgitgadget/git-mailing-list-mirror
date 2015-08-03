From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 04/11] ref-filter: add option to filter only tags
Date: Mon,  3 Aug 2015 22:24:14 +0530
Message-ID: <1438620861-25219-4-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZTYWTjc-OC7N7FGWETP1svpCkqhQ2wwPmbf5nVRyPRAqg@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 03 18:54:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMJ0W-0000MS-1w
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 18:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569AbbHCQyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 12:54:32 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36324 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754178AbbHCQya (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 12:54:30 -0400
Received: by pacgq8 with SMTP id gq8so28901393pac.3
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 09:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cwV+QHhsAjjK1UstlyfCEMfYXpwlj08OoL/7yTnaw1U=;
        b=ehbbi3evb3+rPv4rVJ28u8DU4pqhDT7GrWm2JJRshFy2HcMScfIo5ai9lhQKpUc1VU
         hVXyq9GjdRfsNwfsy5XE1rwfbDLN23k9k3LEMtr7HJk062pW99Dyv6mcQPBVjNazHSCf
         lbkGyaCATYMYpR7OiZUkIdCyw4xm9nLKRomx+gPkQIO0R2O2rJcLqZEG4Jet49q4jlTN
         FLiIkMe8ek8ln7JT4UQPU69cyaFWnuzrFLgBchQhIFC987bZZ0Q0f/A4IwUEFLFMz8hp
         HBemnICd3NSlKPeSwiyPmIFv4hKpoaPGBWchZs61J8TJoTkFRXgSTzctWJG0WHbGzy81
         0xtg==
X-Received: by 10.68.113.37 with SMTP id iv5mr25519901pbb.104.1438620869770;
        Mon, 03 Aug 2015 09:54:29 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id gk5sm18164153pac.21.2015.08.03.09.54.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Aug 2015 09:54:29 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <CAOLa=ZTYWTjc-OC7N7FGWETP1svpCkqhQ2wwPmbf5nVRyPRAqg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275176>

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
index 46d8834..01c9097 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1155,6 +1155,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 		ret = for_each_rawref(ref_filter_handler, &ref_cbdata);
 	else if (type & FILTER_REFS_ALL)
 		ret = for_each_ref(ref_filter_handler, &ref_cbdata);
+	else if (type & FILTER_REFS_TAGS)
+		ret = for_each_tag_ref_fullpath(ref_filter_handler, &ref_cbdata);
 	else if (type)
 		die("filter_refs: invalid type");
 
diff --git a/ref-filter.h b/ref-filter.h
index 01f8cb3..8d4e348 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -15,6 +15,7 @@
 
 #define FILTER_REFS_INCLUDE_BROKEN 0x1
 #define FILTER_REFS_ALL 0x2
+#define FILTER_REFS_TAGS 0x4
 
 #define ALIGN_LEFT 0x01
 #define ALIGN_RIGHT 0x02
diff --git a/refs.c b/refs.c
index 0b96ece..23ce483 100644
--- a/refs.c
+++ b/refs.c
@@ -2108,6 +2108,11 @@ int for_each_tag_ref(each_ref_fn fn, void *cb_data)
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
index e4e46c3..9eee2de 100644
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
2.4.6
