From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: Use OPT_BOOL instead of OPT_BOOLEAN to allow one action multiple times
Date: Tue, 30 Jul 2013 15:22:53 -0700
Message-ID: <7vmwp3vgaq.fsf@alter.siamese.dyndns.org>
References: <1375207251-4998-1-git-send-email-stefanbeller@googlemail.com>
	<7va9l3x34f.fsf@alter.siamese.dyndns.org>
	<51F82E83.30203@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jul 31 00:23:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4IJp-0006NA-El
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 00:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756180Ab3G3WW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 18:22:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44237 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753743Ab3G3WW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 18:22:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19B56341D8;
	Tue, 30 Jul 2013 22:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vYzcoRQKAxUPNHMUyW3BFGZS6TM=; b=EiViPo
	vqWO4TUOZE1UQIPjVS32Xpv3D+iP4gpD1Ba17H3JiQ9r+1Zc9DkjBVVMfbuLereF
	p8FfhI9d8BzJDCPK0wh7qaUTpmwqp/SIaQL1DbvXuvwelumRzZSwEvoSBeJu/uYe
	+T/RHbSwFDbp0xaJNcGRPRdcOMM3qrFLxVdQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vwNlU38ntIYADpzZ6rhD/cVsB603DDFv
	zt009sMk3mkxlEcg45FS82z7vtrPZGio80IVFK+4k3utOduNU+OomvUjuOAkP8oL
	iZhiq724Pm5JlhFWpHXabxSe+Glt9Sq4KX3griyNjObCzCtEbVHIvjq0bm7+tqF7
	1nZQXIEeDy4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D696341D7;
	Tue, 30 Jul 2013 22:22:56 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E5C5341D5;
	Tue, 30 Jul 2013 22:22:55 +0000 (UTC)
In-Reply-To: <51F82E83.30203@googlemail.com> (Stefan Beller's message of "Tue,
	30 Jul 2013 23:22:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94C81DF0-F966-11E2-8C3B-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231394>

Stefan Beller <stefanbeller@googlemail.com> writes:

> Your approach seems more like what we really want, however I'd have
> some points:
>  * Is it a good idea to have so many different OPT_MODE or
>    OPTION_MODE defines? In my attempts I tried to reuse existing
>    OPTION_s to not pollute the parsing infrastructure with more
>    lines of code. ;)
>
>  * You can only have one OPTION_CMDMODE in one argv vector right?

That is not what I intended, at least.

	int one = 0, two = 0;
	struct option options[] = {
        OPT_CMDMODE('a', NULL, &one, N_("set one to a"), 'a'),
        OPT_CMDMODE('b', NULL, &one, N_("set one to b"), 'b'),
        OPT_CMDMODE('c', NULL, &two, N_("set two to c"), 'c'),
        OPT_CMDMODE('d', NULL, &two, N_("set two to d"), 'd'),
        OPT_END()
        }

should give you two independent sets of modes, one and two.

The only reason I needed to add an extra parameter to get_value()
was so that I can tell the former two and the latter two belong to
different groups, and that is done by looking at the address of the
variable.  In opt_command_mode_error(), opt->value == that->value
is used as a condition to see if the other option is possibly the
one that was used previously, which conflicted with us.
