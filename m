Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45FB41FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 17:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642AbcHQRzv (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 13:55:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60180 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752435AbcHQRzu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 13:55:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 284B235ED6;
	Wed, 17 Aug 2016 13:55:49 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KIK13schSsvAu4OzChEi+tmsZ8g=; b=NjSnn1
	RS5t+V9hnh5zGg72AuOXU/e7RYpNmoDCbhU4DwPp4AZXXD4F73mDilcwha7ZYDz3
	IEgdjJkEQ5BymPM0Vb9x5u66BCTSBU6bJquuDGFeBB2q2XrwCFzBCxw7BLCeM4/C
	bPahVLW0IEBpiF2L69x7K2QkaWPdiLrRMPm3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EIDAMBtNqCF/hXJ0Ny0NnzV9E7/fA9QW
	mq3aFYD5UB02TqnfPDA7G/j43xxE5lJvTpZMimDVpyL3TDPIrYPTY8ZlVQXB0U9q
	qZ5ptbln2A9jkujmUAdM3QoZyLCOSnuxeAHTJdhAJeZNhL1nw+lqqoUNvFrpZTP+
	QWwm1KCfQOU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FCCA35ED5;
	Wed, 17 Aug 2016 13:55:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ACFEB35ED4;
	Wed, 17 Aug 2016 13:55:48 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Ben Wijen <ben@wijen.net>,
	Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 1/2] t6026-merge-attr: child processes must not inherit index.lock handles
References: <cover.1471437637.git.johannes.schindelin@gmx.de>
	<742a0bc524ac20bf10ccdf9ac51bb01a30efee16.1471437637.git.johannes.schindelin@gmx.de>
Date:	Wed, 17 Aug 2016 10:55:46 -0700
In-Reply-To: <742a0bc524ac20bf10ccdf9ac51bb01a30efee16.1471437637.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 17 Aug 2016 14:40:59 +0200
	(CEST)")
Message-ID: <xmqqh9aj9t5p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4648E84-64A3-11E6-BDCF-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> From: Ben Wijen <ben@wijen.net>
>
> On Windows, files cannot be removed unless all file handles to it have

s/files/a file/, as the file handles later in the sentence are open
on that single file.

Alternatively s/file handles to it/file handles to them/.

> been released. Hence it is particularly important to close handles when
> spawning children (which would probably not even know that they hold on
> to those handles).
>
> The example chosen for this test is a custom merge driver that indeed
> has no idea that it blocks the deletion of index.lock. The full use case
> is a daemon that lives on after the merge, with subsequent invocations
> handing off to the daemon, thereby avoiding hefty start-up costs. We
> simulate this behavior by simply sleeping one second.
>
> Note that the test only fails on Windows, due to the file locking issue.
> Since we have no way to say "expect failure with MINGW, success
> otherwise", we simply skip this test on Windows for now.
>
> Signed-off-by: Ben Wijen <ben@wijen.net>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Otherwise, nicely done.  Thanks.

>  t/t6026-merge-attr.sh | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
> index ef0cbce..3d28c78 100755
> --- a/t/t6026-merge-attr.sh
> +++ b/t/t6026-merge-attr.sh
> @@ -181,4 +181,17 @@ test_expect_success 'up-to-date merge without common ancestor' '
>  	)
>  '
>  
> +test_expect_success !MINGW 'custom merge does not lock index' '
> +	git reset --hard anchor &&
> +	write_script sleep-one-second.sh <<-\EOF &&
> +		sleep 1 &
> +	EOF
> +
> +	test_write_lines >.gitattributes \
> +		"* merge=ours" "text merge=sleep-one-second" &&
> +	test_config merge.ours.driver true &&
> +	test_config merge.sleep-one-second.driver ./sleep-one-second.sh &&
> +	git merge master
> +'
> +
>  test_done
