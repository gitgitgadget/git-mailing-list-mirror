Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E856C04E30
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 21:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DBB214AF
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 21:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfLIVJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:09:50 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:42897 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLIVJt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 16:09:49 -0500
Received: from localhost (unknown [157.36.220.219])
        (Authenticated sender: me@yadavpratyush.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 4BDCD20000B;
        Mon,  9 Dec 2019 21:09:45 +0000 (UTC)
Date:   Tue, 10 Dec 2019 02:39:42 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5Yqg6Jek5LiA5Y2a?= <kato-k@ksysllc.co.jp>,
        Jonathan Gilbert <JonathanG@iQmetrix.com>
Subject: Re: [PATCH] git gui: fix branch name encoding error on git gui
Message-ID: <20191209210942.gcyp6ch7zingkhfs@yadavpratyush.com>
References: <20191207002842.32208-1-kato-k@ksysllc.co.jp>
 <xmqqpngxux78.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqpngxux78.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/12/19 11:15AM, Junio C Hamano wrote:
> 加藤一博 <kato-k@ksysllc.co.jp> writes:
> 
> > After "git checkout -b '漢字'" to create a branch with UTF-8
> > character in it, "git gui" shows the branch name incorrectly,
> > as it forgets to turn the bytes
> > read from the "git for-each-ref" and
> > read from "HEAD" file
> > into Unicode characters.
> 
> Thanks.
> 
> Note to the git-gui mentainer.  The above may want to be
> line-wrapped a bit.

Thanks. Already done :)
 
> > Signed-off-by: Kazuhiro Kato <kato-k@ksysllc.co.jp>
> > ---
> >  git-gui.sh     | 1 +
> >  lib/branch.tcl | 2 ++
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/git-gui.sh b/git-gui.sh
> > index 0d21f56..8f4a9ae 100755
> > --- a/git-gui.sh
> > +++ b/git-gui.sh
> > @@ -684,6 +684,7 @@ proc load_current_branch {} {
> >  	global current_branch is_detached
> >  
> >  	set fd [open [gitdir HEAD] r]
> > +	fconfigure $fd -translation binary -encoding utf-8
> >  	if {[gets $fd ref] < 1} {
> >  		set ref {}
> >  	}
> 
> A comment totally outside the scope of this fix to anybody
> interested in further working on this code.
> 
> This piece of code is way too intimate with the implementation
> details of HEAD and yet not intimate enough to know that HEAD can be
> a symlink (in other words, it is a poor imitation of the real logic
> implemented in git core).  A kosher way to implement this would be
> to call
> 
> 	git symbolic-ref --quiet --short HEAD
> 
> which would succeed and give the branch name to its standard output,
> or would fail when the head is detached.  Set "current_branch" and
> "is_detached" according to the outcome.

It was introduced in fc4e8da (git-gui: Internalize symbolic-ref HEAD 
reading logic, 2007-05-30). The commit message is:

  To improve performance on fork+exec impoverished systems (such as
  Windows) we want to avoid running git-symbolic-ref on every rescan
  if we can do so.  A quick way to implement such an avoidance is to
  just read the HEAD ref ourselves; we'll either see it as a symref
  (starts with "ref: ") or we'll see it as a detached head (40 hex
  digits).  In either case we can treat that as our current branch.

Now I'm not sure how relevant this still is over 12 years later, but 
AFAIK a fork+exec is still very costly on Windows.

So I wonder whether we should manually check if HEAD is a symbolic link 
or we should just use git-symbolic-ref and hope the performance doesn't 
drop too much.
 
> And yes, Kato-san's fconfigure fix in this patch will still be
> relevant even after such a fix to the implementation of this proc.

Me and Jonathan (Cc) have been having a discussion [0] about whether 
hard-coding UTF-8 as the refname encoding is the right idea. The gist of 
it is that Git _technically_ allows refnames to be in other encodings as 
long as the strings are NULL terminated. It does not restrict itself to 
valid UTF-8 only. More details in the linked thread, of course.

My position is that we should default to UTF-8 given its popularity (at 
least in the Git world), but I'm wondering whether we should also add a 
config variable to allow users to configure their encodings.

If you don't mind, your thoughts on this would be appreciated :)

[0] https://github.com/prati0100/git-gui/pull/21

-- 
Regards,
Pratyush Yadav
