From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 12/17] ref-filter: make remote_ref_atom_parser() use refname_atom_parser_internal()
Date: Sun, 15 May 2016 16:15:28 +0530
Message-ID: <1463309133-14503-13-git-send-email-Karthik.188@gmail.com>
References: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 12:46:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1tZ0-0003uE-Oe
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 12:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191AbcEOKqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 06:46:15 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34941 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164AbcEOKqM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 06:46:12 -0400
Received: by mail-pf0-f194.google.com with SMTP id b66so5171761pfb.2
        for <git@vger.kernel.org>; Sun, 15 May 2016 03:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UNwsvqGm7mkMrglbq4iXgkDRCMGXO+hp9zJpe7y8d6c=;
        b=lkafs3+WKW76sH9OGODibeM5sYfDhA38OHV9u8DMU9d3s1qXbF4qiB9SnF2yBkfL4B
         4a5MYDjMOK9Sjixt0wAWQ+SePMPcUj6/JOvPo26IorBvrGgOA/yd1wO/kfbxIx/kKu/C
         OfGCuJLNFPXONpmfdyYPHj8N0/eT08fA7IG9H00GMexQWuDxcgKPY6cK+N771dFVHWzB
         2LpIWC19N5p0ZQ3JJu4e/9kihp8iCjfhDRRLjDxLh22qHR9NDWsYEO/IVoXvLGtV3TUr
         wMs/6QW54QbkRzvBY8VkfpPSdG61z0AMO4/XI/KuZX8G9ooAAXIW1cO1IMVAMuF6CluV
         Nyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UNwsvqGm7mkMrglbq4iXgkDRCMGXO+hp9zJpe7y8d6c=;
        b=WsIAipEjJl8jnW4E282L2VsQ3hyYWTAb/lfLuZIL47HCY5oIFNKDh9J2XCCKAMlwCi
         otHcCPnwIjX0dSQMLDqnOzW3WIUBDZg9M+WGOqvrGKNjR0YxQBnfyS2yzhel79pRT3cd
         IBVVhBKD/OVcVW/RsBSAX4d7YVp8yTeFS8+3cy9osqANENQ+0hMHyFsFtP1cFL5f5W73
         i0ubS8CpYeSXRFuXYnvR3CTag2szHPUQUTIubQZxfgYU0CUO4kguZdw9rYbJo1dHY001
         CDICp80XEfmZKHEXE4dOa2+DKZqn/LgNP/emOjSCWaN2GrMnQSllT/jIVzaoSPaKgFQv
         S15Q==
X-Gm-Message-State: AOPr4FX44g//GYCwR8+CvFWKgowGSoFnKhKrCfdKgpgLVoa0nPTFTwRIdrXi7KJ0OjdKDw==
X-Received: by 10.98.26.130 with SMTP id a124mr37319917pfa.39.1463309171717;
        Sun, 15 May 2016 03:46:11 -0700 (PDT)
Received: from ashley.localdomain ([106.51.133.65])
        by smtp.gmail.com with ESMTPSA id 71sm39866747pfy.32.2016.05.15.03.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 May 2016 03:46:11 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294660>

Use the recently introduced refname_atom_parser_internal() within
remote_ref_atom_parser(), this provides a common base for all the ref
printing atoms, allowing %(upstream) and %(push) to also use the
':strip' option.

The atoms '%(push)' and '%(upstream)' will retain the ':track' and
':trackshort' atom modifiers to themselves as they have no meaning in
context to the '%(refname)' and '%(symref)' atoms.

Update the documentation and tests to reflect the same.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt | 27 ++++++++++++++-------------
 ref-filter.c                       | 26 +++++++++++++++-----------
 t/t6300-for-each-ref.sh            |  2 ++
 3 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 6ab84b8..b472ee9 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -114,21 +114,22 @@ objectname::
 
 upstream::
 	The name of a local ref which can be considered ``upstream''
-	from the displayed ref. Respects `:short` in the same way as
-	`refname` above.  Additionally respects `:track` to show
-	"[ahead N, behind M]" and `:trackshort` to show the terse
-	version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
-	or "=" (in sync). `:track` also prints "[gone]" whenever
-	unknown upstream ref is encountered. Append `:track,nobracket`
-	to show tracking information without brackets (i.e "ahead N,
-	behind M").  Has no effect if the ref does not have tracking
-	information associated with it.
+	from the displayed ref. Respects `:short` and `:strip` in the
+	same way as `refname` above.  Additionally respects `:track`
+	to show "[ahead N, behind M]" and `:trackshort` to show the
+	terse version: ">" (ahead), "<" (behind), "<>" (ahead and
+	behind), or "=" (in sync). `:track` also prints "[gone]"
+	whenever unknown upstream ref is encountered. Append
+	`:track,nobracket` to show tracking information without
+	brackets (i.e "ahead N, behind M").  Has no effect if the ref
+	does not have tracking information associated with it.
 
 push::
-	The name of a local ref which represents the `@{push}` location
-	for the displayed ref. Respects `:short`, `:track`, and
-	`:trackshort` options as `upstream` does. Produces an empty
-	string if no `@{push}` ref is configured.
+	The name of a local ref which represents the `@{push}`
+	location for the displayed ref. Respects `:short`, `:strip`,
+	`:track`, and `:trackshort` options as `upstream`
+	does. Produces an empty string if no `@{push}` ref is
+	configured.
 
 HEAD::
 	'*' if HEAD matches current ref (the checked out branch), ' '
diff --git a/ref-filter.c b/ref-filter.c
index 933f8ca..3b42aab 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -52,7 +52,8 @@ static struct used_atom {
 		char color[COLOR_MAXLEN];
 		struct align align;
 		struct {
-			enum { RR_NORMAL, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT } option;
+			enum { RR_REF, RR_TRACK, RR_TRACKSHORT } option;
+			struct refname_atom refname;
 			unsigned int nobracket: 1;
 		} remote_ref;
 		struct {
@@ -102,7 +103,9 @@ static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
 	int i;
 
 	if (!arg) {
-		atom->u.remote_ref.option = RR_NORMAL;
+		atom->u.remote_ref.option = RR_REF;
+		refname_atom_parser_internal(&atom->u.remote_ref.refname,
+					     arg, atom->name);
 		return;
 	}
 
@@ -112,16 +115,17 @@ static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
 	for (i = 0; i < params.nr; i++) {
 		const char *s = params.items[i].string;
 
-		if (!strcmp(s, "short"))
-			atom->u.remote_ref.option = RR_SHORTEN;
-		else if (!strcmp(s, "track"))
+		if (!strcmp(s, "track"))
 			atom->u.remote_ref.option = RR_TRACK;
 		else if (!strcmp(s, "trackshort"))
 			atom->u.remote_ref.option = RR_TRACKSHORT;
 		else if (!strcmp(s, "nobracket"))
 			atom->u.remote_ref.nobracket = 1;
-		else
-			die(_("unrecognized format: %%(%s)"), atom->name);
+		else {
+			atom->u.remote_ref.option = RR_REF;
+			refname_atom_parser_internal(&atom->u.remote_ref.refname,
+						     arg, atom->name);
+		}
 	}
 
 	string_list_clear(&params, 0);
@@ -1100,8 +1104,8 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 				    struct branch *branch, const char **s)
 {
 	int num_ours, num_theirs;
-	if (atom->u.remote_ref.option == RR_SHORTEN)
-		*s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
+	if (atom->u.remote_ref.option == RR_REF)
+		*s = show_ref(&atom->u.remote_ref.refname, refname);
 	else if (atom->u.remote_ref.option == RR_TRACK) {
 		if (stat_tracking_info(branch, &num_ours,
 				       &num_theirs, NULL)) {
@@ -1133,8 +1137,8 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 			*s = ">";
 		else
 			*s = "<>";
-	} else /* RR_NORMAL */
-		*s = refname;
+	} else
+		die("BUG: unhandled RR_* enum");
 }
 
 char *get_head_description(void)
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 3d28234..7ca0a12 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -55,8 +55,10 @@ test_atom head refname:strip=1 heads/master
 test_atom head refname:strip=2 master
 test_atom head upstream refs/remotes/origin/master
 test_atom head upstream:short origin/master
+test_atom head upstream:strip=2 origin/master
 test_atom head push refs/remotes/myfork/master
 test_atom head push:short myfork/master
+test_atom head push:strip=1 remotes/myfork/master
 test_atom head objecttype commit
 test_atom head objectsize 171
 test_atom head objectname $(git rev-parse refs/heads/master)
-- 
2.8.2
