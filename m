From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v16 05/14] ref-filter: introduce match_atom_name()
Date: Sun,  6 Sep 2015 00:22:06 +0530
Message-ID: <1441479135-5285-6-git-send-email-Karthik.188@gmail.com>
References: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 05 20:52:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYIZv-000291-DL
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 20:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604AbbIESwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 14:52:41 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35958 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbbIESwT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 14:52:19 -0400
Received: by pacwi10 with SMTP id wi10so54946523pac.3
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 11:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OayUcJ4AtMYQfCIWYQHnv88802RoqOLw1MR+cgkN0Kc=;
        b=vrIqJgFrdgwPnDuGueMGG9ouTbCUdj16QsX81wNvks8bZSpfXXQHaEt/le8wo5/hPs
         uns+p5r82GdewwQQPkxBaoNX6S3nPyMpL0vLoKbxyPip7YzTRmuacrd3eL1+MLLp22p6
         CddNBQjwiGyuPNPoItnHuknfsa2eZnW8DUwvJZTgp9wSFJ5+kppStgxg3TZwe/JL8hWd
         U47+a1lo86xRsY5m9/NJfC/XO8cOhOXNIlhFvooJHe/+oKpCfv+64gXmGkB7Mo9W4Tp6
         Q3lpiC7huH2NyewyusJdpbsp0XeBdU4lmyKa4q7Pa1Lmyt1gPCx48x2AGrL3JXjFRwfn
         XbwA==
X-Received: by 10.66.248.162 with SMTP id yn2mr24094122pac.85.1441479139420;
        Sat, 05 Sep 2015 11:52:19 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ch3sm6583639pbb.18.2015.09.05.11.52.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 05 Sep 2015 11:52:18 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277399>

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
index a993216..e99c342 100644
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
+	*val = body + 1; /* "atomname:val" */
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
