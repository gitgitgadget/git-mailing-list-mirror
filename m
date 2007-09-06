From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rework strbuf API and semantics.
Date: Thu, 06 Sep 2007 02:31:37 -0700
Message-ID: <7vlkbkb0na.fsf@gitster.siamese.dyndns.org>
References: <20070905085720.GD31750@artemis.corp>
	<11890199232110-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 11:32:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITDib-00050v-RI
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 11:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755052AbXIFJbn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 05:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755050AbXIFJbn
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 05:31:43 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:48748 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755019AbXIFJbm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 05:31:42 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A0B1E12D9E1;
	Thu,  6 Sep 2007 05:32:00 -0400 (EDT)
In-Reply-To: <11890199232110-git-send-email-madcoder@debian.org> (Pierre
	Habouzit's message of "Wed, 5 Sep 2007 21:18:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57848>

Pierre Habouzit <madcoder@debian.org> writes:

>   A strbuf can be used to store byte arrays, or as an extended string
> library. The `buf' member can be passed to any C legacy string function,
> because strbuf operations always ensure there is a terminating \0 at the end
> of the buffer, not accounted in the `len' field of the structure.
>
>   A strbuf can be used to generate a string/buffer whose final size is not
> really known, and then "strbuf_detach" can be used to get the built buffer,
> and keep the wrapping "strbuf" structure usable for further work again.
>
>   Other interesting feature: strbuf_grow(sb, size) ensure that there is
> enough allocated space in `sb' to put `size' new octets of data in the
> buffer. It helps avoiding reallocating data for nothing when the problem the
> strbuf helps to solve has a known typical size.

"Rework API semantics" needs to be accompanied with an API
description, perhaps at the beginning of each externally
visible function.

Also the commit log message needs to explain what the old
semantics was and what the improved one is, to highlight the
changes needed to the callers.  Especially...

> @@ -1657,11 +1656,11 @@ static void *cmd_data (size_t *size)
>  			if (term_len == command_buf.len
>  				&& !strcmp(term, command_buf.buf))
>  				break;
> -			ALLOC_GROW(buffer, length + command_buf.len, sz);
> +			ALLOC_GROW(buffer, length + command_buf.len + 1, sz);
>  			memcpy(buffer + length,
>  				command_buf.buf,
> -				command_buf.len - 1);
> -			length += command_buf.len - 1;
> +				command_buf.len);
> +			length += command_buf.len;
>  			buffer[length++] = '\n';
>  		}
>  		free(term);

... it is not all obvious why these off-by-one changes are
needed without such a description.  The other hunks in this
patch to this file are all such changes.

> -static void inline strbuf_add(struct strbuf *sb, int ch) {

> +static inline void strbuf_addch(struct strbuf *sb, size_t c) {
> +	strbuf_grow(sb, 1);
> +	sb->buf[sb->len++] = c;
> +	sb->buf[sb->len] = '\0';
> +}

You certainly did not mean size_t wide characters.
