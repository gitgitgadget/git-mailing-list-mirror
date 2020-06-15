Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9500EC433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 19:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78AC420714
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 19:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbgFOThh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 15:37:37 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:28196 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728571AbgFOThh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 15:37:37 -0400
Received: from host-89-243-191-101.as13285.net ([89.243.191.101] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jkuvG-0005oh-8G; Mon, 15 Jun 2020 20:37:34 +0100
Subject: Re: Collaborative conflict resolution feature request
To:     Junio C Hamano <gitster@pobox.com>,
        "Curtin, Eric" <Eric.Curtin@dell.com>
Cc:     Konstantin Tokarev <annulen@yandex.ru>,
        Christian Couder <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Geary, Niall" <Niall.Geary@dell.com>,
        "rowlands, scott" <Scott.Rowlands@dell.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "Coveney, Stephen" <Stephen.Coveney@Dell.com>
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
 <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD0aoNQNcNJytJBazoKj0jvWwykntHHgnYoCBXr6OmGOnQ@mail.gmail.com>
 <xmqqa716zs7w.fsf@gitster.c.googlers.com> <30661592138737@mail.yandex.ru>
 <BY5PR19MB34007DEED68D13003C614F5F909C0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <c4ebf430-a69d-3d46-bfb9-37c9ece9f519@iee.email>
 <xmqq1rmgxo67.fsf@gitster.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <8b0e65ec-02c1-a1c7-b363-e81f37f3fe7e@iee.email>
Date:   Mon, 15 Jun 2020 20:37:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <xmqq1rmgxo67.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,
On 15/06/2020 17:57, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>> It could be effectively a special strategy. IIUC the '--' separator is
>> already supported by the underlying parser code, so may not be that
>> hard? (perhaps a local contribution to the codebase;-). Just a thought.
> Assuming that there are paths A and B that would leave conflict in
> an attempted merge between commits X and Y,
Are we confusing the file merge X.A and Y.A with X.B and Y.B?

The scenario envisaged is that dev.a has responsibility over the .A file
merge, while dev.b will handle the merge for .B merge (e.g. different
parts of the driver code).

>  you somehow resolve the
> conflict in A and leave B unresolved,
So dev.a has resolved the .A conflicts, and the .B file(s) is still in
the .ours state - no conflict (i.e. we have an 'ours' strategy for all
files not in the A path(s)).

>  what would you pass to the
> other person and ask to resolve the conflicts in B?
Yes the merge that dev.a has performed is passed onto dev.b to complete
a second merge, apparently of the same commit, which is essentially
similar to cherry picking the .B files from the .theirs commit [1].

>   It cannot be a
> merge commit that records X and Y as its parents and a single tree
> object as the result, because the whole point of this is that you do
> not even know what to record for B.
if no merge is attempted for paths not in the A set then the other B set
are never 'in conflict'. As I understand Eric's conundrum, it's that a
plain merge throws too many conflicts at the one developer. This
suggestion would be the way to reduce the number of conflicts just to
the paths the one dev can handle. A lot will depend on how Eric's
problem is partitioned and the depth of the overlaps.
>
> I think the most important and useful part of this is to design the
> data format used for that task of passing from you to the other
> person.  The way to specify which paths are yours etc. are much less
> interesting and trivial part of the story, I would think.
A list of un-merged paths (i.e. not attempted) is one such format, surely?

Philip

[1] actually, it's more like a soft checkout or restore of those files
from the merging branch. (exchange format becomes list of merged
paths...).  Which  then leads easily to the available `git checkout`
options (assuming the approach has validity for Eric's scenario).

