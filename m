Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D796D203C2
	for <e@80x24.org>; Fri, 15 Jul 2016 23:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbcGOXRF (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 19:17:05 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:44934 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481AbcGOXRE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 19:17:04 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1bOCLo-0002lJ-Vc; Sat, 16 Jul 2016 08:16:56 +0900
Date:	Sat, 16 Jul 2016 08:16:56 +0900
From:	Mike Hommey <mh@glandium.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] blame: Allow to blame paths freshly added to the index
Message-ID: <20160715231656.iztvtftk5ttrzeow@glandium.org>
References: <20160715024254.29186-1-mh@glandium.org>
 <xmqqvb06lita.fsf@gitster.mtv.corp.google.com>
 <xmqqr3auli2x.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr3auli2x.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.1-neo (2016-06-11)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

> I suspect that this would be useful without copy detection.  If you
> "git mv fileA fileB" (optionally followed by "edit fileB"), fileB
> would not be in HEAD but you should be able to trace the lineage of
> the lines in it back through the renaming event, and this change
> also allows that use case, no?

It should, but that'd be copy/move detection, wouldn't it? :)

> > I suspect that the above change needs to be updated further if the
> > user wants to run "blame path" during a conflicted renaming merge,
> > i.e.
> >
> >  0. Before two histories diverged, there was old_path.
> >  1. Our side updated contents of that file and kept it at old_path.
> >  2. Their side updated contents of that file and moved it to path.
> >  3. "git merge" notcied the rename, created three stages at "path",
> >     with the result of conflicted content-level merge in the working
> >     tree at "path".
> >  4. The user edits "path" and resolves the conflict, but wants to
> >     double check before running "git add path".
> >  5. "git blame path"
> >
> > Perhaps something like this should suffice:
> >
> >     pos = cache_name_pos(path, strlen(path));
> >     if (0 <= pos)
> >     	; /* ok */
> >     else if (!strcmp(active_cache[-1 - pos]->name), path)
> >         ; /* ok -- just unmerged */
> >     else
> >     	die("no such path in HEAD");
> 
> I do not think the "conflicted renaming merge" example would not be
> a problem in practice iff "git merge" was used, because the fake
> working tree commit would look at both our tree and their tree, and
> find "path" in theirs inside the loop above this "die".

More than that, it seems that's a case that already works without the
patch (it doesn't complain that "no such path in HEAD", although it
only identifies the "theirs" part of the merge conflict when blaming
the file straight out of the merge failure, but that'd be a separate
issue.

> But the user can be in the same conflicted rename situation with
> "git am -3" or cherry-pick, and in these cases there won't be extra
> parent commits for the fake work tree commit, hence the conclusion
> does not change.

Indeed, with cherry-pick, the "no such path in HEAD" error is happening
with the patch.

Mike
