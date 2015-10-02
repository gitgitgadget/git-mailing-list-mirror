From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 4/9] ref-filter: modify "%(objectname:short)" to take length
Date: Fri,  2 Oct 2015 23:09:01 +0530
Message-ID: <1443807546-5985-5-git-send-email-Karthik.188@gmail.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 02 19:39:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi4Iy-00040e-ST
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 19:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761AbbJBRjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 13:39:23 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33649 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801AbbJBRjU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 13:39:20 -0400
Received: by padew5 with SMTP id ew5so12560628pad.0
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 10:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tVSc3gJLTCJUeGlCiBpqCOkuPz8l6c0ob1c6LirVJqI=;
        b=MtXjr/ql3kIt1rgwNS6d8vx/rj9kTkKL3u0e5DHuoIMLFIh8CyNtqfzKGD/1p9OYHm
         1vAwbdXb4zRhScTo2QRVrINcgaOkLPgjwDWgVDlGIi790HUJEXxgrR2maxqkxtP+PQ04
         K3zkd+LHtHFwUkSfQbhVs8ynvFNmbPSdL4NN3XkLlSuzjMRy1tKR3as1ZD5aMSjara7y
         lWQ8myRofpL/OqfOOrIiKLKTb1qjJwPqpOpk2aIlBXFzWmdUZ3GkS5RyvV1vdhp6PM4t
         ruRAEmrfQ0EatdKD7ATuMwJW2qeVoIXpaT3uUDPylIYe4rLofm6RKrgl1mD10MTQWgoE
         WGYw==
X-Received: by 10.68.57.175 with SMTP id j15mr21390186pbq.34.1443807560471;
        Fri, 02 Oct 2015 10:39:20 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id pq1sm12993384pbb.91.2015.10.02.10.39.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Oct 2015 10:39:20 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.0
In-Reply-To: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278928>

Add support for %(objectname:short,<length>) which would print the
abbreviated unique objectname of given length. When no length is
specified 7 is used. The minimum length is 4.

Add tests and documentation for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  2 ++
 ref-filter.c                       | 39 ++++++++++++++++++++++++++++++--------
 t/t6300-for-each-ref.sh            | 22 +++++++++++++++++++++
 3 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 6a476ba..5097915 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -103,6 +103,8 @@ objectsize::
 objectname::
 	The object name (aka SHA-1).
 	For a non-ambiguous abbreviation of the object name append `:short`.
+	The length can be explicitly specified by appending either
+	`:short,<length>` or `:<length>,short`.  Minimum length is 4.
 
 upstream::
 	The name of a local ref which can be considered ``upstream''
diff --git a/ref-filter.c b/ref-filter.c
index b0e86ae..223daeb 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -454,14 +454,37 @@ static void *get_obj(const unsigned char *sha1, struct object **obj, unsigned lo
 static int grab_objectname(const char *name, const unsigned char *sha1,
 			    struct atom_value *v)
 {
-	if (!strcmp(name, "objectname")) {
-		char *s = xmalloc(41);
-		strcpy(s, sha1_to_hex(sha1));
-		v->s = s;
-		return 1;
-	}
-	if (!strcmp(name, "objectname:short")) {
-		v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
+	const char *p;
+
+	if (match_atom_name(name, "objectname", &p)) {
+		struct strbuf **s, **to_free;
+		int length = DEFAULT_ABBREV;
+
+		/*  No arguments given, copy the entire objectname */
+		if (!p) {
+			char *s = xmalloc(41);
+			strcpy(s, sha1_to_hex(sha1));
+			v->s = s;
+		} else {
+			s = to_free = strbuf_split_str(p, ',', 0);
+			while (*s) {
+				/*  Strip trailing comma */
+				if (s[1])
+					strbuf_setlen(s[0], s[0]->len - 1);
+				if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&length))
+					;
+				/*  The `short` argument uses the default length */
+				else if (!strcmp("short", s[0]->buf))
+					;
+				else
+					die(_("format: unknown option entered with objectname:%s"), s[0]->buf);
+				s++;
+			}
+			if (length < MINIMUM_ABBREV)
+				length = MINIMUM_ABBREV;
+			v->s = xstrdup(find_unique_abbrev(sha1, length));
+			free(to_free);
+		}
 		return 1;
 	}
 	return 0;
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 7c9bec7..7f675d2 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -385,6 +385,28 @@ test_expect_success 'Check short objectname format' '
 	test_cmp expected actual
 '
 
+cat >expected <<EOF
+$(git rev-parse --short=1 HEAD)
+EOF
+
+test_expect_success 'Check objectname:short format when size is less than MINIMUM_ABBREV' '
+	git for-each-ref --format="%(objectname:short,1)" refs/heads >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+$(git rev-parse --short=10 HEAD)
+EOF
+
+test_expect_success 'Check objectname:short format' '
+	git for-each-ref --format="%(objectname:short,10)" refs/heads >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Check objectname:short format for invalid input' '
+	test_must_fail git for-each-ref --format="%(objectname:short,-1)" refs/heads
+'
+
 test_expect_success 'Check for invalid refname format' '
 	test_must_fail git for-each-ref --format="%(refname:INVALID)"
 '
-- 
2.6.0
