From: Jeff King <peff@peff.net>
Subject: Re: git-checkout silently throws away the dirty status of index
 without a warning?
Date: Thu, 1 Sep 2011 12:56:38 -0400
Message-ID: <20110901165638.GE15018@sigill.intra.peff.net>
References: <CAEvN+1h+mY+f3dzK7LFOwkqokOZSS-LosCzBqtYGbyjz=Dg7Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tzu-Jung Lee <roylee17@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 01 18:56:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzAZK-0006WS-Kv
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 18:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278Ab1IAQ4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 12:56:41 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36559
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751938Ab1IAQ4k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 12:56:40 -0400
Received: (qmail 21025 invoked by uid 107); 1 Sep 2011 16:57:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Sep 2011 12:57:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Sep 2011 12:56:38 -0400
Content-Disposition: inline
In-Reply-To: <CAEvN+1h+mY+f3dzK7LFOwkqokOZSS-LosCzBqtYGbyjz=Dg7Zw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180548>

On Thu, Sep 01, 2011 at 11:47:59PM +0800, Tzu-Jung Lee wrote:

> Correct me if I'm wrong:
> 
>     git-checkout saves the changes to index and working-tree, and
> tries to apply them to the destined commit.
>     If the changes are applicable, then git-checkout the destined
> commit and apply the changes.
>     Otherwise, git-checkout fails with warnings and leaves the current
> status untouched.

Not exactly. "git checkout <branch>" will switch your HEAD to <branch>,
and then try to make your index and working tree match the contents of
<branch>, with two exceptions:

  1. If you have local changes in a file, but the contents of the file
     in <branch> do not differ from what's in the current HEAD, then the
     file will be left alone (i.e., your local changes will be
     preserved).

  2. If you have local changes in a file, and the contents of the file
     in <branch> differ both from what's in your working tree and from
     what's in your current HEAD, git will print an error and refuse to
     overwrite your changes (though you can ask it to merge them with
     "git checkout -m").

So it is not about "do these changes apply", but rather that we will
give up any time file-level merging is required (unless "-m" is
specified).

The other form, "git checkout <branch> [--] <file>", is not about
switching branches at all, but about putting content from <branch> into
the current index and working tree, overwriting what's there.

> If the above correct. Please help me clarify if the following corner
> case an intended or unexpected behavior.
> [...]
>     $ git checkout -b br1
>     $ git reset HEAD^
>     Unstaged changes after reset:
>     M       aaa.txt
>     M       bbb.txt

So you have changes in two commits...

>     $ git checkout HEAD aaa.txt

And here you explicitly overwrite the changes in aaa.txt.

>     $ git status --short
>     M bbb.txt

...leaving only the changes in bbb.txt.

>     $ git add bbb.txt
>     $ git status
> 
>     # On branch br1
>     # Changes to be committed:
>     #   (use "git reset HEAD <file>..." to unstage)
>     #
>     #       modified:   bbb.txt
>     #

OK, now it's staged.

>     $ git checkout master
>     Switched to branch 'master'
> 
> git silently switch to master without warning against the index are
> "RESTORE/RESET" to clean.

Yes, because the changes in your index were identical to what was in the
destination branch. So we didn't drop any changes; they're still in the
index and in the working tree. It's simply that when compared to your
new HEAD, they are uninteresting.

>     $ git checkout br1
>     $ git status
>     # On branch br1
>     nothing to commit (working directory clean)

And now when we switch to br1, you have no changes against master in
your working tree or index, so there is no dirty state to block
switching branches.

I think git is working as intended here.  I agree it is a somewhat
surprising corner case, but only because your changes happened to
exactly match the difference between the two branches you are switching
between. But it makes sense when you think about what "dirty state"
means: it is differences between HEAD and your index and working tree.
So we usually think of creating or removing dirty state by changing the
working tree. But you could equally well do it by changing the HEAD
without changing the working tree, which is what you did here.

-Peff
