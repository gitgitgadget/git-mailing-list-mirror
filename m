From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RFC: [PATCH] Support incremental pack files
Date: Mon, 26 Feb 2007 23:03:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702262258120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070223071344.GA21107@auto.tuwien.ac.at>
 <7vfy8x9tvo.fsf@assigned-by-dhcp.cox.net> <20070226214552.GA13402@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Feb 26 23:03:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLnw8-0008H3-2L
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 23:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161266AbXBZWDF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 17:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161238AbXBZWDF
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 17:03:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:39557 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161268AbXBZWDE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 17:03:04 -0500
Received: (qmail invoked by alias); 26 Feb 2007 22:03:01 -0000
X-Provags-ID: V01U2FsdGVkX19u8fsiuI9uBWCiJahdiU82QJa4GeVJnFbu29l/F5
	gMtA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070226214552.GA13402@auto.tuwien.ac.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40668>

Hi,

On Mon, 26 Feb 2007, Martin Koegler wrote:

> On Fri, Feb 23, 2007 at 12:10:35AM -0800, Junio C Hamano wrote:
>
> >   $ P=.git/objects/pack
> >   $ git rev-list --objects v1.5.0 |
> >     git pack-objects --delta-base-offset \
> >           --depth=30 --window=100 --no-reuse-delta pack
> >   ...
> >   6fba5cb8ed92dfef71ff47def9f95fa1e703ba59
> >   $ mv pack-6fba5cb8ed92dfef71ff47def9f95fa1e703ba59.* $P/
> >   $ echo 'Post 1.5.0' >$P/pack-6fba5cb8ed92dfef71ff47def9f95fa1e703ba59.keep
> >   $ git gc --prune
> > 
> > This does three things:
> > 
> >  - It packs everything reachable from v1.5.0 with delta chain
> >    that is deeper than the default.
> > 
> >  - The pack is installed in the object store; the presence of
> >    .keep file (the contents of it does not matter) tells
> >    subsequent repack not to touch it.
> > 
> >  - Then the remaining objects are packed into different pack.
> > 
> > With this, the repository uses two packs, one is what I'll keep
> > until it's time to do the big repack again, another is what's
> > constantly recreated by repacking but contains only "recent"
> > object.
> 
> This could be a practical solution for me. The biggest disadvantage of 
> this solution is, that each pack file is at least >= 60 MB.

Junio has a branch he rewinds sometimes. That's why he does not do the 
obvious, which should work for you:

$ git gc --prune
$ for p in .git/objects/pack/*.pack; do
	keepfile=`echo $p | sed s/pack$/keep/`
	echo "Keep all current packs as-are" > $keepfile
  done

You should run this from time to time. You can run "git gc --prune" more 
often, of course...

Hth,
Dscho
