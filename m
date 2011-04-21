From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Cloning into an existing, non-empty directory?
Date: Thu, 21 Apr 2011 23:27:15 +0200
Message-ID: <BANLkTi=VwiqN99AMEJb6jb1uFya2Hipibw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 23:27:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QD1Pa-0002Jk-Mb
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 23:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792Ab1DUV1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 17:27:37 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42080 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754390Ab1DUV1g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 17:27:36 -0400
Received: by iwn34 with SMTP id 34so101027iwn.19
        for <git@vger.kernel.org>; Thu, 21 Apr 2011 14:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=BhczStrjkCjgh1e3y+X5R5orD8MEh6tGwQzQzHAaNXU=;
        b=Vvqw1rhp+vGzFYrDK6qJlJi+bHx2wO+NLf7sV2oZqah2o/5hfVux0/jpASGQQMZc7q
         bSTfL2+cg3ZrCe9tCBZN2PYd6xFdzU83vKtyi6UkN/F1Al5QHHUGIscUC4hWIu6tn8wr
         QIZnNhJ95gibjyabUOlv9WWsbAbCSmcvS+5qE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=HsN0Ycs9pM64ivNrQA6vp5OLkmQquLfnJ6+pNcGgiWWwFJTD978nkv2NO3tC678Exu
         xOB5D+I8x5i7r1KOD6zFKjlJ504JulbjE10GO74V2MWBmsFIxO5WZbh4Q9grqVZu1tUZ
         VOcMPVSYUsZo6Fd1AXeX0J3uVJKfgYEcLZC1k=
Received: by 10.231.61.198 with SMTP id u6mr304019ibh.160.1303421256072; Thu,
 21 Apr 2011 14:27:36 -0700 (PDT)
Received: by 10.231.92.16 with HTTP; Thu, 21 Apr 2011 14:27:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171920>

Hi all,

I know that the manpage explicitly states that it's not possible to
clones into an existing, non-empty directory, but I wanted to see if
anyone is aware of a workaround or if I can convince people that is it
of use in specific circumstances.

Some of you will be keeping their RC files in git repo(s) which means
you are basically left with two options:

1) Use soft-/hardlinks
2) Change your working tree

I went for option two which looks like:

richih@roadwarrior ~/.config/vcsh/repo.d/mr.git % ls -a
.   branches        config       FETCH_HEAD  hooks  info  objects    packed-refs
..  COMMIT_EDITMSG  description  HEAD        index  logs  ORIG_HEAD  refs
richih@roadwarrior ~/.config/vcsh/repo.d/mr.git % cat config
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
	worktree = /home/richih/
[remote "origin"]
	fetch = +refs/heads/*:refs/remotes/origin/*
	url = <remote>
[branch "master"]
	remote = origin
	merge = refs/heads/master
richih@roadwarrior ~/.config/vcsh/repo.d/mr.git %

This works just fine as long as you're using

  git --work-tree=$HOME \
    --git-dir=$HOME/.config/vcsh/repo.d/mr.git \
    pull

or similar on an existing, manually mangled repo. The only real
problem left is that I can't clone initially as $HOME is obviously
non-empty, resulting in

  git --work-tree=$HOME \
    --git-dir=$HOME/.config/vcsh/repo.d/mr.git \
    clone <remote> .config/vcsh/repo.d/mr.git
fatal: working tree '/home/richih' already exists.

This means I am down to cloning, creating the directories I need,
moving .git and the actual files around, making git aware that tracked
files were not deleted, just moved, and then finally being able to use
my repo.

Obviously, this would imply some sort of conflict handling during cloning.

Anyway, I would _really_ love to have a way to avoid all this manual
work and just clone into $HOME, telling git that it's OK and I know
what I am doing.


Thanks,
Richard

PS: In case you are interested in keeping your RC files (and the rest
of your life) in git, there's a vcs-home mailing list and #vcs-home on
irc.oftc.net.
