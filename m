Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FA2C47247
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 17:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 816AC20836
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 17:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="osxtsXBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgD3Roc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 13:44:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50896 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgD3Roc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 13:44:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A629A5F216;
        Thu, 30 Apr 2020 13:44:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LW+kD2z584JvrHhncqjJRjhJEdM=; b=osxtsX
        BTBsabswFOl/OiGSg97+lUSgMDzjZVJlO9eKMv+HPYK5C59HZhHdil1wsPRpn2Zv
        eD6qiNgBhvjyV4cdOprZjQ7gXVhfhXsSr36HTZgAheecgwyuJgh4LMioQvNMLWIg
        2f1EXCDZ19YGauFrtTck/ZCqH+TUupvoD47p4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PKsaTexotjOYsGL8r3nOG71sTw9TGI6z
        TcFlTuy/19+LXFSet5xNZG1g/TgbUGbdCfkeQlyKlBCrlFWheJksMzsu36c7eJsL
        kC+ZdpiqAL/dbo1Hep5toCcwMEeAOQNwFLx38oov/9WmJrKLweHCgFYVLYQeee7S
        ijbBS/auctY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D88B5F215;
        Thu, 30 Apr 2020 13:44:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29CA35F214;
        Thu, 30 Apr 2020 13:44:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] bugreport: collect list of populated hooks
References: <20200427233820.179891-1-emilyshaffer@google.com>
        <20200430012425.209122-1-emilyshaffer@google.com>
        <20200430015049.GA115238@google.com>
Date:   Thu, 30 Apr 2020 10:44:28 -0700
In-Reply-To: <20200430015049.GA115238@google.com> (Jonathan Nieder's message
        of "Wed, 29 Apr 2020 18:50:49 -0700")
Message-ID: <xmqqv9lgswar.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3DDA0502-8B0A-11EA-B2AD-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> When we do that, this "mkdir .git/hooks" will fail because the
> directory already exists.  Ideas:
>
>  A. Include a preparatory patch in this series that removes that "mv"
>     command.  That way, this test can do

While I do not think it is realistic to anticipate that the "test"
repository may someday come with a hooks/ directory, even if we did
so, we would not enable any hook by default in there.  So "move away
and restore" feels way overkill.

>   B. Run "git init" ourselves so we know what we're getting:

That is certainly safer, and simpler.  But perhaps the simplest
would be

    C. Use "mkdir -p .git/hooks" so we won't get affected.

>> +	write_script .git/hooks/applypatch-msg &&
>
> write_script looks for a script on its stdin.  test_eval_ redirects
> stdin to come from /dev/null, so we happen to get an empty script, but
> this is subtle.  How about something like
>
> 	write_script .git/hooks/applypatch-msg <<-\EOF &&
> 	echo >&2 "rejecting message in $1"
> 	exit 1
> 	EOF

Yes, that is good.

> or
>
> 	write_script .git/hooks/applypatch-msg </dev/null &&

This takes us back to the resuling "empty" hook we wanted to avoid
by switching from "use touch to create something" to "write some
meaningful contents" approach, no?

>> +	git bugreport -s hooks &&
>> +	grep applypatch-msg git-bugreport-hooks.txt &&
>> +	! grep prepare-commit-msg git-bugreport-hooks.txt
>> +'
>
> Thanks,

Thanks.
