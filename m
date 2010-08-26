From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bundle: detect if bundle file cannot be created
Date: Thu, 26 Aug 2010 10:26:51 -0700
Message-ID: <7vpqx5l1yc.fsf@alter.siamese.dyndns.org>
References: <20100826092333.GB32617@acharya.in.gluster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Csaba Henk <csaba@gluster.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 19:27:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OogED-0002vW-Bb
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 19:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346Ab0HZR1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 13:27:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41649 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113Ab0HZR06 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 13:26:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 28575D09EF;
	Thu, 26 Aug 2010 13:26:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SLweDLwTv/LKYm0x8mdHhIDCeuA=; b=SSm4gF
	TGm1sVN5uM33XQIImpgrovrtmE4XZoXWclndDaiZZMSH/g6R5ZAT4H/VcOMFCFIi
	GkREaHbqYGlNkSz1IQeoVl/6NP4+E6md59SP8uRKYNBqkDtMf7Ixkz3LFPT07/6C
	i0lWl59cUl2ZZqOOvu3GTpcbtFzrKUwM5H2UU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OGZPzm//L+hJP0aN7ssbHUDDBcYwkBGW
	TFkDlov3Y5T1iFXH6QCzAogEDkgjkupB8SYW8msEWf1BnUMn8KeYMeL6oRktjowW
	HV79o7Mwz37HBme6uGgtNGnBkMhCK9/aI32phqiARYj1zyaeqQifMhqHBkXr3Alk
	WDYs0Q1IdE0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 04FA1D09ED;
	Thu, 26 Aug 2010 13:26:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10F28D09E9; Thu, 26 Aug
 2010 13:26:52 -0400 (EDT)
In-Reply-To: <20100826092333.GB32617@acharya.in.gluster.com> (Csaba Henk's
 message of "Thu\, 26 Aug 2010 14\:53\:33 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1FD72150-B137-11DF-80E2-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154548>

Csaba Henk <csaba@gluster.com> writes:

> bundle command silently died with no sign of failure if it
> could not create the bundle file. (Eg.: its path resovles to a directory,
> or the parent dir is sticky while file already exists and is owned
> by someone else.)
> ---

Sign-off?

> diff --git a/bundle.c b/bundle.c
> index ff97adc..3eb4ca2 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -372,8 +372,10 @@ int create_bundle(struct bundle_header *header, const char *path,
>  	close(rls.in);
>  	if (finish_command(&rls))
>  		return error ("pack-objects died");
> -	if (!bundle_to_stdout)
> -		commit_lock_file(&lock);
> +	if (!bundle_to_stdout) {
> +		if (commit_lock_file(&lock))
> +			die_errno("cannot create bundle file");
> +	}

You would want to parrot the path given by the caller, perhaps like this?

	die_errno("cannot create '%s'", path)

This function tries to report error to the caller in some places but
rudely dies in some other places, so dying here is not a serious offence.

> diff --git a/t/t5704-bundle.sh b/t/t5704-bundle.sh
> index ddc3dc5..728ccd8 100755
> --- a/t/t5704-bundle.sh
> +++ b/t/t5704-bundle.sh
> @@ -30,6 +30,13 @@ test_expect_success 'tags can be excluded by rev-list options' '
>  
>  '
>  
> +test_expect_success 'die if bundle file cannot be created' '
> +
> +	mkdir adir &&
> +	test_must_fail git bundle create adir --all
> +
> +'

I like it ;-)

Thanks.
