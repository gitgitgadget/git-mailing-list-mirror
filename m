Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 099131F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 19:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395011AbfJRTnW (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 15:43:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394892AbfJRTnV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 15:43:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4AE74307D986;
        Fri, 18 Oct 2019 19:43:21 +0000 (UTC)
Received: from redhat.com (dhcp-10-20-1-15.bss.redhat.com [10.20.1.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DEA3579A7;
        Fri, 18 Oct 2019 19:43:20 +0000 (UTC)
Date:   Fri, 18 Oct 2019 15:43:19 -0400
From:   Peter Jones <pjones@redhat.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 2/2] Make "git branch -d" prune missing worktrees
 automatically.
Message-ID: <20191018194317.wvqphshpkfskvkyh@redhat.com>
References: <20191017162826.1064257-1-pjones@redhat.com>
 <20191017162826.1064257-2-pjones@redhat.com>
 <CAPig+cS6SzLdgmzffNkg72YSiDQ9eQRqTK12NsraKpGbkJFY_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cS6SzLdgmzffNkg72YSiDQ9eQRqTK12NsraKpGbkJFY_w@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 18 Oct 2019 19:43:21 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 17, 2019 at 06:44:26PM +0200, SZEDER Gábor wrote:
> >  	if (!wt || (ignore_current_worktree && wt->is_current))
> >  		return;
> > +	if (access(wt->path, F_OK) < 0 &&
> > +	    (errno == ENOENT || errno == ENOTDIR))
> > +		return;
> 
> I think this check is insuffient: even if the directory of the working
> tree is not present, the working tree might still exist, and should
> not be ignored (or deleted/pruned in the second patch).
> 
> See the description of 'git worktree lock' for details.

Ah, thanks for that, I had not realized "lock" was relevant here as I
have never used it.  That explains some of what seemed to me like a very
strange usage model.

On Thu, Oct 17, 2019 at 01:28:09PM -0400, Eric Sunshine wrote:
> Echoing SEZDER's comment on patch 1/2, this behavior is an intentional
> design choice and safety feature of the worktree implementation since
> worktrees may exist on removable media or remote filesystems which
> might not always be mounted; hence, the presence of commands "git
> worktree prune" and "git worktree remove".

Okay, I see that use case now - I hadn't realized there was an
intentional design decision here, and honestly that's anything but clear
from the *code*.  It's surprising, for example, that my patches didn't
break a single test case.

> A couple comment regarding this patch...

Sure...

> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > @@ -133,6 +133,20 @@ static int prune_worktree(const char *id, struct strbuf *reason)
> > +int prune_worktree_if_missing(const struct worktree *wt)
> > +{
> > +       struct strbuf reason = STRBUF_INIT;
> > +
> > +       if (access(wt->path, F_OK) >= 0 ||
> > +           (errno != ENOENT && errno == ENOTDIR)) {
> > +               errno = EEXIST;
> > +               return -1;
> > +       }
> > +
> > +       strbuf_addf(&reason, _("Removing worktrees/%s: worktree directory is not present"), wt->id);
> > +       return prune_worktree(wt->id, &reason);
> > +}
> 
> "git worktree" tries to clean up after itself as much as possible. For
> instance, it is careful to remove the .git/worktrees directory when
> the last worktree itself is removed (or pruned). So, the caller of
> this function would also want to call delete_worktrees_dir_if_empty()
> to follow suit.

Okay, will fix.

> > diff --git a/worktree.h b/worktree.h
> > @@ -132,4 +132,10 @@ void strbuf_worktree_ref(const struct worktree *wt,
> > +/*
> > + * Prune a worktree if it is no longer present at the checked out location.
> > + * Returns < 0 if the checkout is there or if pruning fails.
> > + */
> > +int prune_worktree_if_missing(const struct worktree *wt);
> 
> It's rather ugly that this function is declared in top-level
> worktree.h whereas the actual implementation is in builtin/worktree.c.

I don't disagree, but I didn't want to move stuff into an exposed API if
I didn't have to, and that seemed like an appropriate enough header.  I
can do it the other way though, no problem.

> I'd expect to see a preparatory patch which moves prune_worktree()
> (and probably delete_worktrees_dir_if_empty()) to top-level
> worktree.c.

Sure thing.

> These minor implementation comments aside, before considering this
> patch series, it would be nice to see a compelling argument as to why
> this change of behavior, which undercuts a deliberate design decision,
> is really desirable.

Okay, so just for clarity, when you say there's a deliberate design
decision, which behavior here are you talking about?  If you mean making
"lock" work, I don't have any issue with that.  If you mean not cleaning
up when we do other commands, then I don't see why that's a concern -
after all, that's exactly what "lock" is for.

Assuming it is the "lock" behavior we're talking about, I don't think I
actually have any intention of breaking this design decision, just
making my workflow (without "lock") nag at me less for what seem like
pretty trivial issues.

I can easily accommodate "git worktree lock".  What bugs me though, is
that using worktrees basically means I have to replace fairly regular
filesystem activities with worktree commands, and it doesn't seem to be
*necessary* in any way.  And I'm going to forget.  A lot.

To me, there doesn't seem to be any reason these need to behave any different:

$ git worktree add foo foo
$ rm -rf foo
vs
$ git worktree add foo foo
$ git worktree remove foo

And in fact the only difference right now, aside from some very
minuscule storage requirements that haven't gotten cleaned up, is the
first one leaves an artifact that tells it to give me errors later until
I run "git worktree prune" myself.  

I'll send another revision of this patchset as a reply to this mail,
which should clear up some of our differences.

-- 
  Peter
