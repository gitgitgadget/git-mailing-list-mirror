From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 4/8] pretty.c: teach format_commit_message() to
 reencode the output
Date: Wed, 13 Oct 2010 14:59:30 -0700
Message-ID: <7vd3rdiwjh.fsf@alter.siamese.dyndns.org>
References: <1286478657-61581-1-git-send-email-patnotz@gmail.com>
 <1286478657-61581-5-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Pat Notz" <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 23:59:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P69MN-0000p3-29
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 23:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463Ab0JMV7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 17:59:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab0JMV7h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 17:59:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D344DDEAEF;
	Wed, 13 Oct 2010 17:59:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=9Ldnf1qLZ3fdW2k6N2jLPNAMrSc=; b=mjaHANFzJM2e5uaV6kUBDT2
	8AW3WiT791pElFClfq+C/FMGmVf4yic9zOKhnM2cTO5s44Wq+9K6I2GFfvpn8mxx
	ZbmdAx4+tHDDB3zlIc33K4tPA98LdbDUsCiL53m8yEW1J/8NL8yPe0/6Cyiba76J
	wZ4HUDYpqBA2YLtRaCc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=lIptLopOqT5Sws8pMSEKWxcBDgyuOw2G2NznrB44bzQ0H7M00
	WYScK5HdbvuHOgjvtc5cQq2gypzHbJp0GnwxidVrhCpGmVCD1zX3m4bgJMRbUYg/
	jddHqtYNo66Tyb87Bp+OmXKnV59xqLwd4C4qFirrMR11pR1ZWrkzXBKJAY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AFF07DEAED;
	Wed, 13 Oct 2010 17:59:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E7EB1DEAE7; Wed, 13 Oct
 2010 17:59:31 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2A36E92E-D715-11DF-9639-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158989>

"Pat Notz" <patnotz@gmail.com> writes:

> diff --git a/pretty.c b/pretty.c
> index a607fd6..e5ce7fb 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1009,16 +1009,47 @@ void userformat_find_requirements(const char *fmt, struct userformat_want *w)
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
> +	char *buffer;
> +	char *enc_buffer;
> +	struct strbuf scratch_sb = STRBUF_INIT;
> +	struct strbuf *sb_ptr;
> +
> +	enc = get_header(commit, "encoding");
> +	enc = enc ? enc : utf8;
> +	if(output_encoding && strcmp(enc,output_encoding)) {
> +		sb_ptr = &scratch_sb;
> +	} else {
> +		sb_ptr = sb;
> +	}

Style...

>  	memset(&context, 0, sizeof(context));
>  	context.commit = commit;
>  	context.pretty_ctx = pretty_ctx;
>  	context.wrap_start = sb->len;
> -	strbuf_expand(sb, format, format_commit_item, &context);
> -	rewrap_message_tail(sb, &context, 0, 0, 0);
> +	strbuf_expand(sb_ptr, format, format_commit_item, &context);
> +	rewrap_message_tail(sb_ptr, &context, 0, 0, 0);
> +
> +	if(sb_ptr != sb) {
> +		/* if re-encoding fails, take the content byte-for-byte */
> +		buffer = strbuf_detach(sb_ptr, 0);
> +		enc_buffer = reencode_string(buffer, output_encoding, enc);
> +		enc_buffer = enc_buffer ? enc_buffer : buffer;
> +
> +		strbuf_addstr(sb,enc_buffer);
> +
> +		if(enc_buffer != buffer)
> +			free(enc_buffer);
> +		free(buffer);
> +	}
> +
> +	if(enc != utf8)
> +		free(enc);
>  }

You are expanding and wrapping commit->buf before re-encoding, but I am
not sure it is the right thing to do.  Wouldn't it become much simpler and
more consistent if you re-encode first and then give the result to later
expansion and wrapping process?  format_commit_one() would need to take
"msg" not from c->commit->buffer but from a new field to hold reencoded
result you will add in your patch to the structure, if you do so, of
course.

Besides, I am a bit lost as to what this patch has to do with the stated
goal of the series, "Add commit message options for rebase --autosquash".
