From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [BAD PATCH 0/9] v4-aware tree walker API
Date: Wed, 09 Oct 2013 12:51:26 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1310091137310.3023@syhkavp.arg>
References: <1381329976-32082-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_Gq8vJT5pw5JbgkZqlGKjnw)"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 09 18:51:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTwyz-0002j3-3W
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 18:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828Ab3JIQv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 12:51:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:43413 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914Ab3JIQv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 12:51:28 -0400
Received: from yoda.home ([66.130.143.177]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MUE0042XUTRNN10@VL-VM-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 09 Oct 2013 12:51:27 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id ED9CB2DA04B2; Wed, 09 Oct 2013 12:51:26 -0400 (EDT)
In-reply-to: <1381329976-32082-1-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Content-id: <alpine.LFD.2.03.1310091216170.3023@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235830>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_Gq8vJT5pw5JbgkZqlGKjnw)
Content-id: <alpine.LFD.2.03.1310091216171.3023@syhkavp.arg>
Content-type: TEXT/PLAIN; CHARSET=VISCII
Content-transfer-encoding: 8BIT

On Wed, 9 Oct 2013, Nguy­n Thái Ng÷c Duy wrote:

> I know I still have a lot of holes to plug, but this was more
> interesting because we could see some encouraging numbers.
> Unfortunately the result is disappointing. Maybe I did it in a stupid
> way and need to restart with a totally different way.
> 
> "rev-list --objects" on v2 takes 4 secs, v4 with current walker 11s
> and the new walker 16s (worst!).

Clear indication that something is wrong if the intermediate step of 
converting to the canonical object representation is faster than your 
attempt at a native pv4 walker.

However here's the numbers I get here after a fresh clone of git.git

$ time git revlist --objects --all > /dev/null

real    0m2.619s
user    0m2.577s
sys     0m0.033s
$ mkdir orig
$ mv .git/objects/pack/pack-* orig/
$ ../../git/test-packv4 orig/pack-*.pack .git/objects/pack/pack-foo.pack
Scanning objects: 100% (162785/162785), done.
Writing objects: 100% (162785/162785), done.
$ time git rev-list --objects --all > /dev/null

real    0m6.210s
user    0m6.140s
sys     0m0.027s

[installing git with your latest patches applied here]

$ time git rev-list --objects --all > /dev/null

real    0m20.409s
user    0m20.337s
sys     0m0.029s

So... I get even *worse* numbers relative to v2 than you do!

Now let's mitigate the deep delta chaining effect in the tree encoding:

$ rm .git/objects/pack/pack-foo.*
$ ../../git/test-packv4 --min-tree-copy=50 orig/pack-*.pack .git/objects/pack/pack-foo.pack
Scanning objects: 100% (162785/162785), done.
Writing objects: 100% (162785/162785), done.
$ time git rev-list --objects --all > /dev/null

real    0m9.451s
user    0m9.393s
sys     0m0.036s

Using --min-tree-copy=50 produces a pack which is still smaller than 
pack v2 but any tree copy sequence must refer to a minimum of 50 
entries.  This significantly reduces the CPU usage in decode_entries() 
by reducing the needless chaining effect I mentioned here:

http://article.gmane.org/gmane.comp.version-control.git/234975

Now let's keep that pack and back out your patches.

[installing git with your latest patches reverted here]

$ time git rev-list --objects --all > /dev/null

real    0m3.751s
user    0m3.711s
sys     0m0.029s

So I shoved almost 2.5 seconds of runtime here.  Not the half of the 
original runtime, but still significant.

Let's push the chaining theory even further:

$ rm .git/objects/pack/pack-foo.*
$ ../../git/test-packv4 --min-tree-copy=100 orig/pack-*.pack .git/objects/pack/pack-foo.pack
Scanning objects: 100% (162785/162785), done.
Writing objects: 100% (162785/162785), done.
$ time git rev-list --objects --all > /dev/null

real    0m3.445s
user    0m3.406s
sys     0m0.029s

With --min-tree-copy=100 the resulting pack gets somewhat larger than 
the v2 equivalent, but still smaller if we take into account the size of 
both the pack and index files.  However the runtime benefit is no more 
significant.

So, there are 2 conclusions here:

1: The current tree delta euristic is inefficient for pack v4.

2- Something must be very wrong in your latest patches as they make it
   close to 3 times more expensive than without them.

> The only bit I haven't done is avoid checking if a tree is already
> examined, if so do not bother with copy sequences referring to it.
> That should cut down the number of decode_entries but not sure how
> much because there's no relation between tree traversing order and how
> copy sequences are made.

I'm sure it would help mitigate the deep delta chaining effect as well.

> Maybe we could make an exception and allow the tree walker to pass
> pv4_tree_cache* directly to decode_entries so it does not need to do
> the first lookup every time..
> 
> Suggestions?

I'll try to have a look at your patches in more details soon.


Nicolas

--Boundary_(ID_Gq8vJT5pw5JbgkZqlGKjnw)--
