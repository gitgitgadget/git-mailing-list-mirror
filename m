Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707E7C00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 18:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239184AbiHLSIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 14:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239135AbiHLSIe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 14:08:34 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46746B2876
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 11:08:33 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 402A914C402;
        Fri, 12 Aug 2022 14:08:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8VlKJZ8VUgKa
        d8Pzc2Xic0hp4OQS9e6HZEYVBnpxqgM=; b=gr0/YX0RSSERlb4YaDCnu4nK66kU
        y6sYljFtgAGumwOeIIO5m5PyxllgZGgk99taf/tt1zNXNtMZjG3sEg06h7OHez2O
        fjhew0hhUDSbsMI2iQZm3fqUBavk5fu7LFTuWagJPvE1PQtbUSdraN0GSuERFSla
        MLSnWjT+Zcab3CM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3888B14C401;
        Fri, 12 Aug 2022 14:08:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A122514C400;
        Fri, 12 Aug 2022 14:08:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Jeff Hostetler <jeffhost@microsoft.com>
Cc:     git@vger.kernel.org
Subject: Re: t7527 intermittent failure on macOS APFS and possible fix
References: <YvZbGAf+82WtNXcJ@danh.dev>
Date:   Fri, 12 Aug 2022 11:08:30 -0700
In-Reply-To: <YvZbGAf+82WtNXcJ@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
        "Fri, 12 Aug 2022 20:52:24 +0700")
Message-ID: <xmqqmtc9baht.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C627E582-1A69-11ED-B934-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> Running t7527 on macOS with encrypted APFS filesystem.
> I observes intermittent failure, however, when I manually check the
> test cases, they're all passed.
>
> I suspected fileystem caching issue.
> I added those sync-s into test steps and the test pass.
> I'm not sure if this is the intending "fix" for the tests
> since we're testing the fsmonitor with t7527.
>
> Please advise!

fsmonitor experts, please do.

My gut feeling is that, unless the production code internally calls
the equivalent of "sync" done here and the failure in tests are
coming from the fact that the "sync" is missing in "test-tool
fsmonitor-client" (i.e. test-tool does not emulate the real world
closely enough and fails in cases where the machinery does not fail
in the real world), these "sync" calls only sweep the problem under
the rug.

> P/S: When debugging, I also found out that:
> "test-tool fsmonitor-client query" doesn't write the final newline
> character, thus making the output harder to read. The diff also have
> the final newline added.
>
> ----- 8< -------
> diff --git a/t/helper/test-fsmonitor-client.c b/t/helper/test-fsmonitor=
-client.c
> index 54a4856c48..98d6cf1440 100644
> --- a/t/helper/test-fsmonitor-client.c
> +++ b/t/helper/test-fsmonitor-client.c
> @@ -55,6 +55,7 @@ static int do_send_query(const char *token)
> =20
>  	write_in_full(1, answer.buf, answer.len);
>  	strbuf_release(&answer);
> +	write_in_full(1, "\n", 1);
> =20
>  	return 0;
>  }
> @@ -77,6 +78,7 @@ static int do_send_flush(void)
> =20
>  	write_in_full(1, answer.buf, answer.len);
>  	strbuf_release(&answer);
> +	write_in_full(1, "\n", 1);
> =20
>  	return 0;
>  }

Aren't these protocol drivers?  If the protocol is defined without
the trailing LF, would it make sense to update only the sending end
to do this?  Or does the protocol makes it clear that a trailing LF,
or lack of it, should be tolerated by all the implementations?

If we are absolutely sure that no implementation of the other side
will get upset by seeing an extra LF, It would be fine, but as the
original code wants to call write_in_full(), it would be more
preferrable to do it this way instead, I suspect.

+	strbuf_complete(&answer, '\n');
	write_in_full(1, answer.buf, answer.len);
	strbuf_release(&answer);
