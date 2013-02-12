From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] parse-options: report uncorrupted multi-byte options
Date: Mon, 11 Feb 2013 18:10:10 -0800
Message-ID: <7va9rajn99.fsf@alter.siamese.dyndns.org>
References: <1360624428-4728-1-git-send-email-kusmabite@gmail.com>
 <CACsJy8BByNnEhhE3TieM_kOy65t75rmB45ZzjJJ8AtL2N4-UFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	peff@peff.net, matthieu.moy@grenoble-inp.fr, tboegi@web.de
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 03:10:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U55KS-0005Uv-4l
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 03:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366Ab3BLCKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 21:10:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62832 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253Ab3BLCKN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 21:10:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB6C6BC81;
	Mon, 11 Feb 2013 21:10:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZvJXMkTAionuCl8D7qLll4KlDNE=; b=t77Z85
	8L34UTXczzAM+yxdCcW0y4QOJlqcmjob2mgM5gDcoRrBkDl0OSNar2m3JajOSWAq
	zWzQkido6bJQmOPD7VsFa667Fr6sBbmh5m1CVYm6KJTyRt6iJFJ9o7eEk5rg/QTB
	uvEv5ZsOy3uCtE1rudzezPwJ/uttWKTfo3uys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NjsRfott9f6dRaYU3/6BwGEd05W+uecd
	dkUee6aaHAOE4n9RSKqtr0I20iYjgWzYIi93WI9U5itHgSsvQxtIo0XeCcOVnyuS
	FwR8Zkjqdjje57zaGIwImoD/hjkJxqtTn62ETY81CzxiCMh4wlU6G7ApKkx2/kU8
	xigbyo3/zLk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE67CBC80;
	Mon, 11 Feb 2013 21:10:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4903BBC7F; Mon, 11 Feb 2013
 21:10:12 -0500 (EST)
In-Reply-To: <CACsJy8BByNnEhhE3TieM_kOy65t75rmB45ZzjJJ8AtL2N4-UFA@mail.gmail.com> (Duy
 Nguyen's message of "Tue, 12 Feb 2013 08:21:24 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5547D148-74B9-11E2-9D16-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216110>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Feb 12, 2013 at 6:13 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> Because our command-line parser considers only one byte at the time
>> for short-options, we incorrectly report only the first byte when
>> multi-byte input was provided. This makes user-erros slightly
>> awkward to diagnose for instance under UTF-8 locale and non-English
>> keyboard layouts.
>>
>> Make the reporting code report the whole argument-string when a
>> non-ASCII short-option is detected.
>
> Similar cases:
>
> config.c:git_default_core_config() assumes core.commentchar is ascii.
> We should catch and report non-ascii chars, or simply accept it as a
> string.

That one is just an uninterpreted byte.  core.commentString might be
a nice extension to the concept, but it is an entirely different
category.

> builtin/update-index.c:cmd_update_index(): error("unknown switch
> '%c'", *ctx.opt);

This one is in the same category as this topic.

> builtin/apply.c:apply_one_fragment(): error(_("invalid start of line:
> '%c'"), first); where 'first' may be a part of utf-8 from a broken
> patch.

This is where the patch is expected to have either " ", "-" or "+",
again, anything else is an uninterpreted byte.  It is more like
reporting the file we found an error in, whose filename is not
encoded in UTF-8 to the user's terminal.
