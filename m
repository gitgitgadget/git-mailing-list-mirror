From: Moritz Bunkus <moritz@bunkus.org>
Subject: Ignoring pattern in un-ignored directory not working anymore
Date: Thu, 6 Jun 2013 10:29:08 +0200
Message-ID: <CANPayMS19-bjgWRMYrRcGYzKgEo_0Az_8emeDrKwxx9RguDbwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 06 10:39:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkViu-0002Lq-OI
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 10:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701Ab3FFIjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 04:39:01 -0400
Received: from belgarath.bunkus.org ([78.46.80.115]:37983 "EHLO
	liselle.bunkus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976Ab3FFIi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 04:38:59 -0400
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Jun 2013 04:38:58 EDT
Received: from mail-pb0-x230.google.com (mail-pb0-x230.google.com [IPv6:2607:f8b0:400e:c01::230])
	by liselle.bunkus.org (Postfix) with ESMTPSA id 9EA741BC0DB0
	for <git@vger.kernel.org>; Thu,  6 Jun 2013 10:29:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bunkus.org;
	s=mail2013040101; t=1370507352;
	bh=y191+dZ3WJ5mBJ3jj2M3oTRwXek1vBmkMuxbUWAKLAk=;
	h=Date:Subject:From:To;
	b=jPQ4lXjgxJLVteJxy4GrYhmLVb28O8esuUhru9uVJXeO6vjajnUXryOHhtD0ignhD
	 LiunrBHr/knjYdL4f0V/1JvX5ISJJFiqceTycGl7Lk/wbCiULo2apK2GenMma8qa6A
	 q8fUtFblJHe9Uf6a4OY9rMY+OLDViTTSkWGntljI=
Received: by mail-pb0-f48.google.com with SMTP id md4so2939018pbc.21
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 01:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=nVd7oaCFCeK2sWpPJomUd2JXnYDG5M1R1pmvFTPTL6E=;
        b=gbhnSNKiu3sB2T7wmpnzNNFJRXHjuKkY6OKoZDGQscS7kcq+oI8VnzZBMLXnF2g81N
         Dm8EzPE/TI2o9gZA3YvDrNmnKyIT7VM1IBLqlhPnQnAh26Ida/51j7kgVmbC0RezAfCl
         BT3X1aoUq9cW5LxbVSSbvZhwcg7s868tV/ZjllPCXrYj+gtQ8AjNnVwz/ctY7z0MUCDH
         kGhH5t8D+7a8Bp3qlbFB8BY6kBEeKxVuSR3eEo5z7Hxkcos3RP4RNc0WeZZdCCsQkbiJ
         5KqqEVqbF+xq2iQVy3OCzNh7biSqpjuJNeQ4eFyWi3Qpkevt5VH4wa6M/sI5Ft+Tx//O
         3X5Q==
X-Received: by 10.68.179.99 with SMTP id df3mr30805917pbc.198.1370507348793;
 Thu, 06 Jun 2013 01:29:08 -0700 (PDT)
Received: by 10.70.1.5 with HTTP; Thu, 6 Jun 2013 01:29:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226488>

Hey,

What I want to do:

* ignore certain patterns completely
* but keep one important directoy
* but not the patterns from the first step that are located within
that directory.

Concrete example: I'm tracking certain parts of my $HOME including
~/.emacs.d/ -- but I don't want the compiled Emacs Lisp files therein.

This used to work until recently, though I'm not sure up to which
version excatly. I'm on Arch Linux and therefore usually pretty much
up to date. My current git version is 1.8.3.

More details and how to reproduce:

My ~/.gitignore usually looked like this:

--- cut ---------------------------------------------------------
/*
*.elc
!/.emacs.d/
--- cut ---------------------------------------------------------

With this setup the scenario described at the beginning was possible.
Now it's not as all files within ~/.emacs.d are always considered
regardless of what patterns came before.

Not even putting '*.elc' into ~/.emacs.d/.gitignore will work in such
a case, even though gitignore(5) seems to imply that .gitignore files
closer to the actual file have higher precendence.

Here's a copy & paste of a simple session demonstrating the problem on
a new repo:

--- cut ---------------------------------------------------------
[0 mbunkus@chai-latte ~/tmp/repo] git init
Initialized empty Git repository in /home/mbunkus/tmp/repo/.git/
[0 mbunkus@chai-latte (branchless-repo) ~/tmp/repo] cat > .gitignore
# Ignore all compiled Emacs lisp files
*.elc
# But I want this one directory
!important/
[0 mbunkus@chai-latte (branchless-repo) ~/tmp/repo] mkdir important
[0 mbunkus@chai-latte (branchless-repo) ~/tmp/repo] touch important/wanted.el
[0 mbunkus@chai-latte (branchless-repo) ~/tmp/repo] git add important
[0 mbunkus@chai-latte (branchless-repo) ~/tmp/repo] git commit -m 'all ok'
[master (root-commit) 5ab6055] all ok
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 important/wanted.el
[0 mbunkus@chai-latte (master) ~/tmp/repo] touch unwanted1.elc
[0 mbunkus@chai-latte (master) ~/tmp/repo] touch important/unwanted2.elc
[0 mbunkus@chai-latte (master) ~/tmp/repo] git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       .gitignore
#       important/unwanted2.elc
nothing added to commit but untracked files present (use "git add" to track)
[0 mbunkus@chai-latte (master) ~/tmp/repo] cat > .gitignore
# Second try: list *.elc twice
*.elc
!important/
*.elc
[0 mbunkus@chai-latte (master) ~/tmp/repo] git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       .gitignore
#       important/unwanted2.elc
nothing added to commit but untracked files present (use "git add" to track)
[0 mbunkus@chai-latte (master) ~/tmp/repo] cat > .gitignore
# Third times' the charm
*.elc
!important/
important/**/*elc
[0 mbunkus@chai-latte (master) ~/tmp/repo] git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       .gitignore
#       important/unwanted2.elc
nothing added to commit but untracked files present (use "git add" to track)
[0 mbunkus@chai-latte (master) ~/tmp/repo] echo '*.elc' > important/.gitignore
[0 mbunkus@chai-latte (master) ~/tmp/repo] git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       .gitignore
#       important/.gitignore
#       important/unwanted2.elc
nothing added to commit but untracked files present (use "git add" to track)
--- cut ---------------------------------------------------------

Kind regards,
mosu
