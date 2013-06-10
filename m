From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/4] push: make upstream, simple work with pushdefault
Date: Mon, 10 Jun 2013 17:18:31 +0530
Message-ID: <CALkWK0mY5=H6FoUZCOXTYykEV1f=3wrP21WPXj1v4VBCeOxocg@mail.gmail.com>
References: <1370798000-2358-1-git-send-email-artagnon@gmail.com>
 <1370798000-2358-3-git-send-email-artagnon@gmail.com> <7vip1moq3k.fsf@alter.siamese.dyndns.org>
 <CALkWK0mesZay8Cpi6yTvhUG=136=9JLyFUZXm8t_fMOrY0F62Q@mail.gmail.com> <7v4nd6l31d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Leandro Lucarella <leandro.lucarella@sociomantic.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 13:49:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um0b9-0001LH-Uk
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 13:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222Ab3FJLtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 07:49:13 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:41025 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843Ab3FJLtM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 07:49:12 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so2383934ied.28
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 04:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8kef4Xv2Ru72gJ2yFqVHZGYF0drlY0CLpwFJH5+GWsM=;
        b=cqWDWuWIM29azdn5FwsWHoiKC4z02GhvaJK1ytUWhDMgdvejv+aUkRhtbK1BoF5uE8
         A0bpIjzyFR8K14Spu9iPaTWJCxOp+PFmvBpvWrWxCKpaoFesVNbZupM+XJBAZEazv5Js
         wEJ99UTay7N97XjpSnqq07NbgPj0qKg6Yj1dxEtsvujvUhPjDkixEQEN1dl90W/u4+I+
         A1HG4OP9zEZmak7QTkc+MgMwiNjr6TwQY/YsrJnbHXc3w/DdUKjDJX7v5EqkddwFOGXI
         6w+sUKEC7NbH/XUb9Rka0RWZoEmg56mFUZXBBUaOYKdeHAo59dduwe59sHWG77Z7uney
         ZE4w==
X-Received: by 10.43.88.70 with SMTP id az6mr3631644icc.10.1370864951960; Mon,
 10 Jun 2013 04:49:11 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 10 Jun 2013 04:48:31 -0700 (PDT)
In-Reply-To: <7v4nd6l31d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227275>

Junio C Hamano wrote:
> The name under which the local branch is published needs a sensible
> default (when branch.$name.push is not specified), and I agree that
> you would get the name of the branch my work was forked from if you
> reuse the "upstream" code.  I am saying that it does not necessarily
> give us a good default.

See, that's the problem: push.default is simply a default refspec to
push to for all branches, that can be _overridden_ by
branch.<name>.push.  Getting an override is not going to solve the
problem we are facing: what to do when branch.<name>.push is
unspecified?  Fall back to push.default, right?

> Now think _why_ I renamed the branch on my end, i.e. not calling
> that branch in question "triangle" that is the blanket name for the
> collective effort but calling it with a more specific name
> "pushbranch", in the first place.

Look, it's very simple.  upstream was built to support the case when
the local branch name is different from the remote branch name, but it
was too specialized for central workflows.  How do we extend it for
triangular workflows?

Just like we introduced branch.<name>.pushremote to override
branch.<name>.remote, we get branch.<name>.push to override
branch.<name>.merge.  If branch.<name>.pushremote is unset, where do
the pushes go?  branch.<name>.remote.  If branch.<name>.push is
unspecified, what is the refspec to be pushed?  branch.<name>.merge
(when push.default = upstream) [*1*].

What does this mean?  I publish the branch "triangle" on ram (what my
local branch is called or what push.default I use is irrelevant).  You
have a branch called pushremote with branch.pushremote.remote set to
ram, remote.pushdefault set to junio, branch.pushremote.merge set to
refs/heads/triangle, and push.default set to upstream.

  # on jc's machine; on branch pushremote
  $ git pull
  # integrates changes from ram's triangle just fine
  $ git push
  # publishes the branch as triangle on remote junio

I rewrite my branch, and you have 4 commits based on my branch:

  $ git rebase --onto @{u} @~4

Perfect.

The only limitation is that you don't choose the branch name on junio.
 When we get branch.pushremote.push, you'll be able to set it to
refs/heads/pushremote, making push.default inconsequential.  Done.

[Footnotes]

*1* remote.pushdefault overrides branch.<name>.remote, while
push.default will be overridden by a future branch.<name>.push.  Not
exactly elegant, is it?
