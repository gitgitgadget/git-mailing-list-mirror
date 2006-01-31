From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] shallow clone
Date: Tue, 31 Jan 2006 12:28:39 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601311127490.25248@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de>
 <43DDFF5C.30803@hogyros.de> <Pine.LNX.4.63.0601301305100.20228@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmld7c2g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 12:28:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3tgk-000245-FB
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 12:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWAaL2m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 06:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWAaL2m
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 06:28:42 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:24301 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750767AbWAaL2l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 06:28:41 -0500
Received: from virusscan.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.48])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1BC111463F4; Tue, 31 Jan 2006 12:28:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 0E15BA47;
	Tue, 31 Jan 2006 12:28:40 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BF1931463F4; Tue, 31 Jan 2006 12:28:39 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmld7c2g.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15310>

Hi,

On Mon, 30 Jan 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > - disallow fetching from this repo, and
> >> 
> >> Why? It's perfectly acceptable to pull from an incomplete
> >> repo, as long as you don't care about the old history.
> >
> > Right. But should that be the default? I don't think so. Therefore: 
> > disable it, and if the user is absolutely sure to do dumb things, she'll 
> > have to enable it explicitely.
> 
> If the downstream person wants to have a shallow history of post
> X.org X server core to further hack on it, I do not think of a
> reason why we would want to refuse her from cloning a repository
> of a fellow developer who has already done such a shallow copy.

Okay. But in their case, they'll probably do what was done with Linux: 
start afresh. If you want to have the old history, you can import it and 
merge it via a graft.

> If such a clone is done without telling the downstream that the
> result is a shallow one, it is "dumb".  I would agree it should
> not be done.

That was my point. As long as you don't make sure the client handles the 
shallow upstream gracefully, it is dangerous. At the moment, there are too 
many code parts relying on the completeness of the repository (local and 
remote).

Since I wrote this, I realized that the problem I saw is not limited to 
shallow upstream, but there is a subtle issue with shallow downstreams, 
too:

Just imagine this: Alice starts a project, Bob makes a shallow copy from 
it when Alice just reverted an experimental feature. Then, Alice decides 
the experimental feature was not bad at all and reverts the revert. Bob 
pulls from Alice: Alice's upload-pack assumes Bob already has the original 
files (now re-reverted), and Bob ends up with a broken repository.

While writing the last paragraph, it became clear to me that the shallow 
thing is very fragile: IMHO it is impossible to be fully backwards 
compatible (remember: you should not force anybody to upgrade).

> By the way, please refrain from discussing .git/config vs 
> .git/eparate-config-files issue in this thread.

Okay. I will shut up on that issue.

> My personal feeling so far is that the information current graft 
> represents is good enough to support shallow clones, and if not we can 
> extend its semantics to support such.

No. The grafts are more powerful. I have quite a few repos here in which I 
heavily work with grafts, and they are no cutoffs for shallow repos. They 
are hard links between different lines of development. For example, I use 
them to map merges in cvsimported projects, thus fixing a shortcoming of 
CVS. Also, you can "add" history.

If you now rely on the grafts file to determine what was a cutoff, you may 
well end up with bogus cutoffs.

Ciao,
Dscho
