From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] stash: Allow git stash branch to process commits
 that look like stashes but are not stash references.
Date: Wed, 04 Aug 2010 16:51:21 -0700
Message-ID: <7vwrs6djie.fsf@alter.siamese.dyndns.org>
References: <1280831775-30759-1-git-send-email-jon.seymour@gmail.com>
 <1280831775-30759-3-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, ams@toroid.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 01:51:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgnkG-000871-QZ
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 01:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759516Ab0HDXvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 19:51:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51476 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900Ab0HDXvb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 19:51:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EEC0ADC5;
	Wed,  4 Aug 2010 19:51:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s9bRfdr5tSlNiZsVAeivgfYJoNY=; b=g3C6qS
	NOJB0VKB59+eyVCwGbiS40MEkHkGAVyQeoAOzm7rLFt9o8eRFWbtcfonRY7G9B3C
	RpDw4Te31kv2rF8kCsszRBi9GiIhp6Pp79PGb6KZwXhsxjWe8GSW8JsWi+mydGYY
	QwFJ26aOBI263EomQwVOXBGyWP6sahi7aMExU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yg7LpWSjbfwiPwjkGVBVN10kIoyg3+AD
	AGTGNNM4EmFceYAIjdlOdSFMFm/X198I7vS1VOxv5JGKvDVMFlnPRwiRSrI6khx7
	IvHnX75g4hfdDg/K/evAvpwNGcFigIB6vWspMLowHkXcj/tuQKpqzz31iLyk10mG
	xAm+qZccjHw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BCE0CDC4;
	Wed,  4 Aug 2010 19:51:26 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D9693DC2; Wed,  4 Aug
 2010 19:51:22 -0400 (EDT)
In-Reply-To: <1280831775-30759-3-git-send-email-jon.seymour@gmail.com> (Jon
 Seymour's message of "Tue\,  3 Aug 2010 20\:36\:14 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 31FE4086-A023-11DF-B621-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152613>

Jon Seymour <jon.seymour@gmail.com> writes:

> This patch allows git stash branch to work with stash-like commits created by git stash create.
>
> Two changes were required:
>
> * relax the pre-condition so that a stash stack is required if and only if a stash argument is not specified
> * don't attempt to drop a stash argument that doesn't look like a stash reference.
>
>
> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>

Please wrap very long lines.

> diff --git a/git-stash.sh b/git-stash.sh
> index 1d95447..432ddae 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -225,6 +225,12 @@ show_stash () {
>  	git diff $flags $b_commit $w_commit
>  }
>  
> +if_stash_ref() {
> +	ref="$1"
> +	shift
> +	test "${ref#stash}" = "${ref}" -a "${ref#$ref_stash}" = "${ref}" || "$@"
> +}

The interface to this function looks a rather bad taste to me; wouldn't it
look more natural if the callers can say:

	if stash_ref $it
        then
        	do this
	fi

Your criteria used here is that the given parameter does not begin with
"stash" nor "refs/stash".  If it begins with either of these two strings,
the "test" fails and "$@" is run.  Wouldn't this produce a false hit if
you kept a handcrafted stash-looking commit with a tag "stash-42" or
something?

It may make more sense to give "stash drop" an option to be silent if
the given parameter is not on the list to begin with, perhaps?
