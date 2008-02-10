From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sun, 10 Feb 2008 17:45:00 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802101649110.11591@racer.site>
References: <200802081828.43849.kendy@suse.cz>  <alpine.LFD.1.00.0802081250240.2732@xanadu.home>  <200802091525.36284.kendy@suse.cz>  <e5bfff550802092323u3ec3c9c8uf6e92399395efd27@mail.gmail.com>  <alpine.LSU.1.00.0802101207330.11591@racer.site>
 <ee77f5c20802100846g10937a49m4901f88a70a6de0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>,
	Jan Holesovsky <kendy@suse.cz>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org, gitster@pobox.com
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 18:46:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOGFh-0007Bc-Gj
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 18:46:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbYBJRpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 12:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbYBJRpD
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 12:45:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:48642 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751226AbYBJRpA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 12:45:00 -0500
Received: (qmail invoked by alias); 10 Feb 2008 17:44:59 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp003) with SMTP; 10 Feb 2008 18:44:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19JQFYJ9qZJ6C5iX6zFqMks5Ksq+ddEzpe+3t1e6Y
	ULNYgffa6VIuut
X-X-Sender: gene099@racer.site
In-Reply-To: <ee77f5c20802100846g10937a49m4901f88a70a6de0@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73381>

Hi,

On Sun, 10 Feb 2008, David Symonds wrote:

> On Feb 10, 2008 4:08 AM, Johannes Schindelin 
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Sun, 10 Feb 2008, Marco Costalba wrote:
> >
> > > Linux git repository is not very big and can be downloaded with 
> > > easy. On the other end Linux history spans many more years then the 
> > > repo does.
> > >
> > > The design choice here is two have *two repositories*, one with 
> > > recent stuff and one historical, with stuff older then version 
> > > 2.6.12
> >
> > I do not think that this is an option: Jan already tried a shallow 
> > clone (which would amount to something like what you propose), and it 
> > was still too large.
> 
> I think that was still pulling all the branches, so a shallow clone of 
> just a couple of branches might be feasible.

Indeed:

$ git ls-remote git://o3-build.services.openoffice.org/git/ooo.git|wc -l
3970
$ git ls-remote --heads git://o3-build.services.openoffice.org/git/ooo.git|
	wc -l
751

Fetching just master is a little hard on the server (it spends quite a 
lot of time deltifying -- minutes! -- especially between 80% and 95%, 
and indexing is even slower), but other than 
that:

$ /usr/bin/time git fetch --depth=1 \
	git://o3-build.services.openoffice.org/git/ooo.git \
	master:refs/remotes/origin/master
warning: no common commits
remote: Generating pack...
remote: Done counting 79934 objects.
remote: Deltifying 79934 objects...
remote:  100% (79934/79934) done
Indexing 79934 objects...
remote: Total 79934 (delta 34549), reused 51323 (delta 20737)
 100% (79934/79934) done
Resolving 34549 deltas...
 100% (34549/34549) done
* refs/remotes/origin/master: storing branch 'master' of 
git://o3-build.services.openoffice.org/git/ooo
  commit: 29990e4
46.48user 4.60system 16:48.29elapsed 5%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (0major+941205minor)pagefaults 0swaps

$ du .git/objects/pack/
464688  .git/objects/pack/
$ /usr/bin/time git repack -a -d -f --window=250 --depth=250
Generating pack...
Done counting 79934 objects.
Deltifying 79934 objects...
 100% (79934/79934) done
Writing 79934 objects...
 100% (79934/79934) done
Total 79934 (delta 40013), reused 0 (delta 0)
Pack pack-350e4edca93ee75ef3d85269284a24775bf6b24f created.
Removing unused objects 100%...
Done.
1869.78user 6.66system 31:36.50elapsed 98%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (2031major+1753824minor)pagefaults 0swaps
$ du .git/objects/pack/
454636  .git/objects/pack/

Of course, the clone time would be reduced dramatically if the repository 
you clone from has only "master", and is fully (re-)packed.

So I was not completely correct in my assumption that a clear cut a la 
linux-2.6 (possibly grafting historical-linux) would not help.

Ciao,
Dscho
