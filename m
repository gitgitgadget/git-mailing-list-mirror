From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 2/6] pretty.c: teach format_commit_message() to
 reencode the output
Date: Wed, 27 Oct 2010 15:35:46 -0700
Message-ID: <7vvd4nb6wt.fsf@alter.siamese.dyndns.org>
References: <1287689637-95301-1-git-send-email-patnotz@gmail.com>
 <1287689637-95301-3-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Pat Notz" <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 00:36:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBEbN-0005Ub-BK
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 00:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757374Ab0J0Wfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 18:35:53 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50850 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756171Ab0J0Wfw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 18:35:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 787FC113A;
	Wed, 27 Oct 2010 18:35:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=8AdZ0lznp1tTwPSlyi7r0/fpgpI=; b=PPTk4bREpdAfD5mois4zv87
	A69SxdF9qMDqVX1X4S4t4LGAMaYBheeJ8G2yJ2lQMuzsCUPOVd6sIZ5FzkJJdbhC
	nAHvelfUPXe9+Ve7ltnwHrMQK39Cbb3ziuJMZTVF328sNhalAdh63GRzAovsmX4b
	R/p3tySVfXmDStSq0Bdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=FaDW1/gFX7VpC9s1WZqVQGOPmUUoMxkR7u838IuLsE/F/4x0n
	68XaUR8hWLr0A1Ejq87bZlXxOBdAcRixhIGg+6A3he+fq+6Tc0vUU81OLyGjb88S
	3W18ljVtnVWGS9NOVTRiwSAQojGv8+pmM53SZbOW9PWopWsf0M8/lbmN2M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F3E61138;
	Wed, 27 Oct 2010 18:35:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CA4B1136; Wed, 27 Oct
 2010 18:35:47 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8CC14098-E21A-11DF-A46A-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160130>

"Pat Notz" <patnotz@gmail.com> writes:

> @@ -1008,16 +1009,29 @@ void userformat_find_requirements(const char *fmt, struct userformat_want *w)
>  
>  void format_commit_message(const struct commit *commit,
>  			   const char *format, struct strbuf *sb,
> -			   const struct pretty_print_context *pretty_ctx)
> +			   const struct pretty_print_context *pretty_ctx,
> +			   const char *output_encoding)
>  {
>  	struct format_commit_context context;
> +	static char utf8[] = "UTF-8";
> +	char *enc;
> +
> +	enc = get_header(commit, "encoding");
> +	enc = enc ? enc : utf8;
>  
>  	memset(&context, 0, sizeof(context));
>  	context.commit = commit;
>  	context.pretty_ctx = pretty_ctx;
>  	context.wrap_start = sb->len;
> +	if (output_encoding && strcmp(enc, output_encoding))
> +		context.message = logmsg_reencode(commit, output_encoding);
> +	context.message = context.message ? context.message : commit->buffer;
> +
>  	strbuf_expand(sb, format, format_commit_item, &context);
>  	rewrap_message_tail(sb, &context, 0, 0, 0);
> +
> +	if (context.message != commit->buffer)
> +		free(context.message);
>  }

Three points.

 - Most of the callers give NULL to the output_encoding. Does it make
   sense to limit get_header(commit, "encoding") call only when the
   argument is given?

 - The conditional assignment to context.message with ?: is hard to read;
   perhaps it would be easier to read if you structure it like this:

	memset(&context, 0, sizeof(context));
        context.commit = ...;
        ...
	context.message = commit->buffer;
	if (output_encoding) {
        	enc = ...
                if (strcmp(enc, output_encoding))
                	context.message = ...
	}

 - Should output_encoding be a separate argument to this function?  If
   anybody is going to call this function with the same pretty_ctx with
   different output_encoding, your patch may make sense, but I suspect
   adding it as a new member to pretty_print_context structure may be much
   cleaner.  I would imagine that it would cut this patch down by 70% ;-)
