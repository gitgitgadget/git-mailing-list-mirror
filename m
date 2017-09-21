Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F130202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 01:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbdIUBKc (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 21:10:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62732 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751681AbdIUBKb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 21:10:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 69BCFA6355;
        Wed, 20 Sep 2017 21:10:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5VyXQSIQHGfMFYIMy94SPa7JCnA=; b=VBtKpt
        HSyMPMpoew0KTDjNis8jx6W20mbcdEkoRQmeyKaKm69LBEpQ/2k332cmO9kk0dN/
        3EEAn5mx9os4JUmvOXX1LNvxuI2V/kddKagXmJphKnSEYndHWjLwkVj/2GXx2O1v
        VRYijOLqy0tvjzMghSVlcOLlyH8PdzSRsgVpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eWpdY3ak71Tr3N563Q/UAfUXj/1i7WUc
        OJhDyTK3Xsw9/UyO2dPCalvdcUPTLRZpQ+IoYaRzG4hWZg4RZIzqUePWlBMx+nov
        7nI5QelnT0TPhK/FaM3xd1ov0YnebkduCAk9IBj/NDcA95T86Nv9ritv4gW2dNBt
        jc7urO4MPvY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 61628A6354;
        Wed, 20 Sep 2017 21:10:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B03EAA6351;
        Wed, 20 Sep 2017 21:10:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCHv3] builtin/merge: honor commit-msg hook for merges
References: <xmqqd174bzco.fsf@gitster.mtv.corp.google.com>
        <20170907220429.31312-1-sbeller@google.com>
        <1505542931.27598.4.camel@gmail.com>
        <CAGZ79kaN4nKwGXq9t+Lv9e4X6qkBUAj4S8gofrNj3VZYw1sv+w@mail.gmail.com>
Date:   Thu, 21 Sep 2017 10:10:29 +0900
In-Reply-To: <CAGZ79kaN4nKwGXq9t+Lv9e4X6qkBUAj4S8gofrNj3VZYw1sv+w@mail.gmail.com>
        (Stefan Beller's message of "Wed, 20 Sep 2017 12:55:49 -0700")
Message-ID: <xmqqy3p8n9fe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A94EE98C-9E69-11E7-B90A-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I'll send a patch fixing the docs, though with this thought, maybe we need
> to fix other commands, that produce commits as well?
> (git revert, others?)

I do not think "commands that create commits" is not a good
criteria.  "git notes" and "git stash" would (internally) create a
commit while recording a new change, but you obvously would not want
these hooks to kick in.

A command that can stop in the middle and to which running "git
commit" is how the end-user concludes the operation would be a
candidate.  "git merge X", "git cherry-pick A", and "git cherry-pick
A..B" may be good candidates.

For "rebase" and others that have the "convenience --continue"
option that make a commit before continuing, I would think that we
should treat these as invoking "git commit".  That is, when these
commands stop and you resolve the conflict in the index and in the
working tree, the next "git $cmd --continue" you type is merely a
way to let you be lazy.  You'd be typing "git commit && git $cmd
--continue" if you were to refuse the lazy convenience option and
want to spell out what you are doing explicitly, and you'd get the
same result as you'd get from just "git $cmd --continue" if you did
so.

On the other hand, "git am" is not a candidate.  You never use "git
commit" to mark that you are done, even if you refuse to use the
lazy convenience option and spell out what you are doing explicitly.
