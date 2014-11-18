From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce a hook to run after formatting patches
Date: Tue, 18 Nov 2014 09:02:59 -0800
Message-ID: <xmqqoas4wif0.fsf@gitster.dls.corp.google.com>
References: <1416012460-4459-1-git-send-email-sbeller@google.com>
	<xmqqzjbryonp.fsf@gitster.dls.corp.google.com>
	<xmqqlhn9y7dn.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZ=1qekoKfY5cwdmDp68oU-poTcc6A4Fa7u5LhwCB5HyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 18:03:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqmBR-0006Hb-5m
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 18:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754279AbaKRRDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 12:03:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64275 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754273AbaKRRDK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 12:03:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 196A51D4DC;
	Tue, 18 Nov 2014 12:03:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MQ9c7+bfobBwqOTSvQECTbD9zDY=; b=rL5y38
	EYVq/wkyDa4taCC1uhxORucM2tWlLME0GfrjGXUFWGZJlTXY5oy1zTtU9L53c383
	bEEZ0dlUsxSFmX4bLqT1bcO8fVl8ntfGjk3FcoWXQGH+/G1evx3ZOKXu7BNxUUZ3
	+Jie9rzxmz0f7DM/+beF+4ILb6KhGqlZ0ZnMo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mhi8pnYKA2YYpZV+PIenhNwmyvS38uqo
	CRTIAnJae8BaQB4GDtI0FkQosVACFoyHgeNKR1PtTlLzkQf23UhMTELw4NZgNgyi
	/lqBx/sU4krRuEUdHypOmC20c/jMLco/z5UHqBAWAqntYB/Ib5hvWlSifb3udSsb
	dR/FK+SzyWA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 013181D4DB;
	Tue, 18 Nov 2014 12:03:05 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3C5361D4D7;
	Tue, 18 Nov 2014 12:03:03 -0500 (EST)
In-Reply-To: <CAGZ79kZ=1qekoKfY5cwdmDp68oU-poTcc6A4Fa7u5LhwCB5HyQ@mail.gmail.com>
	(Stefan Beller's message of "Mon, 17 Nov 2014 18:30:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C214AF30-6F44-11E4-BBD2-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Do we have similar filters somewhere in place already,
> so I could have a look at the code architecture,
> the api, and how the user would operate that?

The clean/smudge filters interacts with the payload data and the end
user configuration in a similar way, I would say.

> The way you're proposing, doesn't sound as if a hook would be the right
> thing for such filtering.

That depends on how you define "what a hook is", I think.

> The one big thing I liked over the first patch in this thread was
> the 'maintainability', i.e. if it were a hook, I could set that up
> and forget about it.  No need to change my behavior in using git,
> but still I have the desired postprocessed results.

In the message you are responding, I said "detect a request to use",
exactly because I wanted to leave it up to you to design what
form(s) that "request detection" takes.  One of the forms could be
"a script with this $filename exists in $GIT_DIR/", and the $filname
may be "hooks/format-patch-redaction-filter".

Of course, any "configured into repository" solution must have a
command line override, so the order you would develop this would be:

 (0) make the code that interracts with the filter if given by the
     user work, without worrying about how the user specifies the
     filter.

 (1) add a --command-line-option=<filter-name> to trigger the code
     you wrote in (0) above.

 (2) add a --no-command-line-option to defeat the configured filter,
     without worrying about how the user configures.  For your new
     command line option --frotz, "git cmd --frotz --no-frotz"
     should make your cmd refrain from doing frotz.

 (3) add configuration variable to point at a filter script,
     e.g. "format.redactionFilter"; you must make sure that this is
     disabled with "--no-*" you added in (2) above;

 (4) perhaps add support for "hooks/format-patch-redaction-filter",
     if you strongly feel like it.  The user must be able to disable
     this with the same "--no-*" added in (2).

I'd say (4) is optional; by the time you reach (3), you already have
the same "write once and forget" capability.
