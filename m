Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50D121F667
	for <e@80x24.org>; Fri, 18 Aug 2017 06:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbdHRG4P (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 02:56:15 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:58804 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751622AbdHRG4O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 02:56:14 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.89)
        (envelope-from <mh@glandium.org>)
        id 1diayu-0005Wy-OH
        for git@vger.kernel.org; Fri, 18 Aug 2017 15:42:08 +0900
Date:   Fri, 18 Aug 2017 15:42:08 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: Revision resolution for remote-helpers?
Message-ID: <20170818064208.plkppke7efpucuwm@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

As you might remember, I'm maintaining a remote helper that allows to
talk directly to mercurial servers with git: git-cinnabar.

When dealing with "foreign (non-git) repositories", it is often
necessary to refer to revisions with their native name. With mercurial,
that's a sha1, with svn it's a revision number, etc.

Git-cinnabar does provide a helper command that gives back the git
commit from the mercurial revision (and vice versa), but that's
cumbersome to use in commands.

I was thinking it could be useful to have a special syntax for revisions
that would query a helper program. The helper program could use a
similar protocol to that of the remote helpers.

My thought is that a string like <helper>::<revision> could be used
wherever a committish is expected. That would call some helper
and request to resolve revision, and the helper would provide a git
commit as a response.

The reason for the <helper>:: prefix is that it matches the <helper>::
prefix used for remote helpers.

Now, there are a few caveats:
- <revision>, for e.g. svn, pretty much would depend on the remote.
  OTOH, in mercurial, it doesn't. I think it would be fair for the
  helper to have to deal with making what appears after :: relevant
  to find the right revision, by possibly including a remote name.
- msys likes to completely fuck up command lines when they contain ::.
  For remote helpers, the alternative that works is
  <helper>://<host>/etc.

Which leads me to think some "virtual" ref namespace could be a solution
to the problem. So instead of <helper>::, the prefix would be <helper>/.
For e.g. svn, svn/$remote/$rev would be a natural way to specify the
revision for a given remote. For mercurial, hg/$sha1.

Potentially, this could be a sort of pluggable ref stores, which could
be used for extensions such as the currently discussed reftable.

On the opposite end of the problem, I'm also thinking about git log
--decorate=<helper> displaying the mercurial revisions where branch
decorations would normally go.

I have no patch to show for it. Those are ideas that I first want to
discuss before implementing anything.

Thoughts?

Mike
