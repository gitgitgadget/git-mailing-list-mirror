From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] setup_pager: set MORE=R
Date: Tue, 21 Jan 2014 11:23:30 -0800
Message-ID: <xmqqwqhtuojx.fsf@gitster.dls.corp.google.com>
References: <20140117041430.GB19551@sigill.intra.peff.net>
	<20140117042153.GB23443@sigill.intra.peff.net>
	<xmqqvbxiwh8y.fsf@gitster.dls.corp.google.com>
	<20140121054927.GD5878@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Yuri <yuri@rawbw.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 21 20:23:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5gvQ-0003xy-CT
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 20:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357AbaAUTXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 14:23:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52619 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753140AbaAUTXl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 14:23:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EE8164768;
	Tue, 21 Jan 2014 14:23:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qw2hFEHXUvkGjbXj+fT4ci/wXaI=; b=xYEEin
	7+bilPeBX9mPlfpzLvqSB3p1W8VfsuIIsyQ64qzl8SEl9CFcb+yW2gkD+BhCDVXI
	ogTQB7KsMly4YvKLWRSPEvksNFjqL7exCkskfBBwGaJTB5AjEqVu3X47CLiSOCWz
	0kVzTpHSK/MklAJItkF8wWuoSlT3a+MlexMPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oIErmJ4PdZK7OL/BSwttvw+RJTWLckf0
	uQGfCP4wZC0w3phQE24CvdCxV3ikIdX58A1Gh+ps/swdE+z6U8zqldu5LNcXGzPR
	3qZpYdHLrJJBE9/7/ejXWMDDo8N3G1Z3XjjtCi3uPMc3hmv3hmaG1ldboiMjvH+j
	9WxZ0abRgIM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7BA264767;
	Tue, 21 Jan 2014 14:23:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EDCD964764;
	Tue, 21 Jan 2014 14:23:35 -0500 (EST)
In-Reply-To: <20140121054927.GD5878@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 21 Jan 2014 00:49:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 860A6706-82D1-11E3-9A9E-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240764>

Jeff King <peff@peff.net> writes:

> ...
> does complicate the point of my series, which was to add more intimate
> logic about how we handle LESS.
> ...
>                 return !x || strchr(x, 'R');
>     }
>
>     [...]
>   }
>
> but we are still hard-coding a lot of intelligence about "less" here.

I am not sure if it is even a good idea for us to have so intimate
logic for various pagers in the first place.  I'd seriously wonder
if it is better to take this position:

	A platform packager who sets the default pager and/or the
	default environment for the pager at the build time, or an
	individual user who tells your Git what pager you want to
	use and/or with what setting that pager should be run under
	with environment variables. These people ought to know far
	better than Git what their specific choices do. Do not try
	to second-guess them.

The potential breakage caused by setting MORE=R unconditionally is a
good example.  A careless "intimate logic" may think that any pager
that is called 'more' would behave like traditional 'more', breaking
half the 'more' user population while catering to the other half.

> I
> wonder if the abstraction provided by the Makefile variable is really
> worthwhile. Anybody adding a new line to it would also want to tweak
> pager_can_handle_color to add similar logic.

And that is why I am not enthused by the idea of adding such logic
in the first place.  I view the Makefile customization as a way for
the packager to offer a sensible default for their platform without
touching the code, which is slightly different from your 1. below.

> Taking a step back for a moment, we are getting two things out of such a
> Makefile variable:
>
>   1. An easy way for packager to add intelligence about common pagers on
>      their system.
>
>   2. DRY between git-sh-setup and the C code.
>
> I do like (1), but I do not know if we want to try to encode the "can
> handle color" logic into a Makefile variable. What would it look like?
>
> For (2), an alternate method would be to simply provide "git pager" as C
> code, which spawns the appropriate pager as the C code would. Then
> git-sh-setup can easily build around that.

And as to 2., if the answer to the other issue "do we want our code
to be intimately aware of pager-specific quirks, or do we just want
to give packagers a knob to express their choice of the default?"
resolves to the former, I would think that "git pager" would be not
just a workable alternative, but would be the only viable one.
