From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/11] test-lib: make it possible to override how test code is eval'd
Date: Fri, 06 Jun 2014 09:53:20 -0700
Message-ID: <xmqqiooeq8sf.fsf@gitster.dls.corp.google.com>
References: <1401176460-31564-1-git-send-email-rhansen@bbn.com>
	<1401915687-8602-1-git-send-email-rhansen@bbn.com>
	<1401915687-8602-11-git-send-email-rhansen@bbn.com>
	<xmqqk38vrrig.fsf@gitster.dls.corp.google.com>
	<53911297.9030106@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 18:53:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsxOV-0007KL-Tk
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 18:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273AbaFFQx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 12:53:28 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64387 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752258AbaFFQx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 12:53:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 553F01B428;
	Fri,  6 Jun 2014 12:53:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m4QTIigxiTQWC1TR19zzObFjaZA=; b=M46A7N
	qZ/S998tNCe3ZmlQEdoC8Ahr3fvtOuESfx0GTuA/P7ssyC8YT6KYSSBW9oSky9sV
	vt1CAA/OsgKTSN6RX7zrfpXnoEceQMe0PoRldw0M4IWVKilE1pkrMmB7IZ8dJkZK
	sR9RL5qjDzvINSrzSqYHmG6EH90Vuv35zpEds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mns/eSukmsTVadGtpTc9MDWkWSOdQwIR
	MXd82lt6b8vMztMlQ7OkHzyOTj2z23LhRWAVNjjqMFvBm+3soBhIwwva93fjE24x
	tnI+P8ZpgL1EoAOdVZfRUQ+lYlgB/06GM8LQYyxZsaU9ssS0Z7d0bD0rCylNy5cF
	ipIU2xZO3TA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4A42F1B427;
	Fri,  6 Jun 2014 12:53:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 718351B421;
	Fri,  6 Jun 2014 12:53:22 -0400 (EDT)
In-Reply-To: <53911297.9030106@bbn.com> (Richard Hansen's message of "Thu, 05
	Jun 2014 21:00:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 11BFACE6-ED9B-11E3-A6E4-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250948>

Richard Hansen <rhansen@bbn.com> writes:

> On 2014-06-05 17:11, Junio C Hamano wrote:
> ...
>> In any case, the above explanation confuses me somewhat.  test_eval_
>> is fed a scriptlet defined for various test_expect_success tests,
>> and they are written in POSIX shells, not zsh, so wouldn't it be
>> wrong to run them as if they are zsh native scripts, following
>> non-POSIX shell syntax rules?
>
> The scriptlets in lib-prompt-tests.sh are not actually written for POSIX
> sh -- they are written in a common subset of the zsh and bash languages
> (I should document this in lib-prompt-tests.sh).
>
> We want to test how the __git_ps1 code behaves when interpreted in
> "native" zsh mode (default options), because that's how it will be used
> in the wild, so the scriptlets must be valid zsh code.  We also want to
> test how __git_ps1 behaves in native bash mode, so the scriptlets must
> also be valid bash code.  (Fortunately the similarities between the
> shells make this easy to do.)

OK.  The above all makes sense, but I think we would prefer a
solution with changes limited to lib-prompt-tests and lib-zsh
without touching lib-test-functions at all if that is the case.

> An alternative to this commit -- and I kinda like this idea so I'm
> tempted to rewrite the series -- would be to do change the form of the
> tests in lib-prompt-tests.sh to something like this:
>
>     test_expect_success 'name of test here' '
>         run_in_native_shell_mode '\''
>             scriptlet code here
>         '\''
>     '

Yeah, or even:

	prompt_test_expect success 'name of test' '
        	scriptlet code here
	'

with a helper prompt_test_expect that wraps whatever logic you will
have in run-in-native-shell-mode.

> ...
> This approach makes it clear to others that the scriptlet code is not
> actually POSIX shell code, but a common subset of multiple shell languages.
>
> What do you think?

;-)

> Ignoring t9902 for a moment, we could even stop doing that messy 'exec
> $SHELL "$0" "$@"' stuff in lib-*sh.sh and let t9903 and t9904 run under
> /bin/sh.  Then run_in_native_shell_mode() would be defined as follows:

No, let's not go there (and you stated the reason why we do not want
to yourself already ;-).
