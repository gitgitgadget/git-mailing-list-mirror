Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 519D91FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 18:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847AbcGSS3H (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 14:29:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52973 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753386AbcGSS3F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 14:29:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D98362BC01;
	Tue, 19 Jul 2016 14:29:03 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QMQw6n9SA/Ig/hOfeM/Nqy8djJ4=; b=everdA
	CLuqPE2dRXP3RTTiJF90tvloPqa1ukxmv+9UrZ71CapDOA7IGIpjQRWKOsNbgouh
	rR77LK1huJSEWUiRW1Y8Z5oF8EoiTPTIuCpe4+rqf7meQpr+s+VOPAYXpj/AMokg
	rEiu+qNrBQgEBUBocEoQdqJcG4ZdtNqJ9/OKc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y1Be3arxYZjvyyEXcCQvtO9bswfJWH1w
	Ebgp8tYpyxifuIew5fhihm1UFh7WZadO7dNXFO/qblUpFXT+W9Vsvyqp8ai/Hm2n
	yg3Ko+dan44XkXvNHxos5dbNnDEQN+WghIxGY67n/vI7Z0PFgjXkK/W4TRDSFS9I
	JUUg+yL6MSg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D258A2BC00;
	Tue, 19 Jul 2016 14:29:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 54B422BBFF;
	Tue, 19 Jul 2016 14:29:03 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	David Aguilar <davvid@gmail.com>
Cc:	John Keeping <john@keeping.me.uk>,
	Bernhard Kirchen <bernhard.kirchen@rwth-aachen.de>,
	Tim Henigan <tim.henigan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] difftool: use Git::* functions instead of passing around state
References: <20160719035756.24961-1-davvid@gmail.com>
	<20160719035756.24961-3-davvid@gmail.com>
Date:	Tue, 19 Jul 2016 11:29:01 -0700
In-Reply-To: <20160719035756.24961-3-davvid@gmail.com> (David Aguilar's
	message of "Mon, 18 Jul 2016 20:57:56 -0700")
Message-ID: <xmqqtwflfpn6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB5920B2-4DDE-11E6-93A3-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> Call Git::command() and friends directly wherever possible.
> This makes it clear that these operations can be invoked directly
> without needing to manage the current directory and related GIT_*
> environment variables.

Good.

> @@ -88,11 +80,11 @@ sub changed_files
>  	my @refreshargs = (
>  		@gitargs, 'update-index',
>  		'--really-refresh', '-q', '--unmerged');
> -	my @diffargs = (@gitargs, 'diff-files', '--name-only', '-z');
>  	try {
>  		Git::command_oneline(@refreshargs);
>  	} catch Git::Error::Command with {};
>  
> +	my @diffargs = (@gitargs, 'diff-files', '--name-only', '-z');
>  	my $line = Git::command_oneline(@diffargs);
>  	my @files;
>  	if (defined $line) {

This hunk looks like "oops, the @diffargs variable logically belongs
here, not there", correcting an mistake in an earlier step.
