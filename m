Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5E2EE498E
	for <git@archiver.kernel.org>; Fri, 18 Aug 2023 19:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379538AbjHRTF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Aug 2023 15:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379582AbjHRTFX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2023 15:05:23 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEF23A94
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 12:05:21 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8F66B2835E;
        Fri, 18 Aug 2023 15:05:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H/lUBCobOaEzMpf7mkm0LFkCoTPBJdqPRa1Zu2
        P0Rac=; b=rwAH3syPOiNYEeJe1IIIAIP3Ihrdz2IuZX8PqYE1aRfrqaHwFOv8ec
        LLrx/wK1bcqczIO/jc0Amu6pQgffg8TUYIyCkArZMnQgvpJqQr/0Tm2K9QlYvIAQ
        3p1IdCaSp7O37TG9qN10m5i9RVE5YL2UIvV3USoUwH1LdoKsTbt3U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 883CB2835D;
        Fri, 18 Aug 2023 15:05:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 310012835C;
        Fri, 18 Aug 2023 15:05:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [BUG] Git 2.42.0-rc2 t1092.57 script error
References: <018601d9d1fc$2049ede0$60ddc9a0$@nexbridge.com>
Date:   Fri, 18 Aug 2023 12:05:16 -0700
In-Reply-To: <018601d9d1fc$2049ede0$60ddc9a0$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Fri, 18 Aug 2023 13:47:52
        -0400")
Message-ID: <xmqqedk0uq6r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B454180-3DFA-11EE-A894-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> I'm getting the following error when running t1092.57 in Git 2.42.0-rc2
> on NonStop ia64:
>
> + ensure_not_expanded status
> test_region[8]: test: argument expected
> grep: ensure_full_index: No such file or directory
> error: last command exited with $?=1
> not ok 57 - sparse-index is not expanded
>
> Any suggestions?

Sorry for not coming up with anything concrete.

"ensure_not_expanded status" should be running as its second step

	test_region ! index ensure_full_index trace2.txt

Which should do this:

    test_region () {
            local expect_exit=0
            if test "$1" = "!"
            then
                    expect_exit=1
                    shift
            fi

            grep -e	'"region_enter".*"category":"'"$1"'","label":"'"$2"\" "$3"
            exitcode=$?

            if test $exitcode != $expect_exit
            then


As "grep" complains that ensure_full_index is not a file, when the
command runs there the file name is "$3".

So it appears to me that the first 

	test "$1" = "!"

is not firing and failing to set expect_exit to 1 and shift the "!"
out of $@.  Why?  I dunno.  Perhaps your shell has quirks around
"local"?  I dunno.


