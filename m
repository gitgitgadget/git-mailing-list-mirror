From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH, WAS: "weird diff output?" 2/2] xdiff: implement empty line chunk heuristic
Date: Fri, 15 Apr 2016 13:06:29 -0700
Message-ID: <xmqq8u0ebpru.fsf@gitster.mtv.corp.google.com>
References: <20160415165141.4712-1-jacob.e.keller@intel.com>
	<20160415165141.4712-3-jacob.e.keller@intel.com>
	<CAGZ79ka7h25=rHun_hPv1qjqeghXt1UwUU3Q6xT0aj4+OW87fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 22:06:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arA0j-0000dO-Fj
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 22:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbcDOUGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 16:06:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63243 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750899AbcDOUGc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 16:06:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C9BD713036;
	Fri, 15 Apr 2016 16:06:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MhfqJwnMLNSlS5TRkE2Vmgdh8Hg=; b=MjsvpB
	PK6Vof8/+nyxpmezbFQzoF5x8pyH6BlhvXk0Sj3LIZ9HWvGPvOXmbQIv4CxyKWun
	zJk9CE6jjIje3NfnMdfdRIPKU5xwvJyeoTrrXNxWDiPLmRfT4FIdufW9KwKJMSn4
	KUyVGFpAtUNXGYO4PWPa3HigIgZaYle1l95cQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=alQwTXLkG/+/sMk7+/v+bA9qv2aF21za
	xvvV7dYR70u2Fh6vXc+I2/wswGrpEV5DXQOFID3H+JISuujgLv5CbQiJrETy5hcX
	6fRPx+ASoq5ZAdpfj9Zw1WVJwnbInv5lFGjMk7frfKl4m6L8WOxcj3QGGkgk7dWK
	remLcN3O/8g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C247213035;
	Fri, 15 Apr 2016 16:06:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 258A813034;
	Fri, 15 Apr 2016 16:06:30 -0400 (EDT)
In-Reply-To: <CAGZ79ka7h25=rHun_hPv1qjqeghXt1UwUU3Q6xT0aj4+OW87fg@mail.gmail.com>
	(Stefan Beller's message of "Fri, 15 Apr 2016 12:57:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8B1368E6-0345-11E6-8A58-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291651>

Stefan Beller <sbeller@google.com> writes:

>> +diff.emptyLineHeuristic::
>
> I was looking at the TODO here and thought about the name:
> It should not encode the `emptyLine` into the config option as
> it is only one of many heuristics.
>
> It should be something like `diff.heuristic=lastEmptyLine`
> The we could add firstEmptyLine, aggressiveUp, aggressiveDown,
> breakAtShortestLineLength or other styles as well later on.
>
> I do not quite understand the difference between diff.algorithm
> and the newly proposed heuristic as the heuristic is part of
> the algorithm? So I guess we'd need to have some documentation
> saying how these differ. (fundamental algorithm vs last minute
> style fixup?)

I actually do not think these knobs should exist when the code is
mature enough to be shipped to the end users.

Use "diff.compactionHeuristics = <uint>" as an opaque set of bits to
help the developers while they compare notes and reach consensus on
a single tweak that they can agree on being good enough, and then
remove that variable before the code hits 'next'.

Thanks.
