From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -x: do not die without -i
Date: Thu, 17 Mar 2016 11:10:22 -0700
Message-ID: <xmqq37rp0ycx.fsf@gitster.mtv.corp.google.com>
References: <1458177584-11378-1-git-send-email-sbeller@google.com>
	<xmqq4mc535n2.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1603171406080.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Matthieu.Moy@grenoble-inp.fr, j6t@kdbg.org,
	Lucien.Kong@ensimag.imag.fr
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 17 19:10:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agcNT-0004kS-En
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 19:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936327AbcCQSK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 14:10:27 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58455 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932933AbcCQSKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 14:10:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 21A014B54C;
	Thu, 17 Mar 2016 14:10:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WN0oHAE+XCkyce7XgBf6LVq45w4=; b=TM3ZkM
	c8et69g5u447m+SASmvaffACgDEWIQs4bK42SWthI2c7CMy3iLq4iphLw5ZdMpvc
	+zwiOoW1J74IFzR8hQ9Q0wzsfI+GyYeeaWzKmiVFg/EEhU9g9IVKJZdP79hq5xI4
	hjSRJh1udO9QogmDKkP3ZNbOFd/byRCL/7JFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KBWOamZfDCEtVRT1oNyZ8f20nQKS7ek1
	jT5b1WiW1Uab5yro/lmdU+0wvsbf+Ssjcd0kxFEGn8JUj90wGJkNmi/tg6l/sJoO
	SlgS9HXRI/7a3Fit39I/xrVymMREMbQeBbTyTwK/W8E0ixWi/DtoEb1UNKZj0tup
	2p2XN2KRjxE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 184924B54B;
	Thu, 17 Mar 2016 14:10:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8AAB84B54A;
	Thu, 17 Mar 2016 14:10:23 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1603171406080.4690@virtualbox> (Johannes
	Schindelin's message of "Thu, 17 Mar 2016 14:11:01 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 84B0827C-EC6B-11E5-B955-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289136>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> And that is very, very much the purpose of the interactive rebase.
>
>>     $ git for-each-rev -x "$command" old..new
>> 
>> where you can write "sh -c 'git checkout $1 && make test' -" as
>> your $command.
>
> You meant
>
> 	git rev-list old...new |
> 	while read rev
> 	do
> 		$command || break
> 	done
>
> ?

Yeah, if I actually felt the lack of "for-each-ref -x" a problem (I
don't), that is what I would have used instead (but with just two
dots ;-).

But you are correct to point out that I didn't consider that
"... and I want to fix right there if it breaks" is a part of the
use case, mainly because the log message said this:

    In the later steps of preparing a patch series I do not want to
    edit the patches any more, but just make sure the test suite
    passes after each patch.

and partly I lack imagination.

If you throw in that extra "I want to fix right there if it breaks"
requirement, it makes perfect sense to make use of the sequencing
machinery we implement for "rebase -i", as the while loop above does
not give you the same sequencing without extra work.

So perhaps the idea of the patch is good with a better explanation.
