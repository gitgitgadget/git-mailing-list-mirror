From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH 04/11] ref-filter: add 'ifexists' atom
Date: Tue, 28 Jul 2015 12:26:29 +0530
Message-ID: <1438066594-5620-4-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 08:56:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJyoh-0006E5-G0
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 08:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524AbbG1G4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 02:56:42 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36698 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572AbbG1G4k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 02:56:40 -0400
Received: by pachj5 with SMTP id hj5so64861411pac.3
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 23:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wMm6WAfrFJU1sVn+PdNiqOfFKlx/9XvaL3ItRpvFCpE=;
        b=ZcF3/DE9Lvz73iNUzii/aqjt0YWW+8e3jYw+e0ml0qjdGL6C0cmNSPq3wCZa/GPxkk
         jM/tR6fisoFjixj9Y1eBjv553XT8cZylTU/NExeg/NdV0VyYjzS5toiC2lEiPp+oA+O8
         dQ9D/GBUWLsY4/Bwaw0nbH7IdIwv5gOzP5u3pswe5UbKPNSp69hSwt3u3560pasx0uAg
         gdginbG6shxupxj7A7U64xbBQnyRE+tQv9Tr+XTvG/3249RrZ0/tgTnuQqnrSri8sqWc
         RVkGTvJoLVv4wH+6OAXB9nOTaby2ZT3EFK2siRpyPV1o6F6M9cKn13aB7GCcAgMCFSL1
         AEeg==
X-Received: by 10.66.66.130 with SMTP id f2mr80025642pat.120.1438066599741;
        Mon, 27 Jul 2015 23:56:39 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id q7sm33147846pdj.31.2015.07.27.23.56.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jul 2015 23:56:39 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274742>

The 'ifexists' atom allows us to print a required format if the
preceeding atom has a value. If the preceeding atom has no value then
the format given is not printed. e.g. to print "[<refname>]" we can
now use the format "%(ifexists:[%s])%(refname)".

Add documentation and test for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  8 ++++++++
 ref-filter.c                       | 37 ++++++++++++++++++++++++++++++++++---
 ref-filter.h                       |  5 +++--
 t/t6302-for-each-ref-filter.sh     | 21 +++++++++++++++++++++
 4 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 9dc02aa..4424020 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -138,6 +138,14 @@ colornext::
 	`<:colorname>`.  Not compatible with `padright` and resets any
 	previous `color`, if set.
 
+ifexists::
+	Print required string only if the next atom specified in the
+	'--format' option exists.
+	e.g. --format="%(ifexists:[%s])%(symref)" prints the symref
+	like "[<symref>]" only if the ref has a symref.  This was
+	incorporated to simulate the output of 'git branch -vv', where
+	we need to display the upstream branch in square brackets.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/ref-filter.c b/ref-filter.c
index 3f40144..ff5a16b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -58,6 +58,7 @@ static struct {
 	{ "color" },
 	{ "padright" },
 	{ "colornext" },
+	{ "ifexists" },
 };
 
 /*
@@ -722,6 +723,13 @@ static void populate_value(struct ref_array_item *ref)
 			v->modifier_atom = 1;
 			v->color_next = 1;
 			continue;
+		} else if (starts_with(name, "ifexists:")) {
+			skip_prefix(name, "ifexists:", &v->s);
+			if (!*v->s)
+				die(_("no string given with 'ifexists:'"));
+			v->modifier_atom = 1;
+			v->ifexists = 1;
+			continue;
 		} else
 			continue;
 
@@ -1315,11 +1323,32 @@ static void apply_formatting_state(struct ref_formatting_state *state,
 {
 	if (state->color_next && state->pad_to_right)
 		die(_("cannot use `colornext` and `padright` together"));
-	if (state->color_next) {
+	if (state->pad_to_right && state->ifexists)
+		die(_("cannot use 'align' and 'ifexists' together"));
+	if (state->color_next && !state->ifexists) {
 		strbuf_addf(value, "%s%s%s", state->color_next, v->s, GIT_COLOR_RESET);
 		return;
-	}
-	else if (state->pad_to_right) {
+	} else if (state->ifexists) {
+		const char *sp = state->ifexists;
+
+		while (*sp) {
+			if (*sp != '%') {
+				strbuf_addch(value, *sp++);
+				continue;
+			} else if (sp[1] == '%') {
+				strbuf_addch(value, *sp++);
+				continue;
+			} else if (sp[1] == 's') {
+				if (state->color_next)
+					strbuf_addf(value, "%s%s%s", state->color_next, v->s, GIT_COLOR_RESET);
+				else
+					strbuf_addstr(value, v->s);
+				sp += 2;
+			}
+		}
+
+		return;
+	} else if (state->pad_to_right) {
 		if (!is_utf8(v->s))
 			strbuf_addf(value, "%-*s", state->pad_to_right, v->s);
 		else {
@@ -1413,6 +1442,8 @@ static void store_formatting_state(struct ref_formatting_state *state,
 		state->color_next = atomv->s;
 	if (atomv->pad_to_right)
 		state->pad_to_right = atomv->ul;
+	if (atomv->ifexists)
+		state->ifexists = atomv->s;
 }
 
 static void reset_formatting_state(struct ref_formatting_state *state)
diff --git a/ref-filter.h b/ref-filter.h
index a021b04..7d1871d 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -28,13 +28,14 @@ struct atom_value {
 	unsigned long ul; /* used for sorting when not FIELD_STR */
 	unsigned int modifier_atom : 1, /*  atoms which act as modifiers for the next atom */
 		pad_to_right : 1,
-		color_next : 1;
+		color_next : 1,
+		ifexists : 1;
 };
 
 struct ref_formatting_state {
 	int quote_style;
 	unsigned int pad_to_right;
-	const char *color_next;
+	const char *color_next, *ifexists;
 };
 
 struct ref_sorting {
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 6aad069..29ed97b 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -149,4 +149,25 @@ test_expect_success 'check `colornext` format option' '
 	test_cmp expect actual
 '
 
+test_expect_success 'check `ifexists` format option' '
+	cat >expect <<-\EOF &&
+	[foo1.10]
+	[foo1.3]
+	[foo1.6]
+	EOF
+	git for-each-ref --format="%(ifexists:[%s])%(refname:short)" | grep "foo" >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<EOF &&
+[$(get_color green)foo1.10$(get_color reset)]||foo1.10
+[$(get_color green)foo1.3$(get_color reset)]||foo1.3
+[$(get_color green)foo1.6$(get_color reset)]||foo1.6
+EOF
+
+test_expect_success 'check `ifexists` with `colornext` format option' '
+	git for-each-ref --format="%(ifexists:[%s])%(colornext:green)%(refname:short)||%(refname:short)" | grep "foo" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.4.6
