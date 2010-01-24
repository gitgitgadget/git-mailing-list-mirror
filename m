From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: cherry picking several patches at once
Date: Sun, 24 Jan 2010 16:31:43 +0100
Message-ID: <1264345006-sup-8582@nixos>
References: <20100121161157.GA3628@gandalf> <94a0d4531001221557n7a892f03u5e5d1c5e5ba5fea0@mail.gmail.com> <1264330354.14140.1.camel@gandalf> <94a0d4531001240510g25ea3398qdd0c7b98f9b81209@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 24 16:32:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ4RR-0003wT-E6
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 16:31:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550Ab0AXPbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 10:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753384Ab0AXPbw
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 10:31:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:36341 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751632Ab0AXPbv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 10:31:51 -0500
Received: (qmail invoked by alias); 24 Jan 2010 15:31:48 -0000
Received: from mawercer.at.xencon.net (EHLO mail.gmx.net) [83.246.111.127]
  by mail.gmx.net (mp021) with SMTP; 24 Jan 2010 16:31:48 +0100
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1/5JXZFEwz5hV434X2cLs96hpOy6LmY+6Ff+h4zxO
	NLbVPP8IPipnzb
Received: by mail.gmx.net (sSMTP sendmail emulation); Sun, 24 Jan 2010 16:31:44 +0100
In-reply-to: <94a0d4531001240510g25ea3398qdd0c7b98f9b81209@mail.gmail.com>
User-Agent: Sup/git
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53000000000000003
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137902>

> Ok, in that case we would just need a cherry-pick that can commit to a
> separate branch, however I don't think git internals allow that kind
> of thing.

Which is the best way to implement this git-cherry-push command?

# naive implementation (BASH function):

gitCherryPush(){
  # start a subshell so that failures don't quit your shell because of
  # set -e
  (
  set -e
  local branch=$(cat .git/HEAD |  sed 's@ref: refs/heads/\(.*\)@\1@')
  local otherBranch=$1; shift
  commits="$(
    for range in "$@"; do
      local HAS_DOTS=${range%%*..*}
      # add -1 if commit is not a range
      git rev-list --reverse ${HAS_DOTS:+-1} "$range"
    done
  )"

  echo "checking out other branch"
  git checkout "$otherBranch"
  echo "$commits" | while read c; do
    git cherry-pick "$c" || {
      echo "cherry-picking $c failed. fix it, exit 1 to abort. Starting subshell now"
      $SHELL || [ "$?" != 1] || return
    }
  done
  echo "checking out original branch $branch"
  git checkout $branch
  )
}

zsh completion:

compdef _gitCherryPush gitCherryPush
_gitCherryPush(){
  typeset -A opt_args
  _arguments -S \
   ':branch to which to move commit range:__git_branch_names' \
   ':branch to which to move commit range:__git_commit_ranges2'
}

Example usage (push last 5 commits)
gitCherryPush branch-to-push-to HEAD~4 HEAD~4..HEAD

Can I checkout the other branch without touching the working copy? I
don't think so because cherry-pick will fail operating if working
directory is not clean, correct?

Is something like this worth comitting to the main repo?

Marc Weber
