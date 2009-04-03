From: Jeff King <peff@peff.net>
Subject: [PATCH 0/4] NO_PERL support
Date: Fri, 3 Apr 2009 15:27:01 -0400
Message-ID: <20090403192700.GA14965@coredump.intra.peff.net>
References: <20090403T065545Z@curie.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 21:28:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lpp4O-0002kk-Pz
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 21:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757729AbZDCT1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 15:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757412AbZDCT1S
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 15:27:18 -0400
Received: from peff.net ([208.65.91.99]:39588 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757247AbZDCT1S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 15:27:18 -0400
Received: (qmail 1040 invoked by uid 107); 3 Apr 2009 19:27:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 03 Apr 2009 15:27:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Apr 2009 15:27:01 -0400
Content-Disposition: inline
In-Reply-To: <20090403T065545Z@curie.orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115554>

OK, here is a series based on Robin's patch that I think is suitable for
inclusion in mainstream git. The first two are related cleanups, the
third is a rebase of what I sent earlier today, and the fourth covers
the matching tests.

  1/4: commit: abort commit if interactive add failed
  2/4: tests: remove exit after test_done call
  3/4: Makefile: allow building without perl
  4/4: tests: skip perl tests if NO_PERL is defined

With these applied, you can build and pass the tests with NO_PERL
defined. _But_ you still can't pass the tests without perl installed at
all, as several of the other tests rely on perl to do text munging in
the tests. I'm not sure it is possible to rewrite them not to use perl;
we ended up with perl in the first place because many versions of
standard tools like sed don't handle NULs very well. So I think the only
option would be to skip those tests, too.

Breaking my perl installation yields these failing tests:

  $ cat <<'EOF' >$HOME/local/bin
  #!/bin/sh
  echo >&2 I am a broken perl.
  exit 1
  EOF
  $ make test NO_PERL=NoThanks
  ...
  $ cd t && grep 'failed [^0]' test-results/*
  test-results/t0020-crlf-25091:failed 16
  test-results/t1300-repo-config-30265:failed 2
  test-results/t3300-funny-names-4931:failed 3
  test-results/t4012-diff-binary-22876:failed 1
  test-results/t4014-format-patch-23170:failed 14
  test-results/t4020-diff-external-25409:failed 2
  test-results/t4029-diff-trailing-space-26781:failed 1
  test-results/t4030-diff-textconv-26899:failed 5
  test-results/t4031-diff-rewrite-binary-26911:failed 1
  test-results/t4103-apply-binary-28344:failed 8
  test-results/t4116-apply-reverse-29276:failed 7
  test-results/t4200-rerere-30898:failed 1
  test-results/t5300-pack-object-983:failed 24
  test-results/t5303-pack-corruption-resilience-2980:failed 3
  test-results/t6002-rev-list-bisect-17175:failed 12
  test-results/t6003-rev-list-topo-order-17683:failed 31
  test-results/t6011-rev-list-with-bad-commit-19971:failed 3
  test-results/t6013-rev-list-reverse-parents-20684:failed 2
  test-results/t8001-annotate-11125:failed 10
  test-results/t8002-blame-11523:failed 10
