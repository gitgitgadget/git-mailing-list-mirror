Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95BB320A40
	for <e@80x24.org>; Sun,  3 Dec 2017 05:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750786AbdLCF0K (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 00:26:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50525 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750705AbdLCF0K (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 00:26:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 60261B6329;
        Sun,  3 Dec 2017 00:26:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YyghPilCyeoA8ZSTQHNuDDbQ7xk=; b=sQuoBg
        rGwuPbPYDI0l4jnZa2KNwTPpX3ivwAdEvCIWE45olyihdhbMzuLTnxsCe6i2ac6y
        qvi08zQzKGRsNJG9Hq3c2sP2r6EuKTUrkUfo3B4UapXYwzbFNuI6Ty6nECY3q+RH
        bJAO43YjGIDK9zCCUbBmDygsD/CM4ZB7jenJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tV/+PI+IwyIPn16nSKvoIiQmOBEha4MV
        pLhsuH/MlTWZ3bTDrcVAfc7w8rymbZY9gx1B7AjJrMkCsupUHYsk4nuwurNrla6q
        3mTQ9qB9NBDptLFouYPt4YjH30uFpd3ZUQMhiD4opBAiNsymg9lXRt9SAP+X6KUd
        l9ZK6JXB290=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 58A3EB6328;
        Sun,  3 Dec 2017 00:26:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C94EAB6327;
        Sun,  3 Dec 2017 00:26:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Dan Jacques <dnj@google.com>, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de, avarab@gmail.com
Subject: Re: [PATCH v4 1/4] Makefile: generate Perl header from template file
References: <20171129155637.89075-1-dnj@google.com>
        <20171129155637.89075-2-dnj@google.com>
        <3c897f4c-0cb5-ca44-f144-598a623c1dc3@kdbg.org>
Date:   Sat, 02 Dec 2017 21:26:07 -0800
In-Reply-To: <3c897f4c-0cb5-ca44-f144-598a623c1dc3@kdbg.org> (Johannes Sixt's
        message of "Fri, 1 Dec 2017 17:59:46 +0100")
Message-ID: <xmqqr2scjsb4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77AFB9A0-D7EA-11E7-937D-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>> +	sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
>
> This doesn't work, unfortunately. When $(pathsep) is ';', we get an
> incomplete sed expression because ';' is also a command separator in
> the sed language.

It is correct that ';' can be and does get used in place of LF when
writing a script on a single line, but even then, as part of a
string argument to 's' command (and also others), there is no need
to quote ';' or otherwise treat it any specially, as the commands
know what their syntax is (e.g. 's=string=replacement=' after seeing
the first '=' knows that it needs to find one unquoted '=' to find
the end of the first argument, and another to find the end of the
replacement string, and ';' seen during that scanning would not have
any special meaning).

If your sed is so broken and does not satisfy the above expectation,
t6023 would not work for you, I would gess.

t/t6023-merge-file.sh:sed -e "s/deerit.\$/deerit;/" -e "s/me;\$/me./" < new5.txt > new6.txt
t/t6023-merge-file.sh:sed -e "s/deerit.\$/deerit,/" -e "s/me;\$/me,/" < new5.txt > new7.txt
t/t6023-merge-file.sh:sed -e 's/deerit./&%%%%/' -e "s/locavit,/locavit;/"< new6.txt | tr '%' '\012' > new8.txt

