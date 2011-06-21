From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/13] revert: Factor out add_message_to_msg function
Date: Tue, 21 Jun 2011 12:01:30 -0700
Message-ID: <7vmxhb80vp.fsf@alter.siamese.dyndns.org>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-3-git-send-email-artagnon@gmail.com>
 <20110621155836.GG15461@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 21:01:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ6Ck-0006uV-Ig
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 21:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757360Ab1FUTBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 15:01:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47753 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757357Ab1FUTBe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 15:01:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1D44744A4;
	Tue, 21 Jun 2011 15:03:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vzr4bbHngWbZ09ig2tfWx2OdDuo=; b=erk7zi
	RaeYP0p6wioBRkFZa99wglxkF1pqROxECJymQ3OYOBFa0V5Ynmg19OHo0smyXmWY
	g1xkAimHzovVYw6XwWQp3q9AtKDoPSsY6cJIxm+ylPAOmAIUFs8xMesrz75DX3O6
	+GX+dkEfUOJbwtd82wqE+gyBNWY5mwX+OefB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CtjJJ70zGQ4f0tEF/SwnFGxJbYSeg7yf
	jfMoG0MKWltnhg3EANX6kp0jS4O2Xkoi6wo0UauRjEkC6PxEmhf18zuylb50u4wV
	Z8ZtloUyWGE/m0wm4/1+oJmCVpY4u0ZLBKUlLhNYZlGdH9b77g/XuIWV9TE9BB/s
	4QNvEo0V9MQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 15B5544A3;
	Tue, 21 Jun 2011 15:03:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 43BB244A2; Tue, 21 Jun 2011
 15:03:44 -0400 (EDT)
In-Reply-To: <20110621155836.GG15461@elie> (Jonathan Nieder's message of
 "Tue, 21 Jun 2011 10:58:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F5DEDAA-9C39-11E0-A2CF-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176183>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> The add_message_to_msg function is poorly implemented, has an unclear
>> API, and only one callsite.  Replace the callsite with a cleaner
>> implementation.
>
> The above does not answer the question I would have, namely what
> exactly is wrong with add_message_to_msg.  Is it too slow?  Not
> robust?  Is the generated assembly too long?  Is it hard for a reader
> to figure out the intent?  Does it blend in poorly with its
> surroundings?

I do not know if I _suggested_ this, but ...

> diff --git a/builtin/revert.c b/builtin/revert.c
> index 1f27c63..d6d2356 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -185,19 +185,6 @@ static char *get_encoding(const char *message)
>  	return NULL;
>  }
>  
> -static void add_message_to_msg(struct strbuf *msgbuf, const char *message)
> -{
> -	const char *p = message;
> -	while (*p && (*p != '\n' || p[1] != '\n'))
> -		p++;

This is a loop that manually implements strstr("\n\n"); rewriting of which
is a Good Thing.

> -	if (!*p)
> -		strbuf_addstr(msgbuf, sha1_to_hex(commit->object.sha1));
> -
> -	p += 2;
> -	strbuf_addstr(msgbuf, p);

I am not sure if this corresponds to what the new code does. What happens
if *p was NUL (i.e. we did not find any "\n\n" in the "message" at all)?
We go two bytes beyond that NUL and run addstr from that unknown space?
The new code does not seem to do that ;-)

I suspect that this was a bug from the original C-rewrite of git-revert
that was done by 9509af6 (Make git-revert & git-cherry-pick a builtin,
2007-03-01), and the new code fixes the bug, but then it would be nice to
note that in the commit log message.

> @@ -471,11 +458,17 @@ static int do_pick_commit(void)
>  		}
>  		strbuf_addstr(&msgbuf, ".\n");
>  	} else {
> +		const char *p = strstr(msg.message, "\n\n");
> +
>  		base = parent;
>  		base_label = msg.parent_label;
>  		next = commit;
>  		next_label = msg.label;
> -		add_message_to_msg(&msgbuf, msg.message);
> +
> +		/* Add msg.message to msgbuf */

This is an incorrect comment that confuses the reader. Think:

 - What did you skip by looking for the first "\n\n"?
 - What do you instead when no such "\n\n" is found?

Perhaps what it is doing is: "Add commit log message, if exists, or the
commit object name if it doesn't"

> +		p = p ? p + 2 : sha1_to_hex(commit->object.sha1);
> +		strbuf_addstr(&msgbuf, p);
> +
>  		if (no_replay) {
>  			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
>  			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
