From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: add show_err flag to git_config_parse_key()
Date: Wed, 11 Feb 2015 10:47:50 -0800
Message-ID: <xmqq386cuvxl.fsf@gitster.dls.corp.google.com>
References: <20150206124528.GA18859@inner.h.apk.li>
	<20150206193313.GA4220@peff.net>
	<xmqqbnl6hljt.fsf@gitster.dls.corp.google.com>
	<20150206203902.GB10857@peff.net> <54DA5FC1.9010707@gmail.com>
	<20150211002754.GC30561@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tanay Abhra <tanayabh@gmail.com>, Andreas Krey <a.krey@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:48:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLcKS-0004ED-RG
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 19:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201AbbBKSr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2015 13:47:59 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59456 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754102AbbBKSr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2015 13:47:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E2393387E3;
	Wed, 11 Feb 2015 13:47:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e6PoazegBjrqJHw+6pfcZwtYktI=; b=Q4FchV
	/Ogkf7U6HNwn0sg45c267Tg01tdar73GnSxlE7DI4PNrzDD5o6oBHNDC2UsXLlh/
	O4v1lZ17t+F4F9JCqciJXdeeHpZPPaZfEoe1Hi1CdsEqsvHSI3ZpxRwZeFsZxBuV
	TTQyeyA4Q5CrxrLcZgselMOvxnuMa7MrunwRs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xGtHWSaR6pjNMelf2Gsg21gQPRSFwJL9
	dqXOUgFzwC9D8QhQgu5gKCEOaB1vdPEKt8NvDJUxvdJ6U41E5kPtzr4aEgPSDInu
	14Tjy24rfUwb3wgysTF+aH3nDBOBSSK/gPlJV8101njOOuvbS5B9sXHsXMpLsIlY
	/9/6qaElRyI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D7B80387E2;
	Wed, 11 Feb 2015 13:47:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 347F6387E1;
	Wed, 11 Feb 2015 13:47:52 -0500 (EST)
In-Reply-To: <20150211002754.GC30561@peff.net> (Jeff King's message of "Tue,
	10 Feb 2015 19:27:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7BC70524-B21E-11E4-A086-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263687>

Jeff King <peff@peff.net> writes:

> On Wed, Feb 11, 2015 at 01:15:05AM +0530, Tanay Abhra wrote:
>
>> I just saw your mail late in the night (I didn't had net for a week).
>> This patch just squelches the error message, I will take a better
>> look tomorrow morning.
>
> Thanks, this is probably a good first step. We can worry about making
> the config look actually _work_ as the next step (which does not even
> have to happen right now; it is not like it hasn't been this way since
> the very beginning of git).

I agree this is probably a good first step in the right direction.
As to the implementation, there are a few minor things I would
change, but they are both minor:

 - "defective" may want to be a bit more descriptive to clarify what
   kind fo defect is undesired. In the context of this patch, I
   think Tanay meant (syntactically) "malformed", perhaps?

 - "int show_err" should be "unsigned flags" with its bit 01 defined
   to be used as QUIET bit.

> Another option for this first step would be to actually make
> git_config_parse_key permissive, rather than just squelching the
> error.  That is, to actually look up pager.under_score rather than
> silently erroring out with an invalid key whenever we are reading
> (whereas on the writing side, we _do_ want to make sure we enforce
> syntactic validity).  I doubt it matters, much, though.

Sensible.

> I was tempted to also add something like:
>
>   test_expect_failure TTY 'command with underscores can override pager' '
> 	test_config pager.under_score "sed s/^/paged://" &&
> 	git --exec-path=. under_score >actual &&
> 	echo paged:ok >expect &&
> 	test_cmp expect actual
>   '
>
> but I am not sure it is worth adding the test, even as a placeholder.
> Unless we are planning to relax the config syntax, the correct spelling
> is more like "pager.under_score.command". It's probably better to just
> add the test along with the code when we know what the final form will
> look like.

Concurred.
