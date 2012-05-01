From: Jeff King <peff@peff.net>
Subject: Re: gc --aggressive
Date: Tue, 1 May 2012 12:28:06 -0400
Message-ID: <20120501162806.GA15614@sigill.intra.peff.net>
References: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com>
 <CAG+J_DyqvCxwd6+gzixQEk6SxMZF0qsXKcJPaU6imsJdFQ-64g@mail.gmail.com>
 <vpqbomqqdxo.fsf@bauges.imag.fr>
 <20120428122533.GA12098@sigill.intra.peff.net>
 <alpine.LFD.2.02.1204281258050.21030@xanadu.home>
 <20120429113431.GA24254@sigill.intra.peff.net>
 <alpine.LFD.2.02.1204290917051.21030@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue May 01 18:28:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPFw1-0000oo-F7
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 18:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191Ab2EAQ2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 12:28:13 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53423
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752561Ab2EAQ2M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 12:28:12 -0400
Received: (qmail 6587 invoked by uid 107); 1 May 2012 16:28:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 May 2012 12:28:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 May 2012 12:28:06 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1204290917051.21030@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196690>

On Sun, Apr 29, 2012 at 09:53:31AM -0400, Nicolas Pitre wrote:

> But my remark was related to the fact that you need to double the 
> affected resources to gain marginal improvements at some point.  This is 
> true about computing hardware too: eventually you need way more gates 
> and spend much more $$$ to gain some performance, and the added 
> performance is never linear with the spending.

Right, I agree with that. The trick is just finding the right spot on
that curve for each repo to maximize the reward/effort ratio.

> >   1. Should we bump our default window size? The numbers above show that
> >      typical repos would benefit from jumping to 20 or even 40.
> 
> I think this might be a good indication that the number of objects is a 
> bad metric to size the window, as I mentioned previously.
> 
> Given that you have the test repos already, could you re-run it with 
> --window=1000 and play with --window-memory instead?  I would be curious 
> to see if this provides more predictable results.

It doesn't help. The git.git repo does well with about a 1m window
limit. linux-2.6 is somewhere between 1m and 2m. But the phpmyadmin repo
wants more like 16m. So it runs into the same issue as using object
counts.

But it's much, much worse than that. Here are the actual numbers (same
format as before; left-hand column is either window size (if no unit) or
window-memory limit (if k/m unit), followed by resulting pack size, its
percentage of baseline --window=10 pack, the user CPU time and finally
its percentage of the baseline):

  git:
    10 | 31.4M (100%) |   54s (100%)
    20 | 28.8M ( 92%) |   72s (133%)
  128k | 81.4M (260%) |   77s (142%)
  256k | 59.1M (188%) |  106s (195%)
  512k | 44.5M (142%) |  166s (306%)
    1m | 28.7M ( 91%) |  267s (491%)
    2m | 27.0M ( 86%) |  347s (637%)
    4m | 26.0M ( 83%) |  417s (767%)

  linux-2.6:
    10 |  564M (100%) |  990s (100%)
    20 |  521M ( 92%) | 1323s (134%)
  128k | 1.41G (256%) | 1322s (133%)
  256k | 1.08G (196%) | 1810s (183%)
  512k |  783M (139%) | 2775s (280%)
    1m |  579M (103%) | 4620s (466%)
    2m |  504M ( 89%) | 6786s (685%)
    4m |  479M ( 85%) | 8119s (819%)

  phpmyadmin:
    10 |  380M (100%) | 1617s (100%)
    80 |  163M ( 43%) | 3410s (211%)
  128k | 3.42G (921%) | 2367s (146%)
  256k | 3.36G (904%) | 2437s (151%)
  512k | 3.22G (865%) | 2589s (160%)
    1m | 3.10G (833%) | 2746s (170%)
    2m |  436M (115%) | 1674s (104%)
    4m |  299M ( 78%) | 2140s (132%)
    8m |  222M ( 58%) | 2751s (170%)
   16m |  178M ( 47%) | 3334s (206%)

I intentionally started with a too-small memory limit so we could see
the effect as the window size approached something reasonable. You can
see the pack sizes getting comparable for --window=20 around
--window-memory=1m for the git and linux-2.6 cases. But look at the CPU
usage. For a comparable resulting pack size, limiting the window memory
uses 4-5x as much CPU.

I'm not sure what is causing that behavior. I guess maybe for small
objects we end up with a really huge window (in terms of number of
objects), but it doesn't end up actually saving us a lot of space
because there is not as much space to be saved with small objects. So we
spend a lot of extra time looking at objects that don't yield big space
savings.

For some of the really tiny limits, the "writing" phase ended up
dominating. For example, linux-2.6 at 128k ends up with a horribly large
pack that takes even longer to run than --window=10. These numbers don't
reflect the split between the compression and writing phases, but I
noticed while watching the progress meter that the writing phase was
quite slow in such cases. Mostly because we end up having to zlib
deflate a lot more data (which I confirmed via perf).

Interestingly, the phpmyadmin script does not have the same issue. The
CPU usage for the object and memory limits are about the same (probably
this is due to the fact that the history is dominated by similar-sized
.po files, so the two limits end up equating to each other).

> >   2. Is there a heuristic or other metric we can figure out to
> >      differentiate the first two repositories from the third, and use a
> >      larger window size on the latter?
> 
> Maybe we could look at the size reduction within the delta search loop.  
> If the reduction quickly diminishes as tested objects are further away 
> from the target one then the window doesn't have to be very large, 
> whereas if the reduction remains more or less constant then it might be 
> worth searching further.  That could be used to dynamically size the 
> window at run time.

I really like the idea of dynamically sizing the window based on what we
find. If it works. I don't think there's any reason you couldn't have 50
absolutely terrible delta candidates followed by one really amazing
delta candidate. But maybe in practice the window tends to get
progressively worse due to the heuristics, and outliers are unlikely. I
guess we'd have to experiment.

> >   3. Does the phpmyadmin case give us any insight into whether we can
> >      improve our window sorting algorithm?
> [...]
> 
>  You could test this theory by commenting out the size comparisons in 
> type_size_sort() and re-run the test.

I'll try this next.

-Peff

PS Here's my updated collection script, just for reference.

-- >8 --
#!/bin/sh

windows='10 20 128k 256k 512k 1m 2m 4m'
repo=$1; shift
test $# -gt 0 && windows="$*"

cd "$repo" || exit
for i in $windows; do
  case "$i" in
  *[kmg])
    opts="--window=1000 --window-memory=$i" ;;
  *)
    opts="--window=$i" ;;
  esac

  echo >&2 "Repacking $repo with $opts..."

  time -f %U -o time.out \
    git pack-objects --stdout --all-progress-implied --all \
      --no-reuse-delta $opts </dev/null |
    wc -c >size.out
  echo "$i `cat size.out` `cat time.out`"
  rm -f size.out time.out
done
