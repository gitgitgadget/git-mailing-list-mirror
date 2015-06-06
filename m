From: Karthik Nayak <karthik.188@gmail.com>
Subject: [WIP/PATCH v5 09/10] for-each-ref: introduce filter_refs()
Date: Sat,  6 Jun 2015 12:39:40 +0530
Message-ID: <1433574581-23980-9-git-send-email-karthik.188@gmail.com>
References: <55729B78.1070207@gmail.com>
 <1433574581-23980-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 09:11:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z18Fl-0003HA-N0
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 09:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbbFFHKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 03:10:31 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35445 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbbFFHK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 03:10:27 -0400
Received: by pdbnf5 with SMTP id nf5so67247669pdb.2
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 00:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oH3IZgox+hAf758An6npcdTwBVhibPiXNq/a/w4mwFg=;
        b=YgGkSObIzBCPmi1TxkZYM2ftxsm44yT8bFyas6l179pxnyuaS2x9VsFV+OTqqvCp2U
         OigvBOKTHCbarNJPQ5D/aT0yZtKuhrGxJ+nBzJs4lYgT64NtXqrEFCRELXFqRcneIyH+
         MZC4sko9Qw7G/cgwQqlN9YJxfPtF4s8iYBIK0iP3pwUhbjMpDaf2scVrDcLHoRMIu/5m
         uL0ixVdnvI4aK72FhGB99HbhHY8UgxWaHur6e1MmMMCfqdqTo1seEYdhcf9fk1QYqpOF
         hOi4GodbFv69w+MdkJCf5khIbayRruf08EKQ8Yo1ESLx4irTUTsf9wF+tMNoR5auzZ9F
         WSGw==
X-Received: by 10.68.209.130 with SMTP id mm2mr11998197pbc.88.1433574627055;
        Sat, 06 Jun 2015 00:10:27 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id ve1sm8572230pbc.52.2015.06.06.00.10.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 00:10:26 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433574581-23980-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270909>

Introduce filter_refs() which will act as an API for users to
call and provide a function which will iterate over a set of refs
while filtering out the required refs.

Currently this will wrap around ref_filter_handler(). Hence,
ref_filter_handler is made file scope static.

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c |  2 +-
 ref-filter.c           | 12 +++++++++++-
 ref-filter.h           |  8 ++++++--
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index e237194..2a16947 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -56,7 +56,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 	memset(&ref_cbdata, 0, sizeof(ref_cbdata));
 	ref_cbdata.filter.name_patterns = argv;
-	for_each_rawref(ref_filter_handler, &ref_cbdata);
+	filter_refs(for_each_rawref, &ref_cbdata);
 
 	ref_array_sort(sort, &ref_cbdata.array);
 
diff --git a/ref-filter.c b/ref-filter.c
index 95e72f6..c32b86f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -843,7 +843,7 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
  * A call-back given to for_each_ref().  Filter refs and keep them for
  * later object processing.
  */
-int ref_filter_handler(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int ref_filter_handler(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct ref_filter_cbdata *ref_cbdata = cb_data;
 	struct ref_filter *filter = &ref_cbdata->filter;
@@ -889,6 +889,16 @@ void ref_array_clear(struct ref_array *array)
 	array->nr = array->alloc = 0;
 }
 
+/*
+ * API for filtering a set of refs. The refs are provided and iterated
+ * over using the for_each_ref_fn(). The refs are stored into and filtered
+ * based on the ref_filter_cbdata structure.
+ */
+int filter_refs(int (for_each_ref_fn)(each_ref_fn, void *), struct ref_filter_cbdata *data)
+{
+	return for_each_ref_fn(ref_filter_handler, data);
+}
+
 static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, struct ref_array_item *b)
 {
 	struct atom_value *va, *vb;
diff --git a/ref-filter.h b/ref-filter.h
index 1432ff6..15e6766 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -46,8 +46,12 @@ struct ref_filter_cbdata {
 	struct ref_filter filter;
 };
 
-/*  Callback function for for_each_*ref(). This filters the refs based on the filters set */
-int ref_filter_handler(const char *refname, const unsigned char *sha1, int flag, void *cb_data);
+/*
+ * API for filtering a set of refs. The refs are provided and iterated
+ * over using the for_each_ref_fn(). The refs are stored into and filtered
+ * based on the ref_filter_cbdata structure.
+ */
+int filter_refs(int (for_each_ref_fn)(each_ref_fn, void *), struct ref_filter_cbdata *data);
 /*  Clear all memory allocated to ref_array */
 void ref_array_clear(struct ref_array *array);
 /*  Parse format string and sort specifiers */
-- 
2.4.2
