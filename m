From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: how to git a read only directory
Date: Wed, 21 Jan 2009 10:57:41 +0100
Message-ID: <4976F195.9030908@drmicha.warpmail.net>
References: <20090121083354.GG6970@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>, cbill.lam@gmail.com
X-From: git-owner@vger.kernel.org Wed Jan 21 10:59:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPZrb-0001E9-TB
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 10:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754971AbZAUJ5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 04:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754825AbZAUJ5r
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 04:57:47 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48611 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752931AbZAUJ5q (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2009 04:57:46 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 5962822F6CE;
	Wed, 21 Jan 2009 04:57:44 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 21 Jan 2009 04:57:44 -0500
X-Sasl-enc: K25FcnYdo9jMO9accCS+pfZXer4MbpPUAWwbPi+vyuxK 1232531864
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C583FE8DC;
	Wed, 21 Jan 2009 04:57:43 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <20090121083354.GG6970@b2j>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106586>

bill lam venit, vidit, dixit 21.01.2009 09:33:
> I want to use git to keep track of files inside /etc but do not want
> to do it as a super user. Is that possible to put GIT_DIR under my
> home directory and add public-read files inside /etc? Or that it could
> be done in some other ways.
> 
> Thanks.
> 

You can use the core.worktree config variable in order to specify a
worktree (/etc) which is not directly above .git. For your git commands
to find the .git dir you would need to set GIT_DIR or use the --git-dir
parameter.

I have found, though, that several git commands require you to be within
the worktree or else they become confused. I use a shell function for
that, doing something like "gg ~/path/project log" which requires
~/path/project.git to have its core.worktree set. Also, having a git
alias like "git view" set up for gitk helps calling gitk in that way.
git-gui makes unfounded assumptions and is completely unhappy in a
situation like that.

I think the situation around GIT_DIR and and worktree is a bit in the
flux at the moment (panta rhei..) but it works for me.

Cheers,
Michael

Here's the "git go" bash function. I'm not proud of it, it makes several
assumptions and does no error checking. Use it like "gg path/project
command parameters" if the git-dir is "path/project.git" or "gg
path/project/" if the git-dir is "path/project/.git". Have your
core.worktree set in the former case, and also in the latter if the
worktree is not "path/project".

I'm sure it can be done much better using helper functions from git's
bash-completion, e.g.

gg ()
{
    local _gg="$1";
    shift;
    local _ggwt=`git --git-dir="${_gg}.git" config --get core.worktree`;
    if [ -z "${_ggwt}" ]; then
        _ggwt=$(cd ${_gg} 2> /dev/null && pwd -P);
    fi;
    local _gggd=$(cd ${_gg}.git 2> /dev/null && pwd -P);
    pushd ${_ggwt} > /dev/null;
    git --git-dir=${_gggd} "$@";
    popd > /dev/null
}
