From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-annotate, a tool for assigning blame.
Date: Fri, 24 Feb 2006 01:00:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602240055080.31816@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11404323692193-git-send-email-ryan@michonline.com>
 <20060220234054.GA7903@c165.ib.student.liu.se> <20060223221048.GA6423@mythryan2.michonline.com>
 <20060223225547.GB8673@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ryan Anderson <ryan@michonline.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 01:00:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCQOC-00009a-GF
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 01:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWBXAAq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 19:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWBXAAq
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 19:00:46 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:44980 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932151AbWBXAAp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 19:00:45 -0500
Received: from virusscan.mail (mail03.mail [172.25.1.102])
	by mailrelay.mail (Postfix) with ESMTP id 216491BB9;
	Fri, 24 Feb 2006 01:00:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 14BC6113D;
	Fri, 24 Feb 2006 01:00:42 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id B0885A91;
	Fri, 24 Feb 2006 01:00:41 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060223225547.GB8673@c165.ib.student.liu.se>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16674>

Hi,

On Thu, 23 Feb 2006, Fredrik Kuivinen wrote:

> On Thu, Feb 23, 2006 at 05:10:49PM -0500, Ryan Anderson wrote:
> > (Biased critique since I have the other tool in the tree, but still...)
> > 
> > > +    FILE* fout = fopen("/tmp/git-blame-tmp1", "w");
> > 
> > Probably should be using something like mkstemp (mkstmp?) here, so if
> > someone is runnign things as root or with a malicous user around, things
> > don't collide.
> > 
> > Hell, so on a multi-user machine this doesn't blow up on you.
> 
> Yep, I know. The code is mostly a proof of concept. I didn't submit it
> for inclusion.

Ha ha, famous last words!

> > But, read down for a related comment.
> > 
> > > +    if(!fout)
> > > +        die("fopen tmp1 failed: %s", strerror(errno));
> > > +
> > > +    if(fwrite(info_c->buf, info_c->size, 1, fout) != 1)
> > > +        die("fwrite 1 failed: %s", strerror(errno));
> > > +    fclose(fout);
> > > +
> > > +    fout = fopen("/tmp/git-blame-tmp2", "w");
> > > +    if(!fout)
> > > +        die("fopen tmp2 failed: %s", strerror(errno));
> > > +
> > > +    if(fwrite(info_o->buf, info_o->size, 1, fout) != 1)
> > > +        die("fwrite 2 failed: %s", strerror(errno));
> > > +    fclose(fout);
> > > +
> > > +    FILE* fin = popen("diff -u0 /tmp/git-blame-tmp1 /tmp/git-blame-tmp2", "r");
> > > +    if(!fin)
> > > +        die("popen failed: %s", strerror(errno));
> > 
> > Can't git-diff-tree do this sufficiently, anyway?  See my Perl script
> > for an example, you just need both commit IDs and both filenames and the
> > appropriate -M and you get the right results.
> > 
> > (It's possible that's part of where the performance differences are,
> > though, not really sure at the moment.)
> > 
> 
> Yeah.. maybe. My first thought was to avoid forking and execing diff
> and use some C library for doing the diffing instead (libxdiff). But
> then I just wanted to get some code working and the simplest solution
> I could think of was to fork and exec diff.

git-diff-tree fork()s a diff. So, by fork()ing git-diff-tree you get two 
fork()s (and no knife...).

> > I'm going to stop there for the moment, I'm not really confident in my
> > understanding of git-internals to say much more just yet.
> > 
> > This could probably benefit a *LOT* from the libification project, I
> > think, though.
> 
> Yes, perhaps. Some of the git-rev-list bits might simplify a couple of
> things.

The major problem is probably not solved: What Linus calls a "stream 
interface".

I.e. if you pipe the output of git-rev-list to another program, you 
*need* to execute the two semi-simultaneously. The "alternative" would be 
to use buffers, which can get huge (and are sometimes not needed: think 
git-whatchanged, which starts outputting before it's getting no more 
input).

> I have found some severe problems with the code I posted, in
> particular it doesn't handle parallel development tracks at all. I am
> working on fixing it, but it isn't finished yet.

Looking forward to them!

Ciao,
Dscho
