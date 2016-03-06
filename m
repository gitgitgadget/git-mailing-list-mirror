From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow "-" as a short-hand for "@{-1}" in "git branch -d @{-1}"
Date: Sun, 06 Mar 2016 13:09:29 -0800
Message-ID: <xmqqa8mbtit2.fsf@gitster.mtv.corp.google.com>
References: <1457268494-8394-1-git-send-email-dpdineshp2@gmail.com>
	<1457268494-8394-2-git-send-email-dpdineshp2@gmail.com>
	<CAPig+cTHBLGjn_tnAKE2i_zv9TRxdVbNfONpxg=ZvRSz9-4t=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dinesh Polathula <dpdineshp2@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Mar 06 22:09:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acfvm-0002mz-Rk
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 22:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbcCFVJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 16:09:34 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51878 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750848AbcCFVJc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 16:09:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5BE874934C;
	Sun,  6 Mar 2016 16:09:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cw1TEy2EQtVB+Fe5hx0FQJnbPys=; b=kaYTe9
	l7Tke16s0xXVEaiuC9chbSMQjtkRY3EwviM8hAiLtyuCkPIOKxggTrgzazolvmHV
	E9Px6f0da3oe6twW7RNFUnryDWozslhMDTVhAPXPgfDgNSYQPlk363McmUV00Gzh
	W0wYVITdnpFjCig4DESc2vPl6jNzDL25mpOcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l/keNru34tW3cT3TygrCUgKPOqyP0rr8
	Ia8k5csj6RdU6oot2g3lJDpSMsSXTqlaJirJjKjtjRLEcgByuNE9s9g5jYUtISJz
	u1T2gdvz6sKZ1oB0Q7Y8Z4x9a19VIh5X0FO60GFqimtXKuihctQclYE308WXATIK
	HhnkFVL3s8g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5245C4934B;
	Sun,  6 Mar 2016 16:09:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C54454934A;
	Sun,  6 Mar 2016 16:09:30 -0500 (EST)
In-Reply-To: <CAPig+cTHBLGjn_tnAKE2i_zv9TRxdVbNfONpxg=ZvRSz9-4t=Q@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 6 Mar 2016 14:35:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B7F62AB8-E3DF-11E5-B3CF-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288366>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +       if (argc == 3 && !strcmp(argv[2], "-"))
> ...
> To address these issues, it seems like a more correct place to
> recognize "-" as an alias would be somewhere within
> builtin/branch.d:delete_branches().

I agree with all your review comments, and the above would also
cover another issue you did not mention above: "git branch -d/-D"
actually takes one or more branches to delete.

Another issue to consider is if we get a sensible error message.

What should the error message say if a user did these in a freshly
created empty repository?

    $ git commit --allow-empty -m initial
    $ git commit --allow-empty -m second
    $ git branch side master^
    $ git branch -d -

Currently, you would get

    $ git branch -d -
    error: branch '-' not found.

Is it OK to say

    error: branch '@{-1}' not found.

when the user never said '@{-1}' from the command line?

I am not saying it _is_ a problem--it may very well be acceptable,
as long as the users understand that '-' is merely a short-hand for
'@{-1}'.  Either way, the log message needs to have some evidence
that the patch author thought about the issue, the resolution the
patch author chose for the issue, and the reason why a particular
resolution was chosen.

Thanks.
