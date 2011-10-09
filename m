From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Git is not scalable with too many refs/*
Date: Sun, 09 Oct 2011 07:43:47 +0200
Message-ID: <4E913493.7010101@alum.mit.edu>
References: <4DF6A8B6.9030301@op5.se> <201109301502.30617.mfick@codeaurora.org> <201109301606.31748.mfick@codeaurora.org> <201110081459.52174.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030509010000080909030405"
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Sun Oct 09 07:44:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCmBJ-0003a8-2d
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 07:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860Ab1JIFoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 01:44:08 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:51791 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab1JIFoF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2011 01:44:05 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEDFD0.dip.t-dialin.net [84.190.223.208])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p995hmpx022723
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Oct 2011 07:43:49 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <201110081459.52174.mfick@codeaurora.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183185>

This is a multi-part message in MIME format.
--------------030509010000080909030405
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 10/08/2011 10:59 PM, Martin Fick wrote:
> [...]
> So, with this in mind, I have discovered, that the fetch 
> performance degradation by invalidating the caches in 
> write_ref_sha1() is actually due to the packed-refs being 
> reloaded and resorted again on each ref insertion (not the 
> loose refs)!!!

Good point.

> I think that all of this might explain why no matter how 
> good Michael's intentions are with his patch series, his 
> series isn't likely to fix this problem

I never claimed that my patch fixes all use cases, or cures cancer
either :-)  One step at a time.

>                                         unless he does not
> invalidate the packed-refs after each insertion.  I tried 
> preventing this invalidation in his series to prove this, 
> but unfortunately, it appears that in his series it is no 
> longer possible to only invalidate just the packed-refs? :(
> Michael, I hope I am completely wrong about that...

Yes, you are completely wrong.  I just implemented more selective cache
invalidation on top of the patch series.

I think your suggestion is safe because only non-symbolic references can
be stored in the packed refs; therefore the modification of a loose ref
can never affect the value of a packed ref.  Of course a loose ref can
*hide* the value of a packed ref, but in such cases the packed ref is
never read anyway.  And the *deletion* of a loose ref can expose a
previously-hidden packed ref, but this case is handled by delete_ref(),
which explicitly invalidates the packed-ref cache.

While I was at it, I also:

* In delete_ref(), only invalidate the packed reference cache if the
reference that is being deleted actually *is* among the packed references.

* Changed the code to stop invalidating the ref caches for submodules.
In the code paths where the cache invalidation was being done, only
main-module references were being changed.  However, I'm not familiar
enough with submodules to know if/when submodule references *can* be
changed.  It could be that the submodule reference caches have to be
invalidated under some circumstances; the current code might be buggy in
this area.

The changes are pushed to github.  They don't make any significant
difference to my "refperf" results (attached), so perhaps a new
benchmark should be added.  But I'm curious to see how they affect your
timings.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/

--------------030509010000080909030405
Content-Type: text/plain;
 name="refperf-summary.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="refperf-summary.out"

===================================  =======  =======  =======  =======  =======  =======  =======  =======  =======  =======
Test name                                [0]      [1]      [2]      [3]      [4]      [5]      [6]      [7]      [8]      [9]
===================================  =======  =======  =======  =======  =======  =======  =======  =======  =======  =======
branch-loose-cold                       3.19     3.15     3.10     3.19     3.25     0.70     0.61     0.74     0.66     0.56
branch-loose-warm                       0.19     0.19     0.20     0.19     0.19     0.00     0.00     0.00     0.00     0.00
for-each-ref-loose-cold                 3.73     3.45     3.55     3.39     3.44     3.40     3.50     3.52     3.70     3.51
for-each-ref-loose-warm                 0.44     0.44     0.44     0.43     0.43     0.43     0.43     0.43     0.43     0.43
checkout-loose-cold                     3.35     3.23     3.23     3.15     3.29     0.65     0.71     0.76     0.66     0.69
checkout-loose-warm                     0.19     0.19     0.20     0.18     0.19     0.01     0.01     0.01     0.01     0.00
checkout-orphan-loose                   0.19     0.19     0.19     0.18     0.19     0.00     0.00     0.00     0.00     0.00
checkout-from-detached-loose-cold       7.80     4.17     4.17     4.05     4.09     4.07     4.26     4.23     4.18     4.08
checkout-from-detached-loose-warm       1.01     1.01     1.02     1.02     1.04     1.03     1.04     1.04     1.02     1.04
branch-contains-loose-cold             35.76    35.80    36.15    36.67    35.13    36.29    36.37    36.03    36.70    36.01
branch-contains-loose-warm             33.01    33.62    33.52    33.51    32.41    33.51    33.71    32.10    33.70    31.99
pack-refs-loose                         4.19     4.20     4.25     4.21     4.20     4.21     4.20     4.19     4.24     4.21
branch-packed-cold                      0.79     0.62     0.60     0.66     0.65     0.58     0.68     0.72     0.60     0.61
branch-packed-warm                      0.02     0.02     0.02     0.02     0.02     0.02     0.02     0.02     0.02     0.02
for-each-ref-packed-cold                0.96     0.97     0.97     0.93     0.89     0.92     0.98     0.96     0.92     0.96
for-each-ref-packed-warm                0.26     0.26     0.26     0.26     0.26     0.26     0.26     0.27     0.27     0.27
checkout-packed-cold                   16.14    16.16    16.74     2.04     2.03     2.09     2.06     2.13     2.03     2.00
checkout-packed-warm                    0.17     0.17     0.18     0.19     0.18     0.17     0.27     0.18     0.19     0.18
checkout-orphan-packed                  0.02     0.01     0.02     0.02     0.02     0.02     0.02     0.02     0.02     0.02
checkout-from-detached-packed-cold     16.24    15.96    16.80     1.99     2.06     2.01     2.08     2.10     1.97     1.96
checkout-from-detached-packed-warm     15.04    14.96    15.76     0.77     0.81     0.79     0.83     0.80     0.79     0.80
branch-contains-packed-cold            36.18    36.98    36.92    35.19    34.97    35.09    33.34    33.87    34.27    34.51
branch-contains-packed-warm            35.27    35.12    36.20    33.52    32.76    33.49    33.65    32.96    33.68    32.34
clone-loose-cold                        9.09     9.22     9.15     9.10     9.19     9.03     9.09     9.25     8.96     9.03
clone-loose-warm                        5.57     5.85     5.65     5.55     5.61     5.64     5.65     5.61     5.74     5.59
fetch-nothing-loose                     1.43     1.43     1.44     1.44     1.45     1.45     1.46     1.44     1.44     1.44
pack-refs                               0.08     0.08     0.08     0.08     0.09     0.08     0.09     0.08     0.08     0.08
fetch-nothing-packed                    1.44     1.43     1.44     1.44     1.44     1.44     1.44     1.44     1.44     1.44
clone-packed-cold                       1.35     1.26     1.30     1.32     1.28     1.35     1.38     1.35     1.29     1.21
clone-packed-warm                       0.36     0.35     0.35     0.36     0.36     0.36     0.35     0.36     0.37     0.35
fetch-everything-cold                  30.29    30.01    29.79    29.04    29.84    29.25    29.30    29.26    29.76    29.30
fetch-everything-warm                  26.20    26.04    26.40    25.60    26.22    25.83    25.82    25.85    26.68    25.73
===================================  =======  =======  =======  =======  =======  =======  =======  =======  =======  =======


[0] f696543 (tag: v1.7.6) Git 1.7.6
[1] 703f05a (tag: v1.7.7) Git 1.7.7
[2] 27897d2 (origin/master) Merge remote-tracking branch 'gitster/mh/iterate-refs'
[3] 558b49c is_refname_available(): reimplement using do_for_each_ref_in_list()
[4] 1658397 Store references hierarchically
[5] 5f5a126 get_ref_dir(): add a recursive option
[6] a306af1 get_ref_dir(): read one whole directory before descending into subdirs
[7] fd53cf7 add_ref(): change to take a (struct ref_entry *) as second argument
[8] 9944c7f (origin/testing) read_packed_refs(): keep track of the directory being worked in
[9] cb75c57 (origin/ok, origin/hierarchical-refs, origin/HEAD) refs.c: call clear_cached_ref_cache() from repack_without_ref()


--------------030509010000080909030405--
