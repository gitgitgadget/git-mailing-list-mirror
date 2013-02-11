From: Junio C Hamano <gitster@pobox.com>
Subject: Re: segfault for git log --graph --no-walk --grep a
Date: Mon, 11 Feb 2013 12:01:56 -0800
Message-ID: <7v621ymxfv.fsf@alter.siamese.dyndns.org>
References: <201302090052.22053.thom311@gmail.com>
 <7vsj56xsg5.fsf@alter.siamese.dyndns.org>
 <7vobfuxrns.fsf@alter.siamese.dyndns.org>
 <20130209002710.GA5570@sigill.intra.peff.net>
 <7vfw16xqvj.fsf@alter.siamese.dyndns.org>
 <7va9rexqii.fsf@alter.siamese.dyndns.org>
 <20130211191607.GA21269@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Haller <thom311@gmail.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 21:02:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4za4-0006pG-ES
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 21:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089Ab3BKUCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 15:02:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35834 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759929Ab3BKUB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 15:01:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F14BBAF4;
	Mon, 11 Feb 2013 15:01:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eusZR6vvJYUv0YclWT6FE5YMclI=; b=mDBX50
	2iKoXEY4q/0sAqd23hIEF562Lk9tj1lbRKBVGN6eR1+tQYi1pqzh7kJqwCV6zMUK
	h98tHyYQomDT4x2ss//kxJDaxLBvY1iqAUYPRGmW2T+BEFwOpySjk3P9n+9rug7h
	25yhovAGPuGaux+eO5kPcPX9oanwatm5/r94M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eeFyhAvQNPmY5QolSgod3khaEUPanJdj
	PV8i5kFjNI++/2pMoOZmTMf0B+EyUNpV0C9+1juaz6gLCbQuwY+igbzD+rK8hzHp
	tdSlp2pImrJAoeQ8ZABA+pCjzFWpsejH+WopGLTr/g9+rfGJ/ZOEWP6B8CSTaZMY
	uWMlfwYmGbI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 546FDBAF3;
	Mon, 11 Feb 2013 15:01:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A07BBBAF2; Mon, 11 Feb 2013
 15:01:57 -0500 (EST)
In-Reply-To: <20130211191607.GA21269@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 11 Feb 2013 14:16:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E3D8D972-7485-11E2-BF0F-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216081>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 08, 2013 at 04:47:01PM -0800, Junio C Hamano wrote:
>
>> > Yeah, that actually is a good point.  We should be using logmsg_reencode
>> > so that we look for strings in the user's encoding.
>> 
>> Perhaps like this.  Just like the previous one (which should be
>> discarded), this makes the function always use the temporary strbuf,
>> so doing this upfront actually loses more code than it adds ;-)
>
> I didn't see this in What's Cooking or pu. We should probably pick an
> approach and go with it.
>
> I think using logmsg_reencode makes sense. I'd be in favor of avoiding
> the extra copy in the common case, so something like the patch below. If
> you feel strongly about the code cleanup at the minor run-time expense,
> I won't argue too much, though.

Sounds good to me.  Care to do the log message while at it?

> ---
> diff --git a/revision.c b/revision.c
> index d7562ee..a08d0a5 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2268,7 +2268,10 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
>  static int commit_match(struct commit *commit, struct rev_info *opt)
>  {
>  	int retval;
> +	const char *encoding;
> +	const char *message;
>  	struct strbuf buf = STRBUF_INIT;
> +
>  	if (!opt->grep_filter.pattern_list && !opt->grep_filter.header_list)
>  		return 1;
>  
> @@ -2279,13 +2282,23 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
>  		strbuf_addch(&buf, '\n');
>  	}
>  
> +	/*
> +	 * We grep in the user's output encoding, under the assumption that it
> +	 * is the encoding they are most likely to write their grep pattern
> +	 * for. In addition, it means we will match the "notes" encoding below,
> +	 * so we will not end up with a buffer that has two different encodings
> +	 * in it.
> +	 */
> +	encoding = get_log_output_encoding();
> +	message = logmsg_reencode(commit, encoding);
> +
>  	/* Copy the commit to temporary if we are using "fake" headers */
>  	if (buf.len)
> -		strbuf_addstr(&buf, commit->buffer);
> +		strbuf_addstr(&buf, message);
>  
>  	if (opt->grep_filter.header_list && opt->mailmap) {
>  		if (!buf.len)
> -			strbuf_addstr(&buf, commit->buffer);
> +			strbuf_addstr(&buf, message);
>  
>  		commit_rewrite_person(&buf, "\nauthor ", opt->mailmap);
>  		commit_rewrite_person(&buf, "\ncommitter ", opt->mailmap);
> @@ -2294,18 +2307,18 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
>  	/* Append "fake" message parts as needed */
>  	if (opt->show_notes) {
>  		if (!buf.len)
> -			strbuf_addstr(&buf, commit->buffer);
> -		format_display_notes(commit->object.sha1, &buf,
> -				     get_log_output_encoding(), 1);
> +			strbuf_addstr(&buf, message);
> +		format_display_notes(commit->object.sha1, &buf, encoding, 1);
>  	}
>  
> -	/* Find either in the commit object, or in the temporary */
> +	/* Find either in the original commit message, or in the temporary */
>  	if (buf.len)
>  		retval = grep_buffer(&opt->grep_filter, buf.buf, buf.len);
>  	else
>  		retval = grep_buffer(&opt->grep_filter,
> -				     commit->buffer, strlen(commit->buffer));
> +				     message, strlen(message));
>  	strbuf_release(&buf);
> +	logmsg_free(message, commit);
>  	return retval;
>  }
>  
