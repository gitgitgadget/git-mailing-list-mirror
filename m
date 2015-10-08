From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 03/10] ref-filter: add support for %(refname:dir) and %(refname:base)
Date: Thu,  8 Oct 2015 14:47:58 +0530
Message-ID: <1444295885-1657-4-git-send-email-Karthik.188@gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 08 11:20:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zk7N3-0000kn-Dp
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 11:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239AbbJHJUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 05:20:12 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35385 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820AbbJHJSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 05:18:09 -0400
Received: by pabve7 with SMTP id ve7so8803094pab.2
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 02:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7NUuJEy1Y5UrBGdruXJKMYgAqa0a3FIQuuRomsK7B60=;
        b=zNTfkoiDaDT1a3BNOI4uYNlwXJuN0iY2PqereE1NErx0jcWRZSJ5dumSv6v57Ns2L6
         RdimweDt+VeQBZE5zNTwzWtZRHF+i46IcocYa4aH7mUuQ/GbOi5xGOUpBnAQKalyWQqG
         /pxfAwQHhVHuzHEXGXaPKzjRHQZmubnp0AFu+mkOh/JNQYMhaXeJWzNoOfDg1s9LEIaE
         fF75ajp3BGf3Apb5QmsVot5bZ6bzj5V7ZmGINyRJy2/r7eCh2V+4MbPSxVpR3UqqVzBy
         pF5yYLj8EVWzSHaWipEF43RJ6Ill/o06APjPdgldNYkyIivg6O6fGt5cdIc7kb5s1DrX
         q4RQ==
X-Received: by 10.68.168.97 with SMTP id zv1mr7006287pbb.86.1444295889226;
        Thu, 08 Oct 2015 02:18:09 -0700 (PDT)
Received: from ashley.localdomain ([106.51.20.153])
        by smtp.gmail.com with ESMTPSA id sv9sm44171159pbc.44.2015.10.08.02.18.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Oct 2015 02:18:08 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279234>

Add the options `:dir` and `:base` to the %(refname) atom. The `:dir`
option gives the directory (the part after $GIT_DIR/) of the ref
without the refname. The `:base` option gives the base directory of
the given ref (i.e. the directory following $GIT_DIR/refs/).

Add tests and documentation for the same.
---
 Documentation/git-for-each-ref.txt |  4 +++-
 ref-filter.c                       | 23 +++++++++++++++++++
 t/t6302-for-each-ref-filter.sh     | 47 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 206d646..b8d33a1 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -92,7 +92,9 @@ refname::
 	The name of the ref (the part after $GIT_DIR/).
 	For a non-ambiguous short name of the ref append `:short`.
 	The option core.warnAmbiguousRefs is used to select the strict
-	abbreviation mode.
+	abbreviation mode. For the base directory of the ref (i.e. foo
+	in refs/foo/bar/boz) append `:base`. For the entire directory
+	path append `:dir`.
 
 objecttype::
 	The type of the object (`blob`, `tree`, `commit`, `tag`).
diff --git a/ref-filter.c b/ref-filter.c
index 359c76d..94d8754 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1105,6 +1105,29 @@ static void populate_value(struct ref_array_item *ref)
 				else
 					v->s = "<>";
 				continue;
+			} else if (!strcmp(formatp, "dir") &&
+				   (starts_with(name, "refname"))) {
+				const char *sp, *ep, *tmp;
+
+				sp = tmp = ref->refname;
+				/*  Obtain refs/foo/bar/ from refname refs/foo/bar/abc */
+				do {
+					ep = tmp;
+					tmp = strchr(ep + 1, '/');
+				} while (tmp);
+				v->s = xstrndup(sp, ep - sp);
+				continue;
+			} else if (!strcmp(formatp, "base") &&
+				   (starts_with(name, "refname"))) {
+				const char *sp, *ep;
+
+				if (skip_prefix(ref->refname, "refs/", &sp)) {
+					ep = strchr(sp, '/');
+					if (!ep)
+						continue;
+					v->s = xstrndup(sp, ep - sp);
+				}
+				continue;
 			} else
 				die("unknown %.*s format %s",
 				    (int)(formatp - name), name, formatp);
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index f45ac1f..19a5075 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -340,4 +340,51 @@ test_expect_success 'check %(if:notequals=<string>)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'update refs for %(refname:dir) and %(refname:base)' '
+	git update-ref refs/foo HEAD &&
+	git update-ref refs/foodir/bar/boz HEAD
+'
+
+test_expect_success 'check %(refname:dir)' '
+	git for-each-ref --format="%(refname:dir)" >actual &&
+	cat >expect <<-\EOF &&
+	refs
+	refs/foodir/bar
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
+test_expect_success 'check %(refname:base)' '
+	git for-each-ref --format="%(refname:base)" >actual &&
+	cat >expect <<-\EOF &&
+	
+	foodir
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
