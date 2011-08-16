From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] update-index: add --swap to swap index and worktree content
Date: Tue, 16 Aug 2011 21:45:25 +0700
Message-ID: <CACsJy8DMwqM4rPfAeaXnvDEg1Pv4Y8q7+eJJBeO+ZyaN-m0oZw@mail.gmail.com>
References: <1313158058-7684-1-git-send-email-pclouds@gmail.com> <4E4A6A43.7040706@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Aug 16 16:46:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtKu3-0003GV-B4
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 16:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147Ab1HPOp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 10:45:58 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58815 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444Ab1HPOp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 10:45:57 -0400
Received: by bke11 with SMTP id 11so3778673bke.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 07:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bFBki1zHBAmla+BTIJ9IslYACmHfUmBM7nMeSjfoKBM=;
        b=mSbMYlwk4mYWGPOjmSXWqkEys4rt48006uoXCZYAMNM5PmHLJ90X5vsGNLzYbFi4JW
         IgDY5deMDnY+IAHjuKQo7emOSMqsCYVPqud1ZUdzF0doQ/mMEUdyVBoJEoU0IDmqXxHC
         8FnbovRG1ZFNowb1FxpKn5vlCdSWh6/kGPBuM=
Received: by 10.204.166.2 with SMTP id k2mr1492424bky.123.1313505956163; Tue,
 16 Aug 2011 07:45:56 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Tue, 16 Aug 2011 07:45:25 -0700 (PDT)
In-Reply-To: <4E4A6A43.7040706@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179453>

2011/8/16 Michael J Gruber <git@drmicha.warpmail.net>:
> I had to think about that explanation for a while (partly because "git
> add" does not alter the wt either). So, your patch would support the
> following workflow:
>
> git add foo # have index == wt
> hack foo # change foo in wt
> git update-index --swap foo # add foo and reset to previous state
>
> Am I understanding you right? The option could trickle down to "add".

Well, the point is I want to skip the first phase of normal edit path
(wt -> index -> commit) and edit index directly (even in parts that
are not touched by wt, which means "git add -e" is useless), leaving
my wt "unchanged". Sometimes wt is just too dirty I don't want to make
any more changes to it while I focus on "index -> commit" phase.

I could add an option to fire up editor with a temporary file
containing current index content and automatically update index after
editor is closed. But I'd lose the ability to diff my changes. So I do
need to wt to change index without losing my current wt. I have to
stash my wt somewhere, and index seems a safe place for that.

After swapping, it'd look like index -> wt -> commit, I can do "diff
HEAD" to check index vs head. Once I'm done (and create index'), I can
swap it back to wt -> index' -> commit.

Thinking a bit more, this may have another use case (for lazy guys
like me, anyway). Assume I have separate changes in wt and I'm ready
to make many commit. I should make good commits, which means tests (or
at least a compile to see I don't miss any changes). So I add related
changes to index, then swap wt/index so index becomes wt (and old wt
hidden in index). Test what is to be committed. Good? Swap back,
commit. Repeat with the rest of changes in wt.

My current workflow is picking changes I believe should go together,
commit, then "rebase -i", stopping at each commit to test. It takes
longer (especially when I mis-pick changes).

> I share the pov that "add -p with e" sometimes doesn't cut it. But
> similarly, the fact that "add -p" can't be used to undo a previous "add
> -p" is suboptimal. Both issues could be solved with a 3way stage tool. I
> have this on my todo/wish list, and I seem to recall that Jeff or Junio
> came up with a few lines of (scripting) code for that. That would depend
> on the availability of proper tools, though (e.g. vim in diff mode).

That'd be great.
-- 
Duy
