From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Cherry-pick with symlinks fails horribly
Date: Thu, 11 Mar 2010 05:57:11 +0100
Message-ID: <201003110557.11268.chriscool@tuxfamily.org>
References: <c6c947f61003081728u48292de4x6f2c26e1ea9c1756@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 11 05:57:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpaSc-0005ae-VU
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 05:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756484Ab0CKE5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 23:57:21 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:34853 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756305Ab0CKE5U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 23:57:20 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B640781803B;
	Thu, 11 Mar 2010 05:57:14 +0100 (CET)
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 92016818062;
	Thu, 11 Mar 2010 05:57:11 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31-19-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <c6c947f61003081728u48292de4x6f2c26e1ea9c1756@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141933>

On Tuesday 09 March 2010 02:28:30 Alexander Gladysh wrote:
> Hi, list!
> 
> OS X 10.6.2
> Git 1.7.0.2
> 
> I'm complaining about Git symlink handling again. This time it is
>  cherry-pick.
> 
> In my repo I have a symlink pointing to a directory.
> 
> I swap symlink with the directory in a single commit.
> 
> Now, if I try to cherry-pick any later commit from the branch that has
> that swap commit to a branch that have not, cherry-pick fails
> horribly.
> 
> See script to reproduce the bug below (run it in a clean directory).
> 
> Output example:
> 
> $ git cherry-pick <SHA>
> 
> Automatic cherry-pick failed.  After resolving the conflicts,
> mark the corrected paths with 'git add <paths>' or 'git rm <paths>'
> and commit the result with:
> 
>         git commit -c 6a398597ce7a00fe05f43ff88808303eb151dfb5
> 
> $ git status # Note the "Untracked files" section
> 
> # On branch master
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #	renamed:    a/f -> f1
> #
> # Unmerged paths:
> #   (use "git reset HEAD <file>..." to unstage)
> #   (use "git add/rm <file>..." as appropriate to mark resolution)
> #
> #	added by us:        b/a
> #
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #	b/a~HEAD
> 
> (Also I've seen git reset --hard to fail afterwards, complaining it
> can't delete a directory, but I can't reproduce it now.)
> 
> I see a similar behaviour if I try to do interactive rebase accross
> symlink swap commit.
> 
> Alexander.
> 
> #! /bin/bash
> 
> git init
> 
> mkdir a
> touch a/f
> git add a
> git commit -m "a"
> 
> mkdir b
> ln -s ../a b/a
> git add b
> git commit -m "b"
> 
> git checkout -b branch
> rm b/a
> mv a b/
> ln -s b/a a
> git add .
> git commit -m "swap"
> 
> touch f1
> git add f1
> git commit -m "f1"
> 
> git checkout master
> 
> git cherry-pick `git rev-parse branch` # This one breaks horribly

I can reproduce the bug here on Linux. And Git v1.6.0 has the same bug.
So I suspect an old bug in unpack_trees.c. I will try to have another look at 
it this evening, but I am not familiar with that code.

Thanks for the report,
Christian.
