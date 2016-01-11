From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] Handle more file writes correctly in shared repos
Date: Mon, 11 Jan 2016 09:06:24 -0800
Message-ID: <xmqqtwmkxcz3.fsf@gitster.mtv.corp.google.com>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de>
	<cover.1452085713.git.johannes.schindelin@gmx.de>
	<c03e5a9d367b76d8a249680c752b4c4d935e9b91.1452085713.git.johannes.schindelin@gmx.de>
	<xmqq1t9t3vn8.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601081704280.2964@virtualbox>
	<xmqqbn8w2brm.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601111018550.2964@virtualbox>
	<xmqqio30yur4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 11 18:06:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIfvP-00054X-TX
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 18:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934250AbcAKRG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 12:06:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933658AbcAKRG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 12:06:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 44E6F3886F;
	Mon, 11 Jan 2016 12:06:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PVr2+Xx0vBjNnbsOywsqw1DqtNc=; b=LzQMDW
	7YR+0h9dMooWZObW0KE6L2fWuKIl2CWsxWnlPe/UGbehfIXUtMAHY7oclErTu/HM
	3it2uwC3mpK1V9yLVAdhi8kA1frRzYUOFm9YJKHpytPItkey5iPVPYvmkyYnE9nH
	NkI6VJ0U/ZObRBNSu+dsDo8z378DnmyCq+PFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=deC5bmamBbdaddf4JqtAowb/owtVKZ5b
	M1fq7xATG2jm+ktgOldkHiROkO1R/XJbJ3jKYLHDTY4SmZGXCxtxHMsCM5ftEXZ4
	6+xinODUEtioxViH4nEPkzjLLEos/1y+zKAUqxCDAo3UeWgoNu/utXRonURu7mC5
	eTSpydYAWCk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3A7BA3886D;
	Mon, 11 Jan 2016 12:06:26 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B03E63886C;
	Mon, 11 Jan 2016 12:06:25 -0500 (EST)
In-Reply-To: <xmqqio30yur4.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 11 Jan 2016 07:57:03 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A5DA263E-B885-11E5-B03E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283674>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Fri, 8 Jan 2016, Junio C Hamano wrote:
>>
>>> I think it is correct not to touch this codepath in this patch,
>>> because of the above two reasons, but more simply and generally, it
>>> is correct not to touch this codepath because core.sharedRepository
>>> is not about working tree files, and .rej is a file you use in your
>>> working tree.
>>
>> I am happy to adjust the log message, but I am pretty certain that the
>> `core.sharedRepository` setting actually also affects the working tree. At
>> least in my hands, calling
>>
>> 	git clone -c core.sharedRepository=group . test-shared
>>
>> results in all of the working tree files being group-writable.
>
> Interesting.  I have a suspicion that "clone" does not honor the
> configuration given that way, though.
>
>  $ umask 077
>  $ git clone -c core.sharedRepository=group ~/w/git.git sharedtest
>  $ cd sharedtest
>  $ ls -l COPYING .git/index
>  -rw------- 1 jch eng 18765 Jan 11 07:43 COPYING
>  -rw------- 1 jch eng 272037 Jan 11 07:43 .git/index
>
> Notice that the permission bits in the working tree is correct, but
> in the resulting .git/ they are bogus, so from this we cannot
> clearly see the reason why COPYING is not group-readable is because
> the checkout codepath (write_entry(), I think) is correctly omitting
> the call to adjust_perm(), or simply the configuration is ignored
> during the clone.
>
> With a workaround to ensure that checkout happens definitely after
> the configuration gets in effect by doing config and pull/checkout
> as two separate steps:
>
>  $ rm -fr sharedtest
>  $ umask 077
>  $ git init sharedtest && cd sharedtest
>  $ git config core.sharedRepository group
>  $ git pull ~/w/git.git/ master
>  $ ls -l COPYING .git/index
>  -rw------- 1 jch eng 18765 Jan 11 07:48 COPYING
>  -rw-rw---- 1 jch eng 272037 Jan 11 07:48 .git/index
>
> we can see that the configuration affects only the $GIT_DIR/ files
> and not working tree.
>
> So you found a bug in clone, I think ;-)

Having said all that, the above does not mean that I'll refuse to
consider changing the semantics of core.sharedRepository in a future
major version bump by doing adjust_perm() for working tree files,
which we have deliberately chosen not to do in the current code.

But that is not within the scope of the patch we are discussing, and
I am not convinced it is a good idea (I haven't heard either sides
of arguments), so based on the current design, I think "we don't do
fopen_for_writing() for working tree files" is a valid justification
that is short-and-sweet for this patch.
