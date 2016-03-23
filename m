From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] bisect--helper: convert a function in shell to C
Date: Wed, 23 Mar 2016 09:24:56 -0700
Message-ID: <xmqqtwjxcgbr.fsf@gitster.mtv.corp.google.com>
References: <010201539d57ae98-ce4860a6-f7b6-4e06-b556-3c1340cd7749-000000@eu-west-1.amazonses.com>
	<01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
	<alpine.DEB.2.20.1603231238180.4690@virtualbox>
	<CAFZEwPPDhK1biRLuXtYeBX5fsQGw==fUOLxSOXVaZPghbJQYGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 17:25:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ailai-0004sL-VZ
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 17:25:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbcCWQZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 12:25:00 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60672 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751088AbcCWQY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 12:24:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0AB334DE8C;
	Wed, 23 Mar 2016 12:24:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hrzSehBCuUmj36XSvhFCkpJM/Mc=; b=MAkq4J
	O670SedQqPQXIzJyL5/oIQNkfrahYRDe1HXPPFJ9Cvtp4X1xGAjmJZRid/XLY57q
	5xUnumml81xFQoWuC0+dPlUtL5ZZ7QoG6UNfOo9qOJ6trQNbFhVOxqcfS8jXtkf2
	1WwZnf6rzEosQtyQq+HDijz/fBlG6n3oB2nX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MvJyb8pc4G8CTlZ/FiK0B1202zALwh74
	ivfSIfJzE8kfPKfnaJlAM9sFB+Ze9eKUcNpUSDkyBagd2zG8Jr8LB/5e/7R0mChw
	8v8tin8UwOhULKvBHDkLfZM64Qvbys4JJy3fWIBYhFHorlqTcd2KwiaQoHczTZGt
	pR3GmAvMahg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 004E14DE8A;
	Wed, 23 Mar 2016 12:24:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6F3034DE89;
	Wed, 23 Mar 2016 12:24:57 -0400 (EDT)
In-Reply-To: <CAFZEwPPDhK1biRLuXtYeBX5fsQGw==fUOLxSOXVaZPghbJQYGg@mail.gmail.com>
	(Pranit Bauva's message of "Wed, 23 Mar 2016 18:46:37 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C8790392-F113-11E5-8B12-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289666>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> On Wed, Mar 23, 2016 at 5:27 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi Pranit,
>>
>> On Wed, 23 Mar 2016, Pranit Bauva wrote:
>>
>>> Convert the code literally without changing its design even though it
>>> seems that it is obscure as to the use of comparing revision to different
>>> bisect arguments which seems like a problem in shell because of the way
>>> function arguments are handled.

Are you talking about the need to do one_of("help", "start", ...)?

I do not see how that is "problem in shell" or "they way function
arguments are handled".

    git bisect bad
    git bisect good

are the ways how you mark the current commit as bad or good, and
recent change that introduced the "term" thingy allows you to
replace these "bad" and "good" with your own words, but

    git bisect start
    git bisect help

etc. have their own meaning, so you cannot say "I call bad state
'start' and good state 'help'" without confusing yourself.  You'd
never be able to start or get help if you did so, and that does not
have anything to do with "shell" or "function argument" which are
implementation detail.

You cannot fundamentally allow replacing bad/good with these
blacklisted words unless you are going to adopt different command
line syntax (e.g. instead of accepting "git bisect $bad" with a word
chosen by the end user, use "git bisect mark $bad", and $bad can be
any word including "start", "visualize", etc.).
