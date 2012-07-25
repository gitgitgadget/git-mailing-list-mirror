From: Junio C Hamano <gitster@pobox.com>
Subject: Re: False positive from orphaned_commit_warning() ?
Date: Wed, 25 Jul 2012 15:05:42 -0700
Message-ID: <7v629bbio9.fsf@alter.siamese.dyndns.org>
References: <20120725185343.GA6937@windriver.com>
 <7va9ynbj9l.fsf@alter.siamese.dyndns.org>
 <20120725215730.GA30966@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 26 00:05:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su9iJ-00041O-Dx
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 00:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813Ab2GYWFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 18:05:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65057 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062Ab2GYWFp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 18:05:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81A017E30;
	Wed, 25 Jul 2012 18:05:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uu+uckDCXfw+Z2mvJyfqrZhISZM=; b=O13usI
	eggaD87247hbuTJNvylEE7Wqz4WdfqU9nsNpT3kVhgHTdPGbm6/UONMkyJBd8mfS
	YLEyTU3Fh4MP665dVNdE09a1Oysyxr7Vvgw/YFW3uBey/NOh52eWf+vELJLCFwDr
	/i8q+VhIFoUktOiXtrBdwHuUxAuAS52KwYeCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FPcMVape3VSe40lx88vCIvAueSj9s3zY
	hAme+WOLSN+Kf++gej5u9YnDpFtaBuJAU9pDhfiLnNlpLxszJcxKSgTZ8BduIVqc
	kQG2GGe111v/AmMPswg2tdji2+da+doBacI0pBsp2zccDkgvRjqEqUWhKmsAs9Tm
	j9FChgufr5M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 653D47E2A;
	Wed, 25 Jul 2012 18:05:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99F807E28; Wed, 25 Jul 2012
 18:05:43 -0400 (EDT)
In-Reply-To: <20120725215730.GA30966@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 25 Jul 2012 17:57:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E10ACD56-D6A4-11E1-A9FD-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202207>

Jeff King <peff@peff.net> writes:

> On Wed, Jul 25, 2012 at 02:52:54PM -0700, Junio C Hamano wrote:
>
>> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
>> 
>> > Has anyone else noticed false positives coming from the
>> > orphan check?
>> 
>> Thanks.  This should fix it.
>
> I've just been hunting the same bug and came up with the same answer.
> Here's a commit message. Feel free to apply or steal text for your
> commit.

Heh, let's try not to waste duplicated efforts by being silent next
time, OK?  Winning such a race by 5 minutes does not buy us much.

I wish we had some type safe way to say "This uint and the other
uint are to hold different kinds of flag bits; do not mix them by
bitwise operators".

Thanks.

> -- >8 --
> Subject: [PATCH] checkout: don't confuse ref and object flags
>
> When we are leaving a detached HEAD, we do a revision
> traversal to check whether we are orphaning any commits,
> marking the commit we're leaving as the start of the
> traversal, and all existing refs as uninteresting.
>
> Prior to commit 468224e5, we did so by calling for_each_ref,
> and feeding each resulting refname to setup_revisions.
> Commit 468224e5 refactored this to simply mark the pending
> objects, saving an extra lookup.
>
> However, it confused the "flags" parameter to the
> each_ref_fn clalback, which is about the flags we found
> while looking up the ref (e.g., REF_ISSYMREF) with the
> object flag (UNINTERESTING), leading to unpredictable

s/UNINTERESTING/SEEN/; I think.

What was happening was that the remotes/origin/HEAD symref happened
to point at the same commit as "master", and ^master that was in the
pending array was not transferred to the commit list used by the
revision traversal.

What's interesting still is that

	git checkout master~
        git checkout master

does not exhibit this problem in the same repository.

> results, as we were setting random flag bits on objects in
> the traversal.
> ---
>  builtin/checkout.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index a76899d..f855489 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -592,7 +592,7 @@ static int add_pending_uninteresting_ref(const char *refname,
>  					 const unsigned char *sha1,
>  					 int flags, void *cb_data)
>  {
> -	add_pending_sha1(cb_data, refname, sha1, flags | UNINTERESTING);
> +	add_pending_sha1(cb_data, refname, sha1, UNINTERESTING);
>  	return 0;
>  }
>  
