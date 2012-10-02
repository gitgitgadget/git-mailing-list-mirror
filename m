From: Sascha Cunz <sascha@babbelbox.org>
Subject: Re: Submodule design
Date: Tue, 02 Oct 2012 17:38:31 +0200
Message-ID: <2324506.6kHImzYEks@blacky>
References: <CALkWK0kYh3tKXRqRO9SFMHkrytmhXFkR3yHwmiTpw6KocuLzZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 17:39:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ4YU-00036j-4I
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 17:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598Ab2JBPic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 11:38:32 -0400
Received: from babbelbox.org ([83.133.105.186]:43385 "EHLO mail.babbelbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754545Ab2JBPib (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 11:38:31 -0400
Received: (qmail 17747 invoked from network); 2 Oct 2012 15:39:06 -0000
Received: from p54aec2e3.dip.t-dialin.net (HELO blacky.localnet) (sascha@babbelbox.org@84.174.194.227)
  by babbelbox.org with ESMTPA; 2 Oct 2012 15:39:06 -0000
User-Agent: KMail/4.9.1 (Linux/3.5.3-gentoo; KDE/4.9.1; x86_64; ; )
In-Reply-To: <CALkWK0kYh3tKXRqRO9SFMHkrytmhXFkR3yHwmiTpw6KocuLzZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206808>

Am Dienstag, 2. Oktober 2012, 20:53:28 schrieben Sie:
> Hi,
> 
> Today I learnt that a gitlink is a commit object embedded in a tree.
> However, I can't seem to be able to cat it.
> 
>     $ git ls-tree HEAD
>     100644 blob 5a91f388f3648b98ae34a19ec42ba9acc7852ef4    .gitmodules
>     160000 commit 8daa12004db8862b22f6c7dd244a88ac6108b194  dotfiles
>     $ git cat-file 8daa12004db8862b22f6c7dd244a88ac6108b194
>     fatal: git cat-file 8daa12004db8862b22f6c7dd244a88ac6108b194: bad file
> 
> Why is this?  Does the object not exist in the object store at all?

Correct. The tree entry is a pointer to the commit inside your submodule that 
shall be checked out. Obviously the submodule's commit is not part of the 
superproject. 
IOW: There are are actually 2 object stores: the superproject's and the 
submodule's. This tree entry makes a (perstiable) connection between the two.

> Then how was it embedded in the toplevel tree object in the first
> place?
The .gitlink for submodules has quite some special handling associated to it. 
You can commit (and diff) it like any other blob. 

> Also, why (how) does 'git diff' give me the impression that
> it's a blob?

>     $ git diff
>     diff --git a/dotfiles b/dotfiles
>     index 8daa120..ff61f40 160000
>     --- a/dotfiles
>     +++ b/dotfiles
>     @@ -1 +1 @@
>     -Subproject commit 8daa12004db8862b22f6c7dd244a88ac6108b194
>     +Subproject commit ff61f40e0938024aa3b748eb733a974b17082ec2

See above. Git smartly converts the "state" of the submodule into a one line 
text, allowing you to "diff 2 states of the submodule"

cd dotfiles
git pull # pulls some updates
cd ..
git add dotfiles && git commit -m"Update dot files to Version xxx"
git push

This will record the dotfiles submodule's new HEAD SHA1 as the current one 
inside the superproject. When you now checkout the superproject to another 
location and do: a "git submodule update --init" it will clone the dotfiles 
submodule and checkout the exact same version that you just commited with the 
above commit.

> If it is really a blob, I should be able to stage and unstage it
> normally, but the following command is a no-op:
> 
>     $ git checkout -- dotfiles
> 
> What is going on?  Shouldn't we get rid of these ugly inconsistencies?

HTH,
Sascha
