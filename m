Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 006EB2022D
	for <e@80x24.org>; Fri, 18 Nov 2016 23:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753255AbcKRXIf (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 18:08:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:37381 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753241AbcKRXI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 18:08:29 -0500
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP; 18 Nov 2016 15:08:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,660,1473145200"; 
   d="scan'208";a="33066057"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.116])
  by fmsmga005.fm.intel.com with ESMTP; 18 Nov 2016 15:08:27 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 2/2] ref-filter: add support to display trailers as part of contents
Date:   Fri, 18 Nov 2016 15:08:25 -0800
Message-Id: <20161118230825.20952-3-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.11.0.rc2.152.g4d04e67
In-Reply-To: <20161118230825.20952-1-jacob.e.keller@intel.com>
References: <20161118230825.20952-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Add %(trailers) and %(contents:trailers) to display the trailers as
interpreted by trailer_info_get. Update documentation and add a test for
the new feature.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/git-for-each-ref.txt |  2 ++
 ref-filter.c                       | 22 +++++++++++++++++++++-
 t/t6300-for-each-ref.sh            | 26 ++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index f57e69bc83e3..e5807eede787 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -165,6 +165,8 @@ of all lines of the commit message up to the first blank line.  The next
 line is 'contents:body', where body is all of the lines after the first
 blank line.  The optional GPG signature is `contents:signature`.  The
 first `N` lines of the message is obtained using `contents:lines=N`.
+Additionally, the trailers as interpreted by linkgit:git-interpret-trailers[1]
+are obtained as 'contents:trailers'.
 
 For sorting purposes, fields with numeric values sort in numeric order
 (`objectsize`, `authordate`, `committerdate`, `creatordate`, `taggerdate`).
diff --git a/ref-filter.c b/ref-filter.c
index d4c2931f3aab..b6f1bb73ed37 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -13,6 +13,7 @@
 #include "utf8.h"
 #include "git-compat-util.h"
 #include "version.h"
+#include "trailer.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
@@ -40,7 +41,7 @@ static struct used_atom {
 		enum { RR_NORMAL, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT }
 			remote_ref;
 		struct {
-			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
+			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB, C_TRAILERS } option;
 			unsigned int nlines;
 		} contents;
 		enum { O_FULL, O_SHORT } objectname;
@@ -85,6 +86,13 @@ static void subject_atom_parser(struct used_atom *atom, const char *arg)
 	atom->u.contents.option = C_SUB;
 }
 
+static void trailers_atom_parser(struct used_atom *atom, const char *arg)
+{
+	if (arg)
+		die(_("%%(trailers) does not take arguments"));
+	atom->u.contents.option = C_TRAILERS;
+}
+
 static void contents_atom_parser(struct used_atom *atom, const char *arg)
 {
 	if (!arg)
@@ -95,6 +103,8 @@ static void contents_atom_parser(struct used_atom *atom, const char *arg)
 		atom->u.contents.option = C_SIG;
 	else if (!strcmp(arg, "subject"))
 		atom->u.contents.option = C_SUB;
+	else if (!strcmp(arg, "trailers"))
+		atom->u.contents.option = C_TRAILERS;
 	else if (skip_prefix(arg, "lines=", &arg)) {
 		atom->u.contents.option = C_LINES;
 		if (strtoul_ui(arg, 10, &atom->u.contents.nlines))
@@ -194,6 +204,7 @@ static struct {
 	{ "creatordate", FIELD_TIME },
 	{ "subject", FIELD_STR, subject_atom_parser },
 	{ "body", FIELD_STR, body_atom_parser },
+	{ "trailers", FIELD_STR, trailers_atom_parser },
 	{ "contents", FIELD_STR, contents_atom_parser },
 	{ "upstream", FIELD_STR, remote_ref_atom_parser },
 	{ "push", FIELD_STR, remote_ref_atom_parser },
@@ -785,6 +796,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 			name++;
 		if (strcmp(name, "subject") &&
 		    strcmp(name, "body") &&
+		    strcmp(name, "trailers") &&
 		    !starts_with(name, "contents"))
 			continue;
 		if (!subpos)
@@ -808,6 +820,14 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 			/*  Size is the length of the message after removing the signature */
 			append_lines(&s, subpos, contents_end - subpos, atom->u.contents.nlines);
 			v->s = strbuf_detach(&s, NULL);
+		} else if (atom->u.contents.option == C_TRAILERS) {
+			struct trailer_info info;
+
+			/* Search for trailer info */
+			trailer_info_get(&info, subpos);
+			v->s = xmemdupz(info.trailer_start,
+					info.trailer_end - info.trailer_start);
+			trailer_info_release(&info);
 		} else if (atom->u.contents.option == C_BARE)
 			v->s = xstrdup(subpos);
 	}
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 19a2823025e7..eb4bac0fe477 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -553,4 +553,30 @@ test_expect_success 'Verify sort with multiple keys' '
 		refs/tags/bogo refs/tags/master > actual &&
 	test_cmp expected actual
 '
+
+cat >trailers <<EOF
+Reviewed-by: A U Thor <author@example.com>
+Signed-off-by: A U Thor <author@example.com>
+EOF
+
+test_expect_success 'basic atom: head contents:trailers' '
+	echo "Some contents" > two &&
+	git add two &&
+	git commit -F - <<-EOF &&
+	trailers: this commit message has trailers
+
+	Some message contents
+
+	$(cat trailers)
+	EOF
+	git for-each-ref --format="%(contents:trailers)" refs/heads/master >actual &&
+	sanitize_pgp <actual >actual.clean &&
+	# git for-each-ref ends with a blank line
+	cat >expect <<-EOF &&
+	$(cat trailers)
+
+	EOF
+	test_cmp expect actual.clean
+'
+
 test_done
-- 
2.11.0.rc2.152.g4d04e67

