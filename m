From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH 02/11] ref-filter: add 'colornext' atom
Date: Tue, 28 Jul 2015 12:26:27 +0530
Message-ID: <1438066594-5620-2-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 08:56:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJyoa-00067S-7Y
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 08:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbbG1G4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 02:56:35 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:32841 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbbG1G4e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 02:56:34 -0400
Received: by pdbnt7 with SMTP id nt7so65564971pdb.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 23:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/Pg+3Q2FoT+egOJEDmC9z5cdcLRW315Y0Xm0zRD8zT8=;
        b=VuO297S9KGsHx+fw+MbOl8DFrQh5DmlrOzNpOBMbYPoJqiygYmSuiJf7YKTJvtSNbU
         rWkViWalqMuNXzktFJsPCMWAa2s80QUKPR6JZR20MI5nyzR+lE8LRVzc9nd8fla0sLyx
         pQtj58ceVRL5v47rOYjYgr+Xg7pcWQ9uULcgMr9+Q1C/bVAYgBaWcaR0xvRkFE3AtVag
         Yzq7mbBnXnpuQWipd8JNARBIeS6Fv+r/LwyeTAAHN019Z1en1qZcQt7IZAgCxzRRsZYH
         KyW1bC67ERNN1FTbOiiG+aSfpSlGSqOpo3iHjNTGIlm9lhZ7p+TeNEquHzVNz5tqs1UO
         t7FQ==
X-Received: by 10.70.118.5 with SMTP id ki5mr78628101pdb.6.1438066594078;
        Mon, 27 Jul 2015 23:56:34 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id q7sm33147846pdj.31.2015.07.27.23.56.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jul 2015 23:56:33 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274739>

The 'colornext' atom allows us to color only the succeeding atom with
a particular color. This resets any previous color preferences set. It
is not compatible with `padright`. This is required for printing
formats like `git branch -vv` where the upstream is colored in blue.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  5 +++++
 ref-filter.c                       | 20 +++++++++++++++++++-
 ref-filter.h                       |  4 +++-
 t/t6302-for-each-ref-filter.sh     | 16 ++++++++++++++++
 4 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 2b60aee..9dc02aa 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -133,6 +133,11 @@ padright::
 	padding. If the `value` is greater than the atom length, then
 	no padding is performed.
 
+colornext::
+	Change output color only for the next atom. Followed by
+	`<:colorname>`.  Not compatible with `padright` and resets any
+	previous `color`, if set.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/ref-filter.c b/ref-filter.c
index 4c5e3f8..3ab4ab9 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -57,6 +57,7 @@ static struct {
 	{ "HEAD" },
 	{ "color" },
 	{ "padright" },
+	{ "colornext" },
 };
 
 /*
@@ -712,6 +713,15 @@ static void populate_value(struct ref_array_item *ref)
 			v->modifier_atom = 1;
 			v->pad_to_right = 1;
 			continue;
+		} else if (starts_with(name, "colornext:")) {
+			char color[COLOR_MAXLEN] = "";
+
+			if (color_parse(name + 10, color) < 0)
+				die(_("unable to parse format"));
+			v->s = xstrdup(color);
+			v->modifier_atom = 1;
+			v->color_next = 1;
+			continue;
 		} else
 			continue;
 
@@ -1256,7 +1266,13 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 static void apply_formatting_state(struct ref_formatting_state *state,
 				   struct atom_value *v, struct strbuf *value)
 {
-	if (state->pad_to_right) {
+	if (state->color_next && state->pad_to_right)
+		die(_("cannot use `colornext` and `padright` together"));
+	if (state->color_next) {
+		strbuf_addf(value, "%s%s%s", state->color_next, v->s, GIT_COLOR_RESET);
+		return;
+	}
+	else if (state->pad_to_right) {
 		if (!is_utf8(v->s))
 			strbuf_addf(value, "%-*s", state->pad_to_right, v->s);
 		else {
@@ -1346,6 +1362,8 @@ static void emit(const char *cp, const char *ep)
 static void store_formatting_state(struct ref_formatting_state *state,
 				   struct atom_value *atomv)
 {
+	if (atomv->color_next)
+		state->color_next = atomv->s;
 	if (atomv->pad_to_right)
 		state->pad_to_right = atomv->ul;
 }
diff --git a/ref-filter.h b/ref-filter.h
index fcf469e..8c82fd1 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -21,12 +21,14 @@ struct atom_value {
 	const char *s;
 	unsigned long ul; /* used for sorting when not FIELD_STR */
 	unsigned int modifier_atom : 1, /*  atoms which act as modifiers for the next atom */
-		pad_to_right : 1;
+		pad_to_right : 1,
+		color_next : 1;
 };
 
 struct ref_formatting_state {
 	int quote_style;
 	unsigned int pad_to_right;
+	const char *color_next;
 };
 
 struct ref_sorting {
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 68688a9..6aad069 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -133,4 +133,20 @@ test_expect_success 'reverse version sort' '
 	test_cmp expect actual
 '
 
+get_color ()
+{
+	git config --get-color no.such.slot "$1"
+}
+
+cat >expect <<EOF &&
+$(get_color green)foo1.10$(get_color reset)||
+$(get_color green)foo1.3$(get_color reset)||
+$(get_color green)foo1.6$(get_color reset)||
+EOF
+
+test_expect_success 'check `colornext` format option' '
+	git for-each-ref --format="%(colornext:green)%(refname:short)||" | grep "foo" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.4.6
