From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config settings
Date: Thu, 28 Apr 2016 12:41:42 -0700
Message-ID: <xmqqshy54j2h.fsf@gitster.mtv.corp.google.com>
References: <3b71deffa5d07cf73a793773cc3d60ff611843fa.1461759454.git.johannes.schindelin@gmx.de>
	<cover.1461837783.git.johannes.schindelin@gmx.de>
	<89d0024450b0e6e9997ad9e3d681248bde1bafc0.1461837783.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 28 21:41:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avrow-0005Ej-A3
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 21:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692AbcD1Tlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 15:41:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53522 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751539AbcD1Tlp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 15:41:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DFCA1531B;
	Thu, 28 Apr 2016 15:41:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G4r/yaxyEntBGRltismNizLK9wQ=; b=YpRHJK
	VnoD5cvMsMLojekNqWyrYvHVq5TzpHtW21cUTL1nsNT7ejSBmg/telKa1/FsCT0I
	Nouy8k7Ff2YL/CHoEzUbNrccbLUGu2J7tTsDWOWnD+qjWwph0PdDiLVAIcu0++2S
	za3nHAaKf3RHiYePmsjo2nWtRFYKtQXG35uEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ms17pybpqeh5ScWQYO5Ea/KioMaV2gzr
	dH5DKdCB+Apw7AO9MVAIxFfAwylXGvexb5EvyGO0Z4fcRl9MloJVCD4B3ewON2Vr
	YU09ZT+SK/vT67BehfiXNnPrXoWu28ST3smIE1KHRViK1N0DMFyzLZdMay6QJJTW
	1vRZqUVfzs8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7661615319;
	Thu, 28 Apr 2016 15:41:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D730115318;
	Thu, 28 Apr 2016 15:41:43 -0400 (EDT)
In-Reply-To: <89d0024450b0e6e9997ad9e3d681248bde1bafc0.1461837783.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Thu, 28 Apr 2016 12:03:47 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3C8500CA-0D79-11E6-BEA6-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292941>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> -     if (starts_with(var, "credential."))
> +     if (starts_with(var, "credential.") ||
> +                     (starts_with(var, "http.") &&
> +                      ends_with(var, ".extraheader")))

I know you are fond of indenting with HT without aligning things,
but this is going too far in the quest of making the code
unreadable.

        if (starts_with(var, "credential.") ||
            (starts_with(var, "http.") && ends_with(var, ".extraheader")))

would make iteasier to see what are the top-level items (there are two)
and how they are related (just one of them needs to be satisfied).

Assuming that we will discover more variables that can be safely
passed, I'd rather see the above written like this, though:

        if (starts_with(var, "credential."))
                return 1;
        if (starts_with(var, "http.") && ends_with(var, ".extraheader"))
                return 1;

        return 0;

Or even something along this line:

        struct whitelist {
                const char *prefix;
                const char *suffix;
        } whitelist[] = {
                { "credential.", NULL },
                { "http.", ".extraheader" },
        };

        for (i = 0; i < ARRAY_SIZE(whitelist); i++) {
                struct whitelist *w = &whitelist[i];
                if ((!w->prefix || starts_with(var, w->prefix)) &&
                    (!w->suffix || ends_with(var, w->suffix)))
                        return 1;
        }
        return 0;
