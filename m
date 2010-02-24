From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Looks like --amend create commit... don't understand
Date: Wed, 24 Feb 2010 23:01:22 +0100
Message-ID: <vpqr5oa9tu5.fsf@bauges.imag.fr>
References: <4B8599C4.1050409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mat <matthieu.stigler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 23:01:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkPIY-0000Nc-I9
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 23:01:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758167Ab0BXWB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 17:01:26 -0500
Received: from mx1.imag.fr ([129.88.30.5]:43501 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758113Ab0BXWBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 17:01:25 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o1OLwsDJ013136
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 24 Feb 2010 22:58:54 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NkPII-0002A5-Ez; Wed, 24 Feb 2010 23:01:22 +0100
In-Reply-To: <4B8599C4.1050409@gmail.com> (mat's message of "Wed\, 24 Feb 2010 22\:27\:32 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 24 Feb 2010 22:58:55 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140992>

mat <matthieu.stigler@gmail.com> writes:

> commits. But when looking on gitk, I see that
> git commit blabla --amend
>
> does create each and every time a new commit,

Yes. In Git, objects (including commits) are fundamentally immutable.
You never modify an object, you create a new one, and usually forget
about the old one.

> I mean: with git log,
> there is only one commit, but on gitk, I see many, with the same name
> but different revision ID....

The revision ID is the sha1sum of the commit content. So, if they have
different contents, they _must_ have different IDs.

What happens is that you start with a history like

A---B <- master

and then try to --amend B. What happens is that you create a new B,
say B', and let the branch you sit on point to this new one. Like:

A---B
 \
  `-B' <- master

Most of the time, B has just become unreachable: no branch contain it,
no tag point to it, ... so you actually see

A---B' <- master

and it very much looks like you just modified B.

Now, if you made B reachable before your commit --amend, like by
pushing it to another repo, letting someone else pull from it, or if B
is already part of another branch, then the situation is different.

For example, if B is already part of a branch, like this:

    .---- temp-branch
    v
A---B---C <- master

If you do a checkout of temp-branch, then commit --amend, you end up
in this situation :

A---B---C <- master
 \
  `-B' <- temp-branch

The solutions:

* If you already published your commit, then don't amend it. Period.

* If you want to rewrite an old commit in a branch, then read about
  "git rebase -i", but make sure you read all the warnings about
  rebase before you do so.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
