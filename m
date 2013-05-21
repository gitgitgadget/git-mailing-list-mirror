From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/3] Fixing volatile HEAD in push.default = current
Date: Wed, 22 May 2013 02:39:44 +0530
Message-ID: <CALkWK0np7o0eH8ZsWQSwk1Cdwnnpj5B==gS8kAE+OkTskASOsQ@mail.gmail.com>
References: <1369160600-22337-1-git-send-email-artagnon@gmail.com>
 <7v38tgno2k.fsf@alter.siamese.dyndns.org> <CALkWK0m3QP_eE14y8UoJ+HeFzkKM=1nVKAnYJcTrwQMp+Atphg@mail.gmail.com>
 <7vppwkm682.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 23:10:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UetpF-0003ko-Nd
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 23:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635Ab3EUVKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 17:10:25 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:35079 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab3EUVKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 17:10:25 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so3180511iea.17
        for <git@vger.kernel.org>; Tue, 21 May 2013 14:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4Pef45LgEf7mdLOrgbIqRf8JWN3kbBQnRvxIhr/rWck=;
        b=IYPtfpiUEdyA/2cWqVT0+KLzOCZa2F0hvlga6AoO8iAu7alFPhiJMdT+bfCJFWLm0O
         Xpp8//m0fzZ1k7Ln95d5/KFWUWW26f6HxBgKnhjbdnVXymlOEP0rgcmzHH6TyNo0MKs9
         0WE5777rdMwf2x1jSGa4TZ9AQ7DBsOvlMEfJt3X7KWVcxOkew+eVsb1IetFNI1EwT6m0
         /UJD3VEScdyllN3wUlIZ8L27AELK33ffV0k0CndzmwJP3x4xv/EFvGRF5cDIj0b782d5
         Lo+pif9fOjzFwOcUTYlSFqdUI+T4on1jD9p3+ShTfBBoBV7wZG84s6UsZCfdd171dxBX
         WLwg==
X-Received: by 10.50.3.38 with SMTP id 6mr2531845igz.44.1369170624727; Tue, 21
 May 2013 14:10:24 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 21 May 2013 14:09:44 -0700 (PDT)
In-Reply-To: <7vppwkm682.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225077>

Junio C Hamano wrote:
> In general, when a command is working in your repository with a
> working tree, we do not make any such promise that it keeps
> operationg normally when you pull the rug under its feet from
> another terminal ("git checkout maint" running at the same time "git
> pull" would not have a chance to work correctly).  Some are safe
> (like "git push" racing with "git checkout maint" that would not
> have to look at what the current branch is) and some are not (like
> "git push github" racing with "git checkout maint && git push
> origin HEAD:preview").

My current set of expectations look like this:

1. Commands that operate on a worktree (merge family) do not lock the
worktree before operating on it.  These are fast synchronous commands
(operating on recent hot-cached stuff), and there is no _utility_ in a
perfectly atomic worktree operation.  Might be an interesting
theoretical exercise to merge-trees in memory, but I have absolutely
no interest in such a problem.

2. Commands that operate on refs, the-index, and intermediate states
(update-ref, update-index, rebase-state family) do so atomically using
the lockfile API.  The atomicity is important here, because we don't
want a higher-level command to half-fail.  And it's trivial to
implement.

3. Commands that operate only on the object store are guaranteed not
to race as the object store itself is read-only (hash-object,
commit-tree family; gc being the exception).  This is very important
for concurrent access in a server implementation.

In 3 out of the 4 push.default states, push is category (3).
push.default = current is a special case, and should try not to break
end-user expectation even if it involves resolving HEAD.

> I view the value of this topic purely as "showing a real branch name
> when that is what we actually pushed is a lot more preferrable than
> showing HEAD, especially because the user may see it in the terminal
> scrollback buffer hours after it happened".  Explaining this patch
> as "we avoid issues from simultaneously flipping HEAD by resolving
> early" gives a false sense of security to the reader, as "early" has
> to happen early enough for the patch to really avoid the issue, but
> you are not in control of when the user does that flipping in the
> other terminal.

Why should I lie in the patch?  The terminal flipping was a very big
itch I had, and the patch fixes exactly that issue.  Showing the real
branch name was an unintended side-effect.

I just said "early" and showed a nice end-user example in which it
works, not "theoretically impossible to race with".  Better wording
(while not lying about the motivation behind the patch)?
