From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git gc / git repack not removing unused objects?
Date: Sun, 07 Feb 2010 21:11:36 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002071937000.1681@xanadu.home>
References: <cccedfc61002051145q1ff673e7s3db3bd7290be25e1@mail.gmail.com>
 <alpine.LFD.2.00.1002051539080.1681@xanadu.home>
 <cccedfc61002051304t6030d3f7if4bb14709ee6c918@mail.gmail.com>
 <alpine.LFD.2.00.1002051634380.1681@xanadu.home>
 <cccedfc61002060553w464d5d9drd582b3b3c3f35227@mail.gmail.com>
 <alpine.LFD.2.00.1002061935180.1681@xanadu.home>
 <cccedfc61002070948m2491b1e2ua633f125f3573ff9@mail.gmail.com>
 <cccedfc61002071540l7019d5d0mc4666dbd81189064@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_tXqGHTZbcOmtkhOxVMP3IA)"
Cc: git@vger.kernel.org
To: Jon Nelson <jnelson@jamponi.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 03:12:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeJ6V-0000tA-Qr
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 03:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755380Ab0BHCLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 21:11:39 -0500
Received: from relais.videotron.ca ([24.201.245.36]:27697 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211Ab0BHCLi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 21:11:38 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KXI006EG3FC2JR0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 07 Feb 2010 21:11:37 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <cccedfc61002071540l7019d5d0mc4666dbd81189064@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Content-id: <alpine.LFD.2.00.1002072054550.1681@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139272>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_tXqGHTZbcOmtkhOxVMP3IA)
Content-id: <alpine.LFD.2.00.1002072054551.1681@xanadu.home>
Content-type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-transfer-encoding: 8BIT

On Sun, 7 Feb 2010, Jon Nelson wrote:
> On Sat, Feb 6, 2010 at 7:16 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> >On Sat, 6 Feb 2010, Jon Nelson wrote:
> >>         packsizelimit = 256m
> >
> > Why are you using this?
> 
> I didn't want my pack files to be too huge. I've bumped that up to 2G.
> 
> >> pack.packsizelimit=2M
> 
> My ~/.gitconfig normally uses 2M for easy rsyncing. In this repo I
> thought the value was overridden by the project's config (which was
> specifying 256m and now specifies 2048m).

Why do you synchronize with rsync?  Why not a simple 'git fetch' which 
is likely to be much faster in any case?

> Suboptimal or not, it still doesn't explain why the repo grows with each repack.

That's strange indeed.  Except that ...

> turnip:/mnt/backups.git # git count-objects -v ; git repack -ad ; git
> count-objects -v
> count: 0
> size: 0
> in-pack: 2408195
> packs: 675
> size-pack: 174924053
> prune-packable: 0
> garbage: 0
> 
> Counting objects: 266309, done.
> Compressing objects: 100% (207820/207820), done.
> Writing objects: 100% (266309/266309), done.
> Total 266309 (delta 47751), reused 227730 (delta 45117)
> 
> count: 0
> size: 0
> in-pack: 2674504
> packs: 686
> size-pack: 196517094
> prune-packable: 0
> garbage: 0

You previously had 2408195 packed objects and after the repack this is 
2674504.  The difference is 266309, which incidentally is the number of 
objects 'git repack' counted.

If that 266309 object count is stable between repack attempts (and it 
should), then something is failing to clean up the old packs.  If I 
remember right, you were playing with modifications to git-repack.sh 
lately?  It is well possible that you broke it.

I tried to simulate your setup but I'm regretting it now.  My test repo 
expanded to 10x its original size with 900 packs.  Git is also painfully 
slow now while I'm trying to repack it properly back into a single pack.  
However I wasn't able to reproduce your repository growth.  Please 
retest with a vanilla Git version.

I think you should really consider using an unlimited pack size.  Not 
only you'll save quite a lot of disk space, but Git will be much faster 
too.  And Git itself is far more efficient than rsync at keeping Git 
repositories in sync, regardless of pack sizes (unless you have too many 
packs of course).


Nicolas

--Boundary_(ID_tXqGHTZbcOmtkhOxVMP3IA)--
