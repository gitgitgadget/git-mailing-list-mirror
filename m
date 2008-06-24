From: Theodore Tso <tytso@mit.edu>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 09:13:15 -0400
Message-ID: <20080624131315.GD7639@mit.edu>
References: <20080624081601.GA2692@sigill.intra.peff.net> <willow-jeske-01l5PFjPFEDjCfzf-01l5kv6TFEDjCj8S@brm-avmta-1.central.sun.com> <willow-jeske-01l5lTEoFEDjCVta@brm-avmta-1.central.sun.com> <alpine.WNT.1.10.0806241343170.3824@theodor> <e80d075a0806240324j79f872d3t1db9dfb87dc2d37c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fedor Sergeev <Fedor.Sergeev@sun.com>, git@vger.kernel.org
To: David Jeske <jeske@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 15:15:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB8M4-0006w2-RS
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 15:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbYFXNNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 09:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752151AbYFXNNT
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 09:13:19 -0400
Received: from www.church-of-our-saviour.org ([69.25.196.31]:47902 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750968AbYFXNNT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 09:13:19 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KB8Ki-0005qQ-21; Tue, 24 Jun 2008 09:13:16 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KB8Kh-0003O1-Js; Tue, 24 Jun 2008 09:13:15 -0400
Content-Disposition: inline
In-Reply-To: <e80d075a0806240324j79f872d3t1db9dfb87dc2d37c@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86052>

On Tue, Jun 24, 2008 at 03:24:00AM -0700, David Jeske wrote:
> Odd. I've never been a gatekeeper. I'm just a developer who has burned
> himself enough times that I want a tool (i.e. source control) to help
> prevent me from ever destroying anything I create.

It sounds like the main problem is that you need to learn more about
how to use the your tools.  If you use the tools right, the number of
times that you you'll accidentally overwrite a branch pointer is quite
rare; and generally you notice right away; the default GC period of 30
days is a L-O-N-G time, and in practice its more than enough time for
someone to notice that they screwed up.

So a couple of tips

1) "git reflog show <branch name>" is a great way to only look at
changes to a particular branch.  ("git log -g" or "git reflog show"
defaults to showing the reflog for HEAD)

2) A number of accidents with "git rebase" happen because people
forget which branch they are on.  So having your command line prompt
tell you which branch you are on is really helpful.  Google "git
prompt shell" for some examples of how to do this.

I do something like this:

function __prompt_git()
{
	local git_dir ref br top;
	git_dir=$(git-rev-parse --git-dir 2> /dev/null) || return
	ref=$(git-symbolic-ref HEAD 2> /dev/null) || return
	br=${ref#refs/heads/}
	top=$(cat $git_dir/patches/$br/current 2>/dev/null) \
		  && top="/$top"
		  echo "[$br$top]"
}

if [ $UID = 0 ]; then
u="${LOGNAME}.root"
p="#"
else
u="$LOGNAME";
p="%"
fi
if [ $SHLVL != 1 ]; then
s=", level $SHLVL"
fi
PS1="<${u}@${HOSTNAME}> {\${PWD}}$s  \$(__prompt_git)\n\!$p "
unset u s

							- Ted
