From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH, v2] tag: implement --[no-]strip option
Date: Mon, 14 Nov 2011 14:20:23 -0800
Message-ID: <7vipmmibx4.fsf@alter.siamese.dyndns.org>
References: <1321307019-5557-1-git-send-email-kirill@shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Kirill A. Shutemov" <kirill@shutemov.name>
X-From: git-owner@vger.kernel.org Mon Nov 14 23:20:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ4tD-0004sh-5E
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 23:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756514Ab1KNWU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 17:20:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32848 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754362Ab1KNWU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 17:20:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78DD8636D;
	Mon, 14 Nov 2011 17:20:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7lhwLbkxRGXR+uV1nj0bwaFGZAc=; b=mkhIfh
	ZzaBdVlj/JeeFsvySAeKen+FO01eSsMVFj2tmYgMQUsYTmpBnu+I9xZajF8X5Ds6
	IihH0fMOQvBzw7hak5bG+KvcF/OI3QnqX9P7Zz9F1kLUyU1KnFvyicBMhPjTPxhU
	wuGEXrYFgrYA0t+unEChKjd8ABiwZ+NttiEAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cJq0HQFtbmoYxEffHvZ+nMqXm1wR+KPI
	xHfrRvRcYB5vyN5oruUa+0D7BFG5sz6iZzoJidYvFzEKd535ZvFFTtTDZLBlgD8X
	m34Ls7/QFQ8CKeereSBCB/tlQnxdrlLgHzXWLzpUj7k7wC6Xd0swz9M8QipP/oI3
	cr/iyl+2sAM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70395636C;
	Mon, 14 Nov 2011 17:20:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3905636A; Mon, 14 Nov 2011
 17:20:24 -0500 (EST)
In-Reply-To: <1321307019-5557-1-git-send-email-kirill@shutemov.name> (Kirill
 A. Shutemov's message of "Mon, 14 Nov 2011 23:43:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D9567D84-0F0E-11E1-AAB2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185409>

"Kirill A. Shutemov" <kirill@shutemov.name> writes:

> From: "Kirill A. Shutemov" <kirill@shutemov.name>
>
> --strip::
> 	Remove from tag message lines staring with '#', trailing spaces
> 	from every line and empty lines from the beginning and end.
> 	Enabled by default. Use --no-strip to overwrite the behaviour.
>
> --no-strip is useful if you want to take a tag message as-is, without
> any stripping.

That is not a commit log message ;-)

> Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>

> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index c83cb13..dbb76a6 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -99,6 +99,11 @@ OPTIONS
>  	Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
>  	is given.
>  
> +--strip::
> +	Remove from tag message lines staring with '#', trailing spaces
> +	from every line and empty lines from the beginning and end.
> +	Enabled by default. Use --no-strip to overwrite the behaviour.

s/overwrite/override/; or replace the last sentence with "With
`--no-strip`, the tag message given by the user is used as-is".

> diff --git a/builtin/tag.c b/builtin/tag.c
> index 9b6fd95..05a1fd4 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> ...
> @@ -356,7 +362,7 @@ static void create_tag(const unsigned char *object, const char *tag,
>  
>  		if (!is_null_sha1(prev))
>  			write_tag_body(fd, prev);
> -		else
> +		else if (opt->strip)
>  			write_or_die(fd, _(tag_template), strlen(_(tag_template)));

Why are you not writing template when no strip is done? (Not an objection
disguised as a rhetorical question, but a question).

The user who typed "tag -a v1.2.3 HEAD" that spawns an editor would still
find it useful to have commented instructions, once we start filling the
template with more useful information that is customized for the
situation (e.g. "git show -s --oneline" output), no?

> @@ -423,8 +430,13 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	const char *object_ref, *tag;
>  	struct ref_lock *lock;
>  
> -	int annotate = 0, sign = 0, force = 0, lines = -1,
> -		list = 0, delete = 0, verify = 0;
> +	struct create_tag_options opt = {
> +		.sign = 0,
> +		.strip = 1,
> +	};

Avoid doing this.  Even though these C99 initializers are nicer and more
readable way to write this, we try to be gentle to people with older
compilers that do not grok the syntax.

Except for the above minor nits, the patch basically looks good. Please
hold onto it and resubmit after 1.7.8 final ships.

Thanks.
