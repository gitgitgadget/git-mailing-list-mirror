From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn very slow on fetch (shared git-svn repo)
Date: Sun, 11 Oct 2009 00:01:36 -0700
Message-ID: <20091011070136.GB16264@dcvr.yhbt.net>
References: <4AD04F95.7050603@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Sun Oct 11 09:04:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwsU9-0001da-Fx
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 09:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbZJKHCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 03:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbZJKHCO
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 03:02:14 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:41102 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102AbZJKHCN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 03:02:13 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 387BC1F7BA;
	Sun, 11 Oct 2009 07:01:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4AD04F95.7050603@obry.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129904>

Pascal Obry <pascal@obry.net> wrote:
> Here is the problem.
>
> Doing a:
>
>    $ git svn fetch
>
> Takes age to update the repository. The long story is that I'm trying to  
> have shared git-svn repositories.
>
> I'm cloning the repository on a server using a standard "git svn clone".  
> I then let users cloning this repository using the procedure described  
> in git-svn help. Copy/paste here:
>
> <<
>        # Do the initial import on a server
>                ssh server "cd /pub && git svn clone  
> http://svn.example.com/project
>        # Clone locally - make sure the refs/remotes/ space matches the  
> server
>                mkdir project
>                cd project
>                git init
>                git remote add origin server:/pub/project
>                git config --add remote.origin.fetch  
> '+refs/remotes/*:refs/remotes/*'
>                git fetch
>        # Create a local branch from one of the branches just fetched
>                git checkout -b master FETCH_HEAD
>        # Initialize 'git svn' locally (be sure to use the same URL and  
> -T/-b/-t options as were used on server)
>                git svn init http://svn.example.com/project
>        # Pull the latest changes from Subversion
>                git svn rebase
> >>
>
> If you do a "git svn fetch" (to get new branches) it takes age if you  
> have imported branches that are not used since a long time.
>
> I've traced this down to the Perl fetch_all procedure. It seems that the  
> fetch is looking at the older version in all branches and then read the  
> remote repository starting from this revision. As some branches are  
> unused since a very long it it re-read most of the history. In my  
> example it start at rev 8200 whereas the last revision on trunk is  
> 150000 (I put trace in git-svn Perl script).
>
> I have observed that this happen only the first time.
>
> This can be confirmed by the fact that if you break git-svn fetch  
> process and restart it it will start to a later revision. So it seems  
> that git-svn is keeping some kind of data about what has already been  
> fetched but those data are not properly copied by the procedure above.
>
> Is there a workaround that? Where are those data stored?

Hi Pascal,

For globs (branches and tags) the $GIT_DIR/svn/.metadata
config file, under the svn-remote.svn.{branches,tags}-maxRev keys.

For explicitly specified refs (e.g. "trunk"), then it's in the last
record of the corresponding rev_map (e.g.
$GIT_DIR/svn/trunk/.rev_map.$UUID) as a 4-byte revision number + 20
bytes of zeroes.

-- 
Eric Wong
