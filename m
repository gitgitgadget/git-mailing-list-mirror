From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 0/6] --valgrind improvements
Date: Thu, 16 May 2013 22:50:11 +0200
Message-ID: <cover.1368736093.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 16 22:50:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud58B-0004hR-Hx
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 22:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878Ab3EPUuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 16:50:23 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:41637 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102Ab3EPUuU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 16:50:20 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 16 May
 2013 22:50:15 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 16 May
 2013 22:50:17 +0200
X-Mailer: git-send-email 1.8.3.rc2.393.g8636c0b
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224615>

Peff and me discussed improving the usability of --valgrind testing.
In particular, two ideas that came up were options for running only a
subset of the tests in a file under --valgrind, and for running a
single test script under valgrind while exploiting parallelism.

So here's a little series.  It goes like this:

  test-lib: enable MALLOC_* for the actual tests

Fix for an unrelated bug that I came across.

  test-lib: refactor $GIT_SKIP_TESTS matching
  test-lib: verbose mode for only tests matching a pattern
  test-lib: valgrind for only tests matching a pattern

An option --valgrind-only=<patterns> that lets you run only the
subtest matching <patterns> under valgrind.

  test-lib: allow prefixing a custom string before "ok N" etc.
  test-lib: support running tests under valgrind in parallel

An option --valgrind-parallel=<n> to run <n> instances in parallel,
each of which runs every <n>-th test under valgrind, staggered so that
they cover everything.  It's a bit of a hack, and thus RFC, but gives
decent results.  On my 2-core laptop I measured a just over 2x
speedup.  On a 6-core it starts falling off because of the extra
(non-valgrind) runs, resulting in a 4.8x speedup.

One open issue with the last patch that currently eludes me: if I
combine --valgrind-parallel with any --valgrind=*, there are lots of
errors as (apparently) the valgrind wrapper setups race against each
other.  However, without any --valgrind=* (thus defaulting to
'memcheck') this doesn't happen.


Thomas Rast (6):
  test-lib: enable MALLOC_* for the actual tests
  test-lib: refactor $GIT_SKIP_TESTS matching
  test-lib: verbose mode for only tests matching a pattern
  test-lib: valgrind for only tests matching a pattern
  test-lib: allow prefixing a custom string before "ok N" etc.
  test-lib: support running tests under valgrind in parallel

 t/README               |  10 +++
 t/test-lib.sh          | 175 ++++++++++++++++++++++++++++++++++++++++---------
 t/valgrind/valgrind.sh |   3 +
 3 files changed, 156 insertions(+), 32 deletions(-)

-- 
1.8.3.rc2.393.g8636c0b
