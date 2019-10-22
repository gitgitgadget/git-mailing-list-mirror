Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18DD81F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 13:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbfJVNy2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 09:54:28 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35222 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729425AbfJVNy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 09:54:27 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9MDrjb3029728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Oct 2019 09:53:45 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C02D9420456; Tue, 22 Oct 2019 09:53:44 -0400 (EDT)
Date:   Tue, 22 Oct 2019 09:53:44 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Willy Tarreau <w@1wt.eu>, Santiago Torres Arias <santiago@nyu.edu>,
        workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
Subject: Re: email as a bona fide git transport
Message-ID: <20191022135344.GC23268@mit.edu>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016111009.GE13154@1wt.eu>
 <20191016144517.giwip4yuaxtcd64g@LykOS.localdomain>
 <56664222-6c29-09dc-ef78-7b380b113c4a@oracle.com>
 <20191018161547.GG21137@mit.edu>
 <de49fe5e-85cb-9fb0-f9f4-c294d72e356c@oracle.com>
 <20191018191456.GI21137@mit.edu>
 <20191020031716.GA17475@1wt.eu>
 <1a259d8d-b3d1-b64e-07c3-ba143b42c442@oracle.com>
 <de6dd8b5-5c28-d0b2-d3fc-e72a6d643105@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de6dd8b5-5c28-d0b2-d3fc-e72a6d643105@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 22, 2019 at 02:11:22PM +0200, Vegard Nossum wrote:
> 
> As I wrote in there, we could already today start using
> 
>   git am --message-id
> 
> when applying patches and this would provide something that a bot could
> annotate with git notes pointing to lore/LKML/LWN/whatever. I think that
> would already be a pretty nice improvement over today's situation.
> 
> Sadly, since the beginning of 2018, this was only used for a measly
> ~0.14% of all non-merge commits in the kernel:
> 
> $ git rev-list --count --no-merges --since='2018-01-01' --grep 'Message-Id:
> ' linus/master
> 178

You might also want to count commits which have a link tag with a
Message-Id:

Link: https://lore.kernel.org/r/c3438dad66a34a7d4e7509a5dd64c2326340a52a.1571647180.git.mbobrowski@mbobrowski.org

That's because some kernel developers have been using a hook script like this:

#!/bin/sh
# For .git/hooks/applypatch-msg
#
# You must have the following in .git/config:
# [am]
#	messageid = true
	
. git-sh-setup
perl -pi -e 's|^Message-Id:\s*<?([^>]+)>?$|Link: https://lore.kernel.org/r/$1|g;' "$1"
test -x "$GIT_DIR/hooks/commit-msg" &&
	exec "$GIT_DIR/hooks/commit-msg" ${1+"$@"}
:

.... as we had reached rough consensus that this was the best way to
incorprate the message id (since it could made to be a clickable link
in tools like gitk, for example).  This rough consensus has only been
in place since around the time of the Maintainer's Summit in Lisbon,
so uptake is still probably a bit slow.  I'd expect to see a lot more
of this in the next merge window, though.

						- Ted
