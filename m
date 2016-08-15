Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E07B31F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 16:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbcHOQGk (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 12:06:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752850AbcHOQGj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 12:06:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B68033363D;
	Mon, 15 Aug 2016 12:06:37 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SwHvzlxC0cSNhnolFyUacQ+5LWc=; b=Vsm2ay
	mOmusi/3cbmhy/MBJi+RJTVxstIp+oFgQgjv09ucwIb3CBVFbYk8DfceiDr/ZCcz
	B5hG/yKj0U/EA0vly3uQ5Lh/6dVqs2b6BbfMw/knoWqEFo1Saz8wGuZoxynfD4OP
	/Hs2xjzk8kgG/kAS9YdpMUSqbuadVigEeOklk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KgRcRDtjHX3KhWsnwbKzRpn3RARY+xv0
	Po0FKu19SwFrA3VyofgPOLe7FWQStMy2WTrxfUYl5nWtI4YdvQHf9PACUidvRdAx
	0jjA/hrA19dnwSAwlfb76HzSP/5ygIL2EIPPnSntVXFsLC+yILedeWEI81qf6l6c
	RTfxYlz1lNc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AEF2C3363C;
	Mon, 15 Aug 2016 12:06:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 346123363B;
	Mon, 15 Aug 2016 12:06:37 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] t/Makefile: make sure that file names are truly platform-independent
References: <814aefbcf0f9380098e3f7a183399e11e24180dd.1471270061.git.johannes.schindelin@gmx.de>
Date:	Mon, 15 Aug 2016 09:06:35 -0700
In-Reply-To: <814aefbcf0f9380098e3f7a183399e11e24180dd.1471270061.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 15 Aug 2016 16:08:41 +0200
	(CEST)")
Message-ID: <xmqqk2fihv90.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E925F8C-6302-11E6-9B35-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Some file names that are okay on ext4 and on HFS+ are illegal in
> Windows. In order to stay truly platform-independent, Git's source code
> must not contain such illegal file names, even if things just happen to
> work on Linux.

Good thinking.

Some tests may have to be skipped on platforms that cannot express
certain paths, but even then they shouldn't ship a file with
pathname that cannot even be checked out (they should instead create
and use such a path, protected behind filesystem specific test
prerequisite).

> +test-lint-filenames:
> +	@illegal="$$(git ls-files | grep '["*:<>?\\|]')"; \

This pattern must exclude questionables on either NTFS or HFS+; it
is ironic that it is not even sufficient to limit ourselves to the
Portable Character Set [*1*], but such is life.

By the way, doesn't ls-files take pathspec glob, saving one extra
process to run grep?

    master$ git ls-files '*["*:<>?\\|]*'
    pu$ git ls-files '*["*:<>?\\|]*'
    t/t4013/diff.diff_--diff-line-prefix=-->_master_master^_side

Thanks.

> +		test -z "$$illegal" || { \
> +		echo >&2 "illegal file name(s): " $$illegal; exit 1; }

[Reference]

*1* http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap06.html#tag_06_01
