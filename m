From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] diffcore-pickaxe: unify setup and teardown code
 between log -S/-G
Date: Fri, 05 Apr 2013 09:44:52 -0700
Message-ID: <7vr4ipc4fv.fsf@alter.siamese.dyndns.org>
References: <7v1uapfuyp.fsf@alter.siamese.dyndns.org>
 <1365137126-21659-1-git-send-email-gitster@pobox.com>
 <1365137126-21659-3-git-send-email-gitster@pobox.com>
 <20130405052810.GA29815@sigill.intra.peff.net>
 <7vk3ohedn1.fsf@alter.siamese.dyndns.org>
 <20130405054524.GB12705@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:13:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWKT-0002u6-0W
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162029Ab3DEQpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 12:45:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58872 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161970Ab3DEQo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 12:44:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D318613F01;
	Fri,  5 Apr 2013 16:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FUBflnBHwlqjmizFU09qmhyiK2M=; b=HchTds
	X/airbeuXNrDrvemDWJJXAq86QRrpf5a41NUel5l45n+MX3GI/dqa+dahpH9ISIp
	UujJm7FrcK7FrqvaXP7a74EuksMScNdPLh7lFJ/yZBf/N9EZe8IenHbIOS7UyBL+
	y1QJ6xSz721CJ4Uzk8w3eSXE5K+OtE+zjTW8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oqGnzmjMVmHc7Rs2lsCeVAIFafqNJd7P
	9+O4IAPwOmXFlWl6hOfFiicc+R6LLF7rrWqWHctAgrUu25Wf+Z73BXz2r7tKOCa4
	GT8SkAENqRKKa7fSz5C4VL5iJO4y5LTj9cWJWePutINhj1K2B91EEN5ax2zJsdo9
	dg66qqTccXs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C738A13F00;
	Fri,  5 Apr 2013 16:44:58 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB7C913EFD; Fri,  5 Apr
 2013 16:44:57 +0000 (UTC)
In-Reply-To: <20130405054524.GB12705@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 5 Apr 2013 01:45:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 26A7AEDC-9E10-11E2-A2BB-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220197>

Jeff King <peff@peff.net> writes:

> I didn't actually test that patch beyond compilation (but it's
> _obviously_ correct, right?), and I'm about to go to bed. Do you want to
> take care of adapting your commit message to it?

The code looks obviously correct, yes.

We might have to revisit the "Is unmerged?" thing, Cf. d7c9bf22351e
(diffcore-rename: don't consider unmerged path as source,
2011-03-23), but that is an unlikely corner case, especially for
these options (-S/-G).

-- >8 --
From: Jeff King <peff@peff.net>
Date: Fri, 5 Apr 2013 01:28:10 -0400
Subject: [PATCH] diffcore-pickaxe: unify code for log -S/-G

The logic flow of has_changes() used for "log -S" and diff_grep()
used for "log -G" are essentially the same.  See if we have both
sides that could be different in any interesting way, slurp the
contents in core, possibly after applying textconv, inspect the
contents, clean-up and report the result.  The only difference
between the two is how "inspect" step works.

Unify this codeflow in a helper, pickaxe_match(), which takes a
callback function that implements the specific "inspect" step.

After removing the common scaffolding code from the existing
has_changes() and diff_grep(), they each becomes such a callback
function suitable for passing to pickaxe_match().

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diffcore-pickaxe.c | 118 ++++++++++++++++++++++-------------------------------
 1 file changed, 49 insertions(+), 69 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index cadb071..63722f8 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -8,7 +8,12 @@
 #include "xdiff-interface.h"
 #include "kwset.h"
 
-typedef int (*pickaxe_fn)(struct diff_filepair *p, struct diff_options *o, regex_t *regexp, kwset_t kws);
+typedef int (*pickaxe_fn)(mmfile_t *one, mmfile_t *two,
+			  struct diff_options *o,
+			  regex_t *regexp, kwset_t kws);
+
+static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
+			 regex_t *regexp, kwset_t kws, pickaxe_fn fn);
 
 static void pickaxe(struct diff_queue_struct *q, struct diff_options *o,
 		    regex_t *regexp, kwset_t kws, pickaxe_fn fn)
@@ -22,7 +27,7 @@ static void pickaxe(struct diff_queue_struct *q, struct diff_options *o,
 		/* Showing the whole changeset if needle exists */
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			if (fn(p, o, regexp, kws))
+			if (pickaxe_match(p, o, regexp, kws, fn))
 				return; /* do not munge the queue */
 		}
 
@@ -37,7 +42,7 @@ static void pickaxe(struct diff_queue_struct *q, struct diff_options *o,
 		/* Showing only the filepairs that has the needle */
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			if (fn(p, o, regexp, kws))
+			if (pickaxe_match(p, o, regexp, kws, fn))
 				diff_q(&outq, p);
 			else
 				diff_free_filepair(p);
@@ -74,64 +79,33 @@ static void diffgrep_consume(void *priv, char *line, unsigned long len)
 	line[len] = hold;
 }
 
-static int diff_grep(struct diff_filepair *p, struct diff_options *o,
+static int diff_grep(mmfile_t *one, mmfile_t *two,
+		     struct diff_options *o,
 		     regex_t *regexp, kwset_t kws)
 {
 	regmatch_t regmatch;
-	struct userdiff_driver *textconv_one = NULL;
-	struct userdiff_driver *textconv_two = NULL;
-	mmfile_t mf1, mf2;
-	int hit;
+	struct diffgrep_cb ecbdata;
+	xpparam_t xpp;
+	xdemitconf_t xecfg;
 
-	if (!o->pickaxe[0])
-		return 0;
+	if (!one)
+		return !regexec(regexp, two->ptr, 1, &regmatch, 0);
+	if (!two)
+		return !regexec(regexp, one->ptr, 1, &regmatch, 0);
 
-	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
-		textconv_one = get_textconv(p->one);
-		textconv_two = get_textconv(p->two);
-	}
-
-	if (textconv_one == textconv_two && diff_unmodified_pair(p))
-		return 0;
-
-	mf1.size = fill_textconv(textconv_one, p->one, &mf1.ptr);
-	mf2.size = fill_textconv(textconv_two, p->two, &mf2.ptr);
-
-	if (!DIFF_FILE_VALID(p->one)) {
-		if (!DIFF_FILE_VALID(p->two))
-			hit = 0; /* ignore unmerged */
-		else
-			/* created "two" -- does it have what we are looking for? */
-			hit = !regexec(regexp, mf2.ptr, 1, &regmatch, 0);
-	} else if (!DIFF_FILE_VALID(p->two)) {
-		/* removed "one" -- did it have what we are looking for? */
-		hit = !regexec(regexp, mf1.ptr, 1, &regmatch, 0);
-	} else {
-		/*
-		 * We have both sides; need to run textual diff and see if
-		 * the pattern appears on added/deleted lines.
-		 */
-		struct diffgrep_cb ecbdata;
-		xpparam_t xpp;
-		xdemitconf_t xecfg;
-
-		memset(&xpp, 0, sizeof(xpp));
-		memset(&xecfg, 0, sizeof(xecfg));
-		ecbdata.regexp = regexp;
-		ecbdata.hit = 0;
-		xecfg.ctxlen = o->context;
-		xecfg.interhunkctxlen = o->interhunkcontext;
-		xdi_diff_outf(&mf1, &mf2, diffgrep_consume, &ecbdata,
-			      &xpp, &xecfg);
-		hit = ecbdata.hit;
-	}
-	if (textconv_one)
-		free(mf1.ptr);
-	if (textconv_two)
-		free(mf2.ptr);
-	diff_free_filespec_data(p->one);
-	diff_free_filespec_data(p->two);
-	return hit;
+	/*
+	 * We have both sides; need to run textual diff and see if
+	 * the pattern appears on added/deleted lines.
+	 */
+	memset(&xpp, 0, sizeof(xpp));
+	memset(&xecfg, 0, sizeof(xecfg));
+	ecbdata.regexp = regexp;
+	ecbdata.hit = 0;
+	xecfg.ctxlen = o->context;
+	xecfg.interhunkctxlen = o->interhunkcontext;
+	xdi_diff_outf(one, two, diffgrep_consume, &ecbdata,
+		      &xpp, &xecfg);
+	return ecbdata.hit;
 }
 
 static void diffcore_pickaxe_grep(struct diff_options *o)
@@ -198,9 +172,20 @@ static unsigned int contains(mmfile_t *mf, struct diff_options *o,
 	return cnt;
 }
 
-static int has_changes(struct diff_filepair *p, struct diff_options *o,
+static int has_changes(mmfile_t *one, mmfile_t *two,
+		       struct diff_options *o,
 		       regex_t *regexp, kwset_t kws)
 {
+	if (!one)
+		return contains(two, o, regexp, kws) != 0;
+	if (!two)
+		return contains(one, o, regexp, kws) != 0;
+	return contains(one, o, regexp, kws) != contains(two, o, regexp, kws);
+}
+
+static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
+			 regex_t *regexp, kwset_t kws, pickaxe_fn fn)
+{
 	struct userdiff_driver *textconv_one = NULL;
 	struct userdiff_driver *textconv_two = NULL;
 	mmfile_t mf1, mf2;
@@ -209,6 +194,10 @@ static int has_changes(struct diff_filepair *p, struct diff_options *o,
 	if (!o->pickaxe[0])
 		return 0;
 
+	/* ignore unmerged */
+	if (!DIFF_FILE_VALID(p->one) && !DIFF_FILE_VALID(p->two))
+		return 0;
+
 	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
 		textconv_one = get_textconv(p->one);
 		textconv_two = get_textconv(p->two);
@@ -227,18 +216,9 @@ static int has_changes(struct diff_filepair *p, struct diff_options *o,
 	mf1.size = fill_textconv(textconv_one, p->one, &mf1.ptr);
 	mf2.size = fill_textconv(textconv_two, p->two, &mf2.ptr);
 
-	if (!DIFF_FILE_VALID(p->one)) {
-		if (!DIFF_FILE_VALID(p->two))
-			ret = 0; /* ignore unmerged */
-		else
-			/* created */
-			ret = contains(&mf2, o, regexp, kws) != 0;
-	}
-	else if (!DIFF_FILE_VALID(p->two)) /* removed */
-		ret = contains(&mf1, o, regexp, kws) != 0;
-	else
-		ret = contains(&mf1, o, regexp, kws) !=
-		      contains(&mf2, o, regexp, kws);
+	ret = fn(DIFF_FILE_VALID(p->one) ? &mf1 : NULL,
+		 DIFF_FILE_VALID(p->two) ? &mf2 : NULL,
+		 o, regexp, kws);
 
 	if (textconv_one)
 		free(mf1.ptr);
-- 
1.8.2-667-gbdcd2ef
