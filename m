Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F7BD20A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 05:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbeLHFoU (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 00:44:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63541 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbeLHFoT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 00:44:19 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 64581110BA7;
        Sat,  8 Dec 2018 00:44:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eLlXg/buFiliEzw36HTiWkl5Uwc=; b=SxfmTV
        lGhcePqx3Ex5NCHucOnUkn8y/oKGOBqguU22AUkjErcIEdAxYV/VGilJAIAP/Wq9
        VWqXPDAQCUJcIreTmhPcg1wkJhISIz13p08x0iBvM6VnX6HqhwG7zzz5l6fhQfQz
        gKB+xX9UvOBndRbOvHnbrozO3YPNnGO70pKzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cWZ6sSnyz5GtczJ/7sDprWmaxKqYtShi
        eLfrWbP7m1aC/BtY4TxkpfYF74vJQmWthzAfUqlaw5T9FitxneBs+m8Oli8WYaXL
        QcZ7yKwR6v8tZao5+OSHhk05BqnZQeUxf2JYFZykHljim32j4MOumZS0eNHPfcg6
        8E4dFSx18Ao=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CA7F110BA6;
        Sat,  8 Dec 2018 00:44:17 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C9D83110BA5;
        Sat,  8 Dec 2018 00:44:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] commit: abort before commit-msg if empty message
References: <20181207224817.231957-1-jonathantanmy@google.com>
Date:   Sat, 08 Dec 2018 14:44:15 +0900
In-Reply-To: <20181207224817.231957-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 7 Dec 2018 14:48:17 -0800")
Message-ID: <xmqqin048te8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D0665EC-FAAC-11E8-BD87-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When a user runs "git commit" without specifying a message, an editor
> appears with advice:
>
>     Please enter the commit message for your changes. Lines starting
>     with '#' will be ignored, and an empty message aborts the commit.
>
> However, if the user supplies an empty message and has a commit-msg hook
> which updates the message to be non-empty, the commit proceeds to occur,
> despite what the advice states.

When "--no-edit" is given, and when commit-msg fills that blank, the
command should go ahead and record the commit, I think.

An automation where commit-msg is used to produce whatever
appropriate message for the automation is entirely a reasonable
thing to arrange.  Of course, you can move the logic to produce an
appropriate message for the automation from commit-msg to the script
that drives the "git commit" and use the output of that logic as the
value for the "-m" option to achieve the same, so in that sense,
there is an escape hatch even if you suddenly start to forbid such a
working set-up, but it nevertheless is unnecessary busywork for those
with such a set-up to adjust to this change.

I actually think in this partcular case, the commit-msg hook that
adds Change-ID to an empty message is BUGGY.  If the hook looked at
the message contents and refrains from making an otherwise empty
message to non-empty, there is no need for any change here.

In any case, you'll have plenty of time to make your case after the
rc freeze.  I am not so sympathetic to a patch that makes us bend
backwards to support such a buggy hook to e honest.


