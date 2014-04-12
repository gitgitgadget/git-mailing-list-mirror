From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: What's cooking in git.git (Apr 2014, #03; Fri, 11)
Date: Sat, 12 Apr 2014 19:29:07 +0100
Message-ID: <534985F3.6060501@ramsay1.demon.co.uk>
References: <xmqq1tx3qzel.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 20:29:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ2gb-0006N5-Vd
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 20:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889AbaDLS3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 14:29:15 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:35954 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752800AbaDLS3N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 14:29:13 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 64D6F3B21C6;
	Sat, 12 Apr 2014 19:29:11 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 03AFF3B21C4;
	Sat, 12 Apr 2014 19:29:11 +0100 (BST)
Received: from [192.168.254.4] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Sat, 12 Apr 2014 19:29:09 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <xmqq1tx3qzel.fsf@gitster.dls.corp.google.com>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246176>

On 11/04/14 23:22, Junio C Hamano wrote:
[...]
> [New Topics]
> 
> * nd/index-pack-one-fd-per-thread (2014-04-09) 1 commit
>  - index-pack: work around thread-unsafe pread()
> 
>  Enable threaded index-pack on platforms without thread-unsafe
>  pread() emulation.
> 
>  Will merge to 'next' and keep it there for the remainder of the cycle.

The commit message for commit 512ebe5d ("index-pack: work around
thread-unsafe pread()", 25-03-2014) is a little misleading.

The pread() implementation is only thread-unsafe on older versions of
cygwin (anything prior to v1.7 - aka v1.5). Indeed, index-pack has been
threaded on cygwin (v1.7) since commit 103d530f ("Cygwin 1.7 has thread-
safe pread", 19-07-2013). (So, it was released in v1.8.4, I guess).

Since I upgraded my cygwin installation long ago (well about 9 months
ago), I can no longer test patches on cygwin v1.5. Also, since commit
a50dec22 ("Makefile: update defaults for modern Cygwin", 01-04-2010)
tells us that cygwin v1.5 is no longer being actively supported, it
may be difficult to find anyone who can do that testing. (v1.5 was
the last version supported on windows 95, 98 and ME, so maybe ... :)

Yesterday, I briefly compared the performance of the master and pu
branches (respectively with and without this patch) on cygwin.
(There seems to be little difference in the performance, as expected).

  $ uname -a
  CYGWIN_NT-5.1 toshiba 1.7.29(0.272/5/3) 2014-04-07 13:44 i686 Cygwin

First, on the master branch:

  $ ./git version
  git version 1.9.2.459.g68773ac
  $ git log -1 --decorate --oneline
  68773ac (HEAD, origin/master, origin/HEAD, master) Sync with 1.9.2

  $ cd t
  $ time ./t5302-pack-index.sh
  ok 1 - setup
  ...
  ok 31 - running index-pack in the object store
  # passed all 31 test(s)
  1..31
  
  real    1m11.984s
  user    1m24.986s
  sys     0m41.521s
  $

  $ cd perf
  $ ./p5302-pack-index.sh
  warning: $GIT_PERF_LARGE_REPO is $GIT_BUILD_DIR.
  warning: This will work, but may not be a sufficiently large repo
  warning: for representative measurements.
  ok 1 - repack
  perf 2 - index-pack 0 threads: 1 2 3 ok
  perf 3 - index-pack 1 thread : 1 2 3 ok
  perf 4 - index-pack 2 threads: 1 2 3 ok
  perf 5 - index-pack 4 threads: 1 2 3 ok
  perf 6 - index-pack 8 threads: 1 2 3 ok
  perf 7 - index-pack default number of threads: 1 2 3 ok
  # passed all 7 test(s)
  1..7
  Can't locate Git.pm in @INC (@INC contains: /usr/lib/perl5/site_perl/5.14/i686-cygwin-threads-64int /usr/lib/perl5/site_perl/5.14 /usr/lib/perl5/vendor_perl/5.14/i686-cygwin-threads-64int /usr/lib/perl5/vendor_perl/5.14 /usr/lib/perl5/5.14/i686-cygwin-threads-64int /usr/lib/perl5/5.14 /usr/lib/perl5/site_perl/5.10 /usr/lib/perl5/vendor_perl/5.10 /usr/lib/perl5/site_perl/5.8 .) at ./aggregate.perl line 5.
  BEGIN failed--compilation aborted at ./aggregate.perl line 5.

  $ PERL5LIB=/home/ramsay/lib/perl5/site_perl/5.14 ./aggregate.perl ./p5302-pack-index.sh
  Test                                           this tree
  ----------------------------------------------------------------
  5302.2: index-pack 0 threads                   38.60(34.38+0.93)
  5302.3: index-pack 1 thread                    36.48(34.74+0.90)
  5302.4: index-pack 2 threads                   26.60(36.57+1.87)
  5302.5: index-pack 4 threads                   27.32(37.46+2.38)
  5302.6: index-pack 8 threads                   27.18(38.38+3.01)
  5302.7: index-pack default number of threads   25.40(36.07+2.09)
  $
  
NOTE: that t/perf/aggregate.perl can't locate Git.pm; I haven't investigated
that.

Now, on the pu branch:
  
  $ ./git version
  git version 1.9.2.667.ge5b74e1
  $ git log -1 --decorate --oneline
  e5b74e1 (HEAD, origin/pu, pu) Merge branch 'jc/graph-post-root-gap' into pu

  $ cd t
  $ time ./t5302-pack-index.sh
  ok 1 - setup
  ...
  ok 31 - running index-pack in the object store
  # passed all 31 test(s)
  1..31
  
  real    1m8.063s
  user    1m26.151s
  sys     0m40.477s
  $

  $ cd perf
  $ PERL5LIB=/home/ramsay/lib/perl5/site_perl/5.14 ./p5302-pack-index.sh
  warning: $GIT_PERF_LARGE_REPO is $GIT_BUILD_DIR.
  warning: This will work, but may not be a sufficiently large repo
  warning: for representative measurements.
  ok 1 - repack
  perf 2 - index-pack 0 threads: 1 2 3 ok
  perf 3 - index-pack 1 thread : 1 2 3 ok
  perf 4 - index-pack 2 threads: 1 2 3 ok
  perf 5 - index-pack 4 threads: 1 2 3 ok
  perf 6 - index-pack 8 threads: 1 2 3 ok
  perf 7 - index-pack default number of threads: 1 2 3 ok
  # passed all 7 test(s)
  1..7
  Test                                           this tree
  ----------------------------------------------------------------
  5302.2: index-pack 0 threads                   37.90(34.40+0.82)
  5302.3: index-pack 1 thread                    37.93(34.79+0.96)
  5302.4: index-pack 2 threads                   27.75(36.46+1.98)
  5302.5: index-pack 4 threads                   27.93(37.24+2.82)
  5302.6: index-pack 8 threads                   29.34(38.23+3.04)
  5302.7: index-pack default number of threads   26.25(36.55+1.84)
  $


HTH

ATB,
Ramsay Jones
