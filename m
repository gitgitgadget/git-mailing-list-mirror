From: Ingo Molnar <mingo@elte.hu>
Subject: cache-cold repository performance
Date: Thu, 14 Apr 2005 12:50:18 +0200
Message-ID: <20050414105018.GA5408@elte.hu>
References: <20050412230027.GA21759@elte.hu> <20050412230729.GA22179@elte.hu> <20050413111355.GB13865@elte.hu> <425D4E1D.4040108@zytor.com> <20050413165310.GA22428@elte.hu> <425D4FB1.9040207@zytor.com> <Pine.LNX.4.58.0504131008500.4501@ppc970.osdl.org> <87aco2gxu2.fsf@deneb.enyo.de> <Pine.LNX.4.58.0504131503180.4501@ppc970.osdl.org> <20050414070422.GA3226@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Weimer <fw@deneb.enyo.de>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 12:48:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM1t8-0002w0-5z
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 12:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVDNKvM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 06:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVDNKvM
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 06:51:12 -0400
Received: from mx2.elte.hu ([157.181.151.9]:4327 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261420AbVDNKu1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 06:50:27 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id AE45131929B;
	Thu, 14 Apr 2005 12:49:33 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id A0A081FC2; Thu, 14 Apr 2005 12:50:21 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050414070422.GA3226@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> i'd be surprised if it was twice as fast - cache-cold linear checkouts 
> are _seek_ limited, and it doesnt matter whether after a 1-2 msec 
> track-to-track disk seek the DMA engine spends another 30 microseconds 
> DMA-ing 60K uncompressed data instead of 30K compressed... (there are 
> other factors, but this is the main thing.)

i've benchmarked cache-cold compressed vs. uncompressed performance, to 
shed some more light on the performance differences between flat and 
compressed repositories.

i did alot of testing, and i primarily concentrated on being able to 
_trust_ the benchmark results, not to generate some quick numbers. The 
major problem was that the timing of the reads associated with 'checking 
out a large tree' is very unstable, even on a completely isolated 
testsystem with very common (and predictable) IO hardware.

the content i tested was a vanilla 2.6.10 kernel tree, with 19042 files 
in it, taking 246 MB uncompressed, and 110 MB compressed (via gzip -9).  
Average file size is 13.2 KB uncompressed, 5.9 KB compressed.

Firstly, the timings are very sensitive to the way the tree was created.  
To have a 'fair' on-disk layout the trees have to be created in an 
identical fashion: e.g. it is not valid to copy the uncompressed tree 
and run gzip over it - that will create a 'sparse' on-disk layout 
penalizing the compressed layout and making it 30% slower than the 
uncompressed layout! I first created the two trees, then i "cp -a"-ed 
them over into a new directory one after each other, so that they get on 
similar on-disk positions as well. I also created 2 more pairs of such 
trees to make sure disk layout is fair.

all timings were taken fresh after reboot, on a UP 1 GB RAM Athlon64 
3200+, using a large, top of the line IDE disk. The kernel was 
2.6.12-rc2, the filesystem was ext3 with enough free space to not be 
fragmented, both noatime and nodiratime was specified so that no write 
activities whatever occur during the 'checkout'.

the operation timed was a simple:

        time find . -type f | xargs cat > /dev/null

done in the root of the given tree. This generates the very same 
readonly IO pattern for each test. I've run the tests 10 times (i.e.  
have done 10 fresh reboots), but after every reboot i permutated the 
order of trees tested - to make sure there is no interaction between 
trees. (there was no interaction)

here are the raw numbers, elapsed real time in seconds:

 flat-1:  29.7 29.5 29.4 29.4 29.5 29.5 29.7 29.6 29.4 29.6 29.5 29.4:  29.5
 gzip-1:  41.2 40.9 40.7 40.7 40.5 41.7 41.0 40.3 40.6 40.8 40.8 40.9:  40.8

 flat-2:  28.0 28.2 27.7 27.9 27.8 27.9 27.7 27.9 27.9 28.1 27.9 28.0:  27.9
 gzip-2:  27.2 27.4 27.4 27.2 27.2 27.2 27.2 27.2 27.1 27.3 27.2 27.4:  27.2
 flat-3:  27.0 27.8 27.6 27.7 27.8 27.8 27.8 27.7 27.8 27.6 27.8 27.8:  27.6
 gzip-3:  25.8 26.8 26.6 26.5 26.5 26.5 26.6 26.4 26.5 26.7 26.6 26.7:  26.5

The final column is the average. (Standard deviation is below 0.1 sec, 
less than 0.3%.)

flat-1 is the original tree, created via tar. gzip-1 is a cp -a copy of 
it, per-file compressed afterwards. flat-2 is a cp -a copy of flat-1, 
gzip-2 is a cp -a copy of gzip-1. flat-3/gzip-3 are cp -a copies of 
flat-2/gzip-2.

note that gzip-1 is ~40% slower due to the 'sparse layout', so its 
results approximate a repository with 'bad' file layout. I'd not expect 
GIT repositories to have such a layout normally, so we can disregard it.

flat-2/3 and gzip-2/3 can be directly compared. Firstly, the results 
show that the on-disk layout cannot be constructed reliably - there's a 
1% systematic difference between flat-2 and flat-3, and a 3% systematic 
difference between gzip-2 and gzip-3 - both systematic errors are larger 
than the 0.5% standard deviation, so they are not measurement errors but 
real layout properties of these trees.

the most interesting result is that gzip-2 is 2.5% faster than flat-2, 
and gzip-3 is 4% faster than flat-3. These differences are close to the 
layout-related systematic error, but slightly above it, so i'd conclude 
that a compressed repository is 3% faster on this hardware.

(since these results were in line with my expectations i double-checked 
everything again and did another 10 reboot tests - same results.)

conclusion [*]: there's a negligible cache-cold performance hit from 
using an uncompressed repository, because cache-cold performance is 
dominated by number of seeks, which is almost identical in the two 
cases.

	Ingo

[*] lots of conditionals apply: these werent flat/compressed GIT 
repositories (although they were quite similar to it), nor was the GIT 
workload measured (although the one measured should be quite close to 
it).

