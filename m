Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CB0C202D7
	for <e@80x24.org>; Tue,  7 Mar 2017 07:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751579AbdCGHSU (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 02:18:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52622 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751493AbdCGHST (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 02:18:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 172CC769B9;
        Tue,  7 Mar 2017 02:16:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aL6cFhIpKiTNsrXvWAz9Aer0pAA=; b=Sor579
        wvvXDGZDY2vr8qcKXrccKKUuW01UuIBrHhjgh+mDbkc183EmhlySW6L6iuBlS9/s
        k0FMsCPS7uDOs+vdY31CAayCrkR8+FLGNW0njm/4ZhR4HZMhYi3aT+wUJPrXoa3c
        90l4kYvTBt9PScqs44qNYNDs0y8UtkOKq0bFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PmCF0aVHoueiwr5Wm6PyCKnX0llHmFVS
        EaG9Y5XU+RomgmBQm8EEGX6ivOFl46KLPbqcw0pBSm1NhIdhgbebIsRTyf42BYX8
        GmrLmZzaDcvEeLRDKx8RmsaXY/sL4qGajuS/dBQy/HbzKhowGZkXZnaSaBoW/kue
        PfWSI74SDmw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10197769B8;
        Tue,  7 Mar 2017 02:16:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.84])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6C40E769B7;
        Tue,  7 Mar 2017 02:16:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     szeder.dev@gmail.com, email@benjaminfuchs.de, git@vger.kernel.org,
        sandals@crustytoothpaste.net, ville.skytta@iki.fi
Subject: Re: [RFC PATCH] rev-parse: add --show-superproject-working-tree
References: <CAGZ79kZv=LoP+nG0GVtU_Zi+_SX8_98AXFqzXNh=xM6ASy+=Gw@mail.gmail.com>
        <20170307034553.10770-1-sbeller@google.com>
        <xmqqvarly8hn.fsf@junio-linux.mtv.corp.google.com>
Date:   Mon, 06 Mar 2017 23:16:41 -0800
In-Reply-To: <xmqqvarly8hn.fsf@junio-linux.mtv.corp.google.com> (Junio
        C. Hamano's message of "Mon, 06 Mar 2017 21:13:40 -0800")
Message-ID: <xmqqr329y2sm.fsf@junio-linux.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03B88DF6-0306-11E7-AE9A-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +	dirname = relative_path(xgetcwd(), one_up, &sb);
>
> So, the idea is we start at the root level of the current project's
> working tree, and we go up one level, then we know the last component
> of the path our submodule is bound at in the superproject.
>
>> +	prepare_submodule_repo_env(&cp.env_array);
>> +	argv_array_pop(&cp.env_array);
>> +	argv_array_pushl(&cp.args, "--literal-pathspecs", "-C", "..",
>> +			"ls-tree", "HEAD", "--", dirname, NULL);
>
> This would ask our superproject what is at the "dirname" in its
> HEAD.  Two possible issues:
>
>  - Shouldn't that be looking at its index instead?  It would be more
>    correct for unborn branch case, and new or moved submodule case.
>
>  - If our submodule is bound at path sub/dir in the superproject,
>    the relative-path thing above would get "dir" and this ls-tree
>    ends up asking what is at "dir", but the question you really want
>    to ask is what is at "sub/dir", isn't it?

IOW, the basic ontline of the idea may be OK, but I think you would
want to do something along this line:

    - chdir to .. from the root of your submodule working tree;
    - in that .. directory, ask what prefix it is (you'd get
      "sub/dir", or "not a git" if you are not a submodule);
    - in that .. directory, ask ls-files what sub/dir is;
    - if it is 160000, you're happy.

