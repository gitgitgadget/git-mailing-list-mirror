From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 11/16] ref-filter: make remote_ref_atom_parser() use refname_atom_parser_internal()
Date: Sat, 23 Apr 2016 00:34:02 +0530
Message-ID: <1461351847-22903-12-git-send-email-Karthik.188@gmail.com>
References: <1461351847-22903-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 21:05:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atgOJ-000066-GA
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 21:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105AbcDVTFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 15:05:13 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34607 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbcDVTFK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 15:05:10 -0400
Received: by mail-pf0-f196.google.com with SMTP id 145so3074682pfz.1
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 12:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZtvOdUZ9cQ3EpqOR8G2SBJRjZyEFCVWN1v/FrgCgzlk=;
        b=hU3in2MTt12XQPm+E0kCr2sHDXro43aKkRCnVmPhqFnZ61M8+MT5M5bLAhALVP+V79
         0xgfujyetuTL/YhwkuM6rt7svQVhqQPG2Q2sIhKLXwrhfDbm6l5BLK/FW6XthoQmLhUA
         LiUDQIgtoVaqoXZLYYl9KPqpc7qxJ/GxzOuv/cqvltoyufKPN0+p2L9Flde4q8l27YQw
         rzyAPK/pYcvls0Aqwgf+HMoZfWXjqSLgjrnwRmVKL99JaXeaebIByoyK5Ad3qkRFSrr7
         k7PQc/bQL+KLVzYRzttJkKw3P13cuNt+jhAvwXOrMVN3PoYoGm/jtta62T+MTYtYRlQM
         fwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZtvOdUZ9cQ3EpqOR8G2SBJRjZyEFCVWN1v/FrgCgzlk=;
        b=VmIUNYEoMgqeo7Rze+yrRkyHATxHk/LgIXsIWtVIMXXUHgrRkmFdzvZbhOE556cyJl
         xxTe/NMjK95qvNL0NVlaBFcwjC5RZx4B6m1xaPvPNCbWUA5ESENc0j6Ms0Eo531GWlqC
         7B2V9MKj1mLQKqIs107PUAQJz5RSmrgDiOWGrXT2/QY8Y+8b1ydbYrrCMVWyKwrQxGhF
         UmtGzvbu2saHYWdVzW8AYJ/8NLHQTkvtGevW1cCgaPhSBdH2rEvRmXWOUOuHJCpJvsfL
         xQrFpiXHLffe67j9QJlK3KWIw1WFzs+fdWC86qkBaNJGHA0HhDWyJsONl+um4nBr495r
         700Q==
X-Gm-Message-State: AOPr4FU/dKJyxXI4w3wJOsInaqpJ9ZZICD6eyFloiM9JVo21qajpqZSFr62bDTW1cX6y9w==
X-Received: by 10.98.91.198 with SMTP id p189mr30597303pfb.91.1461351909814;
        Fri, 22 Apr 2016 12:05:09 -0700 (PDT)
Received: from ashley.localdomain ([106.216.186.206])
        by smtp.gmail.com with ESMTPSA id t1sm11266470paa.17.2016.04.22.12.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 12:05:09 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461351847-22903-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292257>

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
index e0c0a12..3eaf770 100644
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
2.8.0
