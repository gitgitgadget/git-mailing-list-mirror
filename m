From: Magnus =?iso-8859-1?Q?B=E4ck?= <magnus.back@sonyericsson.com>
Subject: Re: merging bare repository
Date: Fri, 13 May 2011 15:53:48 +0200
Message-ID: <20110513135348.GB10857@jpl.local>
References: <533718318.20110513145132@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 16:17:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKtBZ-0006S4-NM
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 16:17:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756076Ab1EMORk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 May 2011 10:17:40 -0400
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:47690 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755318Ab1EMORj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 10:17:39 -0400
X-Greylist: delayed 1428 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 May 2011 10:17:39 EDT
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id 04835EAD41
	for <git@vger.kernel.org>; Fri, 13 May 2011 15:53:50 +0200 (CEST)
X-SMTPAUTH-B2: [b627879]
X-SENDER-IP: [83.227.167.132]
X-LISTENER: [smtp.bredband.net]
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvwhAGg2zU1T46eEPGdsb2JhbACJHo4qjj8LAQEBATcyiHC8YIYVBJhRhik
X-IronPort-AV: E=Sophos;i="4.64,364,1301868000"; 
   d="scan'208";a="189388816"
Received: from ua-83-227-167-132.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.167.132])
  by ipb1.telenor.se with ESMTP; 13 May 2011 15:53:50 +0200
Received: by elwood.jpl.local (Postfix, from userid 1000)
	id D4EA5422CD; Fri, 13 May 2011 15:53:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <533718318.20110513145132@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173540>

On Friday, May 13, 2011 at 12:51 CEST,
     Ilya Basin <basinilya@gmail.com> wrote:

> Hi list. Please suggest me a solution. There's a remote repository;
> we're not allowed to push to. We have several committers.
> So I want to create a local mirrror. We will push our changes to it.
> Once in a while I want to sync this repo with upstream.

Okay, so you're forking an upstream git and periodically merging from
it. Pretty standard behavior.

> Here's what I do:
>=20
> on server:
>     [git@server]$ git clone --bare ssh://git@some.org/git/project.git=
 /git/project.git
>=20
> on workstation:
>     [me@client]$ git clone ssh://git@server/git/project.git
>     [me@client]$ cd project
>     [me@client]$ touch aaa
>     [me@client]$ git add aaa
>     [me@client]$ git commit aaa -m abracadabra
>     [me@client]$ git push
>=20
> back on server:
>     [git@server]$ git log
>     commit e5c871122cadfa4ed4d2ab488852ecdb803b4bd8
>     Author: Ilya Basin <>
>     Date:   Fri May 13 13:39:39 2011 +0400
>=20
>         abracadabra
>=20
> I want to merge with upstream
>     [git@server]$ git fetch
>     [git@server]$ git merge origin
>     fatal: This operation must be run in a work tree

Don't do the merge in the server-side bare git, do it somewhere you've
made a non-bare clone that has a worktree. A workstation would be the
best choice, but you could make such a clone on the server too (but I'd
avoid introducing a process in an organization that required people to
be able to logon to the Git server). Once you've actually done the merg=
e
you can push the merge commit to the master branch of
ssh://git@server/git/project.git.

To deal with upstreams like this I recommend you place the upstream
branch(es) in a separate namespace prefixed by <upstreamname>/, e.g.
github/master if your upstream is the master branch from the official
Github repo of the project. Example:

   git fetch ssh://git@some.org/git/project.git
   git push ssh://git@server/git/project.git FETCH_HEAD:github/master

If you mirror the upstream branches like this on your server merges
from upstream becomes trivial[*],

   git merge origin/github/master
   git push ssh://git@server/git/project.git HEAD:master

and can be done on any workstation plus it's easy for your users to
e.g. see what they've been up to compared to the upstream:

   git log origin/github/master..origin/master

You could update github/master as often as you wish, perhaps more often
than you do the actual merge to your own branch. That way your users ca=
n
easily keep track of what goodies await them in the next merge from
upstream.

[*] I'm being unnecessarily explicit in the push operation just to
    show what's going on -- a plain "git push origin" will probably
    do the same thing.

[...]

--=20
Magnus B=E4ck                   Opinions are my own and do not necessar=
ily
SW Configuration Manager      represent the ones of my employer, etc.
Sony Ericsson
