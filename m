From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2016, #02; Mon, 11)
Date: Wed, 13 Jan 2016 15:44:29 -0800
Message-ID: <xmqqpox5kpsy.fsf@gitster.mtv.corp.google.com>
References: <xmqqlh7vvfxc.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601120939270.2964@virtualbox>
	<xmqqtwmitz2a.fsf@gitster.mtv.corp.google.com>
	<20160112214909.GD2841@sigill.intra.peff.net>
	<xmqqtwmhkrj2.fsf@gitster.mtv.corp.google.com>
	<20160113232255.GA17937@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 14 00:44:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJV5n-0007Ff-3X
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 00:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbcAMXoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 18:44:38 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753378AbcAMXoc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 18:44:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 906143C656;
	Wed, 13 Jan 2016 18:44:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ObVH76rg4+zUL0VwzI9rlHjeAj0=; b=omNIdD
	g8YSUFw4soTVVM27rPhjQPrjvTQ3WefCOFpc+p6JEKoYO6+/TSV9QMVdiWdDbF0d
	ka/C1epbZgJckC3TROcbgHSuKlmYh22hdotIklLMsVHHb1KuB8gp7yIjwwKNiy0e
	+ANyITy5z916e5yhvwQKyL2CD4wijTmx14ARQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ep4VKsnpMRYl3vRafkTBliNHGbJ7EyCO
	33hMGAX7d6sAVIiKb02S9kPNtPEbmRfn6iWv3+HQrh9EI4eLeHrnQCygALKssloD
	RQ1tphDvjN0TA9HPh7QiDHjbQASG0beWzJ8eZyVPS5KTFLywnm9wQdKLMBH1tN+B
	P3WLHWbpylY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7B58E3C655;
	Wed, 13 Jan 2016 18:44:31 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E08F33C654;
	Wed, 13 Jan 2016 18:44:30 -0500 (EST)
In-Reply-To: <20160113232255.GA17937@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 13 Jan 2016 18:22:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 975E1BDA-BA4F-11E5-A54C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283997>

Jeff King <peff@peff.net> writes:

> I think you'll end up with some of the callers being a bit uglier. I.e.,
> where we say:
>
>   strbuf_getline(&buf, in, delim);
>
> and "delim" is set elsewhere. These will become:
>
>   if (delim == '\n') /* or maybe even "if (nul_terminate)" */
> 	strbuf_getline_lf(&buf, in);
>   else
> 	strbuf_getline_nul(&buf, in);

My plan is to use a function pointer to switch between them.  A code
like the above in practice look more like

(1) there is a config/option parser that sets line_terminator that
    is typically a file-scope global.

	if (z_option)
        	line_terminator = '\0';
	else
        	line_terminator = '\n';

(2) the callsite calls getline with it

	strbuf_getline(..., line_terminator);

So we can introduce a file-scope global, (*getline_fn)(), and then
tweak (1) by removing line_terminator and replacing the assignment
with an assignment to getline_fn.
