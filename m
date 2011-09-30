From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3] refs: Use binary search to lookup refs faster
Date: Fri, 30 Sep 2011 17:30:04 +0200
Message-ID: <4E85E07C.5070402@alum.mit.edu>
References: <4DF6A8B6.9030301@op5.se> <CAP8UFD3TWQHU0wLPuxMDnc3bRSz90Yd+yDMBe03kofeo-nr7yA@mail.gmail.com> <201109281338.04378.mfick@codeaurora.org> <201109281610.49322.mfick@codeaurora.org> <c76d7f65203c0fc2c6e4e14fe2f33274@quantumfyre.co.uk> <960aacbf-8d4d-4b2a-8902-f6380ff9febd@email.android.com> <7c0105c6cca7dd0aa336522f90617fe4@quantumfyre.co.uk> <4E84B89F.4060304@lsrfire.ath.cx> <7vy5x7rwq9.fsf@alter.siamese.dyndns.org> <20110929041811.5363.33396.julian@quantumfyre.co.uk> <7vvcsbqa0k.fsf@alter.siamese.dyndns.org> <20110929221143.23806.25666.julian@quantumfyre.co.uk> <7v62karjv3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Martin Fick <mfick@codeaurora.org>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 17:30:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9f33-0002pj-5v
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 17:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733Ab1I3Pao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 11:30:44 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:54228 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575Ab1I3Pan (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 11:30:43 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8UFU42S005217
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 30 Sep 2011 17:30:05 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7v62karjv3.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182486>

On 09/30/2011 01:48 AM, Junio C Hamano wrote:
> This version looks sane, although I have a suspicion that it may have
> some interaction with what Michael may be working on.

Indeed, I have almost equivalent changes in the giant patch series that
I am working on [1].  The branch is very experimental.  The tip
currently passes all the tests, but it has a known performance
regression in connection if "git fetch" is used to fetch many commits.


But before comparing ref-related optimizations, we have an *urgent* need
for a decent performance test suite.  There are many slightly different
scenarios that have very different performance characteristics, and we
have to be sure that we are optimizing for the whole palette of
many-reference use cases.  So I made an attempt at a kludgey but
somewhat flexible performance-testing script [2].  I don't know whether
something like this should be integrated into the git project, and if so
where; suggestions are welcome.


To run the tests, from the root of the git source tree:

    make # make sure git is up-to-date
    t/make-refperf-repo --help
    t/make-refperf-repo [OPTIONS]
    t/refperf
    cat refperf.times # See the results

The default repo has 5k commits in a linear series with one reference on
each commit.  (These numbers can both be adjusted.)

The reference namespace can be laid out a few ways:

* Many references in a single "directory" vs. sharded over many
"directories"

* In lexicographic order by commit, in reverse order, or "shuffled".

By default, the repo is written to "refperf-repo".

The time it takes to create the test repository is itself also an
interesting benchmark.  For example, on the maint branch it is terribly
slow unless it is passed either the --pack-refs-interval=N (with N, say
100) or --no-replace-object option.  I also noticed that if it is run like

    t/make-refperf-repo --refs=5000 --commits=5000 \
            --pack-refs-interval=100

(one ref per commit), git-pack-refs becomes precipitously and
dramatically slower after the 2000th commit.

I haven't had time yet for systematic benchmarks of other git versions.

See the refperf script to see what sorts of benchmarks that I have built
into it so far.  The refperf test is non-destructive; it always copies
from "refperf-repo" to "refperf-repo-copy" and does its tests in the
copy; therefore a test repo can be reused.  The timing data are written
to "refperf.times" and other output to "refperf.log".

Here are my refperf results for the "maint" branch on my notebook with
the default "make-refperf-repo" arguments (times in seconds):

3.36 git branch (cold)
0.01 git branch (warm)
0.04 git for-each-ref
3.08 git checkout (cold)
0.01 git checkout (warm)
0.00 git checkout --orphan (warm)
0.15 git checkout from detached orphan
0.12 git pack-refs
1.17 git branch (cold)
0.00 git branch (warm)
0.17 git for-each-ref
0.95 git checkout (cold)
0.00 git checkout (warm)
0.00 git checkout --orphan (warm)
0.21 git checkout from detached orphan
0.18 git branch -a --contains
7.67 git clone
0.06 git fetch (nothing)
0.01 git pack-refs
0.05 git fetch (nothing, packed)
0.10 git clone of a ref-packed repo
0.63 git fetch (everything)

Probably we should test with even more references than this, but this
test already shows that some commands are quite sluggish.

There are some more things that could be added, like:

* Branches vs. annotated tags

* References on the tips of branches in a more typical "branchy" repository.

* git describe --all

* git log --decorate

* git gc

* git filter-branch
  (This has very different performance characteristics because it is a
script that invokes git many times.)

I suggest that we try to do systematic benchmarking of any changes that
we claim are performance optimizations and share before/after results in
the cover letter for the patch series.

Michael

[1] branch hierarchical-refs at git://github.com/mhagger/git.git
[2] branch refperf at git://github.com/mhagger/git.git

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
