From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 3/9] ref-filter: add support for %(path) atom
Date: Fri,  2 Oct 2015 23:09:00 +0530
Message-ID: <1443807546-5985-4-git-send-email-Karthik.188@gmail.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 02 19:39:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi4Iy-00040e-9a
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 19:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075AbbJBRjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 13:39:18 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36617 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239AbbJBRjR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 13:39:17 -0400
Received: by pacik9 with SMTP id ik9so12566267pac.3
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 10:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4sNaYCLT6pw5+Ul6/MEOf4YHWAfT0JoJh9k8V2bjAsA=;
        b=LACdDjwWRCwUYm3Q4KbR9uF+mJD8jLaJy114g/DZnQ7vx7WIgySL8q878FlDVvf8zA
         zOdCvo+qDAcNZqfelJuAyc5+ARFm+fgld7WC8m4ud+WCWEyH9M7MeHev6wFdngKZE+n4
         AUZ2f7f0cnlLgaYcv/Jh0r8hlMZNT1W3AIibMvUmR/DKPsGt19YS2y943vGK2BySsZtj
         rb42YfCM8KGOTH/Esy8xoyshmVJmIBFNMsyJfv6PK5Ncww95cPo6n3PU4DS8Ksr84Kbf
         8iNvrci+JGThqgV/iuILrOEUO+SieQnAiER7CAb0u45BjAzJrlCJ96D5iMTOFCnDbk0B
         LZgw==
X-Received: by 10.66.150.161 with SMTP id uj1mr11160505pab.148.1443807556618;
        Fri, 02 Oct 2015 10:39:16 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id pq1sm12993384pbb.91.2015.10.02.10.39.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Oct 2015 10:39:16 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.0
In-Reply-To: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278929>

This adds %(path) and %(path:short) atoms. The %(path) atom will print
the path of the given ref, while %(path:short) will only print the
subdirectory of the given ref.

Add tests and documentation for the same.
---
 Documentation/git-for-each-ref.txt |  5 +++++
 ref-filter.c                       | 17 +++++++++++++++++
 t/t6302-for-each-ref-filter.sh     | 39 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 5c12c2f..6a476ba 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -145,6 +145,11 @@ if::
 	compare the value between the %(if:...) and %(then) atoms with the
 	given string.
 
+path::
+	The path of the given ref. For a shortened version listing
+	only the name of the directory the ref is under append
+	`:short`.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/ref-filter.c b/ref-filter.c
index da7723b..b0e86ae 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -58,6 +58,7 @@ static struct {
 	{ "if" },
 	{ "then" },
 	{ "else" },
+	{ "path" },
 };
 
 #define REF_FORMATTING_STATE_INIT  { 0, NULL }
@@ -1042,6 +1043,22 @@ static void populate_value(struct ref_array_item *ref)
 		} else if (!strcmp(name, "else")) {
 			v->handler = else_atom_handler;
 			continue;
+		} else if (match_atom_name(name, "path", &valp)) {
+			const char *sp, *ep;
+
+			if (ref->kind & FILTER_REFS_DETACHED_HEAD)
+				continue;
+
+			sp = strchr(ref->refname, '/');
+			ep = strchr(++sp, '/');
+
+			if (!valp)
+				sp = ref->refname;
+			else if (strcmp(valp, "short"))
+				die(_("format: invalid value given path:%s"), valp);
+
+			v->s = xstrndup(sp, ep - sp);
+			continue;
 		} else
 			continue;
 
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index d7f7a18..5557657 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -312,6 +312,7 @@ test_expect_success 'check %(if:equals=<string>)' '
 	test_cmp expect actual
 '
 
+
 test_expect_success 'check %(if:notequals=<string>)' '
 	git for-each-ref --format="%(if:notequals=master)%(refname:short)%(then)Not master%(else)Found master%(end)" refs/heads/ >actual &&
 	cat >expect <<-\EOF &&
@@ -321,4 +322,42 @@ test_expect_success 'check %(if:notequals=<string>)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'check %(path)' '
+	git for-each-ref --format="%(path)" >actual &&
+	cat >expect <<-\EOF &&
+	refs/heads
+	refs/heads
+	refs/odd
+	refs/tags
+	refs/tags
+	refs/tags
+	refs/tags
+	refs/tags
+	refs/tags
+	refs/tags
+	refs/tags
+	refs/tags
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'check %(path:short)' '
+	git for-each-ref --format="%(path:short)" >actual &&
+	cat >expect <<-\EOF &&
+	heads
+	heads
+	odd
+	tags
+	tags
+	tags
+	tags
+	tags
+	tags
+	tags
+	tags
+	tags
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.6.0
