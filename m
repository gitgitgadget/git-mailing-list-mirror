From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] generate a valid rfc2047 mail header for multi-line
 subject.
Date: Tue, 22 Feb 2011 12:43:40 -0800
Message-ID: <7vsjvfby0z.fsf@alter.siamese.dyndns.org>
References: <1297670968-28130-1-git-send-email-xiaozhu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: xzer <xiaozhu@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 21:43:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Prz5P-0005lv-1w
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 21:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436Ab1BVUnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 15:43:50 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63516 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab1BVUnt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 15:43:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 58A8F3C4F;
	Tue, 22 Feb 2011 15:45:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FEnTTkuM0lTkMwi49O1P1L4uHog=; b=QDXqqz
	QwISNTy96Ppw1+mHTYKnqX0JCv5FaKTUSsZpn4VRsP6kqIJmbyiYC5cFj4zNl1XI
	/qwz+Nyj7SeEsap0QOdH+TjJgvUcu2Kc0/GM5+D/atduj0YX42c1ogDHuxL+hxN2
	DpDdOhdcgWeCBcwQORh7hiK6Px58gJ2Nd3R/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v/tl/PxIr9zXqUp2okBxnLVgXuNg8r4c
	OJvbA4oeoi4UmRsExkXNgSYsZDDqaeSCUs+FUOBT545W+7z/tAVB2ENxxk8ECtwy
	ea/Fb+K8r03E5vPLuN8JBCbD1b9I16i2HA04FFeI9a3nudncBN5bnX07bHy9ePRd
	vDS2rVBREk8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 34C543C4C;
	Tue, 22 Feb 2011 15:44:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F2F173C41; Tue, 22 Feb 2011
 15:44:54 -0500 (EST)
In-Reply-To: <1297670968-28130-1-git-send-email-xiaozhu@gmail.com> (xzer's
 message of "Mon\, 14 Feb 2011 08\:09\:28 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9C866B78-3EC4-11E0-86F6-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167582>

xzer <xiaozhu@gmail.com> writes:

> Subject: Re: [PATCH] generate a valid rfc2047 mail header for multi-line subject.

We prefer to have "[PATCH] subsystem: description without final full-stop" here.

> There is still a problem that git-am will lost the line break.

What does "still" refer to?  It is unclear under what condition the
command lose "the line break" (nor which line break you are refering to; I
am guessing that you have a commit that begins with a multi-line paragraph
and you are talking about line breaks between the lines in the first
paragraph).

> It's not easy to retain it, but as the first step, we can generate
> a valid rfc2047 header now.

Please describe what is broken (iow, "Given this sample input, we
currently generate this output, which is not a valid rfc2047") and what
the new output looks like ("Update pp_title_line() to generate this output
instead.")

> ---

Missing sign-off with a real name.

> diff --git a/pretty.c b/pretty.c
> index 8549934..f18a38d 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -249,6 +249,33 @@ needquote:
>  	strbuf_addstr(sb, "?=");
>  }
>  
> +static void add_rfc2047_multiline(struct strbuf *sb, const char *line, int len,
> +                       const char *encoding)
> +{
> +	int first = 1;
> +	char *mline = xmemdupz(line, len);
> +	const char *cline = mline;
> +	int offset = 0, linelen = 0;
> +        for (;;) {

You seem to have indent that uses SPs instead of HT around here...

> +                linelen = get_one_line(cline);

I can see you are trying to be careful not to let get_one_line() overstep
past "len" the caller gave you by making a copy first, but is this
overhead really necessary?  After all we know in this static function that
the caller is feeding the contents from a strbuf, which always have a
terminating NUL (and that is why it is Ok that get_one_line() is not a
counted string interface).

> +
> +                cline += linelen;
> +
> +                if (!linelen)
> +                        break;
> +		
> +		if (!first)
> +			strbuf_addf(sb, "\n ");
> +
> +		offset = *(cline -1) == '\n'; 
> +
> +		add_rfc2047(sb, cline-linelen, linelen-offset, encoding);
> +		first = 0;
> +
> +        }
> +	free(mline);
> +}

So the general idea of this change (I am thinking aloud what should be in
the updated commit log message as the problem description) is that:

 - We currently give an entire multi-line paragraph string to the
   add_rfc2047() function to be formatted as the title of the commit;

 - The add_rfc2047() functionjust passes "\n" through, without making it a
   folding whitespace followed by a newline, to help callers that want to
   use this function to produce a header line that is rfc 2822 conformant;

 - The patch introduces a new function add_rfc2047_multiline() that splits
   its input and performs line folding for such a caller (namely, the
   pp_title_line() function);

 - Another caller of add_rfc2047(), pp_user_info, is not changed, and it
   won't fold the name of the user that appear on the From: line.

It is unclear if the last point is really the right thing to do, though.
It is not a new problem that an author name that has a "\n" in it would
break the output, but we probably would want to fix that case too here?
