From: Jean Privat <jean.privat@gmail.com>
Subject: Re: [RFC] teach --edit to git rebase
Date: Wed, 12 Oct 2011 09:57:11 -0400
Message-ID: <CAMQw0oOKsVv82c5yaHR0LQu+B-OaBAE8OBXQH-ksiQc2KEBnjA@mail.gmail.com>
References: <CAMQw0oOBEjW3yS2+wcktXDuEuUiHKjfbK2qDzKvBOiwxo7Zkow@mail.gmail.com>
 <7vvcrubyz1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 15:57:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDzJl-0003Ra-AE
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 15:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570Ab1JLN5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 09:57:53 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42117 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab1JLN5w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 09:57:52 -0400
Received: by eye27 with SMTP id 27so765541eye.19
        for <git@vger.kernel.org>; Wed, 12 Oct 2011 06:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hdarEYsitlxQ2+ybMX5c8mwkKTo/kDW1IsuCCLxy+Zs=;
        b=OhtQtcYc4mpGZWZhPX65Vn77+mYapFQEIuk7wuapHIW/kR85A1W9+TN20QE0i4rovb
         PCORkjXWsDDMrkDq9vq5vmUFUEKePTHwKHhegjTyiCSna4Z+UTGYqHAHbk9VxrdNaMUp
         WSI4GSJuwfaldjZRPUdbRWOaXydb+s1YDgH+g=
Received: by 10.223.75.27 with SMTP id w27mr33747659faj.11.1318427871126; Wed,
 12 Oct 2011 06:57:51 -0700 (PDT)
Received: by 10.223.79.3 with HTTP; Wed, 12 Oct 2011 06:57:11 -0700 (PDT)
In-Reply-To: <7vvcrubyz1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183367>

> The only thing you can do with this new option is "update one commit
> buried in the history, and rebase everything that build on top of it",

It is a good summary indeed.

> as
> far as I can tell. It feels a shame to waste the generic word "--edit" for
> such a narrow option.

I'm bad at bikesheeding. The 'edit' come from the 'edit' command in
rebase interactive. I am open to other names. Note that in the
following I keep the --edit name, not because I am suborn but because
I do not have better to propose yet.

> At the UI level, "git commit --amend HEAD~4" might be a more natural way
> to invoke such an operation, I would think.

As I say in the original email the point of the 'rebase --edit
some-commit' is to temporally checkout some-commit so that edits are
done in the context of the commit and not in the context of the head
of the branch.
One has to do a rebase --edit prior to modification (although we can
imagine a possibility to bring back the index or the content of the
working directory with us either automatically as with a branch
checkout or manually with the help of stash).

Unless I misinterpret the 'git commit --amend HEAD~4' you suggest, it
means that you have to prepare the commit in the head of the branch.
It may be difficult if what was in HEAD~4 is altered by HEAD~2.
My argument is that if preparing a patch to HEAD~4 in HEAD is easy, a
git commit --fixup will do the tick.
If the preparation is difficult because I have to work on (or more
insidious, near) change that occurs between HEAD~4 and HEAD, I need
something like my proposal. For example I added a line in HEAD~2 but I
prefer now to have this line to appears in HEAD~4.

The workflow I propose is :

$ # we are on master
$ git rebase --edit HEAD~4 # workdir is a detached master~4 like with a
                           # git checkout master~4
$ hack hack hack; git add files
$ git commit --amend
$ git rebase --continue # conflict is detected with master~2, resolve it
                        # manually
$ git rebase --continue # workdir is now a rebased master

I do no see what is the workflow with an extend git commit --amend
Do you mean something like the following ?

$ git checkout HEAD~4 -- . # bring back the content of master~4 but
                           # HEAD still points master
$ hack hack hack; git add files # And try to now be disturbed by the fact
                                # that diff and status are polluted
                                # with things related to master
$ git commit --amend HEAD~4 # conflict is detected with master~2, resolve it
$ git rebase --continue # Do we really want using "git rebase"?

This last workflow seems so awkward to me that I might miss something.

-- Jean Privat
