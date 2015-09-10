From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v17 05/14] ref-filter: introduce match_atom_name()
Date: Thu, 10 Sep 2015 21:18:21 +0530
Message-ID: <1441900110-4015-6-git-send-email-Karthik.188@gmail.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 10 17:48:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za45e-0005C6-89
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 17:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728AbbIJPsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 11:48:41 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33270 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbbIJPsh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 11:48:37 -0400
Received: by pacex6 with SMTP id ex6so46669613pac.0
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 08:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1cMF6CXxEFqV6VG95/Cye/xCNmKxfDeqARcL2IdDivU=;
        b=lrZvM1w1+fwZuJpuY0q3AwnCY9KQsYj+3YMAXOXVmDuGM7cC+/vHgZBBwC4Ofr/wWU
         p9yDuUhMZ1XKhXAfFyBBlh82uERZs6PyLlH97eFXSX7BItBTIAPNYUX7tuCTk26w1aCq
         zRO5ylws6XQdV/wD9vHHBAtB8xqY+J4Hwybu/MAvMFLM4/ObLHW1P5DlKEMV9eL/Sk2W
         NQkLJeRj4SNtfv+Gbetv7zv9w54E1pzLS/tGd6bQGKbwpwWGNlKpEd5JJSf6DuM7RYTn
         5PjUnxC6afZp3vOixAUpDNWqYgsqzxjCGPdw3Fa4ESd26wv5/CEnNP2KELc5CtwZJSZZ
         CJiA==
X-Received: by 10.68.249.36 with SMTP id yr4mr83987577pbc.18.1441900116503;
        Thu, 10 Sep 2015 08:48:36 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ts1sm12738918pbc.74.2015.09.10.08.48.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Sep 2015 08:48:36 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277586>

Introduce match_atom_name() which helps in checking if a particular
atom is the atom we're looking for and if it has a value attached to
it or not.

Use it instead of starts_with() for checking the value of %(color:...)
atom. Write a test for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Thanks-to: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c                   | 23 +++++++++++++++++++++--
 t/t6302-for-each-ref-filter.sh |  4 ++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index a993216..70d36fe 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -189,6 +189,22 @@ static void pop_stack_element(struct ref_formatting_stack **stack)
 	*stack = prev;
 }
 
+static int match_atom_name(const char *name, const char *atom_name, const char **val)
+{
+	const char *body;
+
+	if (!skip_prefix(name, atom_name, &body))
+		return 0; /* doesn't even begin with "atom_name" */
+	if (!body[0] || !body[1]) {
+		*val = NULL; /* %(atom_name) and no customization */
+		return 1;
+	}
+	if (body[0] != ':')
+		return 0; /* "atom_namefoo" is not "atom_name" or "atom_name:..." */
+	*val = body + 1; /* "atom_name:val" */
+	return 1;
+}
+
 /*
  * In a format string, find the next occurrence of %(atom).
  */
@@ -687,6 +703,7 @@ static void populate_value(struct ref_array_item *ref)
 		int deref = 0;
 		const char *refname;
 		const char *formatp;
+		const char *valp;
 		struct branch *branch = NULL;
 
 		v->handler = append_atom;
@@ -721,10 +738,12 @@ static void populate_value(struct ref_array_item *ref)
 			refname = branch_get_push(branch, NULL);
 			if (!refname)
 				continue;
-		} else if (starts_with(name, "color:")) {
+		} else if (match_atom_name(name, "color", &valp)) {
 			char color[COLOR_MAXLEN] = "";
 
-			if (color_parse(name + 6, color) < 0)
+			if (!valp)
+				die(_("expected format: %%(color:<color>)"));
+			if (color_parse(valp, color) < 0)
 				die(_("unable to parse format"));
 			v->s = xstrdup(color);
 			continue;
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 505a360..c4f0378 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -81,4 +81,8 @@ test_expect_success 'filtering with --contains' '
 	test_cmp expect actual
 '
 
+test_expect_success '%(color) must fail' '
+	test_must_fail git for-each-ref --format="%(color)%(refname)"
+'
+
 test_done
-- 
2.5.1
