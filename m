From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/11] sha1_name: reorganize get_sha1_basic()
Date: Wed, 08 May 2013 11:41:57 -0700
Message-ID: <7v7gj9fh56.fsf@alter.siamese.dyndns.org>
References: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
	<1367963711-8722-11-git-send-email-felipe.contreras@gmail.com>
	<7vbo8lfi8y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 08 20:42:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua9Jq-0003on-NY
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 20:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605Ab3EHSmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 14:42:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38472 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925Ab3EHSmA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 14:42:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 575041DC14;
	Wed,  8 May 2013 18:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZlJSWkTNxbd+piw8r6glYuZNxNs=; b=OWD8UR
	JjaX5jxPBpk21oCgNWYcLacSHghD0Px/KyBB9bOZIFFmiDwHYQib5x+Ffg3dSuNM
	ZygGzHjudWhOzySb51phmdYOlYAGbEy2TGimvKqr5VNMxyxqHoREYe7U2KmMHrit
	FBLxiugXKwNbSFN99BghShM4LBSmxuBziSkFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FqbWy1PYVHMw+N+cNOv8Cg4b1snbfWgw
	FCKjEtJeEXFdVtB3mhX4PeK/MAtbVLmQKR6f4ogA62fKkhw+CtHvt6B93N+u+13x
	+kyKnkY7nVcVyhQOPHO7GWXnVs2zccfLYqFJ5Nj6JDMa32TScda+/DqoLl/NR5YC
	7D0d2U4rPlU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D9F41DC13;
	Wed,  8 May 2013 18:42:00 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 644E81DC11;
	Wed,  8 May 2013 18:41:59 +0000 (UTC)
In-Reply-To: <7vbo8lfi8y.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 08 May 2013 11:18:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F7659C60-B80E-11E2-897F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223681>

Junio C Hamano <gitster@pobox.com> writes:

> Also, a few points this patch highlights in the code before the
> change:
>
>  - If we were on a branch with 40-hex name at nth prior checkout,
>    would we mistake it as being detached at the commit?
>
>  - If we were on a branch 'foo' at nth prior checkout, would our
>    previous get_sha1_1() have made us mistake it as referring to a
>    tag 'foo' with the same name if it exists?
>
> The former needs a fix to either writing of reflog or reading by
> interpret_nth_prior_checkout() so that we can tell these cases apart
> more reliably.  Then the latter can be solved by splicing
> refs/heads/ in front of the branch name before recursively calling
> get_sha1_1() in the original code (and similar fix can be
> forward-ported to this patch).
>
> Incidentally, I think if we prefix refs/heads/ in front and feed
> that to dwim_ref/log, we would also avoid running @{-N} twice (which
> I suspect might be more expensive than a simple recursion, as it
> needs to go through the reflog file), which may be a nice side
> effect of such a fix we would get for free.

Here is the first step (i.e. more reliable interpret_nth_prior).

I looked at all the existing callers of interpret_branch_name() and
it appears to me that most of them currently assume they are getting
a branch name, because they want to work on a ref, and some of them
do not care, because they are working on a revision.  For the
former, they can (and should) error out instead of relying on not
having refs/heads/$detached_SHA1 that will prevent them from working
on a ref which is what they currently do, if they had the "detached"
information.  For the latter, if we give "detached" information,
they can either prefix "refs/heads/" (if the result is "not
detached") to call resolve_ref(), or call get_sha1_hex (if the
result is "detached"), which would be the solution for the second
issue I noticed in the message I am replying to.

The next step on top of this patch may be to expose the "detached"
bit up in the API chain to let callers of interpret_branch_name() to
know about the distinction.

 sha1_name.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 3820f28..3dd6667 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -862,6 +862,7 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
 struct grab_nth_branch_switch_cbdata {
 	int remaining;
 	struct strbuf buf;
+	int detached;
 };
 
 static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
@@ -880,9 +881,14 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
 	if (!match || !target)
 		return 0;
 	if (--(cb->remaining) == 0) {
+		unsigned char sha1[20];
+
 		len = target - match;
 		strbuf_reset(&cb->buf);
 		strbuf_add(&cb->buf, match, len);
+		cb->detached = (len == 40 &&
+				!get_sha1_hex(match, sha1) &&
+				!hashcmp(osha1, sha1));
 		return 1; /* we are done */
 	}
 	return 0;
@@ -892,7 +898,7 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
  * Parse @{-N} syntax, return the number of characters parsed
  * if successful; otherwise signal an error with negative value.
  */
-static int interpret_nth_prior_checkout(const char *name, struct strbuf *buf)
+static int interpret_nth_prior_checkout(const char *name, struct strbuf *buf, int *detached)
 {
 	long nth;
 	int retval;
@@ -917,6 +923,8 @@ static int interpret_nth_prior_checkout(const char *name, struct strbuf *buf)
 	if (0 < for_each_reflog_ent_reverse("HEAD", grab_nth_branch_switch, &cb)) {
 		strbuf_reset(buf);
 		strbuf_add(buf, cb.buf.buf, cb.buf.len);
+		if (detached)
+			*detached = cb.detached;
 		retval = brace - name + 1;
 	}
 
@@ -992,7 +1000,7 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
 	char *cp;
 	struct branch *upstream;
 	int namelen = strlen(name);
-	int len = interpret_nth_prior_checkout(name, buf);
+	int len = interpret_nth_prior_checkout(name, buf, NULL);
 	int tmp_len;
 
 	if (!len)
