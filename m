From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Memory corruption when rebasing with git version 1.8.1.5 on arch
Date: Fri, 22 Mar 2013 11:08:59 -0700
Message-ID: <7vip4j71dw.fsf@alter.siamese.dyndns.org>
References: <5139D76D.80703@bernhard-posselt.com>
 <20130308212831.GA9217@sigill.intra.peff.net>
 <513A7D80.5000501@bernhard-posselt.com>
 <20130309044850.GB12167@sigill.intra.peff.net>
 <513B14EC.4040504@bernhard-posselt.com>
 <20130310070505.GA15324@sigill.intra.peff.net>
 <513C7267.2090608@bernhard-posselt.com>
 <20130311051840.GB13510@sigill.intra.peff.net>
 <51484125.9000307@bernhard-posselt.com>
 <20130319134452.GA6752@sigill.intra.peff.net>
 <7vobefjs26.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bernhard Posselt <mail@bernhard-posselt.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 22 19:09:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ6PJ-0004G4-5I
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 19:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422883Ab3CVSJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 14:09:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58363 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422788Ab3CVSJD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 14:09:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8081B1E9;
	Fri, 22 Mar 2013 14:09:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p5kAcvgbENzScAVNg8mpMl1RhtY=; b=GSON8d
	5gKSZf//vV+OIY/gw7tY/40iQ4442MKxO5WrZ8G1KNqtOljsuN4o2qudFFie4ntI
	I5loewdf5pgpu2meUwYldIgrV2pdXhyDTyIrG9yIG5p5XuxGHJcRhx15YLkVlQGY
	lVzWNdXN5iST2hpVxXsZTMeqFDGrWFY84Da2U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cjt32+umP3TpQAFNcw5lQZqKqLhENzmE
	D5dp2utU37ECUxlpCwvs6s//BBYMlIcZKc5W8E9PzC9SNDKLtXSvVJbYqf/+8wAa
	ZUBzj9lrvSiJK7EELcsoGKC1OkQ/ZBUAL6eHBmj8S3gJkwwde5+ND1O2b5hyQQIa
	2q6EG25GcSI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAC66B1E0;
	Fri, 22 Mar 2013 14:09:01 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCE96B1DD; Fri, 22 Mar 2013
 14:09:00 -0400 (EDT)
In-Reply-To: <7vobefjs26.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 19 Mar 2013 09:02:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 92B2D570-931B-11E2-BE31-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218829>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> and so on. I haven't quite figured out what is going on. It looks like
>> we call update_pre_post_images with postlen==0, which causes it to just
>> write the fixed postimage into the existing buffer. But of course the
>> fixed version is bigger, because we are expanding the tabs into 8
>> spaces (but it _doesn't_ break if each line starts with only one tab,
>> which confuses me).
>
> I used to be intimately familiar with the update_pre_post_images()
> function, but the version after 86c91f91794c (git apply: option to
> ignore whitespace differences, 2009-08-04), I won't vouch for it
> doing anything sensible.  We recently had to do 5de7166d46d2
> (apply.c:update_pre_post_images(): the preimage can be truncated,
> 2012-10-12) to fix one of its corner cases but I would not be
> surprised if there are other cases the function gets it all wrong.
>
> I'd come back to the topic after I finish other tasks on my plate,
> so if somebody is inclined please go ahead digging this a bit
> further; I won't have much head start to begin with in this code
> X-<.

This may be sufficient.  In the olden days, we relied on that all
whitespace fixing rules made the result shorter and took advantage
of it in update-pre-post-images to rewrite the images in place.  The
oddball tab-in-indent (aka Python), however, can grow the result by
expanding tabs (deemed "incorrect") in the input into runs of spaces
(deemed "kosher").

Fortunately, we already support its more generalized form "match
while ignoring whitespace differences" that can lengthen the result;
as long as we correctly count the number of bytes needed to hold
rewritten postimage, the existing logic in update_pre_post_images
should be able to do the rest for us.

 builtin/apply.c          | 16 ++++++++++------
 t/t4124-apply-ws-rule.sh | 26 ++++++++++++++++++++++++++
 t/t4150-am.sh            |  2 +-
 t/test-lib-functions.sh  |  4 ++--
 4 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 080ce2e..cad4e4f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2117,10 +2117,10 @@ static void update_pre_post_images(struct image *preimage,
 
 	/*
 	 * Adjust the common context lines in postimage. This can be
-	 * done in-place when we are just doing whitespace fixing,
-	 * which does not make the string grow, but needs a new buffer
-	 * when ignoring whitespace causes the update, since in this case
-	 * we could have e.g. tabs converted to multiple spaces.
+	 * done in-place when we are shrinking it with whitespace
+	 * fixing, but needs a new buffer when ignoring whitespace or
+	 * expanding leading tabs to spaces.
+	 *
 	 * We trust the caller to tell us if the update can be done
 	 * in place (postlen==0) or not.
 	 */
@@ -2185,7 +2185,7 @@ static int match_fragment(struct image *img,
 	int i;
 	char *fixed_buf, *buf, *orig, *target;
 	struct strbuf fixed;
-	size_t fixed_len;
+	size_t fixed_len, postlen;
 	int preimage_limit;
 
 	if (preimage->nr + try_lno <= img->nr) {
@@ -2335,6 +2335,7 @@ static int match_fragment(struct image *img,
 	strbuf_init(&fixed, preimage->len + 1);
 	orig = preimage->buf;
 	target = img->buf + try;
+	postlen = 0;
 	for (i = 0; i < preimage_limit; i++) {
 		size_t oldlen = preimage->line[i].len;
 		size_t tgtlen = img->line[try_lno + i].len;
@@ -2362,6 +2363,7 @@ static int match_fragment(struct image *img,
 		match = (tgtfix.len == fixed.len - fixstart &&
 			 !memcmp(tgtfix.buf, fixed.buf + fixstart,
 					     fixed.len - fixstart));
+		postlen += tgtfix.len;
 
 		strbuf_release(&tgtfix);
 		if (!match)
@@ -2399,8 +2401,10 @@ static int match_fragment(struct image *img,
 	 * hunk match.  Update the context lines in the postimage.
 	 */
 	fixed_buf = strbuf_detach(&fixed, &fixed_len);
+	if (postlen < postimage->len)
+		postlen = 0;
 	update_pre_post_images(preimage, postimage,
-			       fixed_buf, fixed_len, 0);
+			       fixed_buf, fixed_len, postlen);
 	return 1;
 
  unmatch_exit:
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 6f6ee88..0bbcf06 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -486,4 +486,30 @@ test_expect_success 'same, but with CR-LF line endings && cr-at-eol unset' '
 	test_cmp one expect
 '
 
+test_expect_success 'whitespace=fix to expand' '
+	qz_to_tab_space >preimage <<-\EOF &&
+	QQa
+	QQb
+	QQc
+	ZZZZZZZZZZZZZZZZd
+	QQe
+	QQf
+	QQg
+	EOF
+	qz_to_tab_space >patch <<-\EOF &&
+	diff --git a/preimage b/preimage
+	--- a/preimage
+	+++ b/preimage
+	@@ -1,7 +1,6 @@
+	 QQa
+	 QQb
+	 QQc
+	-QQd
+	 QQe
+	 QQf
+	 QQg
+	EOF
+	git -c core.whitespace=tab-in-indent apply --whitespace=fix patch
+'
+
 test_done
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index cdafd7e..12f6b02 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -17,7 +17,7 @@ test_expect_success 'setup: messages' '
 	vero eos et accusam et justo duo dolores et ea rebum.
 
 	EOF
-	q_to_tab <<-\EOF >>msg &&
+	qz_to_tab_space <<-\EOF >>msg &&
 	QDuis autem vel eum iriure dolor in hendrerit in vulputate velit
 	Qesse molestie consequat, vel illum dolore eu feugiat nulla facilisis
 	Qat vero eros et accumsan et iusto odio dignissim qui blandit
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index fa62d01..349f3b8 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -87,8 +87,8 @@ q_to_cr () {
 	tr Q '\015'
 }
 
-q_to_tab () {
-	tr Q '\011'
+qz_to_tab_space () {
+	tr QZ '\011\040'
 }
 
 append_cr () {
