From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v17 05/14] ref-filter: introduce match_atom_name()
Date: Fri, 11 Sep 2015 20:29:47 +0530
Message-ID: <1441983587-32568-1-git-send-email-Karthik.188@gmail.com>
References: <1441900110-4015-6-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 11 16:59:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaPnm-0004cD-VL
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 16:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257AbbIKO7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 10:59:42 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34660 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbbIKO7k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 10:59:40 -0400
Received: by padhy16 with SMTP id hy16so77185869pad.1
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qbP310fEFQthLtq0gXa6ONI/n6mTs5cLDDs/5zaWucI=;
        b=d3usdJ0rwuw7yDzT3PiYbhd8ElJ/wW2hpxV5e66fVh31zRybo9gkhXaXyZOKOgWLmS
         PWUPxUlOwoECFIo1JpHkkdv1iXY5partSiwhvgUmZki9UOrWH/6reBQ42/ii674jx6Ek
         aiRe6fhv7YGk+CmrqO5RDfgFkT1WOASXRRIUn8gUuGzsfJgCQSb2e3XH2IeZyNeF8yHy
         wE4YaQ+lqcC1BQwiV1R1G8+E1lcNG4gO8rKpn3c/NOAIgCemmafRoQ4MRRxiHrJubxxf
         j0DDX9wlfZ6jHWwaG5dKKNIxCWo7NeSyX5Oc9Phr15x6Z31GMdnsa3VU22TryIKEuNr0
         Sq7A==
X-Received: by 10.68.111.228 with SMTP id il4mr97652076pbb.44.1441983579461;
        Fri, 11 Sep 2015 07:59:39 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id vw7sm899749pab.15.2015.09.11.07.59.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Sep 2015 07:59:38 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441900110-4015-6-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277660>

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
index a993216..514de34 100644
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
+	if (!body[0]) {
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
