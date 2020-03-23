Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFCAC4332B
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 21:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBDFA2070A
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 21:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E/QFRrzg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCWVUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:20:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56506 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgCWVUc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 17:20:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 779AC46644;
        Mon, 23 Mar 2020 17:20:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ToIglpTm1rkiX913lBLeBiWHlB4=; b=E/QFRr
        zg+M91kbdxt+lSmyoVvHzsisUbCgxmKoDwaZtj5abu+c1VRIrQtNWd6BonrzrlAn
        k9HqMywqiGZ03Cw9OhVPbd5XvXzfdE1JSag3ygDmEUDd352LGjbagXWC/rmGaYwo
        uDtswss2p+2UbnWXoEoHksO1XDwvPzKSwxcKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J5bIcHbHPsJBe+gCWjTe2B1QpbYwB+2c
        K1STIRsBYs33X/oyVENLRJ8auglYyEtlKUQ2Z/GX5IscDvgqUUVEHuuTvHorT6HI
        KdxIzmFG5dRcQP1MZH95owpy6pYtEios6bXiNGwGsaISprEHdH/2n3q4X16OBwM2
        +O3HB7dcNgk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6EE8E46643;
        Mon, 23 Mar 2020 17:20:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F0C3746641;
        Mon, 23 Mar 2020 17:20:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 3/5] bugreport: gather git version and build info
References: <20200302230400.107428-1-emilyshaffer@google.com>
        <20200302230400.107428-4-emilyshaffer@google.com>
Date:   Mon, 23 Mar 2020 14:20:30 -0700
In-Reply-To: <20200302230400.107428-4-emilyshaffer@google.com> (Emily
        Shaffer's message of "Mon, 2 Mar 2020 15:03:58 -0800")
Message-ID: <xmqq4kue4vkx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FFF7926-6D4C-11EA-BD2C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +The following information is captured automatically:
> +
> + - 'git version --build-options'

Good.  

Do make sure to give us the same information as if the end user
typed that command from the command line.  There may be more than
one directory on $PATH that has "git" in it; we want to see the one
that is giving trouble to the end user, not necessarily the one that
came from the same source as running "git bugreport" was compiled
from, so it is a good idea not to rely on the contents of static
git_version_string[] array that came in libgit.a that the bugreport
tool happened to be linked with.
   
It may not be in the scope of this step, but we'd want to see
versions of executables for the python interpreter (2vs3), the
tcl/tk interpreter (i.e. wish), the shell (i.e. bash, dash, etc.).

In addition to them, we would want to see versions of some of our
own binaries (i.e. "git", and transports that are separate
executable files).  It would lead to a confusing diagnositic session
if the end-user's PATH has /usr/bin and then $HOME/bin, and the
end-user has a newer version of "git" with "bugreport" only in
$HOME/bin.  The user may think s/he is using the latest
self-compiled "git", and "bugreport" might even agree if it trusts
anything determined when "bugreport" was compiled, but in reality
the version of "git" used largely was coming from "/usr/bin" except
for any new subcommands, or something silly like that, and asking
the environment just like the end user does is the only way to make
sure we are getting the true piture.

Thanks.
