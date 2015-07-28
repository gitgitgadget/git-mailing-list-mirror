From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 03/10] ref-filter: add option to filter only tags
Date: Tue, 28 Jul 2015 12:03:24 +0530
Message-ID: <1438065211-3777-3-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
 <1438065211-3777-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 08:33:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJySJ-0005cC-TB
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 08:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386AbbG1Gdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 02:33:36 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34489 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbbG1Gdf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 02:33:35 -0400
Received: by pacan13 with SMTP id an13so65870460pac.1
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 23:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZRLeyzoJFLBM+Mxx2Vt2TUdnCOgLIPQ72tm0EDeDQNg=;
        b=YHJkxjU9LCfXAtb5jqQWXLRymr78gMeVlc9Xcm+HjrQzKmdOixv7Z2eyEaf7I+xpdI
         eBkTWXcJNn3PfSnEx8dnrRUIPvqxgSgtmohMnpheDYiWCZibRSWzFphntwCIn597JVOx
         MolEN3JvRdWInxewy9u++j5SB+QXe7kcgfn7XAPjshOPzb67Qfbi+CMIrIGCzpiU6snO
         iRGVcyqCXNxsWLt4y4yrXzo6oZFg7JmTu36hBSDQM0ZlS7IA44iaCvZbYsINsifPXoCo
         Tvzm1iTRIqO8GbLrNltkv7cGYSzGwPfBNPQu59t/dPqbayw7HDuySTXIs1uddCYNiEC7
         MxuA==
X-Received: by 10.67.8.71 with SMTP id di7mr78608633pad.46.1438065215378;
        Mon, 27 Jul 2015 23:33:35 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id p9sm32976792pds.92.2015.07.27.23.33.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jul 2015 23:33:34 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1438065211-3777-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274728>

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
index e5cd97b..515655b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1150,6 +1150,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 		ret = for_each_rawref(ref_filter_handler, &ref_cbdata);
 	else if (type & FILTER_REFS_ALL)
 		ret = for_each_ref(ref_filter_handler, &ref_cbdata);
+	else if (type & FILTER_REFS_TAGS)
+		ret = for_each_tag_ref_fullpath(ref_filter_handler, &ref_cbdata);
 	else if (type)
 		die("filter_refs: invalid type");
 
diff --git a/ref-filter.h b/ref-filter.h
index 23d8574..1956f67 100644
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
