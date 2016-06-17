Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E56120179
	for <e@80x24.org>; Fri, 17 Jun 2016 16:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755479AbcFQQJy (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 12:09:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53698 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751907AbcFQQJx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 12:09:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6290824145;
	Fri, 17 Jun 2016 12:09:47 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bPLzM4PXNPkcKzKM+MO34WuVw7M=; b=fEM5Oi
	5sjyfXhDeFFJLwevYDfPVrviBkdKpg5f9FdrU/EIC/00qZjC/4GkueafgL6nBZrX
	OGy/Swu7wyXwTwcEZd/t9EPqd0E3fXemsNp0GXzSzqO3YZOZ745AFS7r9BoSg2T+
	irdAqb4sYKaIkz/ltAzGinV0Zjvb4AIWFNq0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jZvmSkUNEv7B5ktDT3JjlLKUCPbaStft
	Puh0h8BqGVKhqgqozNwkerb1PiRfRoyhc+UK/yjgGgdqb4ALHlT7IUH5IiyQFivv
	P2WfPnHx6krkdMsRIuwWKZbp0qu7Q0M1x6ELA1hXswb4TA3KlHMlX30/wFXmwwnp
	Ytp2llaTcy8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B3E124144;
	Fri, 17 Jun 2016 12:09:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA19B24142;
	Fri, 17 Jun 2016 12:09:46 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Joey Hess <id@joeyh.name>
Cc:	Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/4] add smudge-to-file and clean-from-file filter configuration
References: <20160616203259.5886-1-joeyh@joeyh.name>
	<20160616203259.5886-3-joeyh@joeyh.name>
	<3c7349e7-34a1-ed7f-721e-e7a7b191bb3d@drmicha.warpmail.net>
	<20160617124707.GB24025@kitenet.net>
Date:	Fri, 17 Jun 2016 09:09:45 -0700
In-Reply-To: <20160617124707.GB24025@kitenet.net> (Joey Hess's message of
	"Fri, 17 Jun 2016 08:47:07 -0400")
Message-ID: <xmqq60t73igm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9380BCA-34A5-11E6-AD91-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Joey Hess <id@joeyh.name> writes:

>> Do you make any promises that %p is a seekable file?
>
> Yes, %p is a regular file and so is seekable, statable, etc.

I wonder if we prefer not to make this customizable (i.e. not having
to use'%p').  Unlike '%f' that is optional, smudgeTo and cleanFrom
"filters" are not filters and MUST read from the path given and not
from any other paths.

A misconfigured smudgeTo filter that uses %f would overwrite a wrong
file when used with checkout-index --prefix=<there>, right?

The only thing '%p' buys is that a "filter" could be written in such
a way that takes the pathname at arbitrary place on the command
line.  A command line that does not have '%p' anywhere is invalid,
which is quite different from how '%f' behaves.

Would an interface that always appends the pathname at the end of
the command line string work?  E.g.

	[filter "foo"] smugeToFile = cmd --from-file

would run "cmd --from-file PATH" when Git wants it to read from
PATH, and

	[filter "bar"] smugeToFile = sh -c 'cmd --from-file="$0"'

would run

	sh -c 'cmd --from-file="$0"' PATH

which in turn becomes 'cmd --from-file=PATH'.

Or something like that.

