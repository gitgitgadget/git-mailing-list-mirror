From: Christopher Wilson <cwilson@cdwilson.us>
Subject: Re: Why does adding an existing repo as a submodule modify .git/config?
Date: Tue, 24 May 2011 20:11:34 -0700
Message-ID: <BANLkTingA2oRY4i6OnYSz8PGdTRDqXVdFw@mail.gmail.com>
References: <irbq5a$h38$1@dough.gmane.org> <4DDAAAD2.1010708@web.de>
 <4DDB0786.5020006@gmail.com> <4DDB58D9.2090701@cdwilson.us> <4DDC562C.2000204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 05:13:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QP4X7-00068b-KA
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 05:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754340Ab1EYDL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 23:11:56 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56569 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979Ab1EYDLz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 23:11:55 -0400
Received: by gxk21 with SMTP id 21so2936966gxk.19
        for <git@vger.kernel.org>; Tue, 24 May 2011 20:11:54 -0700 (PDT)
Received: by 10.236.144.196 with SMTP id n44mr5645816yhj.142.1306293114249;
 Tue, 24 May 2011 20:11:54 -0700 (PDT)
Received: by 10.147.137.2 with HTTP; Tue, 24 May 2011 20:11:34 -0700 (PDT)
X-Originating-IP: [128.107.108.64]
In-Reply-To: <4DDC562C.2000204@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174369>

On Tue, May 24, 2011 at 6:06 PM, Mark Levedahl <mlevedahl@gmail.com> wrote:

> However, while you could then change submodule-add to not register the
> submodule, you would now have the condition of having a submodule that is
> checked out in the current tree but *not* registered in .git/config.

Isn't this exactly what "git submodule add" currently does for
submodules that are NOT added in place?

For example:

$ mkdir testing
$ cd testing
$ git init
...
$ ls
# nothing in the working tree
$ git submodule add git@git.server:submodule.git
Cloning into submodule...
remote: Counting objects: 13, done.
remote: Compressing objects: 100% (7/7), done.
remote: Total 13 (delta 2), reused 0 (delta 0)
Receiving objects: 100% (13/13), done.
Resolving deltas: 100% (2/2), done.
$ ls
submodule
$ cat .git/config
[core]
   repositoryformatversion = 0
   filemode = true
   bare = false
   logallrefupdates = true
   ignorecase = true
$ git status
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#
#	new file:   .gitmodules
#	new file:   submodule
#

As you can see, if I create a new repo and check out a remote
submodule, that submodule IS actually checked out in my current tree
and no entry is created in .git/config.  Although the remote submodule
has been added to .gitmodules, it takes "git submodule init" to
actually register it into .git/config:

$ git submodule init
Submodule 'submodule' (git@git.server:submodule.git) registered for
path 'submodule'
$ cat .git/config
[core]
   repositoryformatversion = 0
   filemode = true
   bare = false
   logallrefupdates = true
   ignorecase = true
[submodule "submodule"]
   url = git@git.server:submodule.git

> This is the key: .git/config is modified to include all submodules that are checked
> out in your current tree. If you add a remote submodule, that submodule is
> not checked out in your current tree so no entry is created in .git/config,
> while adding one that is already checked out in place does modify
> .git/config. I see no inconsistency here.

The inconsistency is that when adding a submodule in place, the
registration into .git/config takes place, but when adding a remote
submodule that is not in the working tree, the registration does not
happen.  In the second case, don't you end up with exactly what you
said we're trying to avoid, which is "the condition of having a
submodule that is checked out in the current tree but *not* registered
in .git/config"?

Chris
