From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] tag: add --points-at list option
Date: Tue, 07 Feb 2012 00:35:19 -0800
Message-ID: <7vd39r2g8o.fsf@alter.siamese.dyndns.org>
References: <1328598076-7773-1-git-send-email-tmgrennan@gmail.com>
 <1328598076-7773-2-git-send-email-tmgrennan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, jasampler@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 09:35:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RugWR-00028z-C3
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 09:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756448Ab2BGIfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 03:35:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32813 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756541Ab2BGIfX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 03:35:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1C992F00;
	Tue,  7 Feb 2012 03:35:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WXuOuWufiqefLjnCmsMuQsj44vE=; b=d1FgpW
	N/UdgXufo710teX542f6crXKdTDa06ma54wnUQuEASHzEbi7lQoB5HdK5kCK35Hf
	AjC6pJannBadMGzX+WLvVxopBcYOHSOIyQRyK9POiKrxTyr0mRAGt7NE8OLqTqo4
	S4R0/Yt0tG9MIZ+++byNslDJYplp6pLpOIYh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G6cC2Vc6NBwKKc9DKu9PrdRheVexySjv
	yKmoEb1BXT0H/0WFZYdnwOBw7+heqoOmZFXYyJhUIlCAk6kox9YqxaQ0AQ/Q5cyK
	yegl3UBJ5OLq7a8vc/Np4QjgWqss4I4bH4nFiJLrJOMOFl3SCCNCNtQUWnRN72TL
	jkirvo4AEQQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A079C2EFF;
	Tue,  7 Feb 2012 03:35:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F1F92EFC; Tue,  7 Feb 2012
 03:35:21 -0500 (EST)
In-Reply-To: <1328598076-7773-2-git-send-email-tmgrennan@gmail.com> (Tom
 Grennan's message of "Mon, 6 Feb 2012 23:01:16 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ABF65BB2-5166-11E1-9868-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190154>

Tom Grennan <tmgrennan@gmail.com> writes:

> +struct points_at {
> +	struct points_at *next;
> +	unsigned char *sha1;
> +};

struct points_at {
	struct points_at *next;
        unsigned char sha1[20];
};

would save you from having to allocate and free always in pairs, no?

> +static void free_points_at (struct points_at *points_at)

Please lose the SP before (.

> +	if (type != OBJ_TAG
> +	    || (tag = lookup_tag(sha1), !tag)
> +	    || parse_tag_buffer(tag, buf, size) < 0) {

Even though I personally prefer to cascade a long expression like this, so
that you see a parse tree when you tilt your head 90-degrees to the left,
I think the prevalent style in Git codebase is

	if (A-long-long-expression ||
            B-long-long-expression ||
            C-long-long-expression) {

Also we try to avoid assignment in the conditional.

> @@ -432,6 +500,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  			PARSE_OPT_LASTARG_DEFAULT,
>  			parse_opt_with_commit, (intptr_t)"HEAD",
>  		},
> +		{
> +			OPTION_CALLBACK, 0, "points-at", &points_at, "object",
> +			"print only annotated|signed tags of the object",
> +			PARSE_OPT_LASTARG_DEFAULT,
> +			parse_opt_points_at, (intptr_t)NULL,
> +		},

If you are going to reject NULL anyway, do you still need to mark this as
lastarg-default?

Looking for example in parse-options.h, I found this:

        #define OPT_STRING_LIST(s, l, v, a, h) \
                    { OPTION_CALLBACK, (s), (l), (v), (a), \
                      (h), 0, &parse_opt_string_list }

which is used by "git clone" to mark its -c option.

Running "git clone -c" gives me

	error: switch 'c' requires a value

without any extra code in the caller of parse_options().

Other than that, looks cleanly done.

Thanks. I'll take another look after I wake up in the morning.
