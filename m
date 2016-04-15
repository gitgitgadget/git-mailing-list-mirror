From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH, WAS: "weird diff output?" 2/2] xdiff: implement empty line chunk heuristic
Date: Fri, 15 Apr 2016 14:44:51 -0700
Message-ID: <xmqqzisu8s30.fsf@gitster.mtv.corp.google.com>
References: <20160415165141.4712-1-jacob.e.keller@intel.com>
	<20160415165141.4712-3-jacob.e.keller@intel.com>
	<CAGZ79ka7h25=rHun_hPv1qjqeghXt1UwUU3Q6xT0aj4+OW87fg@mail.gmail.com>
	<xmqq8u0ebpru.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xoWbrSaONH5xq=w5W190Jknk0Qsc5brS4UKFAs2_dTceg@mail.gmail.com>
	<xmqqzisuaa3t.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xqe4ng9-gn1DRqhjebRXuHXbqZ6f3QsJ798k6DRo3bYyQ@mail.gmail.com>
	<CA+P7+xp7oJoOXBhexe9zhrG1dMkz8jA3yQLzyTiqMwNQ1AQVdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 23:45:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arBXx-0005qN-AD
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 23:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbcDOVo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 17:44:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59320 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751176AbcDOVoz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 17:44:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A54091303C;
	Fri, 15 Apr 2016 17:44:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o43WT4wdK54gfFQ0HteK0AoNPww=; b=BJwHrY
	+qrqw9QKrtyR+A9svEmidAnjKST1UC0WKAiuJc347MiFBn1OVxlYzMwQMiCiwRGw
	0ToCIqIJbSF2rjLq3/v8PaGwaoZaw1m9ok2smoCs9mLCjpSWBfbUGRz2nekl8o0m
	T33rKb/0hRuKccpgkNu0ralhnq32up9SreXTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qi63WMCICbWuQoyJHz/tcRnyQxx9vCwb
	6obmkyc+ZgEpHLCYOnEWw+V4SKR3M+URMF2ptsM/fbYTnllOVPBB1iip9JnORyCM
	mFIHfEAAJ2lxD45L9k8H+rSUOwoZ0nAm4qQOpi7MnO1qx/h9uazJuNED2iq2OmQT
	AN+TH+RxS4M=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CA151303B;
	Fri, 15 Apr 2016 17:44:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB6C413039;
	Fri, 15 Apr 2016 17:44:52 -0400 (EDT)
In-Reply-To: <CA+P7+xp7oJoOXBhexe9zhrG1dMkz8jA3yQLzyTiqMwNQ1AQVdg@mail.gmail.com>
	(Jacob Keller's message of "Fri, 15 Apr 2016 14:22:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 496D6028-0353-11E6-AF26-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291670>

Jacob Keller <jacob.keller@gmail.com> writes:

>>> What you have is a pure developer support; aim to come up with "good
>>> enough" way, giving developers an easier way to experiment with, and
>>> remove it before the feature is shipped to the end user.
>
> What are your thoughts on adding this do the gitattributes diff
> section? Ie: modifications to the diff driver.

I do try to foresee the future needs but I try to limit the forecast
to "just enough so that we won't waste engineering effort on a wrong
thing".  "It may need to be turned off conditionally" suggests we
would want attributes added per path, and that is sufficient to make
me say "don't waste time on bikeshedding configuration variable
names, it will not be in the final product".

We do not need yet to know what the final name of the attributes
are, or how exactly the bit to affect the low level mechanism will
be set by the attribute mechanism.  I do not think this topic is
there yet, and it is a waste of engineering effort to prematurely
trying to make things too flexible and customizable, when the thing
that will eventually become flexible by conditionally enabled is not
even there yet.

As long as the low-level thing has a knob, set of internal bits, to
enable and disable it, that is all that is necessary to know at this
point.

Having said all that, I'd expect we'd compute the right bit to use
in the same place where we currently pick the custom textconv
driver, diff backend, etc., by consulting the attribute system
before running the diff.

But again, I'd think it would be waste of time to think beyond that
at this point, identifying exactly at which line of which source
file the new code would go and what that new code would look like,
until we are ready to start integrating it.
