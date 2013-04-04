From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] diffcore-pickaxe: remove unnecessary call to
 get_textconv()
Date: Thu, 04 Apr 2013 14:10:22 -0700
Message-ID: <7vmwtegfy9.fsf@alter.siamese.dyndns.org>
References: <7vr4iqi2uw.fsf@alter.siamese.dyndns.org>
 <ed31727421dc3000e943e62a8d82ac1af6589733.1365105971.git.simon@ruderich.org>
 <7vvc82ggy3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Ruderich <simon@ruderich.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 04 23:10:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNrQs-0005hj-RM
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 23:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763608Ab3DDVK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 17:10:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58503 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763573Ab3DDVKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 17:10:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DFCC13C8A;
	Thu,  4 Apr 2013 21:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WHcMC4GCsmeg89LRm1bqXwhzpkA=; b=NAtYaG
	W5cJm0xsQC+WIcr9rh7fhpGrFWscGP9RwzaGj96pEKTi/oMd/7QyI6mhgVElwGjK
	MhurYNfU4StCz3R0QXjjCHsftSy4/klvp9wTf7tZuzLQxFW/sGUYfL7P7mXbrMdC
	MIzCtiSW7lDqYXWXKsW/ndcmBpz75jojI6jzI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NKCVbaGIMVn70Ak2rvy8pb0ZW4Sl4So3
	xQT5eykZFbwccOvLES3sos3Pbdt64YrpnKICN5Owho4sodZOrWP1YsiNa8vJ4YPh
	Rx4EJy15BxQHOZ24s24XSoAJw0ncCXQHWcO/PubdnOhk9wHRHj9VQjYKasrcx4Gp
	TTGRAlK8dm8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05FE613C89;
	Thu,  4 Apr 2013 21:10:25 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 39EDB13C88; Thu,  4 Apr
 2013 21:10:24 +0000 (UTC)
In-Reply-To: <7vvc82ggy3.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 04 Apr 2013 13:48:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 110A7734-9D6C-11E2-8D66-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220104>

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps...
>
> 	The fill_one() function is responsible for finding and
> 	filling the textconv filter as necessary, and is called by
> 	diff_grep() function that implements "git log -G<pattern>".
>
> 	The has_changes() function calls get_textconv() for two
> 	sides being compared, before it checks to see if it was
> 	asked to perform the pickaxe limiting with the -S option.
> 	Move the code around to avoid this wastage.  After that,
> 	fill_one() is called to use the textconv.
>
> 	By adding get_textconv() to diff_grep() and relieving
> 	fill_one() of responsibility to find the textconv filter, we
> 	can avoid calling get_textconv() twice.
>
> Explained that way, it makes me wonder why we cannot fix it the
> other way around, that is, not fetching textconv in has_changes()
> and instead letting fill_one() to find textconv as needed.
>
> The answer is because has_changes() itself looks at the textconv.
>
> But we have to wonder why it is so.  diff_grep() short-circuits when
> the two sides are identical and has_changes() has a similar but
> different logic to check if the identical two sides are processed
> with the same textconv filter before saying this filepair is
> uninteresting.
>
> Shouldn't that logic be unified as well?

That is, something along this line.  We may want to unify these two
functions even more, but I do not offhand see a good way to do so.

-- >8 --
Subject: [PATCH] log -S/-G: unify the short-cut logic a bit more

The fill_one() function is responsible for finding and filling the
textconv filter as necessary, and is called by diff_grep() function
that implements "git log -G<pattern>".

The has_changes() function calls get_textconv() for two sides being
compared, before it checks to see if it was asked to perform the
pickaxe limiting with the -S option.  Move the code around to avoid
this wastage.

By adding get_textconv() to diff_grep() and relieving fill_one() of
responsibility to find the textconv filter, we can avoid calling
get_textconv() twice; fill_one() no longer has to be passed a
pointer to a pointer to textconv.

The reason has_changes() calls get_textconv() early is because it
wants to compare two textconv filters on both sides.  When comparing
the two sides that are otherwise identical, if the same textconv
applies to both sides, we know pickaxe (either -S or -G) would not
find anything before applying the textconv and comparing the result.

Teach the same short-circuit logic to diff_grep() as well.  The code
in these two functions become more similar as the result.
---
 diffcore-pickaxe.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index b097fa7..6d285a7 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -75,11 +75,10 @@ static void diffgrep_consume(void *priv, char *line, unsigned long len)
 }
 
 static void fill_one(struct diff_filespec *one,
-		     mmfile_t *mf, struct userdiff_driver **textconv)
+		     mmfile_t *mf, struct userdiff_driver *textconv)
 {
 	if (DIFF_FILE_VALID(one)) {
-		*textconv = get_textconv(one);
-		mf->size = fill_textconv(*textconv, one, &mf->ptr);
+		mf->size = fill_textconv(textconv, one, &mf->ptr);
 	} else {
 		memset(mf, 0, sizeof(*mf));
 	}
@@ -94,11 +93,24 @@ static int diff_grep(struct diff_filepair *p, struct diff_options *o,
 	mmfile_t mf1, mf2;
 	int hit;
 
-	if (diff_unmodified_pair(p))
+	if (!o->pickaxe[0])
 		return 0;
 
-	fill_one(p->one, &mf1, &textconv_one);
-	fill_one(p->two, &mf2, &textconv_two);
+	textconv_one = get_textconv(p->one);
+	textconv_two = get_textconv(p->two);
+
+	/*
+	 * If we have an unmodified pair, we know that the count will be the
+	 * same and don't even have to load the blobs. Unless textconv is in
+	 * play, _and_ we are using two different textconv filters (e.g.,
+	 * because a pair is an exact rename with different textconv attributes
+	 * for each side, which might generate different content).
+	 */
+	if (textconv_one == textconv_two && diff_unmodified_pair(p))
+		return 0;
+
+	fill_one(p->one, &mf1, textconv_one);
+	fill_one(p->two, &mf2, textconv_two);
 
 	if (!mf1.ptr) {
 		if (!mf2.ptr)
@@ -131,6 +143,8 @@ static int diff_grep(struct diff_filepair *p, struct diff_options *o,
 		free(mf1.ptr);
 	if (textconv_two)
 		free(mf2.ptr);
+	diff_free_filespec_data(p->one);
+	diff_free_filespec_data(p->two);
 	return hit;
 }
 
@@ -201,14 +215,17 @@ static unsigned int contains(mmfile_t *mf, struct diff_options *o,
 static int has_changes(struct diff_filepair *p, struct diff_options *o,
 		       regex_t *regexp, kwset_t kws)
 {
-	struct userdiff_driver *textconv_one = get_textconv(p->one);
-	struct userdiff_driver *textconv_two = get_textconv(p->two);
+	struct userdiff_driver *textconv_one = NULL;
+	struct userdiff_driver *textconv_two = NULL;
 	mmfile_t mf1, mf2;
 	int ret;
 
 	if (!o->pickaxe[0])
 		return 0;
 
+	textconv_one = get_textconv(p->one);
+	textconv_two = get_textconv(p->two);
+
 	/*
 	 * If we have an unmodified pair, we know that the count will be the
 	 * same and don't even have to load the blobs. Unless textconv is in
@@ -219,8 +236,8 @@ static int has_changes(struct diff_filepair *p, struct diff_options *o,
 	if (textconv_one == textconv_two && diff_unmodified_pair(p))
 		return 0;
 
-	fill_one(p->one, &mf1, &textconv_one);
-	fill_one(p->two, &mf2, &textconv_two);
+	fill_one(p->one, &mf1, textconv_one);
+	fill_one(p->two, &mf2, textconv_two);
 
 	if (!mf1.ptr) {
 		if (!mf2.ptr)
-- 
1.8.2-634-g203ba97
