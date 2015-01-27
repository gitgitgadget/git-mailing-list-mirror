From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refs.c: clean up write_ref_sha1 returns
Date: Mon, 26 Jan 2015 19:22:22 -0800
Message-ID: <xmqq8ugonc0h.fsf@gitster.dls.corp.google.com>
References: <CAGZ79kbQiVQJyZC8mKaSUnOpY6YJc0TYdX=msuZDXLd7DxmTmQ@mail.gmail.com>
	<1422306638-23785-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: mhagger@alum.mit.edu, peff@peff.net, git@vger.kernel.org,
	loic@dachary.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 04:22:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFwjV-000701-KJ
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 04:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272AbbA0DW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2015 22:22:26 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60608 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751663AbbA0DWY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2015 22:22:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 645BF33428;
	Mon, 26 Jan 2015 22:22:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ppYrPavPTvvLcBWYnDa9i1TWnJE=; b=nGBtFf
	EC/wbGv8FdvVd3b1/lHyVvYHqgp6+np4Fuj2y9Zvsykxvlo/LkLkHEJ2rbcNjRNy
	H5giUV+Ht8SzxmZ2KKu9QyACn4cayjYxRBP42rcyEGub4afrHL4v9O177nuM/X84
	0MrXKztTW2eGsGFFlbqpKZ/YZywpTMrNiVrn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qGbY93c52e9P7kKLMKaE9zkPDQ4HjFhN
	p+55+1DFnpCtWIB3GCPXeEQc8nchRX/rIr0mXNdZAxa1j36ydFlsBo3qI62wU9Ja
	Csbx5X6W0z9TS2/CSHsPwcOLn1mIuWfBcp0EzDHAEsZtR5nWZHZDnfem1neGN1Hq
	3U/tPQsYEAY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A0D933427;
	Mon, 26 Jan 2015 22:22:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C7FCB33426;
	Mon, 26 Jan 2015 22:22:23 -0500 (EST)
In-Reply-To: <1422306638-23785-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 26 Jan 2015 13:10:38 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B6039C36-A5D3-11E4-8EC4-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263057>

Stefan Beller <sbeller@google.com> writes:

>     I can redo the atomic-push-fix series with this cleanup merged
>     into the appropriate patches or you could just queue it on top 
>     of said series.

Yeah, I do not think we are expecting to fast track these two series
through 'next' to 'master' before 2.3 final, so I think it would be
better to use this patch _only_ to see if the final shape of the
code this patch represents makes sense, so that we can expedite the
final submission in the next development cycle, at which time we
will have a chance to refresh 'next', hence a chance to clean-up
atomic-push series in place.

Thanks.

>  refs.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 2594b23..c8fd4a4 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2817,9 +2817,6 @@ static int close_ref(struct ref_lock *lock)
>  
>  static int commit_ref(struct ref_lock *lock, const unsigned char *sha1)
>  {
> -	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1))
> -		return 0;
> -
>  	if (commit_lock_file(lock->lk))
>  		return -1;
>  	return 0;
> @@ -2880,7 +2877,6 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
>  		error("unable to lock %s for update", newrefname);
>  		goto rollback;
>  	}
> -	lock->force_write = 1;
>  	hashcpy(lock->old_sha1, orig_sha1);

Is this hashcpy() still necessary?

>  	if (write_ref_sha1(lock, orig_sha1, logmsg)
>  	    || commit_ref(lock, orig_sha1)) {
