Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 426791F453
	for <e@80x24.org>; Sun, 23 Sep 2018 18:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeIWXzN convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 23 Sep 2018 19:55:13 -0400
Received: from elephants.elehost.com ([216.66.27.132]:57564 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbeIWXzM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Sep 2018 19:55:12 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea ([64.141.110.67])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w8NHuq4c050346
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 23 Sep 2018 13:56:53 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'John Austin'" <john@astrangergravity.com>,
        "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
Cc:     <id@joeyh.name>, "'Taylor Blau'" <me@ttaylorr.com>,
        <git@vger.kernel.org>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Lars Schneider'" <larsxschneider@gmail.com>,
        <pastelmobilesuit@github.com>
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com> <20180914190025.GJ55140@syl> <CA+AhR6fH4=VbuMPasbaH9u52Y=tgJJzhgxosPOb3819ivCVJOg@mail.gmail.com> <20180915164052.GA88932@syl> <878t41lcfi.fsf@evledraar.gmail.com> <20180917135525.GF71477@syl> <874leokw3p.fsf@evledraar.gmail.com> <20180917164705.GA28056@kitenet.net> <8736u8kpgu.fsf@evledraar.gmail.com> <CA+AhR6doYuwoucdcN9aKw7-HxgR-qa6OiN4Dnzcy5rifL8PYvg@mail.gmail.com>
In-Reply-To: <CA+AhR6doYuwoucdcN9aKw7-HxgR-qa6OiN4Dnzcy5rifL8PYvg@mail.gmail.com>
Subject: RE: Git for games working group
Date:   Sun, 23 Sep 2018 13:56:37 -0400
Message-ID: <000501d45366$cf437060$6dca5120$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJCK+yvnEb5QI/ikbJlwoBcKKGxtwJ84Xf9AsGEat8CU8XVTAJ6d6v5Avvgq9ICrS113AHKd7YBAfgV/8YBqRD4eKN5aQDA
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 23, 2018 1:29 PM, John Austin wrote:
> I've been putting together a prototype file-locking implementation for a
> system that plays better with git. What are everyone's thoughts on
> something like the following? I'm tentatively labeling this system git-sync or
> sync-server. There are two pieces:
> 
> 1. A centralized repository called the Global Graph that contains the union git
> commit graph for local developer repos. When Developer A makes a local
> commit on branch 'feature', git-sync will automatically push that new commit
> up to the global server, under a name-spaced
> branch: 'developera_repoabcdef/feature'. This can be done silently as a
> force push, and shouldn't ever interrupt the developer's workflow.
> Simple http queries can be made to the Global Graph, such as "Which
> commits descend from commit abcdefgh?"
> 
> 2. A client-side tool that queries the Global Graph to determine when your
> current changes are in conflict with another developer. It might ask "Are
> there any commits I don't have locally that modify lockable_file.bin?". This
> could either be on pre-commit, or for more security, be part of a read-only
> marking system ala Git LFS. There wouldn't be any "lock" per say, rather, the
> client could refuse to modify a file if it found other commits for that file in the
> global graph.
> 
> The key here is the separation of concerns. The Global Graph is fairly
> dimwitted -- it doesn't know anything about file locking. But it provides a
> layer of information from which we can implement file locking on the client
> side (or perhaps other interesting systems).
> 
> Thoughts?

I'm encouraged of where this is going. I might suggest "sync" is the wrong name here, with "mutex" being slightly better - I would even like to help with your effort and have non-unixy platforms I'd like to do this on.

Having this separate from git LFS is an even better idea IMO, and I would suggest implementing this using the same set of build tools that git uses so that it is broadly portable, unlike git LFS. Glad to help there too.

I would suggest that a higher-level grouping mechanism of resource groups might be helpful - as in "In need this directory" rather than "I need this file". Better still, I could see "I need all objects in this commit-ish", which would allow a revert operation to succeed or fail atomically while adhering to a lock requirement.

One bit that traditional lock-brokering systems implement involve forcing security attribute changes - so an unlocked file is stored as chmod a-w to prevent accidental modification of lockables, when changing that to chmod ?+w when a lock is acquired. It's not perfect, but does catch a lot of errors.

Cheers,
Randall


