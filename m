From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 08/11] ref-filter: introduce prefixes for the align atom
Date: Wed, 16 Dec 2015 20:59:59 +0530
Message-ID: <1450279802-29414-9-git-send-email-Karthik.188@gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 16:30:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9E1s-0001uN-Gm
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 16:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934198AbbLPPaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 10:30:08 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33096 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933118AbbLPPaE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 10:30:04 -0500
Received: by mail-pa0-f52.google.com with SMTP id ur14so25133417pab.0
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 07:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rEP7jMtdl1ipm669xTi710d0XOhVmBLcqD5I8zJoDQE=;
        b=LEWR/ht8tk+PrUYlcQu3AAXam1k6ac5C2kTzca3pqXkGa7Z/oy5QhczQOWB19UsAaq
         xN850I4KSRDhQVAnuKhoOSEq4HYvC62ocfUXvASqwyN6rYL0MyTBxiY0bOjz/iaHM/Pi
         /lY9AZlSLldP7RolFsOhZnPbVuK52/uBYJZnkFglcvd28RCAQV+U4tjBo6ZNowC43N7K
         pFdbnLiz74qPf7U29qT9PfGODz+hKvjNwyUyZMBDywdWhNJ9m0yB1OTJlpKy9xIIkcis
         Ov5OPCIgeEJepH2QJmjmX/XlLuc3VweOmF7jB4EnKgIpdSREq3zGjLvayOJ2UvggiQzS
         t0Jw==
X-Received: by 10.66.255.10 with SMTP id am10mr64068151pad.79.1450279804237;
        Wed, 16 Dec 2015 07:30:04 -0800 (PST)
Received: from ashley.localdomain ([106.51.233.145])
        by smtp.gmail.com with ESMTPSA id x12sm5620612pfi.95.2015.12.16.07.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Dec 2015 07:30:03 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282571>

Introduce optional prefixes "width=" and "position=" for the align atom
so that the atom can be used as "%(align:width=<width>,position=<position>)".

Add Documetation and tests for the same.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  20 +++--
 ref-filter.c                       |  13 ++-
 t/t6302-for-each-ref-filter.sh     | 162 +++++++++++++++++++++++++++++++++++++
 3 files changed, 185 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index c6f073c..9af0f53 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -129,14 +129,18 @@ color::
 
 align::
 	Left-, middle-, or right-align the content between
-	%(align:...) and %(end). The "align:" is followed by `<width>`
-	and `<position>` in any order separated by a comma, where the
-	`<position>` is either left, right or middle, default being
-	left and `<width>` is the total length of the content with
-	alignment. If the contents length is more than the width then
-	no alignment is performed. If used with '--quote' everything
-	in between %(align:...) and %(end) is quoted, but if nested
-	then only the topmost level performs quoting.
+	%(align:...) and %(end). The "align:" is followed by
+	`width=<width>` and `position=<position>` in any order
+	separated by a comma, where the `<position>` is either left,
+	right or middle, default being left and `<width>` is the total
+	length of the content with alignment. For brevity, the
+	"width=" and/or "position=" prefixes may be omitted, and bare
+	<width> and <position> used instead.  For instance,
+	`%(align:<width>,<position>)`. If the contents length is more
+	than the width then no alignment is performed. If used with
+	'--quote' everything in between %(align:...) and %(end) is
+	quoted, but if nested then only the topmost level performs
+	quoting.
 
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
diff --git a/ref-filter.c b/ref-filter.c
index a44673c..985423b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -96,10 +96,19 @@ static void align_atom_parser(struct used_atom *atom)
 
 	while (*s) {
 		int position;
+		buf = s[0]->buf;
 
-		if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&width))
+		if (skip_prefix(buf, "position=", &buf)) {
+			position = parse_align_position(buf);
+			if (position == -1)
+				die(_("unrecognized position:%s"), buf);
+			align->position = position;
+		} else if (skip_prefix(buf, "width=", &buf)) {
+			if (strtoul_ui(buf, 10, (unsigned int *)&width))
+				die(_("unrecognized width:%s"), buf);
+		} else if (!strtoul_ui(buf, 10, (unsigned int *)&width))
 			;
-		else if ((position = parse_align_position(s[0]->buf)) > 0)
+		else if ((position = parse_align_position(buf)) != -1)
 			align->position = position;
 		else
 			die(_("unrecognized %%(align) argument: %s"), s[0]->buf);
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index fe4796c..bcb6771 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -133,6 +133,168 @@ test_expect_success 'right alignment' '
 	test_cmp expect actual
 '
 
+test_expect_success 'alignment with "position" prefix' '
+	cat >expect <<-\EOF &&
+	|  refname is refs/heads/master|refs/heads/master
+	|    refname is refs/heads/side|refs/heads/side
+	|      refname is refs/odd/spot|refs/odd/spot
+	|refname is refs/tags/double-tag|refs/tags/double-tag
+	|     refname is refs/tags/four|refs/tags/four
+	|      refname is refs/tags/one|refs/tags/one
+	|refname is refs/tags/signed-tag|refs/tags/signed-tag
+	|    refname is refs/tags/three|refs/tags/three
+	|      refname is refs/tags/two|refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:30,position=right)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'alignment with "position" prefix' '
+	cat >expect <<-\EOF &&
+	|  refname is refs/heads/master|refs/heads/master
+	|    refname is refs/heads/side|refs/heads/side
+	|      refname is refs/odd/spot|refs/odd/spot
+	|refname is refs/tags/double-tag|refs/tags/double-tag
+	|     refname is refs/tags/four|refs/tags/four
+	|      refname is refs/tags/one|refs/tags/one
+	|refname is refs/tags/signed-tag|refs/tags/signed-tag
+	|    refname is refs/tags/three|refs/tags/three
+	|      refname is refs/tags/two|refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:position=right,30)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'alignment with "width" prefix' '
+	cat >expect <<-\EOF &&
+	|  refname is refs/heads/master|refs/heads/master
+	|    refname is refs/heads/side|refs/heads/side
+	|      refname is refs/odd/spot|refs/odd/spot
+	|refname is refs/tags/double-tag|refs/tags/double-tag
+	|     refname is refs/tags/four|refs/tags/four
+	|      refname is refs/tags/one|refs/tags/one
+	|refname is refs/tags/signed-tag|refs/tags/signed-tag
+	|    refname is refs/tags/three|refs/tags/three
+	|      refname is refs/tags/two|refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:width=30,right)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'alignment with "width" prefix' '
+	cat >expect <<-\EOF &&
+	|  refname is refs/heads/master|refs/heads/master
+	|    refname is refs/heads/side|refs/heads/side
+	|      refname is refs/odd/spot|refs/odd/spot
+	|refname is refs/tags/double-tag|refs/tags/double-tag
+	|     refname is refs/tags/four|refs/tags/four
+	|      refname is refs/tags/one|refs/tags/one
+	|refname is refs/tags/signed-tag|refs/tags/signed-tag
+	|    refname is refs/tags/three|refs/tags/three
+	|      refname is refs/tags/two|refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:right,width=30)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'alignment with "position" and "width" prefix' '
+	cat >expect <<-\EOF &&
+	|  refname is refs/heads/master|refs/heads/master
+	|    refname is refs/heads/side|refs/heads/side
+	|      refname is refs/odd/spot|refs/odd/spot
+	|refname is refs/tags/double-tag|refs/tags/double-tag
+	|     refname is refs/tags/four|refs/tags/four
+	|      refname is refs/tags/one|refs/tags/one
+	|refname is refs/tags/signed-tag|refs/tags/signed-tag
+	|    refname is refs/tags/three|refs/tags/three
+	|      refname is refs/tags/two|refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:width=30,position=right)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'alignment with "position" and "width" prefix' '
+	cat >expect <<-\EOF &&
+	|  refname is refs/heads/master|refs/heads/master
+	|    refname is refs/heads/side|refs/heads/side
+	|      refname is refs/odd/spot|refs/odd/spot
+	|refname is refs/tags/double-tag|refs/tags/double-tag
+	|     refname is refs/tags/four|refs/tags/four
+	|      refname is refs/tags/one|refs/tags/one
+	|refname is refs/tags/signed-tag|refs/tags/signed-tag
+	|    refname is refs/tags/three|refs/tags/three
+	|      refname is refs/tags/two|refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:position=right,width=30)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
+# Last one wins (silently) when multiple arguments of the same type are given
+
+test_expect_success 'alignment with multiple "<width>" values' '
+	cat >expect <<-\EOF &&
+	|refname is refs/heads/master  |refs/heads/master
+	|refname is refs/heads/side    |refs/heads/side
+	|refname is refs/odd/spot      |refs/odd/spot
+	|refname is refs/tags/double-tag|refs/tags/double-tag
+	|refname is refs/tags/four     |refs/tags/four
+	|refname is refs/tags/one      |refs/tags/one
+	|refname is refs/tags/signed-tag|refs/tags/signed-tag
+	|refname is refs/tags/three    |refs/tags/three
+	|refname is refs/tags/two      |refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:32,width=30)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'alignment with multiple "<width>" values' '
+	cat >expect <<-\EOF &&
+	|refname is refs/heads/master    |refs/heads/master
+	|refname is refs/heads/side      |refs/heads/side
+	|refname is refs/odd/spot        |refs/odd/spot
+	|refname is refs/tags/double-tag |refs/tags/double-tag
+	|refname is refs/tags/four       |refs/tags/four
+	|refname is refs/tags/one        |refs/tags/one
+	|refname is refs/tags/signed-tag |refs/tags/signed-tag
+	|refname is refs/tags/three      |refs/tags/three
+	|refname is refs/tags/two        |refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:width=30,32)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'alignment with multiple "<position>" values' '
+	cat >expect <<-\EOF &&
+	|  refname is refs/heads/master|refs/heads/master
+	|    refname is refs/heads/side|refs/heads/side
+	|      refname is refs/odd/spot|refs/odd/spot
+	|refname is refs/tags/double-tag|refs/tags/double-tag
+	|     refname is refs/tags/four|refs/tags/four
+	|      refname is refs/tags/one|refs/tags/one
+	|refname is refs/tags/signed-tag|refs/tags/signed-tag
+	|    refname is refs/tags/three|refs/tags/three
+	|      refname is refs/tags/two|refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:width=30,position=middle,right)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'alignment with multiple "<position>" values' '
+	cat >expect <<-\EOF &&
+	| refname is refs/heads/master |refs/heads/master
+	|  refname is refs/heads/side  |refs/heads/side
+	|   refname is refs/odd/spot   |refs/odd/spot
+	|refname is refs/tags/double-tag|refs/tags/double-tag
+	|  refname is refs/tags/four   |refs/tags/four
+	|   refname is refs/tags/one   |refs/tags/one
+	|refname is refs/tags/signed-tag|refs/tags/signed-tag
+	|  refname is refs/tags/three  |refs/tags/three
+	|   refname is refs/tags/two   |refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:30,right,position=middle)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
 # Individual atoms inside %(align:...) and %(end) must not be quoted.
 
 test_expect_success 'alignment with format quote' "
-- 
2.6.4
