Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF541202D7
	for <e@80x24.org>; Tue,  7 Mar 2017 07:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754684AbdCGH6m (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 02:58:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58127 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752233AbdCGH6i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 02:58:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A876A76AC2;
        Tue,  7 Mar 2017 02:23:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Sbcz5tQ4sPSCywTeyKXQ9AhbebE=; b=LnYQF3
        a/U8EqvGNykD39Q4V+Pg25SCYInzq9e+menORLZiBdJfTcmRs8xOXWRBKebC/iGE
        LOYZT5IQF5scp8fX3acyYiUpxU7cY3sq7SoJDmJLKAMvYAe90xvfMMWIWNoZnSIo
        y06fA4O0B/xWtaZfE0Z+WdVMZ2mzC8t2y3tPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HYYTSMI/mP4LZ8w18FikfP67SJkdkU+J
        cIByClhfyRW4VOyimdP+gZIa0Aw2hhfTCPq8frck01jdPjLYXox7X4MjPm681qVz
        di7dfLmuYQUyvIpLJwQacmKKzthcXM7lw5M51uySt4UL57WgNszakTVuOLzqES6z
        +wgYfOEcZlQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A20A576AC1;
        Tue,  7 Mar 2017 02:23:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.84])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2216C76AC0;
        Tue,  7 Mar 2017 02:23:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     szeder.dev@gmail.com, email@benjaminfuchs.de, git@vger.kernel.org,
        sandals@crustytoothpaste.net, ville.skytta@iki.fi
Subject: Re: [RFC PATCH] rev-parse: add --show-superproject-working-tree
References: <CAGZ79kZv=LoP+nG0GVtU_Zi+_SX8_98AXFqzXNh=xM6ASy+=Gw@mail.gmail.com>
        <20170307034553.10770-1-sbeller@google.com>
        <xmqqvarly8hn.fsf@junio-linux.mtv.corp.google.com>
        <xmqqr329y2sm.fsf@junio-linux.mtv.corp.google.com>
Date:   Mon, 06 Mar 2017 23:23:27 -0800
In-Reply-To: <xmqqr329y2sm.fsf@junio-linux.mtv.corp.google.com> (Junio
        C. Hamano's message of "Mon, 06 Mar 2017 23:16:41 -0800")
Message-ID: <xmqqh935y2hc.fsf@junio-linux.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F57F0F20-0306-11E7-8870-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>  - If our submodule is bound at path sub/dir in the superproject,
>>    the relative-path thing above would get "dir" and this ls-tree
>>    ends up asking what is at "dir", but the question you really want
>>    to ask is what is at "sub/dir", isn't it?
>
> IOW, the basic ontline of the idea may be OK, but I think you would
> want to do something along this line:
>
>     - chdir to .. from the root of your submodule working tree;
>     - in that .. directory, ask what prefix it is (you'd get
>       "sub/dir", or "not a git" if you are not a submodule);
>     - in that .. directory, ask ls-files what sub/dir is;
>     - if it is 160000, you're happy.

Nah, that wouldn't be necessary and would not work.  --prefix would
be "sub" in that case, and you'd need to concatenate the "dir" that
is the basename of the path to the submodule to get "sub/dir".  

Besides, output from "ls-files" by default is relative to cwd, so if
you did ls-files or ls-tree HEAD in "sub/", you'll find where you
came from as "dir", not "sub/dir", so the original code happens to
work even from a subdirectory of a superproject, but the reason why
it works is a bit subtle.  Perhaps it deserves in-code comment to
explain it.


