Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69179C2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 20:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 384BD6194F
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 20:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhFYUu4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 16:50:56 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:23121 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhFYUuy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 16:50:54 -0400
Received: from host-78-147-180-220.as13285.net ([78.147.180.220] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lwskX-0005rM-Cg; Fri, 25 Jun 2021 21:48:30 +0100
Subject: Re: Definition of "the Git repository"
To:     Kevin Buckley <Kevin.Buckley@pawsey.org.au>, git@vger.kernel.org
References: <7dd55e85-38eb-7346-ff10-7124102cd22b@pawsey.org.au>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <435b0150-cd9f-32ce-7a07-3057ef20662a@iee.email>
Date:   Fri, 25 Jun 2021 21:48:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7dd55e85-38eb-7346-ff10-7124102cd22b@pawsey.org.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kevin,

On 25/06/2021 02:44, Kevin Buckley wrote:
> Hi there,
>
> raising this on the back of a discussion over at the Software
> Carpentry lesson about Git,
>
>    https://github.com/swcarpentry/git-novice/issues/810
>
> I used the book to justify my claim that it is the .git directory
> that is the repository, but I do have to concede that the way that
> the text in section 2.1 of the book reads, does suggest that one
> can refer to the working directory PLUS the .git directory as a
> "repository" as well as being able to refer to the .git directory
> alone as the "repository".
>
> In the way I think of it
>
> git init
>
> initialises a Git repository, however, the only thing that changes
> as a result is that a .git directory has been created, ergo, the
> .git directory is the repository.
>
> Furthermore, the fact that one can take the .git directory, move it
> to a new directory and start using it there (very much a nice feature)
> also suggests to me that it is the .git directory that is the repository,
> as distict from a working directory, under Git control because of the
> existence of a repository within it.
>
> Interested to hear any thoughts around the semantics here,

In general, the Git semantics are confusing.

There is the generic, the conceptual and the implementation, all of the
same term which has to be understood in context (which again uses terms
with the same multi-way context..). This leapfrogging from concept to
implementation and back again causes lots of learner confusion.

You have already seen that a source directory can become a repository by
being initialised, and that the primary artefacts are in the .git
sub-directory. One can also include in the generic 'repository' the
various special .git* files that are [user] added to the main source
directory.

But it gets worse. In the .git directory there is the 'objects'
directory which actually holds all the _content_ of the 'repository',
each object named by its hash value. This object store is a superset of
those objects that form the versioned repository structure (the 'DAG'),
and other parts of Git, such as the staging area (Index) contents, and
other temporary copies of 'stuff'.

Meanwhile, to make the repository structure work, there are 'branch'
pointers (see 'ref/heads' [0]) to the specific object hashes that
provide the _starting point_ for each branch's linked list of commits
and their content.

The use of the write-once unique object hash names [1] is part of that
implementation 'trickery' that allows Git to work so well, but helps
confuse those who think the object store is synonymous with the
repository (e.g. all the new learners..).

In summary, everyone is right, as long as they are clear about the
context. Which they rarely are.

Philip

[0] the 'ref name's are just strings that conveniently look just like
posix paths ...
[1] the current hash is the 160 bit sha1, so roughly 1 : 10^24  chance
of a collision - unique enough;-)
