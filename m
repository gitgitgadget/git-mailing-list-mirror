From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH/RFC 08/10] ref-filter: introduce remote_ref_atom_parser()
Date: Thu, 12 Nov 2015 01:14:34 +0530
Message-ID: <1447271075-15364-9-git-send-email-Karthik.188@gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
Cc: matthieu.moy@grenoble-inp.fr, gitster@pobox.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 20:44:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwbK1-0006Fl-Kj
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 20:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbbKKToj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 14:44:39 -0500
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35022 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbbKKToi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 14:44:38 -0500
Received: by padhk6 with SMTP id hk6so5331668pad.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 11:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/k6BTzwAwioKWu11iPAWlbCDDDT2QkB2GPau2hYhZSQ=;
        b=iuum2biBmEQNG+eWh4hUuKQgMeJPIizX1WGXg3FLUxw3jVwLA5FdBymafURdAfrCps
         FLWaTRQ+WOjjrxfzUSqZuDQKjAQURpPwZOfLuK5jr9wTir89/novlZDLGEUj+gKEqiZY
         49xzEt6cLeLdS2qI76pyscisx7Y2VRVSSXptSslN4rYeEd7d5JAuAiCCvfaUzkkq/Zd9
         Lbe0jkyHKeKyQh5ueNJFYHoOHt5x5f/Svq8fVmYpyo+qfC0S6wgyX4sg+1SIdA0jXx52
         zdHhcb4QSpw57lJ8LEDnCC/NeZIsRgu4XKrLVhVayEMVTCSkWDcxQC2daUldYMmAddpQ
         SoCg==
X-Received: by 10.68.130.69 with SMTP id oc5mr16810417pbb.140.1447271077516;
        Wed, 11 Nov 2015 11:44:37 -0800 (PST)
Received: from ashley.localdomain ([106.51.241.110])
        by smtp.gmail.com with ESMTPSA id j5sm278998pbq.74.2015.11.11.11.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Nov 2015 11:44:36 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281187>

Introduce remote_ref_atom_parser() which will parse the '%(upstream)'
and '%(push)' atoms and store information into the 'used_atom'
structure based on the modifiers used along with the corresponding
atom.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 107 ++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 66 insertions(+), 41 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 049e6b9..802629b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -37,6 +37,11 @@ static struct used_atom {
 	union {
 		const char *color;
 		struct align align;
+		struct {
+			unsigned int shorten : 1,
+				track : 1,
+				trackshort : 1;
+		} remote_ref;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -69,6 +74,24 @@ void color_atom_parser(struct used_atom *atom)
 		die(_("expected format: %%(color:<color>)"));
 }
 
+void remote_ref_atom_parser(struct used_atom *atom)
+{
+	const char *buf;
+
+	buf = strchr(atom->str, ':');
+	if (!buf)
+		return;
+	buf++;
+	if (!strcmp(buf, "short"))
+		atom->u.remote_ref.shorten = 1;
+	else if (!strcmp(buf, "track"))
+		atom->u.remote_ref.track = 1;
+	else if (!strcmp(buf, "trackshort"))
+		atom->u.remote_ref.trackshort = 1;
+	else
+		die(_("improper format entered align:%s"), buf);
+}
+
 static align_type get_align_position(const char *type)
 {
 	if (!strcmp(type, "right"))
@@ -156,8 +179,8 @@ static struct {
 	{ "subject", FIELD_STR },
 	{ "body", FIELD_STR },
 	{ "contents", FIELD_STR },
-	{ "upstream", FIELD_STR },
-	{ "push", FIELD_STR },
+	{ "upstream", FIELD_STR, remote_ref_atom_parser },
+	{ "push", FIELD_STR, remote_ref_atom_parser },
 	{ "symref", FIELD_STR },
 	{ "flag", FIELD_STR },
 	{ "HEAD", FIELD_STR },
@@ -838,6 +861,42 @@ static inline char *copy_advance(char *dst, const char *src)
 	return dst;
 }
 
+static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
+				    struct branch *branch, const char **s)
+{
+	int num_ours, num_theirs;
+	if (atom->u.remote_ref.shorten)
+		*s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
+	else if (atom->u.remote_ref.track) {
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
+	} else if (atom->u.remote_ref.trackshort) {
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
+	} else
+		*s = refname;
+}
+
 /*
  * Parse the object referred by ref, and grab needed value.
  */
@@ -892,6 +951,8 @@ static void populate_value(struct ref_array_item *ref)
 			refname = branch_get_upstream(branch, NULL);
 			if (!refname)
 				continue;
+			fill_remote_ref_details(atom, refname, branch, &v->s);
+			continue;
 		} else if (starts_with(name, "push")) {
 			const char *branch_name;
 			if (!skip_prefix(ref->refname, "refs/heads/",
@@ -902,6 +963,8 @@ static void populate_value(struct ref_array_item *ref)
 			refname = branch_get_push(branch, NULL);
 			if (!refname)
 				continue;
+			fill_remote_ref_details(atom, refname, branch, &v->s);
+			continue;
 		} else if (starts_with(name, "color")) {
 			char color[COLOR_MAXLEN] = "";
 			const char *valp = atom->u.color;
@@ -948,49 +1011,11 @@ static void populate_value(struct ref_array_item *ref)
 
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
2.6.2
