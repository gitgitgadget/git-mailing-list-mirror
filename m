From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 04/11] ref-filter: add option to filter only tags
Date: Mon, 27 Jul 2015 12:57:08 +0530
Message-ID: <1437982035-6658-4-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
 <1437982035-6658-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 27 09:27:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJcor-0000fa-05
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 09:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbbG0H1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 03:27:23 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36575 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbbG0H1W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 03:27:22 -0400
Received: by pdjr16 with SMTP id r16so48138753pdj.3
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 00:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iYEAaQ9HmoARVrygSeW0FDaVcXIBJouIQEVaUbOte40=;
        b=XbXWC0jdDWQcmLE19ZOTqGWPz9rigb5mtOkTYqY0gKwmGAjWgXrZgjZ1XSwGV5bEb8
         FJgSO4HggZB6MnRxS8ug0z+1K7VcQFd3x8H4vC4tNnq+tlG/ZMxnaRDxBipAOKem3dy8
         XJrNM5SJGCqDGYOnzjgZbZhTUj2GZPXgzOouLef0AVaS2G1sKt0ML9zRzsvGJKjRBGLl
         P1BO39DxPF9JjePGNmm6QgjEQS+uNrPNdYkcxl9xoA253ADInyEhvCZyIsgKsiQyWzVT
         paHonqyFid9h5dZKhHjwwAaljFg60DGmhH4qAEHB3YqlALEHfVX9jJje+qxRKebfnf04
         rFlQ==
X-Received: by 10.70.136.196 with SMTP id qc4mr66286358pdb.150.1437982041746;
        Mon, 27 Jul 2015 00:27:21 -0700 (PDT)
Received: from ashley.localdomain ([106.51.241.234])
        by smtp.gmail.com with ESMTPSA id wv4sm27732769pac.2.2015.07.27.00.27.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jul 2015 00:27:21 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1437982035-6658-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274657>

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
index 7ab34be..6e01b44 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1152,6 +1152,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 		ret = for_each_rawref(ref_filter_handler, &ref_cbdata);
 	else if (type & FILTER_REFS_ALL)
 		ret = for_each_ref(ref_filter_handler, &ref_cbdata);
+	else if (type & FILTER_REFS_TAGS)
+		ret = for_each_tag_ref_fullpath(ref_filter_handler, &ref_cbdata);
 	else if (type)
 		die("filter_refs: invalid type");
 
diff --git a/ref-filter.h b/ref-filter.h
index 63b8175..62ad979 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -15,6 +15,7 @@
 
 #define FILTER_REFS_INCLUDE_BROKEN 0x1
 #define FILTER_REFS_ALL 0x2
+#define FILTER_REFS_TAGS 0x4
 
 struct atom_value {
 	const char *s;
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
