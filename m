From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH] git-pack-objects: cache small deltas between big objects
Date: Mon, 21 May 2007 19:59:50 +0200
Message-ID: <20070521175950.GA13818@auto.tuwien.ac.at>
References: <11796954641778-git-send-email-mkoegler@auto.tuwien.ac.at> <56b7f5510705202135s8c9cd9qf4489b2b5bb2e264@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 21 20:00:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqCAv-0000RS-4n
	for gcvg-git@gmane.org; Mon, 21 May 2007 20:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758721AbXEUR7z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 21 May 2007 13:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757792AbXEUR7z
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 13:59:55 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:47741 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758721AbXEUR7y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 13:59:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 699A77037F43;
	Mon, 21 May 2007 19:59:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mizqrDeFi7dP; Mon, 21 May 2007 19:59:50 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 8AF0E6800A0D; Mon, 21 May 2007 19:59:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <56b7f5510705202135s8c9cd9qf4489b2b5bb2e264@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48032>

On Sun, May 20, 2007 at 09:35:56PM -0700, Dana How wrote:
> On 5/20/07, Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> >Creating deltas between big blobs is a CPU and memory intensive task=
=2E
> >In the writing phase, all (not reused) deltas are redone.
>=20
> Actually,  just the ones selected,  which is approx 1/window.
> Do you have any numbers describing the effects on runtime
> and memory size for a known repo like linux-2.6?

Objects below 1 MB are not considered for caching.=20
The linux kernel has only such objects:
linux.git$ find -size +1000k |grep -v ".git"|wc
      0       0       0
So no caching happens. The required memory is only increased by the
new pointer in object_entry.=20

At runtime, we have additional (#object)*(window size+1) null pointer
checks, (#objects)*(window size) pointer initialiations with zero and
check (#objects)*(window size) times the caching policy check: ((src_si=
ze
>> 20) + (trg_size >> 21) > (delta_size >> 10))

Writing a cached delta is faster, as we avoid creating a delta. Some
calls to free are delayed.

> >This patch adds support for caching deltas from the deltifing phase,=
 so
> >that that the writing phase is faster.
> >
> >The caching is limited to small deltas to avoid increasing memory us=
age=20
> >very much.
> >The implemented limit is (memory needed to create the delta)/1024.
>=20
> Your limit is applied per-object,  and there is no overall limit
> on the amount of memory not freed in the delta phase.
> I suspect this caching would be disastrous for the large repo
> with "megablobs" I'm trying to wrestle with at the moment.

http://www.spinics.net/lists/git/msg31241.html:
> At the moment I'm experimenting on a git repository with
> a 4.5GB checkout,  and 18 months of history in 4K commits
> comprising 100GB (uncompressed) of blobs stored in
> 7 packfiles of 2GB or less. Hopefully I'll be able to say
> more about tweaking packing shortly.

I you have 100 GB of uncompressed data in your pack files, the cache
limit is between 100MB and 200MB with the current policy.

The aim of my patch is to speed up pack writing without increasing
memory usage very much, if you have blobs of some hundred MB size in
your repository.

The caching policy could be extended to speed more memory on caching
other deltas. Ideas on this topic are welcome.

mfg Martin K=F6gler
PS: If you are trying to optimize packing speed/size, you could test
the following patch: http://marc.info/?l=3Dgit&m=3D117908942525171&w=3D=
2
