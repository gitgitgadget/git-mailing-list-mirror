Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64E4D1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 14:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753175AbdFMOl6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 10:41:58 -0400
Received: from smtp114.iad3a.emailsrvr.com ([173.203.187.114]:47629 "EHLO
        smtp114.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752326AbdFMOl6 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Jun 2017 10:41:58 -0400
Received: from smtp39.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp39.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id EE86C6147;
        Tue, 13 Jun 2017 10:41:56 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp39.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id C31E557AF;
        Tue, 13 Jun 2017 10:41:56 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Tue, 13 Jun 2017 10:41:56 -0400
Subject: Re: proposal for how to share other refs as part of refs/tracking/*
To:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
References: <CA+P7+xrMX+gxQrsB9kcy3RkDL=eDXb_TQ-V+2vH+ir0Sbef8Xg@mail.gmail.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <48064f67-6d88-8c14-853e-fd9214d26647@xiplink.com>
Date:   Tue, 13 Jun 2017 10:41:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CA+P7+xrMX+gxQrsB9kcy3RkDL=eDXb_TQ-V+2vH+ir0Sbef8Xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-06-12 06:58 PM, Jacob Keller wrote:
> Hi,
> 
> There's no actual code yet, (forgive me), but I've been thinking back
> to a while ago about attempting to find a way to share things like
> refs/notes, and similar refs which are usually not shared across a
> remote.
> 
> By default, those refs are not propagated when you do a push or a
> pull, and this makes using them in any project which has more then one
> repository quite difficult.
> 
> I'm going to focus the discussion primarily on refs/notes as this is
> what I am most interested in, but I think similar issues exist for
> refs/grafts and refs/replace, and maybe other sources?

More formal support for custom ref namespaces would be a boon.  For 
example, we have our nightly builds create a "build/w.x.y-z" ref (we 
only want to tag official releases).  Sharing those refs is not hard, 
but a bit obscure.

> For branches, we already have a system to share the status of remote
> branches, called "refs/remotes/<remote-name>/<branch-name>"
> 
> This hierarchy unfortunately does not keep space for non-branches,
> because you can't simply add a "refs/remotes/notes/<>" or
> "refs/remotes/<name>/notes" to this as it would be ambiguous.
> 
> Now, you might just decide to push the refs/notes directly, ie:
> 
> git push origin refs/notes/...:refs/notes/...
> 
> Unfortunately, this has problems because it leaves no standard way to
> distinguish your local work from what is on the remote, so you can't
> easily merge the remote work into yours.

There was a related discussion in the run-up to 1.8.0, about a "remote 
tag namespace" to support having different remotes with the same tag 
name for different objects.  See these messages and their surrounding 
threads:

http://public-inbox.org/git/AANLkTikeqsg+qJ0z4iQ6ZmKL=_HB8YX_z20L=dFFApmA@mail.gmail.com/

http://public-inbox.org/git/AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com/

http://public-inbox.org/git/201102020322.00171.johan@herland.net/

The discussion explored, among other things, making 
refs/remotes/$remote/* a mirror of a remote's own refs/* hierarchy 
(well, within reason -- I think there are limits to what should be 
mirrored).

So I like your refs/tracking proposal, and hope that it aims for 
mirroring a remote's refs, to eventually replace refs/remotes entirely.

		M.


> For example, if Alice creates a new note and pushes it, then Bob
> creates a different note on the same commit, he needs to be able to
> merge Alice's changes into his note, just like one would do when two
> people commit to the same branch.
> 
> Today, he must pull the remote notes into a separate location, (since
> pulling directly into refs/notes will overwrite his work), and then
> update, and then push.
> 
> Because this is not standardized, it becomes unwieldy to actually
> perform on a day to day basis.
> 
> I propose that we add a new "refs/tracking" hierarchy which will be
> used to track these type of refs
> 
> We could even (long term) migrate refs/remotes into refs/tracking
> instead, or provide both with the refs/remotes being pointers or
> something like that..
> 
> Essentially, refs/notes would be pulled into
> refs/tracking/<remote>/notes/* or something along these lines.
> 
> Then, git notes would be modified to be able to have commands to
> "pull" and "push" notes which would fetch the remote, and then attempt
> a merge into the local notes, while a push would update the remote.
> 
> I chose "tracking" because it sort of fits the concept and does not
> include things like "remote-notes" or "remotes-v2" which are a bit
> weird.
> 
> I'm posting this on the mailing list prior to having code because I
> wanted to get a sense of how people felt about the question and
> whether others still felt it was an issue.
> 
> Essentially the goal is to standardize how any refs namespace can be
> shared in such a way that local copies can tell what the remote had at
> a fetch time, in order to allow easier handling of conflicts between
> local and remote changes, just like we do for branches (heads) but
> generalized so that other refs namespaces can get the same ability to
> handle conflicts.
> 
> Thanks,
> Jake
> 
