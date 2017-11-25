Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C49D92036D
	for <e@80x24.org>; Sat, 25 Nov 2017 03:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbdKYD3M (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 22:29:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51010 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751802AbdKYD3L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 22:29:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB6F2C37B4;
        Fri, 24 Nov 2017 22:29:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SnpatZg3udKOTR71a54YanD/86w=; b=lzSjUh
        3IEZghyfQ9REkct0QuquzmVNf6t5XbzoMi61V0KeRQPG7EVETPD35E2KfnDdEkww
        90kIgzve7dFN+Mn6GjXOEwc03vvTO+rUVp7MkhiJmBFeX3VyJ/mMrQ6cPtt/mZjG
        YEuqdkByRqo1eQaARLoQwupnl3sdKeBDc0irM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D6n9My5TGC6SmMYF99EJevJT0G+r3K4A
        prMXFD3/f1YRPvQJootI1omXL5va8NS81idfWF6I62tOCjLuH0XKRW7KyyTQypzM
        //2IFDqJ6EUwskr4H49DQsCTm16m0Qc0H8xyTYbkjoMSV+THvVm4boXc1Bf9ePdp
        T5Fy9KWDI6E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E330BC37B3;
        Fri, 24 Nov 2017 22:29:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5A92BC37B1;
        Fri, 24 Nov 2017 22:29:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
        David Turner <dturner@twitter.com>,
        David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] merge-recursive: ignore_case shouldn't reject intentional removals
References: <20171124195901.2581-1-newren@gmail.com>
Date:   Sat, 25 Nov 2017 12:29:09 +0900
In-Reply-To: <20171124195901.2581-1-newren@gmail.com> (Elijah Newren's message
        of "Fri, 24 Nov 2017 11:59:01 -0800")
Message-ID: <xmqqd147kpdm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD0EF5C4-D190-11E7-A308-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>     But what it really is forced to do is more of a 4-way merge; a good
>     chunk of its annoying complexity is based around this (undocumented
>     and unfortunate) reality.  It derives from what I consider a simple
>     design flaw.

Yes, and it does not help that it wants to write into the filesystem
while it performs the outermost merges.

In the ideal world, we should

 - ask unpack_trees() to do "read-tree -m" without "-u";

 - do all the merge-recursive computations in-core and prepare the
   resulting index, while keeping the current index intact;

 - compare the current in-core index and the resulting in-core
   index, and notice the paths that need to be added, updated or
   removed in the working tree, and ensure that there is no loss of
   information when the change is reflected to the working tree,
   e.g. the result wants to create a file where the working tree
   currently has a directory with non-expendable contents in it, the
   result wants to remove a file where the working tree file has
   local modification, etc.; and then finally

 - carry out the working tree update to make it match what the
   resulting in-core index says it should look like.



   
