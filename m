From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 04/10] ref-filter: modify "%(objectname:short)" to take length
Date: Thu,  8 Oct 2015 14:47:59 +0530
Message-ID: <1444295885-1657-5-git-send-email-Karthik.188@gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 08 11:18:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zk7LE-0007dw-4l
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 11:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252AbbJHJSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 05:18:17 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33228 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755161AbbJHJSN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 05:18:13 -0400
Received: by pacex6 with SMTP id ex6so49743117pac.0
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 02:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rFZu5MD3vehh9v/PoCz4r1fihPECl1bgfuYMr6IrNQw=;
        b=mbKI7NlVgJp0FQNOBED3cY38gIBjw92vGBcC9HXKgAqbEOlL0abDxcJvHHTazND880
         /AVq0Clw7yanxDhdDRIXNmvVS+o/veu1DNrsX1knMSXpDwHkfIwGrWj5kJUatg6WARFw
         Zz25bdDdVufpwTNL/mDD6v4CordQ0oYinwdjinLBekJUlCOZido0o6EH1S1REQBvW0Kf
         sm5pZaWLSXzqbOGjkJV9aDkJ2w+RtJj7N64+F+zSwunSEp09F6B1MVUGbjWwbtv8APsf
         9B6ovizymt7kVW1ba/lc6O/aUvI6GvBa4X5aiN+V3DT0td1J7gIVVNdjT19pimcY9RGa
         t2PA==
X-Received: by 10.66.100.165 with SMTP id ez5mr6829838pab.63.1444295893301;
        Thu, 08 Oct 2015 02:18:13 -0700 (PDT)
Received: from ashley.localdomain ([106.51.20.153])
        by smtp.gmail.com with ESMTPSA id sv9sm44171159pbc.44.2015.10.08.02.18.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Oct 2015 02:18:12 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279227>

Add support for %(objectname:short=<length>) which would print the
abbreviated unique objectname of given length. When no length is
specified 7 is used. The minimum length is 4.

Add tests and documentation for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  4 +++-
 ref-filter.c                       | 30 ++++++++++++++++++++++--------
 t/t6300-for-each-ref.sh            | 22 ++++++++++++++++++++++
 3 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index b8d33a1..c713ec0 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -104,7 +104,9 @@ objectsize::
 
 objectname::
 	The object name (aka SHA-1).
-	For a non-ambiguous abbreviation of the object name append `:short`.
+	For a non-ambiguous abbreviation of the object name append
+	`:short`.  The length can be explicitly specified by appending
+	`:short=<length>`.  Minimum length being 4.
 
 upstream::
 	The name of a local ref which can be considered ``upstream''
diff --git a/ref-filter.c b/ref-filter.c
index 94d8754..de4d451 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -464,14 +464,28 @@ static void *get_obj(const unsigned char *sha1, struct object **obj, unsigned lo
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
+		/*  No arguments given, copy the entire objectname */
+		if (!p) {
+			char *s = xmalloc(41);
+			strcpy(s, sha1_to_hex(sha1));
+			v->s = s;
+		} else {
+			unsigned int length = DEFAULT_ABBREV;
+
+			if (skip_prefix(p, "short", &p)) {
+				if (p[0] == '=')
+					if (strtoul_ui(p + 1, 10, &length))
+						die(_("positive length expected with objectname:%s"), p + 1);
+			} else
+				die(_("format: unknown option entered with objectname:%s"), p);
+
+			if (length < MINIMUM_ABBREV)
+				length = MINIMUM_ABBREV;
+			v->s = xstrdup(find_unique_abbrev(sha1, length));
+		}
 		return 1;
 	}
 	return 0;
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 7c9bec7..6fc569e 100755
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
+	git for-each-ref --format="%(objectname:short=1)" refs/heads >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+$(git rev-parse --short=10 HEAD)
+EOF
+
+test_expect_success 'Check objectname:short format' '
+	git for-each-ref --format="%(objectname:short=10)" refs/heads >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Check objectname:short format for invalid input' '
+	test_must_fail git for-each-ref --format="%(objectname:short=-1)" refs/heads
+'
+
 test_expect_success 'Check for invalid refname format' '
 	test_must_fail git for-each-ref --format="%(refname:INVALID)"
 '
-- 
2.6.0
