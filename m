From: Chris Packham <judge.packham@gmail.com>
Subject: [BUG?] fetching via file:// vs ssh://
Date: Fri, 10 Aug 2012 12:43:02 +1200
Message-ID: <CAFOYHZBm7uOHtDhBJaMO9=u4BEsbLdhPUAHra6Pyd9TGONAa3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 02:44:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzdKk-0006Ef-C7
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 02:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856Ab2HJAnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 20:43:06 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58799 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab2HJAnE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 20:43:04 -0400
Received: by wgbdr13 with SMTP id dr13so951170wgb.1
        for <git@vger.kernel.org>; Thu, 09 Aug 2012 17:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=mjUyTW6eMZXkKQB+H34jMwiYBcYgU5DOjwJZifuuheg=;
        b=A9scuMcfjOftU+d6Zl9vgZfXD/JlENeoeFxr9MSBPNdT26M7B/8wREnjQHYXO/sX5U
         mZfUzpNHDhwP/7eoyTj1uO4g0g1z8ZsvQiBSS30uda/xeDlwrTt7qNyYfvK5aqbH2T/5
         LLOV7shr77Q6+knFCEzI+h6vENLBRDLsyjhg5Vai7P+jwwLd/vJteK2IV9m2bRosQZhl
         t7K3CX2ocdLiKzVPfePk8oI9sdIt2ycXsQClWnq4N/yDaaRFiAIs/xQ6QWKl24KsI/RZ
         4TbeeW/FAlOHG6Sb3XTUS2TGz/1pkMEMmXjPzTdXt1c/VY+ZXgTUQafp/DtG9w3bJZc7
         3yoQ==
Received: by 10.217.3.7 with SMTP id q7mr646859wes.47.1344559382333; Thu, 09
 Aug 2012 17:43:02 -0700 (PDT)
Received: by 10.216.160.17 with HTTP; Thu, 9 Aug 2012 17:43:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203194>

Hi,

At $dayjob we have backups setup for developers using a post-commit
hook that rsyncs the local .git directory to a backup server. The
advantage we get of using rsync instead of git push is that we also
backup the things that git push doesn't touch (e.g. config, hooks,
metadata from other tools). A happy side effect of this method is that
when we want to share code people can just fetch it from backup server
via nfs.

This is where my current problem lies. On a plain repository I can simply run

  $ git remote add -f rmt /net/path/to/backup/repo

However on a repository that is a submodule with a relocated .git
directory I get the following

  $ git --version
  git version 1.7.12.rc2.16.g034161a

  $ git remote add -f rmt /net/path/to/backup/repo
  Updating rmt
  remote: fatal: Could not chdir to '../../../repo': No such file or directory
  error: git upload-pack: git-pack-objects died with error.
  fatal: git upload-pack: aborting due to possible repository
corruption on the remote side.
  remote: aborting due to possible repository corruption on the remote side.
  fatal: protocol error: bad pack header
  error: Could not fetch rmt

Looking at /net/path/to/backup/repo/config I can guess what the
problem is, however I wouldn't have thought that git fetch would even
care about the worktree configuration.

  [core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
        worktree = ../../../repo

Using ssh:// instead of file:// works as expected

  $ git remote add -f rmt2 ssh://server/path/to/backup/repo
  Updating rmt2
  remote: Counting objects: 10, done.
  remote: Compressing objects: 100% (5/5), done.
  remote: Total 6 (delta 3), reused 0 (delta 0)
  Unpacking objects: 100% (6/6), done.
  From ssh://server/path/to/backup/repo
   * [new branch]      master     -> rmt2/master

Using ssh is a viable workaround but plenty of people here have
thought their fingers /net/server/user<tab> (which also let's you
check the path for validity along the way).

Is there any reason fetching using file:// should care about the
remote's worktree? The version of git on the server is different (git
version 1.7.1) so it could be a bug in fetch that is not exposed when
cloning via ssh.

Thanks,
Chris
