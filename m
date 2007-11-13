From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: show all headers when sending mail
Date: Mon, 12 Nov 2007 23:28:45 -0800
Message-ID: <7vbq9ywqmq.fsf@gitster.siamese.dyndns.org>
References: <1194883317-11161-1-git-send-email-ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 08:29:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrqCy-0000HE-GU
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 08:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760714AbXKMH2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 02:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752656AbXKMH2v
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 02:28:51 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:33666 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760685AbXKMH2u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 02:28:50 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A09A62F2;
	Tue, 13 Nov 2007 02:29:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id EB1CA93700;
	Tue, 13 Nov 2007 02:29:08 -0500 (EST)
In-Reply-To: <1194883317-11161-1-git-send-email-ddkilzer@kilzer.net> (David
	D. Kilzer's message of "Mon, 12 Nov 2007 08:01:57 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64759>

"David D. Kilzer" <ddkilzer@kilzer.net> writes:

> +replace_header () {
> +	EXPECTED=expected-show-all-headers &&
> +	ACTUAL=actual-show-all-headers &&
> +	REPLACEMENT=`cat ${ACTUAL} | grep "^$1:"` &&
> +	if [ ! -z "${REPLACEMENT}" ]; then \
> +		cat ${EXPECTED} | sed -e "s/^$1: .*\$/${REPLACEMENT}/" > ${EXPECTED}.$$ && \
> +		mv -f ${EXPECTED}.$$ ${EXPECTED}
> +	fi
> +}

If the actual output did not have an asked-for field,
REPLACEMENT will be empty and the breakage will go unnoticed,
won't it?

It would probably be better to write it this way:

	test_expect_success 'Show all headers' '

		git send-email \
                	--dry-run \
                        --from="Example <from@example.com>" \
                        --to=to@example.com \
                        --cc=cc@example.com \
                        --bcc=bcc@example.com \
                        --in-reply-to="<unique-message-id@example.com>" \
                        --smtp-sever relay.example.com \
                        $patches |
		sed	-e "s/^\(Date:\).*/1 DATE-STRING/" \
                	-e "s/^\(Message-Id:\).*/1 ID-STRING/" \
                        -e "s/^\(X-Mailer:\).*/1 X-MAILER-STRING/" \
			>actual &&
		diff -u expected actual

        '

and prepare the expected output with the varying field already
replaced with the placeholder string.

Oh, by the way, do not cat a single file and pipe it to another
command.  There may still be a few such stupidity in our test
scripts but let's not add even more of them...
