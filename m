From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] attr: "binary" attribute should choose built-in
 "binary" merge driver
Date: Wed, 12 Sep 2012 01:55:53 -0700
Message-ID: <7vk3vzfwme.fsf@alter.siamese.dyndns.org>
References: <7v392twlnm.fsf@alter.siamese.dyndns.org>
 <1347165639-12149-1-git-send-email-gitster@pobox.com>
 <1347165639-12149-3-git-send-email-gitster@pobox.com>
 <20120910140317.GA7906@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephen Bash <bash@genarts.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 12 10:56:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBijx-0006Wm-0d
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 10:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908Ab2ILIz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 04:55:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43735 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295Ab2ILIz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 04:55:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4E4279EB;
	Wed, 12 Sep 2012 04:55:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wt/iXcZ0jHeONO3Bj/cqMULSTQI=; b=tGgsi+
	w4YE84i6pRjqo3FttcE4IOZ/zUD81Q4RzRks+ZS4khKvrQWCp/7V6girQz4hZ9Vd
	OebKDNZuK1lckVVsH1Zx+i6UXtKxpkVTi4hXIiOdpIu6ejI1QhBOzFjvOOZdjcIF
	cUi+kUSiUVvn+7zq66Nb9NL11/zQliK88QG1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HUhUsnW7HLKIU7u89wDC4tVQiPms9Jrj
	FQqyxlEMYJ9bWrsvUwwXKb+Rt0czIiLsW8WOGqQg4QtcY3qnFq/ordmEjfsyYRZh
	hzhRbmjwdF4GvaN1hFvIXZE/QQFjsJsCePTWOUwih4U/wCm494Xgz+9GB9hr/wEB
	92Nogw0cEuI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A223B79EA;
	Wed, 12 Sep 2012 04:55:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD0D379E8; Wed, 12 Sep 2012
 04:55:54 -0400 (EDT)
In-Reply-To: <20120910140317.GA7906@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 10 Sep 2012 10:03:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A96710A6-FCB7-11E1-B499-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205270>

Jeff King <peff@peff.net> writes:

> On Sat, Sep 08, 2012 at 09:40:39PM -0700, Junio C Hamano wrote:
>
>> The built-in "binary" attribute macro expands to "-diff -text", so
>> that textual diff is not produced, and the contents will not go
>> through any CR/LF conversion ever.  During a merge, it should also
>> choose the "binary" low-level merge driver, but it didn't.
>> 
>> Make it expand to "-diff -merge -text".
>
> Yeah, that seems like the obviously correct thing to do. In practice,
> most files would end up in the first few lines of ll_xdl_merge checking
> buffer_is_binary anyway, so I think this would really only make a
> difference when our "is it binary?" heuristic guesses wrong.

You made me look at that part again and then made me notice
something unrelated.

	if (buffer_is_binary(orig->ptr, orig->size) ||
	    buffer_is_binary(src1->ptr, src1->size) ||
	    buffer_is_binary(src2->ptr, src2->size)) {
		warning("Cannot merge binary files: %s (%s vs. %s)",
			path, name1, name2);
		return ll_binary_merge(drv_unused, result,
				       path,
				       orig, orig_name,
				       src1, name1,
				       src2, name2,
				       opts, marker_size);
	}

Given that we now may know how to merge these things, the
unconditional warning feels very wrong.

Perhaps something like this makes it better.

A path that is explicitly marked as binary did not get any such
warning, but it will start to get warned just like a path that was
auto-detected to be a binary.

It is a behaviour change, but I think it is a good one that makes
two cases more consistent.

And we won't see the warning when -Xtheirs/-Xours large sledgehammer
is in use, which tells us how to resolve these things "cleanly".

 ll-merge.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git i/ll-merge.c w/ll-merge.c
index 8535e2d..307315b 100644
--- i/ll-merge.c
+++ w/ll-merge.c
@@ -35,7 +35,7 @@ struct ll_merge_driver {
  */
 static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 			   mmbuffer_t *result,
-			   const char *path_unused,
+			   const char *path,
 			   mmfile_t *orig, const char *orig_name,
 			   mmfile_t *src1, const char *name1,
 			   mmfile_t *src2, const char *name2,
@@ -53,6 +53,9 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 	} else {
 		switch (opts->variant) {
 		default:
+			warning("Cannot merge binary files: %s (%s vs. %s)\n",
+				path, name1, name2);
+			/* fallthru */
 		case XDL_MERGE_FAVOR_OURS:
 			stolen = src1;
 			break;
@@ -88,8 +91,6 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 	if (buffer_is_binary(orig->ptr, orig->size) ||
 	    buffer_is_binary(src1->ptr, src1->size) ||
 	    buffer_is_binary(src2->ptr, src2->size)) {
-		warning("Cannot merge binary files: %s (%s vs. %s)\n",
-			path, name1, name2);
 		return ll_binary_merge(drv_unused, result,
 				       path,
 				       orig, orig_name,
