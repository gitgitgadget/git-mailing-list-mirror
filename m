From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3][GSOC] fsck: use bitwise-or assignment operator to set flag
Date: Thu, 20 Mar 2014 11:20:47 -0700
Message-ID: <xmqqtxasybnk.fsf@gitster.dls.corp.google.com>
References: <1395270124-2242-1-git-send-email-sh19910711@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Hiroyuki Sano <sh19910711@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 19:21:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQhaK-0003XH-U5
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 19:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933312AbaCTSUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 14:20:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48834 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933099AbaCTSUu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 14:20:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31CF976B4C;
	Thu, 20 Mar 2014 14:20:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6X76pF7x0xRlpm/IwKWKeGkLAis=; b=IhQjc6
	fYjMG0+lfT0d3ACZ7XuiQvHk7B4v89Oc4XwLw9NuPckjXAmszmrI8kH5XK07jDP3
	7B+HpiimXBxIE/dXnJVZaRa4+SeQnGpFkUZ/kZryULPz3VPwMmKZoUH7DdbJkMe7
	t9J1sam4enAaaGmtxJz4rZSob1N1h4YuL9saE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J85/VN+WY2RtzFfNVWN1sYivqaFNdJXr
	FYFN98U1rL4cbBW1LvA7TG4JhIW7g+h6XnxbQ/+HSNztgUKCz4yUKPEFPChsSrVh
	IT40Gb6+Krkl9TCo7eE0uByo9JXUUvt3aRaUtnLBb55XTjORCexIypyR/rTj/fnv
	xV9J+O9nvSw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F1D876B4B;
	Thu, 20 Mar 2014 14:20:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 04BB776B4A;
	Thu, 20 Mar 2014 14:20:48 -0400 (EDT)
In-Reply-To: <1395270124-2242-1-git-send-email-sh19910711@gmail.com> (Hiroyuki
	Sano's message of "Thu, 20 Mar 2014 08:02:04 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5CB816D8-B05C-11E3-92A1-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244567>

Hiroyuki Sano <sh19910711@gmail.com> writes:

> fsck_tree() has two different ways to set a flag,
> which are the followings:
>
>   1. Using a if-statement that guards assignment.
>
>   2. Using a bitwise-or assignment operator.
>
> Currently, many with the former way,
> and one with the latter way.
>
> In this patch, unify them to the latter way,
> because it makes the code shorter and easier to read,
> and it is brief and to the point.

Two issues:

 * "In this patch," is redundant.

 * "it is brief and to the point" are equally applicable to both
   styles, so that is not a *reason* to choose one over the other.

If a condition were *not* brief and to the point, then a rewrite to
the latter style will make the resulting code worse:

	if (a very complex condition
            that potentially have to consume a
            lot of brain-cycles to understand) {
		has_that_condition = 1;
	}

is a lot easier to extend than

	has_that_condition = (a very complex condition
                              that potentially have to consume a
                              lot of brain-cycles to understand);

because it is a lot more likely that we would need to later extend
such a complex condition is more likely than a simple singleton
condition, and we could end up with

	if (a very complex condition
            that potentially have to consume a
            lot of brain-cycles to understand) {
		futher computation to check if
                the condition really holds
                will be added here later
                if (does that condition really hold true?)
			has_that_condition = 1;
	}


which may be harder to express in the latter form.

In other words, "it is brief and to the point" merely _allows_ these
statements to be expressed in the latter form; it does not say
anything about which is better between the former and the latter.

> Signed-off-by: Hiroyuki Sano <sh19910711@gmail.com>
> ---
>  fsck.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index b3022ad..abed62b 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -165,18 +165,12 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
>  
>  		sha1 = tree_entry_extract(&desc, &name, &mode);
>  
> -		if (is_null_sha1(sha1))
> -			has_null_sha1 = 1;
> -		if (strchr(name, '/'))
> -			has_full_path = 1;
> -		if (!*name)
> -			has_empty_name = 1;
> -		if (!strcmp(name, "."))
> -			has_dot = 1;
> -		if (!strcmp(name, ".."))
> -			has_dotdot = 1;
> -		if (!strcmp(name, ".git"))
> -			has_dotgit = 1;
> +		has_null_sha1 |= is_null_sha1(sha1);
> +		has_full_path |= !!strchr(name, '/');
> +		has_empty_name |= !*name;
> +		has_dot |= !strcmp(name, ".");
> +		has_dotdot |= !strcmp(name, "..");
> +		has_dotgit |= !strcmp(name, ".git");
>  		has_zero_pad |= *(char *)desc.buffer == '0';
>  		update_tree_entry(&desc);
