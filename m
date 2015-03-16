From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC][GSoC] make "git diff --no-index $directory $file" DWIM better.
Date: Mon, 16 Mar 2015 12:20:24 -0700
Message-ID: <xmqq3854rbpj.fsf@gitster.dls.corp.google.com>
References: <CAHLaBN+93mp6PQmtfjOHSvfW7iwDXwPitGQ5W1am9KBm9EZV2Q@mail.gmail.com>
	<vpq1tkq5fsw.fsf@anie.imag.fr>
	<xmqqr3spsir2.fsf@gitster.dls.corp.google.com>
	<CAHLaBNJxRx9jkNHCM+djq7KEZBV2n5PFZN0-UUtzhO=ikR+Kuw@mail.gmail.com>
	<xmqq61a0sw48.fsf@gitster.dls.corp.google.com>
	<CAHLaBN+FZ5LLwU-6VnFoPva=omtPpCEPzmdvY_3H43dag8kqxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Yurii Shevtsov <ungetch@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 20:20:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXaZE-0006Lh-UA
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 20:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934629AbbCPTUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 15:20:42 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53681 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965683AbbCPTUj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 15:20:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A96264040C;
	Mon, 16 Mar 2015 15:20:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YCckVQp55/i0M2TtRfD0M+od5eI=; b=kUpHk9
	xogpDnpKRyFW0Pzuf9N5/lA2nk2aIfxQWbsI+xOPYp1H2dbRmtf3Ic2vVz+dmJOB
	Po4cWG0/musIofJ95Eq4MVWsEJsJrX6TvZwfgIXAz+hN3ZKuQKBnUZbEsMrXp3EV
	lh5aEcUN6GBgcSvVJr2mPnVpNwstSmY7RGz9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZlSAJ8J5yAjsKWtxZqgrR6AXwO+5rH+2
	FxHhyxqQfyzNNXo45ZGEjJ+EIitTRbznBWVcqjJWRGdNOGHmP2Vv0f+GxUfEZjOn
	f73q+kyRRYcb3jwd43Bwu2rh7ItDLtfn1wtX8XhXV7P1KEkh10GBD6IWDwfg20UF
	dL2f5Yb9Zcs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 97BA74040B;
	Mon, 16 Mar 2015 15:20:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 66EA4403FB;
	Mon, 16 Mar 2015 15:20:25 -0400 (EDT)
In-Reply-To: <CAHLaBN+FZ5LLwU-6VnFoPva=omtPpCEPzmdvY_3H43dag8kqxg@mail.gmail.com>
	(Yurii Shevtsov's message of "Mon, 16 Mar 2015 19:47:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7F8C43E2-CC11-11E4-95F7-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265590>

Yurii Shevtsov <ungetch@gmail.com> writes:

> Yes, I have red what you wrote several times and tried your example.
> I'm really sorry if I sound like I just ignored it. I just got a
> little bit lost about which procedure needs patching. You're
> absolutely right, queue_diff() is wrong place for it. So do you agree
> that "append the name of the file at the end of the directory" logic
> should be put to diff_no_index() which will also include calling
> get_mode() for each path[] member? Sorry again for asking so much
> questions

Questions are to be asked; no need to apologize.

I think that the "if asked to compare D and F, pretend as if asked
to compare D/F and F" and friends (meaning, "if asked to compare F
and D, compare F and D/F" needs to be handled the same way, and also
it needs to handle the case where "D/F" does *not* exist) logic can
be added to diff_no_index() just before it calls queue_diff().

"If one is directory but not the other, return an error" code may
need to be fixed but I think that would be a larger change than a
few hours work (which I understand is the size GSoC Micro aims for).
