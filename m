From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 09/11] ref-filter: introduce remote_ref_atom_parser()
Date: Wed, 16 Dec 2015 21:00:00 +0530
Message-ID: <1450279802-29414-10-git-send-email-Karthik.188@gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 16:30:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9E20-0002Fp-Ff
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 16:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbbLPPaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 10:30:14 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36619 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934195AbbLPPaH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 10:30:07 -0500
Received: by mail-pf0-f174.google.com with SMTP id o64so13671780pfb.3
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 07:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4xRHB8554mDJnmcfcd1tyzwxpHHXdsGzgb4qs7MqUR0=;
        b=OU/0urX7c6MZ5M+57RGWSOA/WkmP0UBQxviIvFW+xKhyGxFOgJIeGKYwBcD8df30JF
         nbTvJuWfeFUt1aVBeJoN1zBOThx4ti62hQJp4JUbWYqah2cKY1FqkGii3jIymxnUrSUb
         mJ50ZpOZquXR93Yuun63geHgKKE1OgEpk6kmVRD0ALBlj5JvT4A7HI0VKynNb0epxEPe
         YECTyanCVRFtd8pk3EeuHMggmxAwFo+S91bQyriiZaiIc7ISiprXNLT3LfETN2zVYaRU
         77nNilCoOZB9I6TkVTqN87DiYCXy/bm84tLkPYGBYcbIzIEB5JsoKXyFAiW9ya3Yh0uo
         tBhg==
X-Received: by 10.98.65.67 with SMTP id o64mr6271538pfa.104.1450279807171;
        Wed, 16 Dec 2015 07:30:07 -0800 (PST)
Received: from ashley.localdomain ([106.51.233.145])
        by smtp.gmail.com with ESMTPSA id x12sm5620612pfi.95.2015.12.16.07.30.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Dec 2015 07:30:06 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282573>

Introduce remote_ref_atom_parser() which will parse the '%(upstream)'
and '%(push)' atoms and store information into the 'used_atom'
structure based on the modifiers used along with the corresponding
atom.

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 105 ++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 64 insertions(+), 41 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 985423b..44670e3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -37,6 +37,8 @@ static struct used_atom {
 	union {
 		const char *color;
 		struct align align;
+		enum { RR_SHORTEN, RR_TRACK, RR_TRACKSHORT, RR_NORMAL }
+			remote_ref;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -69,6 +71,25 @@ static void color_atom_parser(struct used_atom *atom)
 		die(_("expected format: %%(color:<color>)"));
 }
 
+static void remote_ref_atom_parser(struct used_atom *atom)
+{
+	const char *buf;
+
+	buf = strchr(atom->str, ':');
+	atom->u.remote_ref = RR_NORMAL;
+	if (!buf)
+		return;
+	buf++;
+	if (!strcmp(buf, "short"))
+		atom->u.remote_ref = RR_SHORTEN;
+	else if (!strcmp(buf, "track"))
+		atom->u.remote_ref = RR_TRACK;
+	else if (!strcmp(buf, "trackshort"))
+		atom->u.remote_ref = RR_TRACKSHORT;
+	else
+		die(_("unrecognized format: %%(%s)"), atom->str);
+}
+
 static align_type parse_align_position(const char *s)
 {
 	if (!strcmp(s, "right"))
@@ -153,8 +174,8 @@ static struct {
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
@@ -835,6 +856,42 @@ static inline char *copy_advance(char *dst, const char *src)
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
@@ -889,6 +946,8 @@ static void populate_value(struct ref_array_item *ref)
 			refname = branch_get_upstream(branch, NULL);
 			if (!refname)
 				continue;
+			fill_remote_ref_details(atom, refname, branch, &v->s);
+			continue;
 		} else if (starts_with(name, "push")) {
 			const char *branch_name;
 			if (!skip_prefix(ref->refname, "refs/heads/",
@@ -899,6 +958,8 @@ static void populate_value(struct ref_array_item *ref)
 			refname = branch_get_push(branch, NULL);
 			if (!refname)
 				continue;
+			fill_remote_ref_details(atom, refname, branch, &v->s);
+			continue;
 		} else if (starts_with(name, "color:")) {
 			char color[COLOR_MAXLEN] = "";
 
@@ -944,49 +1005,11 @@ static void populate_value(struct ref_array_item *ref)
 
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
