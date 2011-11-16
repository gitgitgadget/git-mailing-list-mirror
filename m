From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/28] Store references hierarchically in cache -- benchmark
 results
Date: Wed, 16 Nov 2011 13:51:04 +0100
Message-ID: <4EC3B1B8.2040106@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Nov 16 13:51:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQexg-0004Dm-ME
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 13:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756584Ab1KPMv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 07:51:26 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:51384 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756550Ab1KPMvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 07:51:25 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pAGCp4mm005135
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 16 Nov 2011 13:51:04 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185541>

On 10/28/2011 02:28 PM, mhagger@alum.mit.edu wrote:
> [...]
> This patch series changes how references are stored in the reference
> cache data structures (entirely internal to refs.c).  Previously, the
> packed refs were stored in one big array of pointers-to-struct, and
> the loose refs were stored in another.  [...]
> 
> Therefore, this patch series changes the data structure used to store
> the reference cache from a single array of pointers-to-struct into a
> tree-like structure in which each subdirectory of the reference
> namespace is stored as an array of pointers-to-entry and entries can
> be either references or subdirectories containing more references.
> Moreover, each subdirectory of loose references is only read from disk
> when a reference from that subdirectory (or one of its descendants) is
> needed.  This slightly slows down commands that need to iterate
> through all references (simply because the new data structures are
> more complicated), but it *dramatically* decreases the time needed for
> some common operations.  For example, in a test repository with 20000
> revisions and 10000 loose tags:

Due to the death of my old computer, I got distracted and never
published the benchmark results that I cited above.  (The numbers here
are different than the originals because they are done on a different
computer.)  The benchmarks are done using code from [1]; the test
repository consists of a linear series of 20000 commits (with very
little content) and 10000 tags (on every second commit); the tags are
unsharded.  The numbers are times in seconds; "cold" means that the disk
cache was flushed immediately before the test; "warm" usually means that
the same operation was done a second time.

Column #0 is Git 1.7.7.2; column #1 is Git 1.7.8-rc2; column #2 is a
recent git master plus my ref-related patch series (what Junio calls
mh/ref-api-take-2 plus the fix that I posted yesterday).

The main change between 1.7.7.2 and 1.7.8 is that the latter stores the
reference cache in a sorted array rather than a linked list, meaning
that it is possible to use bisection to locate a reference quickly by
name rather than having to search linearly through a linked list.  This
greatly helps some operations when most references are packed and can be
read from disk quickly.  It doesn't make much difference when most
references are loose, because the time required to read the loose
references from disk overwhelms the time for iterating through the array
in memory.

The main improvements between 1.7.8 and the new version are when the old
code would have read all of the loose references but the new code only
needs to read a couple of directories of them.  Given that almost all of
the references in the test repository are tags, they often don't need to
be read at all when branches are being manipulated.  By contrast, many
old code paths force *all* of the references to be read, for example
when they check for replacements in refs/replace/.

I've done other benchmarks with varying numbers of references.  The
results suggest that many operations go from O(N) in the number of loose
references to O(1) (e.g., if all they do is check refs/replace/) or some
other slow scaling that depends on how the reference namespace is organized.

Anything involving packed references necessarily scales at least like
O(N) because packed references are all read at once.  OTOH reading
packed refs is so much faster than reading loose references that with
10000 references, packing is still advantageous.  (For some number of
references, of course, the curves must cross and loose references will
be more efficient than packed references for some operations.)

The case of git-filter-branch is particularly dramatic; the old code
scales like O(N^2) whereas the new code scales like O(N) as expected.
Moreover, git-filter-branch creates lots of loose references while it
works, so it is not possible to evade the problem by packing the
references before invoking git-filter-branch.  I believe that
git-filter-branch is mostly slowed down be each subcommand's check for
replacements in refs/replace (even though there are none in my test
repository) because in the old code this check forces *all* loose
references to be read.  Versions 1.7.7 and 1.7.8 of git-filter-branch
runs much faster if the --no-replace-objects option is used.

With these changes, it becomes thinkable to work with repositories with
very large numbers of references (especially if the reference namespace
is sharded appropriately), whereas in 1.7.7 some operations were
annoyingly slow.

Michael

[1] branch "refperf" at git://github.com/mhagger/git.git

> ===================================  ========  ========  ========
> Test name                                 [0]       [1]       [2]
> ===================================  ========  ========  ========
> branch-loose-cold                        1.59      1.68      0.29
> branch-loose-warm                        0.04      0.04      0.00
> for-each-ref-loose-cold                  1.86      1.96      1.88
> for-each-ref-loose-warm                  0.10      0.10      0.11
> checkout-loose-cold                      1.66      1.86      0.39
> checkout-loose-warm                      0.04      0.05      0.01
> checkout-orphan-loose                    0.04      0.04      0.00
> checkout-from-detached-loose-cold        2.04      2.11      1.81
> checkout-from-detached-loose-warm        0.24      0.15      0.16
> branch-contains-loose-cold               1.79      1.86      1.87
> branch-contains-loose-warm               0.14      0.14      0.14
> pack-refs-loose                          0.49      0.53      0.53
> branch-packed-cold                       0.28      0.25      0.25
> branch-packed-warm                       0.02      0.00      0.00
> for-each-ref-packed-cold                 0.34      0.39      0.40
> for-each-ref-packed-warm                 0.07      0.07      0.07
> checkout-packed-cold                     2.81      0.50      0.55
> checkout-packed-warm                     0.01      0.00      0.01
> checkout-orphan-packed                   0.00      0.00      0.00
> checkout-from-detached-packed-cold       2.83      0.55      0.46
> checkout-from-detached-packed-warm       2.45      0.12      0.13
> branch-contains-packed-cold              0.38      0.32      0.43
> branch-contains-packed-warm              0.11      0.11      0.11
> clone-loose-cold                        30.16     30.31     30.51
> clone-loose-warm                         1.28      1.30      1.33
> fetch-nothing-loose                      0.21      0.39      0.38
> pack-refs                                0.14      0.12      0.14
> fetch-nothing-packed                     0.21      0.40      0.39
> clone-packed-cold                        1.07      1.24      1.18
> clone-packed-warm                        0.23      0.23      0.22
> fetch-everything-cold                   30.49     30.89     31.09
> fetch-everything-warm                    1.78      2.01      2.06
> filter-branch-warm                    2949.81   2891.51    440.60
> ===================================  ========  ========  ========
> 
> 
> [0] 8d19b44 (tag: v1.7.7.2) Git 1.7.7.2
>     Test repository created using: t/make-refperf-repo --commits 20000 --refs 10000
> [1] bc1bbe0 (tag: v1.7.8-rc2) Git 1.7.8-rc2
>     Test repository created using: t/make-refperf-repo --commits 20000 --refs 10000
> [2] 01494b4 (github/ref-api-D) repack_without_ref(): call clear_packed_ref_cache()
>     Test repository created using: t/make-refperf-repo --commits 20000 --refs 10000



-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
