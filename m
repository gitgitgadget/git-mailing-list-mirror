From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: Handling tags/branches after git-svn fetch during SVN to Git 
	conversion
Date: Wed, 7 Jul 2010 09:36:55 -0400
Message-ID: <AANLkTim56UOYQJfX3M5Jpt0vXD8iTnkLuG68IjQG39Xn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 07 15:37:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWUoI-0006Y2-3Z
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 15:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755806Ab0GGNg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 09:36:57 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61175 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755290Ab0GGNg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 09:36:56 -0400
Received: by yxk8 with SMTP id 8so360039yxk.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 06:36:56 -0700 (PDT)
Received: by 10.229.248.139 with SMTP id mg11mr3896719qcb.41.1278509815870; 
	Wed, 07 Jul 2010 06:36:55 -0700 (PDT)
Received: by 10.229.38.133 with HTTP; Wed, 7 Jul 2010 06:36:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150470>

I had a fairly complicated config for my SVN to Git migration with
multiple branch and tag locations. Therefore, I had to break up the
"git svn clone" because I didn't know how to pass multiple branch
locations to "git svn clone":

1. git svn init
2. Update .git/config with branch/tag locations
[svn-remote "svn"]
        url = file:///Users/Developers/git_transition/svn_repo
        fetch = project/trunk:refs/remotes/svn/trunk
        branches =
project/branches/{feature1-branch,feature2-branch}:refs/remotes/svn/*
        branches =
project/branches/{6.x,5.x,4.x,3.x,archive}/*:refs/remotes/svn/*
        tags = project/tags/{3.7.x,4.x,5.x,6.x,old-releases}/*:refs/remotes/svn/tags/*
3. git svn -A/path/to/mappings fetch

Do I need to convert these remote tags/branches into local Git
tags/branches before pushing them to my remote Git repo or is there a
way to push remote branches directly to my remote Git repo?

The command that someone else told me was "git checkout -b
<local_branch_name> <remote_branch_name>". Though, I've seen other
places mention different strategies for converting the branches.

The script I devised to convert the tags does this for each tags
folder to maintain the original commit date, author, and commit
message:

git for-each-ref --format="%(refname)" refs/remotes/svn/tags/6.x |
grep -v @ | while read tag; do GIT_COMMITTER_DATE="$(git log -1
--pretty=format:"%ad" "$tag")" GIT_COMMITTER_EMAIL="$(git log -1
--pretty=format:"%ce" "$tag")" GIT_COMMITTER_NAME="$(git log -1
--pretty=format:"%cn" "$tag")" git tag -m "$(git log -1
--pretty=format:"%s%n%b" "$tag")" ${tag#refs/remotes/svn/tags/6.x/}
"$tag"; done

Please let me know if this is correct.

Thanks!
