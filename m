Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA5462047F
	for <e@80x24.org>; Wed, 20 Sep 2017 05:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbdITFdH (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 01:33:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55229 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751556AbdITFdG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 01:33:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 15512ABA8F;
        Wed, 20 Sep 2017 01:33:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F6eb7pY0ctT0u9ULlw3qoHy2R9U=; b=Ze9MyK
        O9xVzDoF9+MSCFp4SbGCd+7y5I3DeKxZ+0vJHT+I7EacPZF0I+NHtwH511ypSBOM
        uCNW42Cr+dfupeZ8oOxe19zAtfdxnG41uieFR3pYAxX3ALHidOhsLMibJCOzk843
        xsUiT8IOda7vBrGNvkmjIl0DINYkaZiKfZTl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pUuBGPlxHtxkHfEvootw//bGmos2NaYa
        dzDWJm9VL/Jxw3rcraK2JnLbTI4e8TZ/lIYqts3OMjvsCu5598CzDv5QTNhRkS3c
        2ZC4JnpWmCtWNmQ17YJMvrrfaWiDf73ntgrAjxrgo4JNQ2ggDy7xknwZK/lUD9Bw
        MrvyiWQbt/M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E29DABA8E;
        Wed, 20 Sep 2017 01:33:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5DC2EABA8B;
        Wed, 20 Sep 2017 01:33:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Behaviour of 'git stash show' when a stash has untracked files
References: <1505626069.9625.6.camel@gmail.com>
Date:   Wed, 20 Sep 2017 14:33:04 +0900
In-Reply-To: <1505626069.9625.6.camel@gmail.com> (Kaartic Sivaraam's message
        of "Sun, 17 Sep 2017 10:57:49 +0530")
Message-ID: <xmqqfubinddb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D678102-9DC5-11E7-AD28-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> Some time ago, I stashed a few changes along with untracked files. I
> almost forgot it until recently. Then I wanted to see what I change I
> had in the stash. So I did a 'git stash show <num>'. It worked fine but
> didn't say anything about the untracked files in that stash. That made
> me wonder where the untracked files I added went. I then applied the
> stash to see that they were still there but weren't listed in show.
>
> I understand that they aren't listed because 'git stash show' is
> typically a "diff between the stashed state and its original parent" as
> the documentation says but shouldn't there be at least a message that
> the stash contains untracked files? Those untracked files are "part of
> the stash" and I see no way to get information about their presence
> currently.
>
> So, should this behaviour be changed?

Hmm, crickets tell us that nobody is all that interested in this, it
seems.  I do not think I'd be against a new feature that lets users
ask what untracked paths are in the stash (and even their contents),
but I do think it is a bad idea to change a vanilla "stash show" to
show that information in addition to what is currently shown.

Two things need to be designed carefuly.  One is the UI to _invoke_
the new feature, the other is the output from the new feature.

As to the invocation, an obvious pair of choices are:

 - "git stash show-untracked stash@{0} [ [--] <pathspec>]"?
 - "git stash show --untracked stash@{0} [ [--] <pathspec>]"?

I'd personally vote for the former, if only because the latter makes
the design more complicated.  For one thing, tying the feature to
"show" means the output _must_ be in the form of "diff" output in
order to be consistent with the normal output from the subcommand,
but a whole-file creation diff may not be the best way to show the
entire contents of an untracked file.  Also by adding it as an
option to the existing "show" command, it makes it debatable if the
output should show the contents of untracked files in addition to
the stashed changes of tracked paths, or in place of them.  Because
I suspect that viewing contents of the untracked files and the
changes to tracked paths may serve quite different purposes from the
point of view of expected use cases, I am leaning towards saying
that it is a bad idea to show contents of untracked paths in
addition to changes to tracked paths.  There probably are other
reasons why we should prefer the former, i.e. a separate subcommand
to "git stash", independent of the existing "git stash show".

Assuming that we choose to go with a separate command, the output
format from the command does not have to be in the form of patch, so
perhaps "git stash show-untracked --list" may be a way to list the
paths (and we may want -z to show the list NUL-terminated like
"ls-files" does)?  There may be other operations to help those who
want a way to learn about untracked paths in a stash.  But this is
not exactly my itch so I'll let people who do have the itch to work
on designing the details out.



