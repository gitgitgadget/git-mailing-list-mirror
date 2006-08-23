From: Jim Meyering <jim@meyering.net>
Subject: "cg-commit -M msg-file ..." fails when not run from top of tree
Date: Wed, 23 Aug 2006 12:27:38 +0200
Message-ID: <87d5aru4px.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Aug 23 12:27:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFpxB-000413-WE
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 12:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWHWK1R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 06:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWHWK1R
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 06:27:17 -0400
Received: from mx.meyering.net ([82.230.74.64]:23953 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S964819AbWHWK1Q (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Aug 2006 06:27:16 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 3E720B29; Wed, 23 Aug 2006 12:27:38 +0200 (CEST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25907>

Hello,

I discovered that "cg-commit -M MSG-FILE ..." fails when run from
a subdirectory, and when MSG-FILE is a relative file name.
This is using cogito-0.17.3-2 from Debian/unstable, but the problem
remains when using the latest cogito sources, pulled minutes ago.

Here's an example:

  $ mkdir a; touch a/x; cg-init -m. .; cd a; echo . > x; cg-commit -M x x
  defaulting to local storage area
  Adding file a/x
  Committing initial tree 341d89829a1bf9c0ccfbccf738815cbc862b3242
  Committed as 6497164c6f8e86220ff26c6b89b9d0dbad5a7743
  cat: x: No such file or directory
  [Exit 1]

This appears to be due to the "cd", that can happen in cg-Xlib:

  _git="${GIT_DIR:-.git}"
  if [ ! "$_git_repo_unneeded" ] && [ ! "$GIT_DIR" ] && [ ! -d "$_git" ]; then
          _git_abs_path="$(git-rev-parse --git-dir 2>/dev/null)"
          if [ -d "$_git_abs_path" ]; then
                  _git_relpath="$(git-rev-parse --show-prefix)"
==========>       cd "$_git_abs_path/.."         <==============
          fi
  fi
  _git_objects="${GIT_OBJECT_DIRECTORY:-$_git/objects}"

I can work around the problem by using an absolute name for
the message file, but I shouldn't have to do that.

FWIW, I tried setting GIT_DIR to the absolute name of the .git directory,
but that just made it so cg-commit failed with this diagnostic:

  cg-commit: Nothing to commit

Jim
