From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] completion: Handle '!f() { ... }; f' aliases
Date: Mon, 09 Jun 2014 22:27:36 -0700
Message-ID: <xmqq1tuxcp13.fsf@gitster.dls.corp.google.com>
References: <CAPig+cQKtVoc7X2SBE8L1pSpnwQxkmFF6pL2PL-7RUoFq5h8gw@mail.gmail.com>
	<1402318493-29943-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Jun 10 07:27:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuEb5-00054V-AM
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 07:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755043AbaFJF1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 01:27:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62226 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbaFJF1m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 01:27:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B03051FD79;
	Tue, 10 Jun 2014 01:27:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3UcIxxMKC9nMVql/FLTtn3NXm3M=; b=b2xp00
	o9U7pOUDtlvJG0BKPzdE1y/vYUcfN0SHBWogLFnXBJGuhGTnVZFTEfKsUs8KcKa+
	8V5xTETh+c5oV/PQRykTNM1YbOfXZ4LcxhLiVQuWfQOqUdDuGGbQJUDlQ5pK+h0H
	EHoEDTaiWAj+6R8t/vO9VMcnHlpCa917uqg58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KS90nb9gQ6r/y5gesxWwyEN2Ky2FQfd1
	SSltBi9vScGHzmjgG8otM8M4RUchAIeSaIUsKHdNDwcr/wnhSFzVRS2q98Y9TxTx
	cQZUlhAi+3QXfJ7MaQQ3FVMMC+D+Gc2gHg7VRhyb9qjOL5QmYQRA2SG+3nqYtJEk
	U0Z0TjZmRcE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A6A541FD78;
	Tue, 10 Jun 2014 01:27:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A95201FD75;
	Tue, 10 Jun 2014 01:27:37 -0400 (EDT)
In-Reply-To: <1402318493-29943-1-git-send-email-prohaska@zib.de> (Steffen
	Prohaska's message of "Mon, 9 Jun 2014 14:54:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EF3522B0-F05F-11E3-A4C1-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251159>

Steffen Prohaska <prohaska@zib.de> writes:

> '!f() { ... }; f' is a recommended pattern to declare more complex
> aliases (see git wiki [1]).  This commit teaches the completion to
> handle them.

Hmm, I've never endorsed nor recommended such a notation myself ;-)
I tend to prefer writing it like so instead:

    sh -c '...' -

so that I won't clobber "f" (or any other name).  I wonder if you
can help users of this other pattern as well.

> When determining which completion to use for an alias, the opening brace
> is now ignored in order to continue the search for a git command inside
> the function body.  For example, the alias '!f() { git commit ... }' now
> triggers commit completion.

I suspect that "scanning" is error-prone.  I like this one for its
cuteness very much, though:

> Furthermore, the null command ':' is now skipped, so that it can be used
> as a workaround to declare the desired completion style.  For example,
> the alias '!f() { : git commit ; if ...  ' now triggers commit
> completion.



> +test_expect_success 'completion uses <cmd> completion for alias !f() { VAR=val git <cmd> ... }' '
> +	test_config alias.co "!f() { VAR=val git checkout ... ; } f" &&

Is it only "f" that is completed, or can I spell it using another
arbitrary token, e.g.

	test_config alias.co "!co () { git checkout ... } co"
