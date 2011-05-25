From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/10] revert: Propogate errors upwards from
 do_pick_commit
Date: Wed, 25 May 2011 15:44:22 -0700
Message-ID: <7v62oy1juh.fsf@alter.siamese.dyndns.org>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
 <1306333025-29893-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 00:44:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPMok-0006qL-Nd
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 00:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755814Ab1EYWoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 18:44:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49886 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755784Ab1EYWoh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 18:44:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B065E521A;
	Wed, 25 May 2011 18:46:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g9aUTAY9fjPw8rpSavE9cPdfLGQ=; b=SsIuAY
	JQGBMH50TESSWy3LYQ1/2XS+zUY2IqlGlhaV2UNY6jNqwgUkGQDf0y5/CwU4aGah
	NTF2tghAok+TlXy2PKU7TcJ7e1k81WlMXQ9Kwsu6nf96sHMb+Yu3JIT5aA4xEuJr
	c2vUbF4QION9Yu1i+xO0AN/UK6sovHoeNLloQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=olLGPco8J0F5/tusvd8bqtsTpnn6eeQs
	AUtTsbsUPad9W2V8GFeXP3LqGWWZAb5zRS3eWiR4tYdwbNKCsqiNk0UjZV+Mk4au
	eFTqNkf0T2CjFrrO+aMFH1Sy3T2gErSCcxb4u192cFrT+s4WPCWmOHA/1lZv5zd0
	iOhHkrp+jZY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5BB615216;
	Wed, 25 May 2011 18:46:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B25A65215; Wed, 25 May 2011
 18:46:31 -0400 (EDT)
In-Reply-To: <1306333025-29893-3-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Wed, 25 May 2011 14:16:57 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D9BDD5A4-8720-11E0-A96B-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174470>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> +static int error_dirty_index(const char *me)
>  {
> +	if (read_cache_unmerged())
> +		return error_resolve_conflict(me);
> +
> +	int ret = error(_("Your local changes would be overwritten by %s.\n"), me);
> +	if (advice_commit_before_merge)
> +		advise(_("Please, commit your changes or stash them to proceed."));
> +	return ret;
>  }

I like this rewrite whose result is short-and-sweet, but you do not even
need the "ret" variable. error() always yields -1, no?

> @@ -594,14 +584,28 @@ static int revert_or_cherry_pick(int argc, const char **argv)
>  
>  int cmd_revert(int argc, const char **argv, const char *prefix)
>  {
> +	int res = 0;
>  	if (isatty(0))
>  		edit = 1;
>  	action = REVERT;
> -	return revert_or_cherry_pick(argc, argv);
> +	res = revert_or_cherry_pick(argc, argv);
> +	if (res > 0)
> +		/* Exit status from conflict */
> +		return res;
> +	if (res < 0)
> +		/* Other error */
> +		exit(128);
> +	return 0;
>  }
>  
>  int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
>  {
> +	int res = 0;
>  	action = CHERRY_PICK;
> -	return revert_or_cherry_pick(argc, argv);
> +	res = revert_or_cherry_pick(argc, argv);
> +	if (res > 0)
> +		return res;
> +	if (res < 0)
> +		exit(128);
> +	return 0;
>  }

This hunk is dubious.

 - Why initialize res to zero if it always is assigned the return value of
   revert_or_cherry_pick() before it is used?

 - The called function seems to return errors from various places but as
   far as I see they are all return value of error(), so it would be
   equivalent to

	if (r_o_c_p(...))
		exit(128);
	return 0;

If you are going to introduce different return values from r-o-c-p() in a
later patch, these functions should be updated in that patch, I think.
