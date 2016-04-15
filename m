From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH, WAS: "weird diff output?" 2/2] xdiff: implement empty line chunk heuristic
Date: Fri, 15 Apr 2016 13:30:14 -0700
Message-ID: <xmqqzisuaa3t.fsf@gitster.mtv.corp.google.com>
References: <20160415165141.4712-1-jacob.e.keller@intel.com>
	<20160415165141.4712-3-jacob.e.keller@intel.com>
	<CAGZ79ka7h25=rHun_hPv1qjqeghXt1UwUU3Q6xT0aj4+OW87fg@mail.gmail.com>
	<xmqq8u0ebpru.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xoWbrSaONH5xq=w5W190Jknk0Qsc5brS4UKFAs2_dTceg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 22:30:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arANp-0005ma-1l
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 22:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbcDOUaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 16:30:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50881 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751069AbcDOUaR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 16:30:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 082D813660;
	Fri, 15 Apr 2016 16:30:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WTXt89UUisuArZPois67V1jswDI=; b=sHcKHK
	zHr+q4oYtRSJEXe8ZjsYoPverh9pTHqPi6an3Eog+L5RA7qTzmddIIuFfUmeptOU
	Gb+GiE/JDoZxUpSXp8HR8cyTJyaYd8VnRfZtGYiYMuPuFW2GMm/0z/LWQgap4g5D
	228r8aOKHW4xDRbQ9+fIU1XqVs4c35C8YMuTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ET0AHSwTqWAeI/2eH4+TvdlVfElalpRD
	cNVct9ibv0ytZtDTFZo7LQDphggXO2VAUeGQFS5Qy0GhJcY0yqWVuvdVbcoNVQen
	HG9p3JCTB8zzE8MAAx4qL0i7D61cIUAq5y4Rd1+nLzWsz9+4ZbtSalZeWiQ26Ty8
	RBzkKmSsqiY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F2F6D1365F;
	Fri, 15 Apr 2016 16:30:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4677A1365E;
	Fri, 15 Apr 2016 16:30:15 -0400 (EDT)
In-Reply-To: <CA+P7+xoWbrSaONH5xq=w5W190Jknk0Qsc5brS4UKFAs2_dTceg@mail.gmail.com>
	(Jacob Keller's message of "Fri, 15 Apr 2016 13:17:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DC84C550-0348-11E6-A87C-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291658>

Jacob Keller <jacob.keller@gmail.com> writes:

> On Fri, Apr 15, 2016 at 1:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> I actually do not think these knobs should exist when the code is
>> mature enough to be shipped to the end users.
>>
>> Use "diff.compactionHeuristics = <uint>" as an opaque set of bits to
>> help the developers while they compare notes and reach consensus on
>> a single tweak that they can agree on being good enough, and then
>> remove that variable before the code hits 'next'.
>>
>> Thanks.
>
> I was under the impression that we would want a longer lived
> configuration until we had enough data to say whether it was
> helpful to make it default. I guess i had thought it would need to
> be longer lived since there may be cases where it's not optimal
> and being able to turn it off would be good?

Once you start worrying about "some cases this may misbehave", a
configuration variable is a wrong mechanism to do so anyway.  You
would need to tie this to attributes, so the users can say "use this
heuristics for my C code, but do not apply it for my AsciiDoc
input", etc.

What you have is a pure developer support; aim to come up with "good
enough" way, giving developers an easier way to experiment with, and
remove it before the feature is shipped to the end user.
