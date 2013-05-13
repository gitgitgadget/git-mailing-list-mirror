From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/5] config: make parsing stack struct independent from actual data source
Date: Mon, 13 May 2013 07:54:06 -0700
Message-ID: <7vtxm7nd69.fsf@alter.siamese.dyndns.org>
References: <20130511131721.GA17991@book-mint>
	<20130511132013.GD17991@book-mint>
	<7vfvxrscjc.fsf@alter.siamese.dyndns.org>
	<20130513140435.GC3561@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon May 13 16:54:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubu8k-0008Lc-UI
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 16:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840Ab3EMOyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 10:54:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43654 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754135Ab3EMOyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 10:54:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C47B71DB0A;
	Mon, 13 May 2013 14:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LTQuKY99Y3CFEf9Rcymex+EPcws=; b=CGE9zn
	9ut2ylc0gN6GqnmRGNglylL+WUVvgmpReiBES1R6hl5DczHwsPqo2xV6LlN0XN0k
	QtkSj83SSxXyo7syyxRv5yKAHCbNSahQtYMl1hl1Xo0Ay0NBbqtfUOlebBu6LQve
	m5O5JAnYj9UtMM3Lb/3juB2LRCPZwBS/ReOH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NZL8lgr9OIhO5SOkNwIfiAHmYj0fPGNR
	iA0FyLi1aGNON9mAQRE4HLtCl0xIiiyToHPYhNdMmQ8LdJQe/arItcoL12jXIYlk
	SAvUoCNSkfg2PHVELantwCSpCTzx9M/Da0RmRZZLMqHDMxE1wPJ9PAlTo1n154Bv
	2HzF3U8o3MQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA10E1DB09;
	Mon, 13 May 2013 14:54:08 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 248A61DB05;
	Mon, 13 May 2013 14:54:08 +0000 (UTC)
In-Reply-To: <20130513140435.GC3561@book-mint> (Heiko Voigt's message of "Mon,
	13 May 2013 16:04:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F6C14594-BBDC-11E2-8CC6-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224160>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Sun, May 12, 2013 at 09:56:39PM -0700, Junio C Hamano wrote:
>> Heiko Voigt <hvoigt@hvoigt.net> writes:
>> 
>> >  /*
>> > - * The fields f and name of top need to be initialized before calling
>> > + * All source specific fields in the union, name and the callbacks
>> > + * fgetc, ungetc, ftell of top need to be initialized before calling
>> >   * this function.
>> >   */
>> > -static int do_config_from(struct config_file *top, config_fn_t fn, void *data)
>> > +static int do_config_from_source(struct config_source *top, config_fn_t fn, void *data)
>> 
>> This renaming may have made sense if we were to have many different
>> do_config_from_$type functions for different types of source, but as
>> this patch introduces a nice "config_source" abstraction, I do not
>> think it is unnecessary. Shortening do_config_from() to do_config()
>> may make more sense, if anything.
>> 
>> But that is a very minor point, as this is entirely internal with a
>> single caller.
>
> Did you really intent this double negation: "..., I do not think it
> is unnecessary."

Eh, rather "I think it is unnecessary" or "I do not think it is
necessary".
