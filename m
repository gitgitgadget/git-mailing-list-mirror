From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretty-print: de-tabify indented logs to make things line up properly
Date: Wed, 16 Mar 2016 12:47:11 -0700
Message-ID: <xmqqoaae4340.fsf@gitster.mtv.corp.google.com>
References: <alpine.LFD.2.20.1603160926060.13030@i7>
	<xmqq7fh25mkc.fsf@gitster.mtv.corp.google.com>
	<CA+55aFxV5PWdSn9Gj=zV464TtJo=QvciZrhc5Pwe+Qfyqt8sXw@mail.gmail.com>
	<xmqqwpp243sb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 16 20:47:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agHPb-0006bL-Rs
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 20:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755520AbcCPTrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 15:47:15 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60479 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754959AbcCPTrO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 15:47:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 750D04D9E2;
	Wed, 16 Mar 2016 15:47:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P1RvGZY7W4YvmmQR/XmVGskp+xk=; b=DhCqAR
	pZBDoN1zwp1QrosfbXfwkj0JEtezWRC2FjMpa9oaaMelh/As3urW+ILuGl7mmOF8
	WSB/Jm9HKeH9pmahVh5KdqGcak0jPRFUaGT424yrZ7aHp+QNDw6XiqTpNpypqZjs
	W1JGdoDc86Vcj64czL3tyUZYshUOe8vIvGLac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vpQmL0mg+hpx7ugB14IUm6D6KMTApqRw
	YVr7Gz1ng2NhQJshNHjBQCdlQ5CW5aKvM8jA0i8MLSlllMgjCSCg98UVr40MbScZ
	iIob4friGfRYekfBpQt4DYQRzqi4OMOqjSDKf6ZFAIsKdLSP82xxu8+AsQiTW+ce
	su19hg94P80=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6CB4E4D9E1;
	Wed, 16 Mar 2016 15:47:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E5F534D9E0;
	Wed, 16 Mar 2016 15:47:12 -0400 (EDT)
In-Reply-To: <xmqqwpp243sb.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 16 Mar 2016 12:32:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E0E49586-EBAF-11E5-84CA-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289025>

Junio C Hamano <gitster@pobox.com> writes:

> The above is most likely what I would have written if I were doing
> this patch.  I could squash it to save a round-trip, but let me run
> the testsuite first to see if we need adjustments to existing tests.

Strangely running t4201 with your patch (without any squashing)
seems to show a breakage in shortlog.  I won't be able to come back
to this topic for at least a few hours, so this is just a single bit
"breaks" report, without "how and why" analysis, sorry.

>
> Also your idea:
>
>> But the code *could* be made to just always do the whole
>> "strbuf_add()", and not return a return value at all, and the no-tab
>> case wouldn't be explicitly written to be different.
>
> may give us a better structure if we are going to give users a knob
> to disable this tab expansion, i.e. move the addition of 4 spaces to
> the caller, name the body of such a function strbuf_expand_add(),
> and then make the caller do something like this perhaps?
>
> @@ -1723,10 +1711,14 @@ void pp_remainder(struct pretty_print_context *pp,
>  
>  		strbuf_grow(sb, linelen + indent + 20);
>  		if (indent) {
> -			if (pp_handle_indent(sb, indent, line, linelen))
> -				linelen = 0;
> +			strbuf_addchars(sb, ' ', indent);
> +			if (pp->fmt == CMIT_FMT_EXPAND_TABS)
> +				strbuf_expand_add(sb, line, linelen);
> +			else
> +				strbuf_add(sb, line, linelen);
> +		} else {
> +			strbuf_add(sb, line, linelen);
>  		}
> -		strbuf_add(sb, line, linelen);
>  		strbuf_addch(sb, '\n');
>  	}
>  }
