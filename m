From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/6] t9001: non order-sensitive file comparison
Date: Tue, 07 Jun 2016 18:07:06 -0700
Message-ID: <xmqqziqwmqth.fsf@gitster.mtv.corp.google.com>
References: <1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
	<20160607140148.23242-1-tom.russello@grenoble-inp.org>
	<20160607140148.23242-2-tom.russello@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	samuel.groot@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, e@80x24.org, aaron@schrab.com
To: Tom Russello <tom.russello@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 03:07:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bARxl-00011A-3B
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 03:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754209AbcFHBHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 21:07:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60863 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754199AbcFHBHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 21:07:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6371E23DF6;
	Tue,  7 Jun 2016 21:07:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W3n5vAMsFNbWwVDmq/b6NimOQlY=; b=FjpIdV
	2OjqTcxiEMKpxXqlAPriHrO1zN14KUkWhqaHVdb3BaaVAFlH2fcDQqi6/gFjo6ZB
	TzKkP4YlSiLKyW0aFggvaMjFD/xO34ryZV2BlQrKM3Ekswd8LCtKKEM/3NSt6KvR
	4TyF9/o5+FH8933QmImTycX11LIC1NFYYIS50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SyeoiN6Z/KX1CeFQUSJ2NfA5HygxXZtY
	EgH+aDkXpDOutqU7fzcr+c4BKqMw/E7+r4Iwkfi33sh25R0G2XVi8u2ofPhvv9bl
	789/DK+H9rC1p3bQS9g/Jp/81COVt2Vda6ctd5/1UbHtcOlVSls3FsplSImtRxsS
	9DPvrW2R++g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B98F23DF5;
	Tue,  7 Jun 2016 21:07:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DC30723DF4;
	Tue,  7 Jun 2016 21:07:07 -0400 (EDT)
In-Reply-To: <20160607140148.23242-2-tom.russello@grenoble-inp.org> (Tom
	Russello's message of "Tue, 7 Jun 2016 16:01:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 524EAC7E-2D15-11E6-993D-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296753>

Tom Russello <tom.russello@grenoble-inp.org> writes:

> +# Check if two files have the same content, non-order sensitive
> +test_cmp_noorder () {
> +	sort $1 >$1;

Here is what I think happens:

    0) the shell parses this command line;
    1) the shell notices that the output has to go to $1;
    2) the shell does open(2) of $1,
    3) the shell spawns "sort" with a single argument, with its
       output connected to the file descriptor obtained in 2).

Because "$1" becomes an empty file at 2), "sort" reads nothing and
writes nothing.

> +	sort $2 >$2;
> +	return $(test_cmp $1 $2)

What is this return doing?  I would understand if it were just

	test_cmp $1 $2

Of course, all the places you use test_cmp_noorder are happy when
this function returns 0/success, and because $1 and $2 at this point
are both empty files and test_cmp will not say anything to its
standard output, the return will just yield 0/success to the caller
of the function, so it is likely that with this patch t9001 would
have passed for you, but that is not necessarily a good thing X-<.

> @@ -269,7 +276,7 @@ test_expect_success $PREREQ 'Show all headers' '
>  		-e "s/^\(Message-Id:\).*/\1 MESSAGE-ID-STRING/" \
>  		-e "s/^\(X-Mailer:\).*/\1 X-MAILER-STRING/" \
>  		>actual-show-all-headers &&
> -	test_cmp expected-show-all-headers actual-show-all-headers
> +	test_cmp_noorder expected-show-all-headers actual-show-all-headers
>  '

It is dubious that it is a good idea to blindly sort two files and
compare, especially because expected-show-all-headers is actually
something like this:

    cat >expected-show-all-headers <<\EOF
    0001-Second.patch
    (mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
    (mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
    (mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
    Dry-OK. Log says:
    Server: relay.example.com
    MAIL FROM:<from@example.com>
    RCPT TO:<to@example.com>
    RCPT TO:<cc@example.com>
    ...
    To: to@example.com
    Cc: cc@example.com,
            A <author@example.com>,
            One <one@example.com>,
            two@example.com
    Subject: [PATCH 1/1] Second.
    Date: DATE-STRING
    Message-Id: MESSAGE-ID-STRING
    X-Mailer: X-MAILER-STRING
    In-Reply-To: <unique-message-id@example.com>
    References: <unique-message-id@example.com>

    Result: OK
    EOF

We do want to see MAIL FROM: as the first thing we give to the
server, followed by RCPT TO:, followed by the headers.

I am having a hard time guessing what prompted you to sort the
output, i.e. what problem you were trying to solve.  It cannot be
because addresses on a list (e.g. Cc:) could come out in an
indeterministic order, because the address that a test expects to be
the first (cc@example.com in the above example) may not appear as
the first one, but in the textual output it _is_ shown differently
from the remainder (i.e. even if you sort, from "Cc:
cc@example.com," it is clear it was the first one output for Cc: and
diferent from "A <author@example.com>".
