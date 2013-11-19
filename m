From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 6/6] for-each-ref: avoid color leakage
Date: Tue, 19 Nov 2013 08:26:52 -0800
Message-ID: <xmqqiovo9x2r.fsf@gitster.dls.corp.google.com>
References: <1384796353-18701-1-git-send-email-artagnon@gmail.com>
	<1384796353-18701-7-git-send-email-artagnon@gmail.com>
	<xmqqwqk59xyz.fsf@gitster.dls.corp.google.com>
	<CALkWK0mnYXBVW-agV_v6=mPxA=MoJAfHQaPKarwKU=x2SE+tnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 19 17:27:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vio8r-0001Sl-8T
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 17:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265Ab3KSQ1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 11:27:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46808 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753432Ab3KSQ1C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 11:27:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B83A52674;
	Tue, 19 Nov 2013 11:26:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JtTRlrKPBAVNXYqP4H+pODXOEaU=; b=Vxunc8
	2xZOatWGQ0VbnwKT1Zpwze9PlwWSLV4TRSVyr3FXhpsH35AZ4RuSRA+j29Jpo/43
	fBqxbQ+ms/pnN7tGmB3Bt/H8WYgAw5sdSs5JniIFHo3k47o22675y9khYVVGma5I
	55B6gBwzA6KKDqhWiKhU3fY0PyqCQRP5r9AL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PjM2QNOKollxUd/A24KjWcAsGS/mm0mK
	/0GYt4L4KFnzwVFRnIgT7Sk1IYAO/NlLutygqCTuLV+RHGaxclmqOpYJ61omaI3s
	rkqtga+Tv5VgPYvI6PUDHxysYxd3uVHnKCSlLsh+wWvGKSYZPhxA/1t88F0wuu0j
	bvHT7ZkEHu8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16AD452673;
	Tue, 19 Nov 2013 11:26:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4884E5266B;
	Tue, 19 Nov 2013 11:26:55 -0500 (EST)
In-Reply-To: <CALkWK0mnYXBVW-agV_v6=mPxA=MoJAfHQaPKarwKU=x2SE+tnQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 19 Nov 2013 10:07:33 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6784D788-5137-11E3-978F-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238028>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Isn't a new single bit in "struct refinfo" all you need to keep
>> track of, to see the last %(color:something) you ever saw is for a
>> color that is not reset?
>
> No; because I can only look at one atom and set v->color, at a time.

That is probably because the patch is trying to collect a wrong kind
of information, I think. If the approach is to check if each atom is
a color atom, parse_atom() may be the right place, but that is not
necessary.

The only thing you need to know is if you need to emit a "reset"
that the user did not explicitly ask for at the end, and that is a
property of the format string, which is constant across refs you are
iterating over. You do not even need to know which one of the atom
is of the "color" kind.

My knee-jerk "adding it to struct refinfo" is not correct, either,
because what we want to know, i.e. "do we need an extra reset?" is
not a property for each ref.  It is similar to "what is the set of
atoms the format string is using?" and "do we need to peel tags in
order to show all information asked by the format string?"
(i.e. used_atom[] and need_tagged, respectively).

Unlike need_tagged which asks "is there any *refname that asks us to
peel tags?", however, "is the _last_ color:anything in the format
string not 'reset'?" depends on the order of appearance of atoms in
the format string, so this needs to be done in a loop that scans the
format string from left to right once at the very beginning, and we
have a perfect place to do so in verify_format().

So perhaps like this one on top?

 builtin/for-each-ref.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 04e35ba..5ff51d1 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -23,7 +23,6 @@ typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 struct atom_value {
 	const char *s;
 	unsigned long ul; /* used for sorting when not FIELD_STR */
-	int color : 2; /* 1 indicates color, 2 indicates color-reset */
 };
 
 struct ref_sort {
@@ -94,6 +93,7 @@ static struct {
 static const char **used_atom;
 static cmp_type *used_atom_type;
 static int used_atom_cnt, sort_atom_limit, need_tagged, need_symref;
+static int need_color_reset_at_eol;
 
 /*
  * Used to parse format string and sort specifiers
@@ -180,13 +180,21 @@ static const char *find_next(const char *cp)
 static int verify_format(const char *format)
 {
 	const char *cp, *sp;
+	static const char color_reset[] = "color:reset";
+
+	need_color_reset_at_eol = 0;
 	for (cp = format; *cp && (sp = find_next(cp)); ) {
 		const char *ep = strchr(sp, ')');
+		int at;
+
 		if (!ep)
 			return error("malformed format string %s", sp);
 		/* sp points at "%(" and ep points at the closing ")" */
-		parse_atom(sp + 2, ep);
+		at = parse_atom(sp + 2, ep);
 		cp = ep + 1;
+
+		if (!memcmp(used_atom[at], "color:", 6))
+			need_color_reset_at_eol = !!strcmp(used_atom[at], color_reset);
 	}
 	return 0;
 }
@@ -644,7 +652,7 @@ static void populate_value(struct refinfo *ref)
 		int deref = 0;
 		const char *refname;
 		const char *formatp;
-		struct branch *branch;
+		struct branch *branch = NULL;
 
 		if (*name == '*') {
 			deref = 1;
@@ -669,10 +677,6 @@ static void populate_value(struct refinfo *ref)
 			char color[COLOR_MAXLEN] = "";
 
 			color_parse(name + 6, "--format", color);
-			if (!strcmp(name + 6, "reset"))
-				v->color = 2;
-			else
-				v->color = 1;
 			v->s = xstrdup(color);
 			continue;
 		} else if (!strcmp(name, "flag")) {
@@ -730,7 +734,7 @@ static void populate_value(struct refinfo *ref)
 				continue;
 			} else if (!strcmp(formatp, "trackshort") &&
 				!prefixcmp(name, "upstream")) {
-
+				assert(branch);
 				stat_tracking_info(branch, &num_ours, &num_theirs);
 				if (!num_ours && !num_theirs)
 					v->s = "=";
@@ -986,35 +990,28 @@ static void emit(const char *cp, const char *ep)
 static void show_ref(struct refinfo *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
-	struct atom_value *atomv, resetv;
-	int reset_color = 0;
-	char color[COLOR_MAXLEN] = "";
 
-	color_parse("reset", "--format", color);
-	resetv.s = color;
 	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
+		struct atom_value *atomv;
+
 		ep = strchr(sp, ')');
 		if (cp < sp)
 			emit(cp, sp);
 		get_value(info, parse_atom(sp + 2, ep), &atomv);
 		print_value(atomv, quote_style);
-
-		/*
-		 * reset_color is used to avoid color leakage; it
-		 * should be set when the last color atom is not a
-		 * color-reset.
-		 */
-		if (atomv->color == 1)
-			reset_color = 1;
-		else if (atomv->color == 2)
-			reset_color = 0;
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
 		emit(cp, sp);
 	}
-	if (reset_color)
+	if (need_color_reset_at_eol) {
+		struct atom_value resetv;
+		char color[COLOR_MAXLEN] = "";
+
+		color_parse("reset", "--format", color);
+		resetv.s = color;
 		print_value(&resetv, quote_style);
+	}
 	putchar('\n');
 }
 
