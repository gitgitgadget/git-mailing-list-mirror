From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Mon, 4 May 2009 23:14:23 +0200
Message-ID: <20090504211423.GK15420@raven.wolf.lan>
References: <20090429160129.GF15420@raven.wolf.lan> <32541b130904291113p6f99a82ft824cd3c482447117@mail.gmail.com> <20090429223747.GG15420@raven.wolf.lan> <32541b130904291907q4003ad86v4728c5b2ba0aacb7@mail.gmail.com> <20090430222808.GH15420@raven.wolf.lan> <32541b130904301559w329bdd4bo6f2736a505b7235f@mail.gmail.com> <20090501142811.GI15420@raven.wolf.lan> <32541b130905011217x7f339d41x696fedee7298e3a4@mail.gmail.com> <20090502215852.GJ15420@raven.wolf.lan> <32541b130905040858v2a0b7a6br5b056a365fcb6855@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 23:16:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M15Wo-0000mz-Sw
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 23:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbZEDVQc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 May 2009 17:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752436AbZEDVQc
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 17:16:32 -0400
Received: from quechua.inka.de ([193.197.184.2]:35036 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286AbZEDVQc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 17:16:32 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1M15WZ-0003tb-68; Mon, 04 May 2009 23:16:31 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 4A7792CCA6; Mon,  4 May 2009 23:14:23 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <32541b130905040858v2a0b7a6br5b056a365fcb6855@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118263>

On Mon, May 04, 2009 at 11:58:20AM -0400, Avery Pennarun wrote:
> On Sat, May 2, 2009 at 5:58 PM, Josef Wolf <jw@raven.inka.de> wrote:
> > Somehow, I still can't get it work. =A0This is what I do:
> [...]
> > =A0# move stuff from svn-2 to svn-1
> > =A0#
> > =A0git svn fetch svn-2
> > =A0git checkout svn-1
> > =A0git cherry-pick 05b964
> > =A0[ =A0continue cherry-picking ]
> > =A0git merge --no-ff -s ours svn-1
>=20
> Note that you probably should be merging '-s ours svn-2' here, not
> svn-1.  svn-1 already contains svn-1 (of course) so that merge didn't
> do anything.  It most especially doesn't mark svn-1 as being
> up-to-date with svn-2, and that's probably going to make trouble
> later.

Yeah, you're right.  That was a typo.

=46ixing this, the "getting started" seems to work now: the cherry-pick=
ed
commits end up in the svn repositories.  But the synchronization after
the "getting started" does not seem to work yet.  Here's what I've done=
:

 git tag svn-1-orig svn-1
 git tag svn-2-orig svn-2

 # move cherries to svn-2
 #
 git svn fetch svn-1
 git checkout svn-2
 git cherry-pick c9da
 [ ... ]
 git merge --no-ff -s ours svn-1
 git checkout svn-2/trunk
 git merge --no-ff svn-2
 git svn dcommit
 git diff svn-2-orig svn-2/trunk   # check what I've done

 # move cherries to svn-1
 #
 git svn fetch svn-2
 git checkout svn-1
 git cherry-pick 05b9
 [ ... ]
 git merge --no-ff -s ours svn-2
 git checkout svn-1/trunk
 git merge --no-ff svn-1
 git svn dcommit
 git diff svn-1-orig svn-1/trunk   # check what I've done

 git diff svn-1/trunk svn-2/trunk  # shows the diffs I want to keep

 # now try a synchronization
 #
 git checkout svn-2/trunk
 git svn fetch svn-1      # nothing new was checked in yet
 git merge --no-ff svn-1
 git svn dcommit

Since no new commits were made in svn, those four commands should be
almost a no-op.

But Instead of merging only the changes that were done after the last
synchronization, the last dcommit makes svn-2/trunk identical to svn-1.
This effectively wipes all the differences which I would like to keep.
