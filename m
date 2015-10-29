From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/8] Expose the submodule parallelism to the user
Date: Thu, 29 Oct 2015 10:23:48 -0700
Message-ID: <xmqqh9l9si57.fsf@gitster.mtv.corp.google.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
	<1446074504-6014-1-git-send-email-sbeller@google.com>
	<56321CF4.60807@ramsayjones.plus.com>
	<CAGZ79kYXrOFDqs5c-OYG2vRO9GY_aoD_GU1=TkRtOMaGC_GowA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 18:23:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zrqvc-0007gR-Ce
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 18:23:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757678AbbJ2RXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 13:23:52 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56125 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756230AbbJ2RXv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 13:23:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 833D922FC5;
	Thu, 29 Oct 2015 13:23:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RRWgU7Xd6Uga2FJh/iWu1g5x+Bs=; b=SbYATz
	oY9036ITIeBKMzG6/91BXQAlZy2JHVTBSYJQ+b5Msd5osnh4SFNpb7qLaSKeHYv8
	+P4dXkAFmr7kgCHVBAp4knnaj98P4n1LSLhFKhPk8ISzx550RK4zJe1S6tMrqrcL
	kGjdJmbT/MAU7Fn8q3nt5XxgQIuXiZk3Hqgr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SQ+fIM0BKdXhgxkcYmJgvC2akHBgmVks
	3RJ0XPfRPoqsQ9ix6BFqA20vU+pgIU+8g3ZlhRnuz2y6kbIW8OQmbFRQsIXfd3L2
	pwpP0jfA3Q/pSO+J0l0oSyxeKKHMpBTpm/7KoQfJlFjaAHhC+6fjUB8FEw0/qvdV
	DcolGw9hddI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 78FED22FC4;
	Thu, 29 Oct 2015 13:23:50 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DCAB322FC3;
	Thu, 29 Oct 2015 13:23:49 -0400 (EDT)
In-Reply-To: <CAGZ79kYXrOFDqs5c-OYG2vRO9GY_aoD_GU1=TkRtOMaGC_GowA@mail.gmail.com>
	(Stefan Beller's message of "Thu, 29 Oct 2015 08:51:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D1B44248-7E61-11E5-8BB6-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280447>

Stefan Beller <sbeller@google.com> writes:

> On Thu, Oct 29, 2015 at 6:19 AM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>
>> Hmm, is there a way to _not_ fetch in parallel (override the
>> config) from the command line for a given command?
>>
>> ATB,
>> Ramsay Jones
>
> git config submodule.jobs 42
> git <foo> --jobs 1 # should run just one task, despite having 42 configured
>
> It does use the parallel processing machinery though, but with a maximum of
> one subcommand being spawned. Is that what you're asking?

With this patch, do we still keep a separate machinery that bypasses
the parallel thing altogether in the first place?

I was hoping that the underlying parallel machinery is polished
enough that using it with max=1 parallelism would be equivalent to
serial execution.  At least, that was my understanding of our goal,
and back when we reviewed the previous "fetch --recurse-sub" series,
my impression was we were already there.

And in that ideal endgame world, your "Give '-j1' from the command
line" would be perfectly an acceptable answer ;-).

Thanks.
 
