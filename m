From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 08/10] ref-filter: add support for %(upstream:track,nobracket)
Date: Thu,  8 Oct 2015 14:48:03 +0530
Message-ID: <1444295885-1657-9-git-send-email-Karthik.188@gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 08 11:19:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zk7MM-00007g-27
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 11:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755312AbbJHJTC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 05:19:02 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34643 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755270AbbJHJSb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 05:18:31 -0400
Received: by padhy16 with SMTP id hy16so49628214pad.1
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 02:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8BCpQQWLB8Jq3qWzZ+1hp8SO2lBDasz3SaisMQzyW4I=;
        b=XWSLQHgjsRWhkbiZoJhWdKjELxbwsarlDUhIGjIDnP1LB4bfTpp0a44UANUTtZ7Qxc
         2BouLBOi4W6F4Ez8GwXVgrREfK6cAp/V+8GHOMsSvW0oqMp2wAYU1x7rx9AQ3S2FRO5a
         gb2NQw8wHOPPV5QEDTnzWS8xZEAbLpXM4/lM4wklcNuM58OgxXDhDIUqdNBBHIQqv98y
         Co43CeT87UD9Qn1jm/2rLWOvODN6PTkxtR2Ufs+EWGBDcjmXTufk/ZtyGn+y/DV2WCmn
         KX2ZU4+h/spTn/cJLc1qJTPsDXy9TjovO3oUT8raItPT6khHrYLnzRzpENXA3QWVYUO3
         Z5jA==
X-Received: by 10.67.12.166 with SMTP id er6mr6903834pad.40.1444295911099;
        Thu, 08 Oct 2015 02:18:31 -0700 (PDT)
Received: from ashley.localdomain ([106.51.20.153])
        by smtp.gmail.com with ESMTPSA id sv9sm44171159pbc.44.2015.10.08.02.18.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Oct 2015 02:18:30 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279232>

Add support for %(upstream:track,nobracket) which will print the
tracking information without the brackets (i.e. "ahead N, behind M").

Add test and documentation for the same.
---
 Documentation/git-for-each-ref.txt |  6 ++++--
 ref-filter.c                       | 28 +++++++++++++++++++++++-----
 t/t6300-for-each-ref.sh            |  9 +++++++++
 3 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index c713ec0..a38cbf6 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -114,8 +114,10 @@ upstream::
 	`refname` above.  Additionally respects `:track` to show
 	"[ahead N, behind M]" and `:trackshort` to show the terse
 	version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
-	or "=" (in sync).  Has no effect if the ref does not have
-	tracking information associated with it.
+	or "=" (in sync).  Append `:track,nobracket` to show tracking
+	information without brackets (i.e "ahead N, behind M").  Has
+	no effect if the ref does not have tracking information
+	associated with it.
 
 push::
 	The name of a local ref which represents the `@{push}` location
diff --git a/ref-filter.c b/ref-filter.c
index 6a38089..6044eb0 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1112,27 +1112,45 @@ static void populate_value(struct ref_array_item *ref)
 			if (!strcmp(formatp, "short"))
 				refname = shorten_unambiguous_ref(refname,
 						      warn_ambiguous_refs);
-			else if (!strcmp(formatp, "track") &&
+			else if (skip_prefix(formatp, "track", &valp) &&
+				 strcmp(formatp, "trackshort") &&
 				 (starts_with(name, "upstream") ||
 				  starts_with(name, "push"))) {
 				char buf[40];
+				unsigned int nobracket = 0;
+
+				if (!strcmp(valp, ",nobracket"))
+					nobracket = 1;
 
 				if (stat_tracking_info(branch, &num_ours,
 						       &num_theirs, NULL)) {
-					v->s = "[gone]";
+					if (nobracket)
+						v->s = "gone";
+					else
+						v->s = "[gone]";
 					continue;
 				}
 
 				if (!num_ours && !num_theirs)
 					v->s = "";
 				else if (!num_ours) {
-					sprintf(buf, "[behind %d]", num_theirs);
+					if (nobracket)
+						sprintf(buf, "behind %d", num_theirs);
+					else
+						sprintf(buf, "[behind %d]", num_theirs);
 					v->s = xstrdup(buf);
 				} else if (!num_theirs) {
-					sprintf(buf, "[ahead %d]", num_ours);
+					if (nobracket)
+						sprintf(buf, "ahead %d", num_ours);
+					else
+						sprintf(buf, "[ahead %d]", num_ours);
 					v->s = xstrdup(buf);
 				} else {
-					sprintf(buf, "[ahead %d, behind %d]",
+					if (nobracket)
+						sprintf(buf, "ahead %d, behind %d",
+							num_ours, num_theirs);
+					else
+						sprintf(buf, "[ahead %d, behind %d]",
 						num_ours, num_theirs);
 					v->s = xstrdup(buf);
 				}
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 4f620bf..7ab8bf8 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -344,6 +344,15 @@ test_expect_success 'Check upstream:track format' '
 '
 
 cat >expected <<EOF
+ahead 1
+EOF
+
+test_expect_success 'Check upstream:track,nobracket format' '
+	git for-each-ref --format="%(upstream:track,nobracket)" refs/heads >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
 >
 EOF
 
-- 
2.6.0
