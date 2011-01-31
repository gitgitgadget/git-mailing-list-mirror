From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] Add --create-cache to repack
Date: Mon, 31 Jan 2011 10:47:34 -0800
Message-ID: <AANLkTimW=fuKrhw6+ZDipEtSGX_oR4LbTZzyAxZ8Pry1@mail.gmail.com>
References: <1296201984-24426-1-git-send-email-spearce@spearce.org>
 <4D42878E.2020502@viscovery.net> <AANLkTim+AUY9SdeAFfkny2_a3qQ9SCDLUHR3s9Q3M98u@mail.gmail.com>
 <alpine.LFD.2.00.1101281304270.8580@xanadu.home> <AANLkTikPcp5CUTWfhy6FYbCEkNG6epGBAMNT5vTfSbvy@mail.gmail.com>
 <alpine.LFD.2.00.1101281502170.8580@xanadu.home> <AANLkTi=U7qRRij=BQXC1Goqa9toDFfaVKT=+-8zYxCcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	John Hawley <warthog19@eaglescrag.net>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Jan 31 19:48:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjynR-0004dc-7P
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 19:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730Ab1AaSsK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Jan 2011 13:48:10 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:65521 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755693Ab1AaSsI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jan 2011 13:48:08 -0500
Received: by eye27 with SMTP id 27so2716334eye.19
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 10:47:58 -0800 (PST)
Received: by 10.103.221.3 with SMTP id y3mr2677955muq.95.1296499674752; Mon,
 31 Jan 2011 10:47:54 -0800 (PST)
Received: by 10.103.1.2 with HTTP; Mon, 31 Jan 2011 10:47:34 -0800 (PST)
In-Reply-To: <AANLkTi=U7qRRij=BQXC1Goqa9toDFfaVKT=+-8zYxCcc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165739>

On Fri, Jan 28, 2011 at 17:32, Shawn Pearce <spearce@spearce.org> wrote=
:
>>> >
>>> >> This started because I was looking for a way to speed up clones =
coming
>>> >> from a JGit server. =A0Cloning the linux-2.6 repository is painf=
ul,
>
> Well, scratch the idea in this thread. =A0I think.

Nope, I'm back in favor with this after fixing JGit's thin pack
generation.  Here's why.

Take linux-2.6.git as of Jan 12th, with the cache root as of Dec 28th:

  $ git update-ref HEAD f878133bf022717b880d0e0995b8f91436fd605c
  $ git-repack.sh --create-cache \
      --cache-root=3Db52e2a6d6d05421dea6b6a94582126af8cd5cca2 \
      --cache-include=3Dv2.6.11-tree
  $ git repack -a -d

  $ ls -lh objects/pack/
  total 456M
  1.4M pack-74af5edca80797736fe4de7279b2a81af98470a5.idx
  38M pack-74af5edca80797736fe4de7279b2a81af98470a5.pack

  49M pack-d3e77c8b3045c7f54fa2fb6bbfd4dceca1e2b9fa.idx
  89 pack-d3e77c8b3045c7f54fa2fb6bbfd4dceca1e2b9fa.keep
  368M pack-d3e77c8b3045c7f54fa2fb6bbfd4dceca1e2b9fa.pack

Our "recent history" is 38M, and our "cached pack" is 368M.  Its a bit
more disk than is strictly necessary, this should be ~380M.  Call it
~26M of wasted disk.  The "cached object list" I proposed elsewhere in
this thread would cost about 41M of disk and is utterly useless except
for initial clones.  Here we are wasting about 26M of disk to have
slightly shorter delta chains in the cached pack (otherwise known as
our ancient history).  So its a slightly smaller waste, and we get
some (minor) benefit.


Clone without pack caching:

  $ time git clone --bare git://localhost/tmp_linux26_withTag tmp_in.gi=
t
  Cloning into bare repository tmp_in.git...
  remote: Counting objects: 1861830, done
  remote: Finding sources: 100% (1861830/1861830)
  remote: Getting sizes: 100% (88243/88243)
  remote: Compressing objects: 100% (88184/88184)
  Receiving objects: 100% (1861830/1861830), 376.01 MiB | 19.01 MiB/s, =
done.
  remote: Total 1861830 (delta 4706), reused 1851053 (delta 1553844)
  Resolving deltas: 100% (1564621/1564621), done.

  real	3m19.005s
  user	1m36.250s
  sys	0m10.290s


Clone with pack caching:

  $ time git clone --bare git://localhost/tmp_linux26_withTag tmp_in.gi=
t
  Cloning into bare repository tmp_in.git...
  remote: Counting objects: 1601, done
  remote: Counting objects: 1828460, done
  remote: Finding sources: 100% (50475/50475)
  remote: Getting sizes: 100% (18843/18843)
  remote: Compressing objects: 100% (7585/7585)
  remote: Total 1861830 (delta 2407), reused 1856197 (delta 37510)
  Receiving objects: 100% (1861830/1861830), 378.40 MiB | 31.31 MiB/s, =
done.
  Resolving deltas: 100% (1559477/1559477), done.

  real	2m2.938s
  user	1m35.890s
  sys	0m9.830s


Using the cached pack increased our total data transfer by 2.39 MiB,
but saved 1m17s on server computation time.  If we go back and look at
our cached pack size (368M), the leading thin-pack should be about
10.4 MiB (378.40M - 368M =3D 10.4M).  If I modify the tmp_in.git client
to have only the cached pack's tip and fetch using CGit, we see the
thin pack to bring ourselves current is 11.07 MiB (JGit does this in
10.96 MiB):

  $ cd tmp_in.git
  $ git update-ref HEAD b52e2a6d6d05421dea6b6a94582126af8cd5cca2
  $ git repack -a -d  ; # yay we are at ~1 month ago

  $ time git fetch ../tmp_linux26_withTag
  remote: Counting objects: 60570, done.
  remote: Compressing objects: 100% (11924/11924), done.
  remote: Total 49804 (delta 42196), reused 44837 (delta 37231)
  Receiving objects: 100% (49804/49804), 11.07 MiB | 7.37 MiB/s, done.
  Resolving deltas: 100% (42196/42196), completed with 4956 local objec=
ts.
  From ../tmp_linux26_withTag
   * branch            HEAD       -> FETCH_HEAD

  real	0m35.083s
  user	0m25.710s
  sys	0m1.190s


The pack caching feature is *no worse* in transfer size than if the
client copied the pack from 1 month ago, and then did an incremental
fetch to bring themselves current.  Compared to the naive clone, it
saves an incredible amount of working set space and CPU time.  The
server only needs to keep track of the incremental thin pack, and can
completely ignore the ancient history objects.  Its a great
alternative for projects that want users to rsync/http dumb transport
down a large stable repository, then incremental fetch themselves
current.  Or busy mirror sites that are willing to trade some small
bandwidth for server CPU and memory.

In this particular example, there is ~11 MiB of data that cannot be
safely resumed, or the first 2.9%.  At 56 KiB/s, a client needs to get
through the first 3 minutes of transfer before they can reach the
resumable checkpoint (where the thin pack ends, and the cached pack
starts).  It would be better if we could resume anywhere in the
stream, but being able to resume the last 97% is infinitely better
than being able to resume nothing.  If someone wants to really go
crazy, this is where a "gittorrent" client could start up and handle
the remaining 97% of the transfer.  :-)


I think this is worthwhile.  If we are afraid of the extra 2.39 MiB
data transfer this forces on the client when the repository owner
enables the feature, we should go back and improve our thin-pack code.
 Transferring 11 MiB to catch up a kernel from Dec 28th to Jan 12th
sounds like a lot of data, and any improvements in the general
thin-pack code would shrink the leading thin-pack, possibly getting us
that 2.39 MiB back.

--=20
Shawn.
