Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 397AF1FEAA
	for <e@80x24.org>; Thu, 23 Jun 2016 06:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbcFWGcT (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 02:32:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53143 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751000AbcFWGcT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 02:32:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 24624248F5;
	Thu, 23 Jun 2016 02:32:18 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gYHSYP3kgcgVRa2CpqPWDJmemP8=; b=l0J/QR
	nR28c2EQnLaXfZfa3GXbMg3dlDtf0VfGivLiM9ED789JSx1mzYyQFMAZRXl1cntH
	EEmfEFxmah9JSyylmICopvUPxLCwC9zJZZgv7IjD7C0I5FTY0fzbU74gsdV4Ypqg
	orN2U87/UwNnQqNAO/MHC50Lpzo+UCr19u0CQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nLy+kBKlMMdM/gOa8N+TRWEK9G/H3pcE
	Ps3Sy318PmSZ0sILSXBk4kmFoBT8FaF/sQC0NAbwH3jG6ZJUXaiPLw9RZHJEl5k/
	kjCT+x/CA3QeugWRznzY9Ch+m2sVaFulCCFmikn2Mee9fp8T+jLmgdOf1Kajo0Ug
	QRA1sfX3Alk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D116248F3;
	Thu, 23 Jun 2016 02:32:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 95448248F2;
	Thu, 23 Jun 2016 02:32:17 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Mehul Jain <mehul.jain2029@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/3] Introduce log.showSignature config variable
References: <20160622165126.12786-1-mehul.jain2029@gmail.com>
	<xmqqr3bpklsd.fsf@gitster.mtv.corp.google.com>
	<CA+DCAeQUJ4D4kjR6FtTibwPO8o+wv-hQNDDj2ysJaBHGTPkHgA@mail.gmail.com>
Date:	Wed, 22 Jun 2016 23:32:15 -0700
In-Reply-To: <CA+DCAeQUJ4D4kjR6FtTibwPO8o+wv-hQNDDj2ysJaBHGTPkHgA@mail.gmail.com>
	(Mehul Jain's message of "Thu, 23 Jun 2016 11:14:27 +0530")
Message-ID: <xmqqd1n8jtzk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B279486-390C-11E6-A4C3-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Mehul Jain <mehul.jain2029@gmail.com> writes:

> In patch 2/3 and 3/3, there are many tests which requires a branch
> similar to that of "signed" branch, i.e. a branch with a commit having
> GPG signature. So previously in v2, I created two new branches,
> "test_sign" and "no_sign", which are identical to that of "signed"
> branch. And with these branches, I wrote the tests in patch 2/3
> and 3/3.
>
> As suggested by Eric [1], rather than creating new branches, I
> can take advantage of "signed" branch which already exists.

Yeah, I understand that part.  But you do not _need_ to do the split
you do in 1/3 in order to reuse "signed".

The first 'log --graph --signature' test may fail, but it is not
like that the test without 1/3 removes the "signed" branch when
"log" command or the signature tests of its output fail, so "I
didn't want the later tests to depend on the first test being
successful" does not quite justify the split.  If "commit -S" step,
which 1/3 splits into the earlier one of the two, fails, then you
won't have a signed commit to use in the later tests, even though
you have "signed" branch.  The split of the tests done by 1/3 does
not make the tests more robust.  If the commands in the original
in the part of the first test in the original that you keep in the
first half with 1/3 fail, subsequent tests will be affected with or
without 1/3.

If 1/3 justifies the change a bit differently, it would become a
good one.

    In 2/3 and 3/3, we will use the same 'signed' branch that the
    first test for 'log --graph --show-signature' uses.  This branch
    is currently created in that 'log --graph --show-signature' test
    itself.

    Split the set-up part into a test of its own, and make the
    existing first test into a separate one that only inspects the
    history on the 'signed' branch.  That way, it would become
    clearer that later tests added by 2/3 and 3/3 reuse the 'signed'
    branch in the same way this 'log --graph --show-signature' uses
    that same branch.

Of course, you would need to keep GPG prerequisite for both halves
1/3 creates.

Thanks.
