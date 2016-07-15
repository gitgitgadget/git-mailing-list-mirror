Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 438AC20195
	for <e@80x24.org>; Fri, 15 Jul 2016 17:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbcGORC0 (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 13:02:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751607AbcGORCY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jul 2016 13:02:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DB2802C2C4;
	Fri, 15 Jul 2016 13:02:22 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xeC33tqVAMLM
	lnFUFs/zpUGLIus=; b=uDcgYwurmcA2jQBu7HG9b4i1KAlDqfV5SHx1yATTmC1q
	gs9wv31BMaWRbQ07jbefp87MOs8rQ1vCErsgkxYKgTGEDUiOq9R1fkikYNqvlJ6w
	JOmEoOVNjwEeqRjjgPShXDmiXlKxytpadvZzbkMAIoYR1h0L6IQJYpYVDNTX66k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=o5BFxj
	aDF9JAW6degXeYKjbIN9PX7RrXIyvFF4/c7t0PzNpHFsu+e6yMhQ0Tx4WG/xr+S9
	pX/iqld1ZE8t7IN+jJ83z9s4YR5R0KX4fDNGD5b+KlduvWnKFdMOuus8DF17PjaJ
	d80H9K/79L8a7ZPeZYmK4Knxir8kM9b0b2h40=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D2D132C2C3;
	Fri, 15 Jul 2016 13:02:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 58C622C2C2;
	Fri, 15 Jul 2016 13:02:22 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Andrew Keller <andrew.keller@covenanteyes.com>
Cc:	Git List <git@vger.kernel.org>
Subject: Re: obsolete index in wt_status_print after pre-commit hook runs
References: <5988D847-25A2-4997-9601-083772689879@covenanteyes.com>
Date:	Fri, 15 Jul 2016 10:02:20 -0700
In-Reply-To: <5988D847-25A2-4997-9601-083772689879@covenanteyes.com> (Andrew
	Keller's message of "Fri, 15 Jul 2016 16:34:19 +0000")
Message-ID: <xmqq1t2uomw3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E5A1C4D8-4AAD-11E6-9E91-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Andrew Keller <andrew.keller@covenanteyes.com> writes:

> I have observed an interesting scenario.  Here are example reproduction steps:
>
> 1. new repository
> 2. create new pre-commit hook that invokes `git mv one two`
> 3. touch one
> 4. git add one
> 5. git commit
>
> Expected outcome: In the commit message template, I expect to see
> “Changes to be committed: new file: two"

Expected outcome is an error saying "do not modify the index inside
pre-commit hook", and a rejection.  It was meant as a verification
mechansim (hence it can be bypassed with --no-verify), not as a way
to make changes that the user didn't tell "git commit" to make.

It is just the implementation that dates back to the old days were
too trusting that all users would behave (with its own definition of
"behaving well", which may or may not match your expectation), did
not anticipate that people would try to muck with the contents being
commited in the hook, and did not implement such verification.


