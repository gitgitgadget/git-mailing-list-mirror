From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] http: expand http.cookieFile as a path
Date: Fri, 29 Apr 2016 10:27:30 -0700
Message-ID: <xmqqr3doz5od.fsf@gitster.mtv.corp.google.com>
References: <20160429062357.12647-1-computersforpeace@gmail.com>
	<20160429062357.12647-2-computersforpeace@gmail.com>
	<20160429141212.GB26643@sigill.intra.peff.net>
	<xmqqziscz6ej.fsf@gitster.mtv.corp.google.com>
	<20160429171631.GA29571@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Brian Norris <computersforpeace@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 29 19:27:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awCCY-0004JN-Qm
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 19:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbcD2R1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 13:27:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64386 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751065AbcD2R1e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 13:27:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D277E15494;
	Fri, 29 Apr 2016 13:27:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3xAoHmRk1tUVEtv8Tafdzm25p4w=; b=sun/OK
	SbYfVxgAJdpn5lEMGgbOvrwNzcurCrltuEY6bNTrQwVxLaidh32HXi/QFSeG/kgj
	Rn1D6KvmnO8EUV8a1mH6XNbfMFAVEBBbX1h3SLmrTWukMqPoJI5jdL/kTZeaDXPp
	IdIRoMQyCJ937snnq5TdETV+6bl/6SqB66kgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=izwY5qnlg50PRmDouB6FdP8eSV+UxviW
	nMix/kL3ca7EiApIp0UNj7EaWRFbi+Ex95x5ej+YCXE6O5jFjv8G3AFiADDiR19/
	FGP3fz3PUWV6GQ3v4xeIMFc4C7/gZ0u8LV70t1j0/992KkWCTrfZAsp8QaZ97qce
	D+x2ao5uWts=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C90E115493;
	Fri, 29 Apr 2016 13:27:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 113FB15492;
	Fri, 29 Apr 2016 13:27:32 -0400 (EDT)
In-Reply-To: <20160429171631.GA29571@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 29 Apr 2016 13:16:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A7AE4A26-0E2F-11E6-871A-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293031>

Jeff King <peff@peff.net> writes:

> Yeah, this is what I had in mind. My only reservation would be that we
> need to make sure it is clear that this applies only to keys marked as
> taking a "pathname" type in the documentation. I'm suspect there are
> ones that are logically paths but do not currently do the expansion, but
> the wording above makes it sound like any pathname-like thing does.

Yeah, my initial draft phrased it more like how we describe boolean,
but somehow the language used there felt awkward to me.

With "A variable that take a pathname value", the users who read it
would find "ones that are logically paths but do not do the
expansion" and file a bug.  We'd resolve each of them by seeing if
the documentation says the variable does take a pathname, and adjust
either the documentation (if the value for the variable should not
be expanded but the documentation hints it might be a pathname-like
thing, clarify that it is not pathname-like at all) or the code (if
the value for the variable should be expanded but we forgot, we call
the user_path() function).

> Alternatively, it might be worth going through the list to make sure all
> paths use git_config_pathname() internally.

I was hoping that with the patch we can farm out the bug-hunting
process to the end users.

> Brian asked earlier if the "no expansion" was an intentional
> policy, but it's not. It's just that pathname expansion came much
> later, and config keys were ported over to it one by one as people
> found it useful to do so.

Yes, that matches the actual order of events.
