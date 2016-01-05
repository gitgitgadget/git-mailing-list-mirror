From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 12/15] ref-filter: align: introduce long-form syntax
Date: Tue,  5 Jan 2016 13:33:11 +0530
Message-ID: <1451980994-26865-13-git-send-email-Karthik.188@gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 09:03:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGMar-0008Vi-KD
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 09:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbcAEIDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 03:03:19 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34555 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbcAEIDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 03:03:09 -0500
Received: by mail-pa0-f44.google.com with SMTP id uo6so191795881pac.1
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 00:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zeyDCznQhXn20hvVfqrdt9848RTMkx2py99lyMJXKGE=;
        b=07uBdbf3aCmrAZgcdDyB+SsO87KS0M7FtNWSd1BzurNy3+Q+UTKLa9t955/+HoCKCq
         JFEir0mXF+0bVUuhARk7MaM2q8o4YlXsDAfD+HUQnO5SHnbWXQaIHxSyX4+U7TEOBrTT
         XYkg7Axk96f2nvpwi6mEqF2JyhIEWsrDXQJMKmP3HF/sunlXwF5kVDUhd8NvqyzfaU5H
         fa9TgRzOXHO+VR9T8nJ5+10D8mZMC2HLEMJJ4Vcl4woTyZq871JF1BMV8jmTxviBHz77
         Df+BNopmMp9duT57/Nf4S7EU0JQd+pyzzLLYdBxLIXS+96W6swEvgs3C7O5g2iUFWHBs
         4FSw==
X-Received: by 10.66.253.97 with SMTP id zz1mr89868721pac.106.1451980988696;
        Tue, 05 Jan 2016 00:03:08 -0800 (PST)
Received: from ashley.localdomain ([106.51.242.38])
        by smtp.gmail.com with ESMTPSA id q190sm125814275pfq.59.2016.01.05.00.03.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Jan 2016 00:03:08 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283365>

Introduce optional prefixes "width=" and "position=" for the align atom
so that the atom can be used as "%(align:width=<width>,position=<position>)".

Add Documetation and tests for the same.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt | 20 +++++++++++--------
 ref-filter.c                       | 10 +++++++++-
 t/t6302-for-each-ref-filter.sh     | 41 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 9 deletions(-)

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
index 4f623a0..df0b114 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -104,7 +104,15 @@ static void align_atom_parser(struct used_atom *atom)
 		int position;
 		buf = s[0]->buf;
 
-		if (!strtoul_ui(buf, 10, &width))
+		if (skip_prefix(buf, "position=", &buf)) {
+			position = parse_align_position(buf);
+			if (position < 0)
+				die(_("unrecognized position:%s"), buf);
+			align->position = position;
+		} else if (skip_prefix(buf, "width=", &buf)) {
+			if (strtoul_ui(buf, 10, &width))
+				die(_("unrecognized width:%s"), buf);
+		} else if (!strtoul_ui(buf, 10, &width))
 			;
 		else if ((position = parse_align_position(buf)) >= 0)
 			align->position = position;
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index fe4796c..0c4417f 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -133,6 +133,47 @@ test_expect_success 'right alignment' '
 	test_cmp expect actual
 '
 
+cat >expect <<-\EOF
+|       refname is refs/heads/master       |refs/heads/master
+|        refname is refs/heads/side        |refs/heads/side
+|         refname is refs/odd/spot         |refs/odd/spot
+|     refname is refs/tags/double-tag      |refs/tags/double-tag
+|        refname is refs/tags/four         |refs/tags/four
+|         refname is refs/tags/one         |refs/tags/one
+|     refname is refs/tags/signed-tag      |refs/tags/signed-tag
+|        refname is refs/tags/three        |refs/tags/three
+|         refname is refs/tags/two         |refs/tags/two
+EOF
+
+test_align_permutations() {
+	while read -r option; do
+		test_expect_success 'align permutations' '
+		git for-each-ref --format="|%(align:$option)refname is %(refname)%(end)|%(refname)" >actual &&
+		test_cmp expect actual
+		'
+	done;
+}
+
+test_align_permutations <<-\EOF
+	middle,42
+	42,middle
+	position=middle,42
+	42,position=middle
+	middle,width=42
+	width=42,middle
+	position=middle,width=42
+	width=42,position=middle
+EOF
+
+# Last one wins (silently) when multiple arguments of the same type are given
+
+test_align_permutations <<-\EOF
+	32,width=42,middle
+	width=30,42,middle
+	width=42,position=right,middle
+	42,right,position=middle
+EOF
+
 # Individual atoms inside %(align:...) and %(end) must not be quoted.
 
 test_expect_success 'alignment with format quote' "
-- 
2.6.4
