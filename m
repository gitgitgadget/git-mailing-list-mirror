From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] Add default merge options for all branches
Date: Fri, 06 May 2011 15:01:06 -0700
Message-ID: <7vsjsrxzdp.fsf@alter.siamese.dyndns.org>
References: <20110503090351.GA27862@elie> <4DC1CE16.5030808@dailyvoid.com>
 <7vsjsuc704.fsf@alter.siamese.dyndns.org> <20110506213257.GD20182@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Grubb <devel@dailyvoid.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 07 00:01:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIT5N-0004oO-Ei
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 00:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417Ab1EFWBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 18:01:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61597 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376Ab1EFWBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 18:01:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 27FAB5F70;
	Fri,  6 May 2011 18:03:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HEwcEBNCnYx80pe8WSB/PqivnJU=; b=WegrrB
	H6cVvZ4kW0xaKMLY5sqpPbCYaKwYeq5XpE4jYpSN6KZKlmNrYdF8jxZa5Ik7+7hU
	FUHUopw/Z3WHkhuyRKZMzy3RRLg6m3ch4nkhUUSWhlLALldpeWeD3YkRHkJcKkXT
	xZTMO6S9zyTV/3UN+j8sBDk2Xye/IO1o7M7DU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cqGqApTc4pGjE4/KLGUBrWDZTKuaTVOm
	KtfbflNFBKdOHI6AQtMYJA4tyrgsaCv59nJcb5BopdO/UBKYVcHuThxjKLzpoXax
	uOCFUcoyn58fUkzWCcrmXQ0zsJzv3fONC5oJEL+BPxcrb8hAwQn6KS1lhW6d6Tng
	CA9eiKg8e+M=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E700E5F6E;
	Fri,  6 May 2011 18:03:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BE3F45F6D; Fri,  6 May 2011
 18:03:11 -0400 (EDT)
In-Reply-To: <20110506213257.GD20182@elie> (Jonathan Nieder's message of
 "Fri, 6 May 2011 16:32:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4B9BBFA-782C-11E0-965B-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173018>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> +static void parse_branch_merge_options(char *bmo)
>> +{
>> +	const char **argv;
>> +	int argc;
>> +	char *buf;
>> +
>> +	if (!bmo)
>> +		return;
>> +	argc = split_cmdline(bmo, &argv);
>> +	if (argc < 0)
>> +		die("Bad branch.%s.mergeoptions string", branch);
>> +	argv = xrealloc(argv, sizeof(*argv) * (argc + 2));
>> +	memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
>
> This is not new code, but it might make sense to do
>
> 	argv[0] = "merge.*.options";
>
> for a saner error message when someone tries
>
> 	[branch "master"]
> 		mergeoptions = --nonsense

Yes, either we stuff a fixed string "branch.*.mergeoptions" to argv[0], or
use another static to recall which variable gave us that value and use
it.  The former is of course easier and less nicer.

>> +	argc++;
>> +	parse_options(argc, argv, NULL, builtin_merge_options,
>> +		      builtin_merge_usage, 0);
>> +	free(buf);
>
> [*]
> This buf seems to be left over.  (I don't think the intent is to
> call free on an uninitialized pointer. ;-))

I also forgot to free argv[].
