From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/16] refs: add methods for the ref iterators
Date: Mon, 04 Jan 2016 12:26:01 -0800
Message-ID: <xmqqegdxnlba.fsf@gitster.mtv.corp.google.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	<1449102921-7707-4-git-send-email-dturner@twopensource.com>
	<20160103000623.GB14424@gmail.com>
	<CAL=YDW=3JE==2s7Y3-fVRnTgaAzT674CAnypuXOKynpfD0q=Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Aguilar <davvid@gmail.com>,
	David Turner <dturner@twopensource.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 21:26:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGBhi-0005T6-Qw
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 21:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbcADU0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 15:26:06 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50557 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752289AbcADU0E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 15:26:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1D32637C04;
	Mon,  4 Jan 2016 15:26:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4ltWFcgUjX4osKBD5I2Np64TIC0=; b=W2oALC
	2hqubz1shvhruii4pk9szzWGayjmlcfD4VyE7XLukrzO0oHGWcHFt3nNDSuLnBHz
	7lHmVMCo+PW3phHQWx++Zpqb00cQ0GgS3lebLIXp4Q+LudlikVIjchycHw4LMowV
	PD8v447wlEYW70KLA6TKL7SHsf+NO3tEAcHw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VaE+q0UbezCicbh6rsLEzogywhFyJJ/J
	TKg9+sAVuSNab4wdeuddCIrXETr25eQ6kxvRgqEzTc9hG1WxqGJf4PrmU9ym5YnG
	DN3bDF6KLMf3q7gcNh3gHATk8YpLjlMMTnMuRPsm+m5Exj7Qw+/6fKwFe3yjRYoq
	fFjRObS49dQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1515037C03;
	Mon,  4 Jan 2016 15:26:03 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7AC0C37C02;
	Mon,  4 Jan 2016 15:26:02 -0500 (EST)
In-Reply-To: <CAL=YDW=3JE==2s7Y3-fVRnTgaAzT674CAnypuXOKynpfD0q=Bg@mail.gmail.com>
	(Ronnie Sahlberg's message of "Mon, 4 Jan 2016 11:12:19 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5FB84104-B321-11E5-A35B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283321>

Ronnie Sahlberg <sahlberg@google.com> writes:

> Not commenting on whether this is the right direction or not. A global
> variable holding a methods table might not be most aesthetic design,
> but there are practicalities.
>
> However, that kind of change would change the function signatures for
> all public refs functions and probably most private refs functions as
> well and will likely have massive conflicts with almost any other
> patch that touches the refs code.

I do not think "the_backend" that is the default is wrong.  Most
callers want to interact with the single default backend that shows
refs from the single default repository (i.e. ours), and having a
set of functions that interact with that single default instance of
the ref data without having to explicitly pass it as a parameter
makes sense.

It is just like how we handle the in-core index.  Most callers want
to interact with the_index, the single default one, and we have a
set of "cache" functions written back in Linus's days to access it
without having to pass &the_index as the parameter.  Later in April
2007 when I invented the support for multiple in-core index, we kept
the traditional "works on the default instance" API in place but
made them thin wrappers to the "works on the given instance", i.e. a
set of "index" functions that was introduced at da94faf6 (Merge
branch 'jc/the-index', 2007-04-24).  Even after that change, most
callers that work on the in-core index intract with "the_index", the
single default instance, via the "cache" functions.

An API enhancement to allow us to handle refs in multiple
repositories separately would be a very welcome move (it would get
rid of the hacky interface for_each_ref_in_submodule(), for one
thing), but even after that happens, I'd expect we would have most
callers asking to interact with "the_backend", the single default
instance.
