Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802F6C48BCF
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 01:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B8B61001
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 01:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhFJBn2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 21:43:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50296 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJBn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 21:43:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3995114F7B9;
        Wed,  9 Jun 2021 21:41:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mO1ih0Ejo4J6
        CiCf0Q1AkhgXzo5HfPFSTTe8LXjjX5M=; b=jeqNtiTvWqxLqCgJxOIh9R+yBPyN
        VI43S+RYnEpAN9nsR/fpmy/r2Ar+w3YdVnV+OaIlRfqdbTC+m+jzneD+CNMB+2qS
        4Kl7syS6mtn8tlSbaa9WYTOhdVKf/sDH501qtP8Wu2nnD9GTHWBUxwcWh0MTgI3d
        X8Jfrdgqm4mAp8s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 32A3714F7B8;
        Wed,  9 Jun 2021 21:41:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7D9D914F7B7;
        Wed,  9 Jun 2021 21:41:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Vojt=C4=9Bch?= Vladyka <Vojtech.Vladyka@velux.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Removing fully-merged branches
References: <DBAPR05MB7510441970BA87A456B8C0D8EC369@DBAPR05MB7510.eurprd05.prod.outlook.com>
Date:   Thu, 10 Jun 2021 10:41:24 +0900
In-Reply-To: <DBAPR05MB7510441970BA87A456B8C0D8EC369@DBAPR05MB7510.eurprd05.prod.outlook.com>
        (=?utf-8?Q?=22Vojt=C4=9Bch?= Vladyka"'s message of "Wed, 9 Jun 2021
 09:05:22 +0000")
Message-ID: <xmqqwnr2h4xn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F86AD006-C98C-11EB-BF08-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vojt=C4=9Bch Vladyka <Vojtech.Vladyka@velux.com> writes:

> I know there are command chains doing this job usually starting
> with git branch --merged followed by grep and ending with git
> branch -d but my point is why such functionality isn't in git
> client already when he has all pieces of information already and
> ability to do all of that. Maybe I am missing some reason behind
> that but to me it looks like missing feature.

I think the primary reason behind it is because the way to "prune"
(i.e. you gave a good outline yourself in your messaage) is
trivially discoverable and people can do so with more flexibility
than a hardcoded "remove every branch that does not have commits
that does not exist in the $master branch".  Add to it the fact that
those who want to make it into a "native" feature haven't produced
any usable design yet [*].

In my repository that is used to develop Git itself, for example,
"remove all branches that are merged to 'master'" is not something
I'd ever want to run, as it will lose all the maintenance tracks (it
is a rule in this project that older maintenance branches are subset
of the newer ones and the 'master' branch), and removing all topic
branches that are merged to 'maint' would not get rid of as many
stale topic branches that are already merged to 'master' and will
never be merged down to 'maint' or older maintenance tracks, so for
such a feature to be useful, I'd need to be able to express
something like:

 - If a branch is not a topic branch (identifyable by having
   two-level names like vv/topic), do not touch it.

 - If a topic branch is based on 'maint' but not merged there yet,
   keep it.

 - If a topic branch is merged to 'master' and in a tagged version
   (identifyable by having a signed tag whose name does not end with
   -rcX), lose it.

So that a bugfix topic that has appeared in the last feature release
can be kept to later be merged down to older maintenance tracks.


[Footnote]

 * As far as I remember, the message I am responding to might be the
   first to explicitly ask for such a feature.
