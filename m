From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 4/4] merge: add support for merging from upstream by
 default
Date: Thu, 10 Feb 2011 17:20:13 -0800
Message-ID: <7vsjvv1i5u.fsf@alter.siamese.dyndns.org>
References: <1297381964-7137-1-git-send-email-jaredhance@gmail.com>
 <1297381964-7137-5-git-send-email-jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 02:20:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnhgU-0004EU-Gx
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 02:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757538Ab1BKBUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 20:20:23 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58411 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754239Ab1BKBUX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 20:20:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 50D8D4431;
	Thu, 10 Feb 2011 20:21:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T5Jqi7lj3Xb/t+orUQ/yAYLeRtQ=; b=PeOjSJ
	LJA5OQ5NzL0ySkjjfnJKMS/ovflv7RIGJzqqmly2Nz6kJvcolyOymcM38s/tR/nn
	Dd1N4dQBqBG4NMXF8zLrhgEYRlFl2sierQdt/BJ2Ys2qMRagCg3xTiWQ7YQXQVXL
	9fCMdzGkFkihIEZ9A/Bsih21kUA/q81o0VUrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CBza1AiEItnI2hqq5VDKjd/keC+9qps5
	RCDM8Zp81qF+KHN3mDemEVkToq5T5iGo+lRlrgG5RSd6njceIqx+b7Hx/qsqP7wa
	N6l1ypRXkkVYWcZhWYZtfdYUvf/mbYxkFVycY4+Yj3w1Jp9FbQrR++pj9R6aDP/q
	Zm1MDTYIck4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2E2D14430;
	Thu, 10 Feb 2011 20:21:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 25DE9442D; Thu, 10 Feb 2011
 20:21:16 -0500 (EST)
In-Reply-To: <1297381964-7137-5-git-send-email-jaredhance@gmail.com> (Jared
 Hance's message of "Thu\, 10 Feb 2011 18\:52\:44 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3B331A92-357D-11E0-9EDA-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166531>

Jared Hance <jaredhance@gmail.com> writes:

> Add the option merge.defaultupstream to add support for merging from
> the upstream branch by default. The upstream branch is found using
> branch.[name].merge.
>
> Signed-off-by: Jared Hance <jaredhance@gmail.com>
> ---

Thanks; the first three in the series looks right.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index c5e1835..4415691 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1389,6 +1389,12 @@ man.<tool>.path::
>  
>  include::merge-config.txt[]
>  
> +merge.defaultUpstream::

I somehow had an impression that majority of others convinced you to
rename this to default-to-upstream, but I may be mistaken.

I think somebody who does not know the history of the development and
discussion of this feature would think that this specifies the default
upstream remote (i.e. not a boolean variable, but a string) given this
name.

> @@ -536,7 +539,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
>  	if (status <= 0)
>  		return status;
>  
> -	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
> +	if (!strcmp(k, "merge.defaultupstream"))
> +		default_upstream = git_config_bool(k, v);
> +	else if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
>  		show_diffstat = git_config_bool(k, v);

It is somewhat rude to reviewers' eyes to turn an existing "if" into "else
if" and place new stuff at the beginning; unless there is a good reason
that the new stuff has to be at the beginning, that is.

This is not a new issue, but a callback function to git_config() should
return once it recognized and handled the variable, instead of cascading
the controll out.  The "diffstat/stat" code shows a bad example and you
inherited the badness from there.
