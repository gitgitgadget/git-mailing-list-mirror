From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH 03/11] ref-filter: add option to filter only branches
Date: Tue, 28 Jul 2015 12:26:28 +0530
Message-ID: <1438066594-5620-3-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 08:56:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJyoe-0006CA-5n
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 08:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204AbbG1G4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 02:56:38 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36458 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572AbbG1G4h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 02:56:37 -0400
Received: by pdjr16 with SMTP id r16so66783563pdj.3
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 23:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NWgfdDTIvjgbtv/FECSkM5HmiOI0RS/QEKXIb7zeee8=;
        b=NK54djatnu2MCSceU4JhIuYd7hU0K1XZn//eUU2l2VVQX4369l8xL8BfEi7or1q8EE
         WD0E4TQJgeEFMTLJiBxjwyjXUavIpHU9uGkkiJ0ttmX4G04Qgc4cx4H1h9Am1raVCYqU
         pvJbbwhqkYggV8KjO2eEIRCPNwCi4XZF0xOfN5dpdH2z6rUe9t3fN2IhEz9auBo+OaQ6
         U576OjKFQXx0ntDCEAKXJ0kTOEi7ldTLtoiy/91N9tNMcYg7y8OTTMiQeBbiAKdH18j/
         wwG7eiPIgxJIEOidQCt25Z3NAcaFeAXVMN/I+qWLcKQpvM4Z/HR2k/p8wGGVnlDELZfs
         paWA==
X-Received: by 10.70.49.98 with SMTP id t2mr75917940pdn.113.1438066596899;
        Mon, 27 Jul 2015 23:56:36 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id q7sm33147846pdj.31.2015.07.27.23.56.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jul 2015 23:56:36 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274740>

From: Karthik Nayak <karthik.188@gmail.com>

Add an option in 'filter_refs()' to use 'for_each_branch_ref()'
and filter refs. This type checking is done by adding a
'FILTER_REFS_BRANCHES' in 'ref-filter.h'.

Add an option in 'ref_filter_handler()' to filter different
types of branches by calling 'filter_branch_kind()' which
checks for the type of branch needed.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 ref-filter.h | 10 ++++++++--
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 3ab4ab9..3f40144 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1054,6 +1054,46 @@ static const unsigned char *match_points_at(struct sha1_array *points_at,
 	return NULL;
 }
 
+/*
+ * Checks if a given refname is a branch and returns the kind of
+ * branch it is. If not a branch, 0 is returned.
+ */
+static int filter_branch_kind(struct ref_filter *filter, const char *refname)
+{
+	int kind, i;
+
+	static struct {
+		int kind;
+		const char *prefix;
+	} ref_kind[] = {
+		{ REF_LOCAL_BRANCH, "refs/heads/" },
+		{ REF_REMOTE_BRANCH, "refs/remotes/" },
+	};
+
+	/*  If no kind is specified, no need to filter */
+	if (!filter->branch_kind)
+		return REF_NO_BRANCH_FILTERING;
+
+	for (i = 0; i < ARRAY_SIZE(ref_kind); i++) {
+		if (starts_with(refname, ref_kind[i].prefix)) {
+			kind = ref_kind[i].kind;
+			break;
+		}
+	}
+
+	if (ARRAY_SIZE(ref_kind) <= i) {
+		if (!strcmp(refname, "HEAD"))
+			kind = REF_DETACHED_HEAD;
+		else
+			return 0;
+	}
+
+	if ((filter->branch_kind & kind) == 0)
+		return 0;
+
+	return kind;
+}
+
 /* Allocate space for a new ref_array_item and copy the objectname and flag to it */
 static struct ref_array_item *new_ref_array_item(const char *refname,
 						 const unsigned char *objectname,
@@ -1079,6 +1119,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	struct ref_filter *filter = ref_cbdata->filter;
 	struct ref_array_item *ref;
 	struct commit *commit = NULL;
+	unsigned int kind;
 
 	if (flag & REF_BAD_NAME) {
 		  warning("ignoring ref with broken name %s", refname);
@@ -1090,6 +1131,9 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 		return 0;
 	}
 
+	if (!(kind = filter_branch_kind(filter, refname)))
+		return 0;
+
 	if (!filter_pattern_match(filter, refname))
 		return 0;
 
@@ -1118,6 +1162,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	 */
 	ref = new_ref_array_item(refname, oid->hash, flag);
 	ref->commit = commit;
+	ref->kind = kind;
 
 	REALLOC_ARRAY(ref_cbdata->array->items, ref_cbdata->array->nr + 1);
 	ref_cbdata->array->items[ref_cbdata->array->nr++] = ref;
@@ -1208,6 +1253,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 		ret = for_each_ref(ref_filter_handler, &ref_cbdata);
 	else if (type & FILTER_REFS_TAGS)
 		ret = for_each_tag_ref_fullpath(ref_filter_handler, &ref_cbdata);
+	else if (type & FILTER_REFS_BRANCHES)
+		ret = for_each_rawref(ref_filter_handler, &ref_cbdata);
 	else if (type)
 		die("filter_refs: invalid type");
 
diff --git a/ref-filter.h b/ref-filter.h
index 8c82fd1..a021b04 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -16,6 +16,12 @@
 #define FILTER_REFS_INCLUDE_BROKEN 0x1
 #define FILTER_REFS_ALL 0x2
 #define FILTER_REFS_TAGS 0x4
+#define FILTER_REFS_BRANCHES 0x8
+
+#define REF_DETACHED_HEAD   0x01
+#define REF_LOCAL_BRANCH    0x02
+#define REF_REMOTE_BRANCH   0x04
+#define REF_NO_BRANCH_FILTERING 0x08
 
 struct atom_value {
 	const char *s;
@@ -40,7 +46,7 @@ struct ref_sorting {
 
 struct ref_array_item {
 	unsigned char objectname[20];
-	int flag;
+	int flag, kind;
 	const char *symref;
 	struct commit *commit;
 	struct atom_value *value;
@@ -66,7 +72,7 @@ struct ref_filter {
 
 	unsigned int with_commit_tag_algo : 1,
 		match_as_path : 1;
-	unsigned int lines;
+	unsigned int lines, branch_kind;
 };
 
 struct ref_filter_cbdata {
-- 
2.4.6
