From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 13/15] ref-filter: introduce remote_ref_atom_parser()
Date: Tue,  5 Jan 2016 13:33:12 +0530
Message-ID: <1451980994-26865-14-git-send-email-Karthik.188@gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 09:03:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGMaa-0008BI-Ib
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 09:03:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbcAEIDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 03:03:20 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35120 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163AbcAEIDL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 03:03:11 -0500
Received: by mail-pa0-f49.google.com with SMTP id do7so1665831pab.2
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 00:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cvPVgfGGILTrA4LzHVrFsbMuOvKC8AlGz4rh07TZKcw=;
        b=B88GLhgJf8HpoUEakorzaavy7vUi5LBofVFplvNtYIUkb4vxXSeSWz0dYiDeIhL7HL
         4RDXse2S4TkBJpaKnZmQu0fNVwqq9KLXHHY2RziRVwOkToefLd4pjWyfT6wbaxqcLJH3
         X91VCRcqW3vggedyyPHE2Z9tRnX55/08JOBSUt03OPyAD87zxOiEzSW77ZPTdL2VHjeS
         yWOsUiSW+r1MTgKmuR6b3F6l9CP0nRv3ZHpZoAqZ5Fw5pZ1088zvcLt0RZto4xUxgTXF
         QG3QcrzlbYSWf6RI8cj3IpUGN44ZhQVbKpuSDfDycjKk5EvUPJjEnXRny9Qac2srahh8
         KFYw==
X-Received: by 10.66.218.225 with SMTP id pj1mr129116176pac.40.1451980990816;
        Tue, 05 Jan 2016 00:03:10 -0800 (PST)
Received: from ashley.localdomain ([106.51.242.38])
        by smtp.gmail.com with ESMTPSA id q190sm125814275pfq.59.2016.01.05.00.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Jan 2016 00:03:10 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283364>

Introduce remote_ref_atom_parser() which will parse the '%(upstream)'
and '%(push)' atoms and store information into the 'used_atom'
structure based on the modifiers used along with the corresponding
atom.

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 107 ++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 66 insertions(+), 41 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index df0b114..32b4674 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -37,6 +37,8 @@ static struct used_atom {
 	union {
 		char *color;
 		struct align align;
+		enum { RR_NORMAL, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT }
+			remote_ref;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -74,6 +76,26 @@ static void color_atom_parser(struct used_atom *atom)
 		die(_("invalid color value: %s"), atom->u.color);
 }
 
+static void remote_ref_atom_parser(struct used_atom *atom)
+{
+	const char *buf;
+
+	buf = strchr(atom->name, ':');
+	if (!buf) {
+		atom->u.remote_ref = RR_NORMAL;
+		return;
+	}
+	buf++;
+	if (!strcmp(buf, "short"))
+		atom->u.remote_ref = RR_SHORTEN;
+	else if (!strcmp(buf, "track"))
+		atom->u.remote_ref = RR_TRACK;
+	else if (!strcmp(buf, "trackshort"))
+		atom->u.remote_ref = RR_TRACKSHORT;
+	else
+		die(_("unrecognized format: %%(%s)"), atom->name);
+}
+
 static align_type parse_align_position(const char *s)
 {
 	if (!strcmp(s, "right"))
@@ -159,8 +181,8 @@ static struct {
 	{ "subject" },
 	{ "body" },
 	{ "contents" },
-	{ "upstream" },
-	{ "push" },
+	{ "upstream", FIELD_STR, remote_ref_atom_parser },
+	{ "push", FIELD_STR, remote_ref_atom_parser },
 	{ "symref" },
 	{ "flag" },
 	{ "HEAD" },
@@ -841,6 +863,43 @@ static inline char *copy_advance(char *dst, const char *src)
 	return dst;
 }
 
+static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
+				    struct branch *branch, const char **s)
+{
+	int num_ours, num_theirs;
+	if (atom->u.remote_ref == RR_SHORTEN)
+		*s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
+	else if (atom->u.remote_ref == RR_TRACK) {
+		if (stat_tracking_info(branch, &num_ours,
+				       &num_theirs, NULL))
+			return;
+
+		if (!num_ours && !num_theirs)
+			*s = "";
+		else if (!num_ours)
+			*s = xstrfmt("[behind %d]", num_theirs);
+		else if (!num_theirs)
+			*s = xstrfmt("[ahead %d]", num_ours);
+		else
+			*s = xstrfmt("[ahead %d, behind %d]",
+				     num_ours, num_theirs);
+	} else if (atom->u.remote_ref == RR_TRACKSHORT) {
+		if (stat_tracking_info(branch, &num_ours,
+				       &num_theirs, NULL))
+			return;
+
+		if (!num_ours && !num_theirs)
+			*s = "=";
+		else if (!num_ours)
+			*s = "<";
+		else if (!num_theirs)
+			*s = ">";
+		else
+			*s = "<>";
+	} else if (atom->u.remote_ref == RR_NORMAL)
+		*s = refname;
+}
+
 /*
  * Parse the object referred by ref, and grab needed value.
  */
@@ -894,6 +953,8 @@ static void populate_value(struct ref_array_item *ref)
 			refname = branch_get_upstream(branch, NULL);
 			if (!refname)
 				continue;
+			fill_remote_ref_details(atom, refname, branch, &v->s);
+			continue;
 		} else if (starts_with(name, "push")) {
 			const char *branch_name;
 			if (!skip_prefix(ref->refname, "refs/heads/",
@@ -904,6 +965,8 @@ static void populate_value(struct ref_array_item *ref)
 			refname = branch_get_push(branch, NULL);
 			if (!refname)
 				continue;
+			fill_remote_ref_details(atom, refname, branch, &v->s);
+			continue;
 		} else if (starts_with(name, "color:")) {
 			v->s = atom->u.color;
 			continue;
@@ -945,49 +1008,11 @@ static void populate_value(struct ref_array_item *ref)
 
 		formatp = strchr(name, ':');
 		if (formatp) {
-			int num_ours, num_theirs;
-
 			formatp++;
 			if (!strcmp(formatp, "short"))
 				refname = shorten_unambiguous_ref(refname,
 						      warn_ambiguous_refs);
-			else if (!strcmp(formatp, "track") &&
-				 (starts_with(name, "upstream") ||
-				  starts_with(name, "push"))) {
-
-				if (stat_tracking_info(branch, &num_ours,
-						       &num_theirs, NULL))
-					continue;
-
-				if (!num_ours && !num_theirs)
-					v->s = "";
-				else if (!num_ours)
-					v->s = xstrfmt("[behind %d]", num_theirs);
-				else if (!num_theirs)
-					v->s = xstrfmt("[ahead %d]", num_ours);
-				else
-					v->s = xstrfmt("[ahead %d, behind %d]",
-						       num_ours, num_theirs);
-				continue;
-			} else if (!strcmp(formatp, "trackshort") &&
-				   (starts_with(name, "upstream") ||
-				    starts_with(name, "push"))) {
-				assert(branch);
-
-				if (stat_tracking_info(branch, &num_ours,
-							&num_theirs, NULL))
-					continue;
-
-				if (!num_ours && !num_theirs)
-					v->s = "=";
-				else if (!num_ours)
-					v->s = "<";
-				else if (!num_theirs)
-					v->s = ">";
-				else
-					v->s = "<>";
-				continue;
-			} else
+			else
 				die("unknown %.*s format %s",
 				    (int)(formatp - name), name, formatp);
 		}
-- 
2.6.4
