From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 00/16] Speed up Counting Objects with bitmap data
Date: Tue, 25 Jun 2013 09:05:05 -0700
Message-ID: <87hagllvsk.fsf@linux-k42r.v.cablecom.net>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Vicent Marti <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 23:34:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrasO-0005JM-L2
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 23:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852Ab3FYVeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 17:34:08 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:6761 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532Ab3FYVeH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 17:34:07 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 25 Jun
 2013 23:34:04 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.210.110) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 25 Jun 2013 23:34:04 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.210.110]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229000>

Vicent Marti <tanoku@gmail.com> writes:

> Like with every other patch that offers performance improvements,
> sample benchmarks are provided (spoiler: they are pretty fucking
> cool).

Great stuff.

I read the first half, and skimmed the second half.  See the individual
replies for comments.

However:

>  Documentation/technical/bitmap-format.txt |  235 ++++++++
>  Makefile                                  |   11 +
>  builtin.h                                 |    1 +
>  builtin/pack-objects.c                    |  362 +++++++-----
>  builtin/pack-objects.h                    |   33 ++
>  builtin/rev-list.c                        |   35 +-
>  builtin/write-bitmap.c                    |  256 +++++++++
>  cache.h                                   |    5 +
>  ewah/bitmap.c                             |  229 ++++++++
>  ewah/ewah_bitmap.c                        |  703 ++++++++++++++++++++++++
>  ewah/ewah_io.c                            |  199 +++++++
>  ewah/ewah_rlw.c                           |  124 +++++
>  ewah/ewok.h                               |  194 +++++++
>  ewah/ewok_rlw.h                           |  114 ++++
>  git-compat-util.h                         |   28 +
>  git-repack.sh                             |   10 +-
>  git.c                                     |    1 +
>  khash.h                                   |  329 +++++++++++
>  list-objects.c                            |    1 +
>  pack-bitmap-write.c                       |  520 ++++++++++++++++++
>  pack-bitmap.c                             |  855 +++++++++++++++++++++++++++++
>  pack-bitmap.h                             |   64 +++
>  pack-write.c                              |    2 +
>  revision.c                                |    5 +
>  revision.h                                |    2 +
>  sha1_file.c                               |   57 +-

It's pretty hard to miss that there isn't a single test in the entire
series.  It seems that the features you add depend on pack.usebitmaps,
and since the tests run with empty config (unless of course they set
their own) your feature is completely untested -- unless I'm missing
something.

I imagine the tests would be of the format

test_expect_success 'do <stuff> without bitmaps' '
	git ... >expect
'

test_expect_success 'do <stuff> with bitmaps' '
	test_config pack.usebitmaps true &&
	# do something to ensure that we have bitmaps
	git ... >actual &&
	test_cmp expect actual
'

or some such.

For bonus points, you could also add some light performance tests in
t/perf/, just to show off ;-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
