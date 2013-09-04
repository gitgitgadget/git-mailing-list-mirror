From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Transfer notes when rebasing
Date: Wed, 4 Sep 2013 10:47:22 +0200
Message-ID: <CAC9WiBg+0PkEeBst6sw5uuCb4-21=zj+XCcjwKWSfAYi-ciqDA@mail.gmail.com>
References: <CAC9WiBiSLMO+JM3aEHZ8xdwKE=jh+mDuo4REQ7rnQ-rTDNb9qA@mail.gmail.com>
	<20130904075310.GB9637@sigill.intra.peff.net>
	<20130904075941.GA2582@serenity.lan>
	<20130904082803.GA17308@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Keeping <john@keeping.me.uk>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 04 10:47:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VH8kL-0000Ne-Ks
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 10:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934437Ab3IDIrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 04:47:24 -0400
Received: from mail-vb0-f41.google.com ([209.85.212.41]:53582 "EHLO
	mail-vb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934392Ab3IDIrX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 04:47:23 -0400
Received: by mail-vb0-f41.google.com with SMTP id g17so7685vbg.28
        for <git@vger.kernel.org>; Wed, 04 Sep 2013 01:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4BTPpwniranJEmVuGSNyLTToX6wrWbPzlOaPkEi957o=;
        b=gtlf5P1oTeCpVHPRPBoi0a98sqx77lxF46e9E/JwKcaSD1PbAFJjIJpDAsHivsBpnp
         Ew1SYcGzY025IyBDgZS65WwiTH1zcTaymkAUpYQP1UUOjKrbOZ0tWzyvREPqwf3G3ZJS
         jPKYJGoH83WW8k27NW/XRN5WIqACVzctOuJrAsdiqRZMGVigJSN8dUTE/V4q0Y3SK1cT
         Z4y0b+eup04vgmjkSMYLACOIploKZn1cUuUbz12A4H/GZuQa3lF8kPMIiac6TqJ7XkCg
         1EZWAnd26BlxrMNaloD0yi4gVwq4Xlf4DUN7yDqMvgBk3kHd9VOiaZtg3BDPnm2jln8k
         wb2Q==
X-Received: by 10.220.10.194 with SMTP id q2mr1621822vcq.2.1378284442360; Wed,
 04 Sep 2013 01:47:22 -0700 (PDT)
Received: by 10.58.96.109 with HTTP; Wed, 4 Sep 2013 01:47:22 -0700 (PDT)
In-Reply-To: <20130904082803.GA17308@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233822>

On Wed, Sep 4, 2013 at 10:28 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Sep 04, 2013 at 08:59:41AM +0100, John Keeping wrote:
>
>> On Wed, Sep 04, 2013 at 03:53:10AM -0400, Jeff King wrote:
>> > On Wed, Sep 04, 2013 at 09:51:26AM +0200, Francis Moreau wrote:
>> >
>> > > When rebasing a branch which contains commits with notes onto another
>> > > branch it happens that some commits are already presents in the target
>> > > branch.
>> > >
>> > > In that case git-rebase correctly drops those (already present)
>> > > commits but it also drops the notes associated with them.
>> > >
>> > > Can the notes be transfered somehow in the target branch on the
>> > > already present commits ?
>> >
>> > Yes, see the notes.rewriteRef config option to enable this.
>>
>> Does that actually work for this case?  It sounds like Francis has the
>> notes copying correctly when commits are rewritten but the notes are not
>> copied anywhere if the commit becomes empty.
>
> Ah, I misunderstood. If we are dropping commits from the rebase because
> their counterpart is already applied upstream, then no, there isn't an
> automatic way to do this.
>
> If the commits are dropped because a commit with the same patch-id
> already exists upstream, you could match them up by patch-id and copy
> the notes. Annoyingly, while we have things like "log --cherry-mark" to
> show which commits are already present on each side, I do not think
> there is a way to correlate them commit for commit. So I think you are
> stuck doing something in the shell like:
>
>   patch_ids() {
>     git rev-list "$1" |
>     git diff-tree --stdin -p |
>     git patch-id |
>     sort
>   }
>
>   patch_ids $upstream..HEAD >us
>   patch_ids HEAD..$upstream >them
>
>   join us them |
>   cut -d' ' -f2-3 |
>   git notes copy --stdin
>
> However, if the commit is dropped because we find while applying that it
> becomes empty, there is not much we can do. It may have been obsoleted
> by its counterpart patch that had a different patch-id, or it may even
> have been obsoleted by unrelated patches. In the latter case, there is
> nothing to copy to. In the former, you would have to trying to match up
> the commit messages or similar to guess that the two commits correspond.

Can't git-rebase at least handle the case where a patch and its
counterpart have the same patch-id ?

Also maybe git-rebase should warn when dropping a commit having a note
to tell the user that the note is dropped too.

-- 
Francis
