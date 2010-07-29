From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] filter-branch tests/docs: avoid \t in sed regexes
Date: Thu, 29 Jul 2010 16:52:52 +0200
Message-ID: <201007291652.52506.trast@student.ethz.ch>
References: <AANLkTin5sv8NQ_8NZkQpW9HG4zYZDZHNF80EWK8Km4Mr@mail.gmail.com> <0bb511ca2d155ea7e37850a78375da1803032d6c.1280409717.git.trast@student.ethz.ch> <4C519498.3000702@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Adam Mercer <ramercer@gmail.com>
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 16:53:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeUU9-0000bv-Kq
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 16:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757680Ab0G2OxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 10:53:16 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:30420 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757664Ab0G2OxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 10:53:16 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 29 Jul
 2010 16:53:14 +0200
Received: from thomas.site (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.0.702.0; Thu, 29 Jul
 2010 16:52:53 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <4C519498.3000702@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152179>

Tomas Carnecky wrote:
> On 7/29/10 3:24 PM, Thomas Rast wrote:
> > Using \t to represent a tab character is not portable beyond GNU sed
> > (see e.g. GNU sed's info pages).  Use printf to generate the tab
> > instead.
[...]
> > That's very funny however, since it means that nobody should ever have
> > had a successful test run on OS X with the preinstalled tools.  What
> > gives?
[...]
> *** t7003-filter-branch.sh ***
> *   ok 17: use index-filter to move into a subdirectory

Oh, I know.  The test isn't correct, it should be something like the
patch below.  Otherwise a failure in git-diff (namely that
directorymoved:newsubdir is invalid) is never detected, and since the
output in this case is empty, also the test -z succeeds.  Can you
apply that and see if it makes the test fail for you?

diff --git i/t/t7003-filter-branch.sh w/t/t7003-filter-branch.sh
index e90da6d..a8e0c48 100755
--- i/t/t7003-filter-branch.sh
+++ w/t/t7003-filter-branch.sh
@@ -148,7 +148,9 @@ test_expect_success 'use index-filter to move into a subdirectory' '
 	          GIT_INDEX_FILE=\$GIT_INDEX_FILE.new \
 			git update-index --index-info &&
 		  mv \"\$GIT_INDEX_FILE.new\" \"\$GIT_INDEX_FILE\"" directorymoved &&
-	test -z "$(git diff HEAD directorymoved:newsubdir)"'
+	git diff HEAD directorymoved:newsubdir > actual &&
+	test ! -s actual
+'
 
 test_expect_success 'stops when msg filter fails' '
 	old=$(git rev-parse HEAD) &&


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
