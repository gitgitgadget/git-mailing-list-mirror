Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D3321FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 17:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868AbcFUReJ (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 13:34:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65080 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752345AbcFUReG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 13:34:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 40D2125158;
	Tue, 21 Jun 2016 13:27:15 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fiA3fyzeR2YzrjaBEYBRJ6xWPVI=; b=i3BNZs
	qXVqAZtbr3ty2Z3nKBj8BLPguC95BSpmZS17V3OO1JFoofcBPNqNbrq3h9NSePvz
	9XK+sFWuD/6E3g/PNCrGjpYe/zUrbtWWp0czTCrTcT4OhCC6FO7PeJ7XpOqi4UaT
	mmvXaY4SFeJbdy2R+Hz19448aJs9WQHsyTtjw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B/7T1ruo3FBFYlLP1QwAiHzyv/yR0T7g
	mCJvsdZw/q6U2z7z6cA4o9koWxAS1XNq6Qy+hwhKsh/PMkb4DfO+zc2m0oR4tQSt
	dl+S0FWmlWsAQLkbWrUqVBa5v8cse8qoqv+WnvZez9owKP224mRJsMUJMxb9MMoz
	bPNRH5Ngnqs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 38E0825157;
	Tue, 21 Jun 2016 13:27:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B435325156;
	Tue, 21 Jun 2016 13:27:14 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/1] mingw: work around t2300's assuming non-Windows paths
References: <cover.1466246919.git.johannes.schindelin@gmx.de>
	<a8bebe126bcd047720a13e90b85b8dccb7231187.1466246919.git.johannes.schindelin@gmx.de>
	<xmqqmvmfu17f.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1606211356170.22630@virtualbox>
	<xmqqr3bqqxhc.fsf@gitster.mtv.corp.google.com>
Date:	Tue, 21 Jun 2016 10:27:12 -0700
In-Reply-To: <xmqqr3bqqxhc.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 21 Jun 2016 10:10:23 -0700")
Message-ID: <xmqqk2hiqwpb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 653DF874-37D5-11E6-98AC-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I think you would need something similar to "pwd -W", that is, leave
> "git --exec-path" as a way to give shell scripts people have written
> over the years that allows them to say "git-cmd" as long as they do
> PATH="$(git --exec-path):$PATH" upfront.  And for Windows scripts,
> introduce a new option "git --exec-path-windows" that can give
> C:/git-sdk-64/usr/src/git (or even using backslash).

Of course we could go the other way.  We can declare that the output
of "git --exec-path" is the format that is platform-native pathname
to the directory [*1*], introduce a new option that is better
named than "--exec-path-to-include-in-PATH-in-shell-scripts" that
does the "convert C:/ to /c/ on Windows before showing" thing, and
rewrite all the references that does PATH=$(git --exec-path):$PATH
in scripts to use that new option.

The fact remains that on some platforms two variants are needed.  We
can update our test scripts with "convert C:/ to /c/ on Windows" to
work around a test failure like the patch under discussion did, but
that approach would not scale to fix real world scripts that people
already have, which is what I am trying to see if we can address in
these two messages.


[Footnote]

*1* ...instead of "it is suitable for PATH=$(git --exec-path):$PATH
in your shell scripts", which was the definition I used in the
message I am responding to.  "The name '--exec-path' implies it is a
path to the directory, and it is more natural for that to be platform
native" is a valid argument (and that is why I am saying "we could
go the other way" here), but I am not convinced that the conclusion
that the argument leads to is a better one in the practical sense.
