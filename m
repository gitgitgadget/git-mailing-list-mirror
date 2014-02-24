From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote: handle pushremote config in any order order
Date: Mon, 24 Feb 2014 12:32:32 -0800
Message-ID: <xmqq7g8k8d5r.fsf@gitster.dls.corp.google.com>
References: <CAMYxyaUwPXXdvGv786_p5n7-biMLOFbur-gQ1pxXOttc0R0=eg@mail.gmail.com>
	<20140224085903.GA10698@sigill.intra.peff.net>
	<xmqqvbw49z0f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jack Nagel <jacknagel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 24 21:32:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI2Cg-0001Oq-45
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 21:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816AbaBXUch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 15:32:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56616 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752655AbaBXUcg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 15:32:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94B326E96D;
	Mon, 24 Feb 2014 15:32:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=wCHl68jT2MgCoyHznC/bTJJ4Ztw=; b=mLFqQwLV7YEwZpFHAEMt
	xSFAiPOwXsOUQvoNMEe5dqxN94fTSRCO1EKQgcHHSc5Ikg1X8qDOossCCcXCIU2k
	e7DTlvukZaK44n/ABYbBusNRN5n1dGn6pz47eHR57mXhG0wwfR2+hQZCCYGIY1vc
	5UOviW3xhIrOLrTT4WyB/00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Zzhb2w/8es/+XPB8LR4+WPruVk2PUfnwWpMrgUDNiVy74J
	0mdSIPqudOrcoTU26WxN2w9HCxswmGXRWw9NFP78NGtgu7cnXL4XNV1QdGxSJnHN
	M+/llV33vdCBxLpUnhCxwDAzmuoWpyhbVIsruLfHuqV2Vjs6PgcwO7TYd6SLc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 716AE6E967;
	Mon, 24 Feb 2014 15:32:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 965B66E964;
	Mon, 24 Feb 2014 15:32:34 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CAE80B18-9D92-11E3-B99C-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242642>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> Yes, with a few exceptions, we usually try to make the ordering in the
>> config file irrelevant. This is a bug. The patch below should fix it.
>
> Looks good.  Thanks.

>> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
>> index 926e7f6..1309c4d 100755
>> --- a/t/t5516-fetch-push.sh
>> +++ b/t/t5516-fetch-push.sh
>> @@ -536,6 +536,18 @@ test_expect_success 'push with config branch.*.pushremote' '
>>  	check_push_result down_repo $the_commit heads/master
>>  '
>>  
>> +test_expect_success 'branch.*.pushremote config order is irrelevant' '
>> +	mk_test one_repo heads/master &&
>> +	mk_test two_repo heads/master &&
>> +	test_config remote.one.url one_repo &&
>> +	test_config remote.two.url two_repo &&
>> +	test_config branch.master.pushremote two_repo &&
>> +	test_config remote.pushdefault one_repo &&
>> +	git push &&
>> +	check_push_result one_repo $the_first_commit heads/master &&
>> +	check_push_result two_repo $the_commit heads/master
>> +'
>> +

This test however does not pass in the Git 2.0 world, without having
this line:

       test_config push.default matching &&

immediately before "git push".

Am I missing something?
