From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 01/14] Add data structures and basic functions for commit trailers
Date: Thu, 06 Feb 2014 15:44:32 -0800
Message-ID: <xmqqzjm3x0v3.fsf@gitster.dls.corp.google.com>
References: <20140206194123.325.99451.chriscool@tuxfamily.org>
	<20140206202004.325.80557.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Feb 07 00:44:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBYcd-00059j-OV
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 00:44:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbaBFXoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 18:44:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32873 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013AbaBFXoi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 18:44:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A17026A8CE;
	Thu,  6 Feb 2014 18:44:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cCugF+AD1LZj2odwRlDdorMdEeA=; b=ZBK1WW
	ds0SvZEzN5t6S0aktz4+pQFGSNDpmNDIrAmJBD/xeXwi0FUI97WTWZ/cbs3db3H0
	cC9EfbdOr121ev3P3pzXVEEsNvXlcnyRTXMvhq7Bnokjlv3etl6BOgLJA7smPTA3
	4S5j5x3gb9o47d3yGRkamHcUPxgdkf4isT2NI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cu5JAx+10c7xhhKj38ewQ1s55BZKegb9
	2g1pXFtDvh4i5kfiNzCFvM1tufwAL8j/LwW4AQKi3K+XBABmwSNunjG3zKf+URZs
	Iyh+Hl6hAWE9NCAhOzuUECRiOKNHZ60FpleAZKcVYFfTyEd86zE2Gznoh91TEUQz
	Sqd4Te3tQSM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 642A86A8CC;
	Thu,  6 Feb 2014 18:44:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 223C36A8C5;
	Thu,  6 Feb 2014 18:44:36 -0500 (EST)
In-Reply-To: <20140206202004.325.80557.chriscool@tuxfamily.org> (Christian
	Couder's message of "Thu, 06 Feb 2014 21:19:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A2E1F3DA-8F88-11E3-8E3E-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241748>

Christian Couder <chriscool@tuxfamily.org> writes:

> We will use a doubly linked list to store all information
> about trailers and their configuration.
>
> This way we can easily remove or add trailers to or from
> trailer lists while traversing the lists in either direction.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Makefile  |  1 +
>  trailer.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
>  create mode 100644 trailer.c
>
> diff --git a/Makefile b/Makefile
> index b4af1e2..ec90feb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -871,6 +871,7 @@ LIB_OBJS += submodule.o
>  LIB_OBJS += symlinks.o
>  LIB_OBJS += tag.o
>  LIB_OBJS += trace.o
> +LIB_OBJS += trailer.o
>  LIB_OBJS += transport.o
>  LIB_OBJS += transport-helper.o
>  LIB_OBJS += tree-diff.o
> diff --git a/trailer.c b/trailer.c
> new file mode 100644
> index 0000000..f129b5a
> --- /dev/null
> +++ b/trailer.c
> @@ -0,0 +1,48 @@
> +#include "cache.h"
> +/*
> + * Copyright (c) 2013 Christian Couder <chriscool@tuxfamily.org>
> + */
> +
> +enum action_where { WHERE_AFTER, WHERE_BEFORE };
> +enum action_if_exist { EXIST_ADD_IF_DIFFERENT, EXIST_ADD_IF_DIFFERENT_NEIGHBOR,
> +		       EXIST_ADD, EXIST_OVERWRITE, EXIST_DO_NOTHING };
> +enum action_if_missing { MISSING_ADD, MISSING_DO_NOTHING };

All these names and "conf_info" below are not named to be specific
to this little tool.  Can I assume that these will never be exposed
to the rest of the system?  If so, they are fine.

> +struct conf_info {
> +	char *name;
> +	char *key;
> +	char *command;
> +	enum action_where where;
> +	enum action_if_exist if_exist;
> +	enum action_if_missing if_missing;

It still feels somewhat strange.  It is true that an item can be
either "exist" or "missing" and it is understandable that it tempts
you to split that into two, but EXIST_OVERWRITE will not trigger
either WHERE_AFTER or WHERE_BEFORE action.



> +};
> +
> +struct trailer_item {
> +	struct trailer_item *previous;
> +	struct trailer_item *next;
> +	const char *token;
> +	const char *value;
> +	struct conf_info *conf;
> +};
> +
> +static inline int same_token(struct trailer_item *a, struct trailer_item *b, int alnum_len)
> +{
> +	return !strncasecmp(a->token, b->token, alnum_len);
> +}
> +
> +static inline int same_value(struct trailer_item *a, struct trailer_item *b)
> +{
> +	return !strcasecmp(a->value, b->value);
> +}
> +
> +static inline int same_trailer(struct trailer_item *a, struct trailer_item *b, int alnum_len)
> +{
> +	return same_token(a, b, alnum_len) && same_value(a, b);
> +}

All these "inlines" look premature optimization that can be
delegated to any decent compiler, don't they?

> +/* Get the length of buf from its beginning until its last alphanumeric character */
> +static inline size_t alnum_len(const char *buf, int len)
> +{
> +	while (--len >= 0 && !isalnum(buf[len]));

Style:

	while (--len >= 0 && !isalnum(buf[len]))
        	;

You may add a comment on the empty statement to make it stand out
even more, i.e.

		; /* nothing */

> +	return (size_t) len + 1;

This is somewhat unfortunate.  if the caller wants to receive
size_t, perhaps it should be passing in size_t (or ssize_t) to the
function?  Hard to guess without an actual caller, though.

> +}
