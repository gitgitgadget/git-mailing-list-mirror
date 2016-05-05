From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v16 0/7] config commit verbose
Date: Thu, 05 May 2016 12:21:53 -0700
Message-ID: <xmqq7ff8b99q.fsf@gitster.mtv.corp.google.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
	<1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: sunshine@sunshineco.com, szeder@ira.uka.de, git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 21:22:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayOqX-0003A6-2O
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 21:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755500AbcEETV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 15:21:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57038 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754293AbcEETV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 15:21:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2AAE719301;
	Thu,  5 May 2016 15:21:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1G1EsQhMgttbsyTqzwX4QJCztNw=; b=qk6DZZ
	XIhyfMzef67I1j964wo8vJBdju11UEOY25t2tLzQgxP9YBtL66pgMA9G2UDjX2K2
	2QnOHKnloebDxCkLqO1oT0TNis5QQKETMGg7+LloNXd9QP1yaIFmJHWP64m2AwZr
	prKuR5ziaN/wtPWSyyX589qstchEgE96n3504=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gWwiJ2+5M3Z2RaHguL9xs2E2B1+LIn/K
	bxTrV2UPXmZVYNL03LOyAe+GIig1URWH6uxbkafeICrWOQiClI6K+BWz1YK77MvU
	16uzfM1RRe3LuTWs8pn5owlbrDHQclljO9KEsJCP7zq1fPndPtM9MH8HiMvXMTgo
	QsL/nVRpi+o=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2063E19300;
	Thu,  5 May 2016 15:21:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 92B5C192FE;
	Thu,  5 May 2016 15:21:54 -0400 (EDT)
In-Reply-To: <1462441802-4768-1-git-send-email-pranit.bauva@gmail.com> (Pranit
	Bauva's message of "Thu, 5 May 2016 15:19:55 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A08C2C2E-12F6-11E6-A5E0-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293666>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> This series of patches add a configuration variable for verbose in
> git-commit.
>
> Link to v15:
> http://thread.gmane.org/gmane.comp.version-control.git/293127
>
> Changes wrt v15:
>  * Remove the previous patch 7/7 and split the tests. Include one in
>    initial patch 6/7. The other one is introduced in a separate commit
>    after 4/7.
>  * Include tests in patch 3/6 for --no-quiet without -q, multiple verbose,
>    --no-verbose with -v as suggested by Eric Sunshine

Thanks for a pleasant read.  Modulo minor readability nits I sent
separately on 7/7, this looked good.

A tangent that we may want to think about after this series lands
and dust settles is to make test-parse-options simpler to use.  I
see many instances of this repeated:

        cat >expect <<\EOF
        boolean: 0
        integer: 0
        magnitude: 0
        timestamp: 0
        string: (not set)
        abbrev: 7
        verbose: 0
        quiet: 3
        dry run: no
        file: (not set)
        EOF

        test_expect_success 'multiple quiet levels' '
                test-parse-options -q -q -q >output 2>output.err &&
                test_must_be_empty output.err &&
                test_cmp expect output
        '

But the only thing this test cares about is if "quiet: 3" is in the
output.  I think we should be able to write the above 18 lines with
just four lines, like this:

	test_expect_success 'multiple quiet levels' '
		test-parse-options --expect="quiet: 3" -q -q -q
	'

There may be a handful of tests that care about more than one
variable, and the current output format must be used when the
new --expect option is not given, but I suspect that the majority of
tests would want the concise form.
