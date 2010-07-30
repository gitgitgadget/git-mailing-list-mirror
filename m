From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFH] Spurious failures of t0025.[34]
Date: Sat, 31 Jul 2010 00:47:45 +0200
Message-ID: <201007310047.46206.trast@student.ethz.ch>
References: <201007292340.01836.trast@student.ethz.ch> <20100730182532.GB18544@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 31 00:48:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeyNA-0006Pg-Lq
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 00:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756784Ab0G3WsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 18:48:06 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:45006 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755935Ab0G3WsF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 18:48:05 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 31 Jul
 2010 00:48:02 +0200
Received: from thomas.site (217.162.250.31) by CAS21.d.ethz.ch (172.31.51.111)
 with Microsoft SMTP Server (TLS) id 14.0.702.0; Sat, 31 Jul 2010 00:48:02
 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <20100730182532.GB18544@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152272>

Jeff King wrote:
> which dumped me with a shell in the "broken" state. The interesting
> thing is that I can then repeatably run "git diff two" and get an empty
> diff.  So I don't think the error or race condition is in the run of
> "git diff" itself, but rather what happened above (presumably the in
> the read-tree step).

This, and Jonathan's observation about git-apply, finally got me
somewhere.  The issue is that the index file has a timestamp different
from the saved mtimes of the file itself.  This can be provoked
deterministically by the patch below, even without valgrind; valgrind
merely makes it much more likely to happen by slowing down
git-read-tree.

Now I don't know what the next step in the chain is.  Who's the
resident expert on index raciness?  Does git-diff then reindex the
file, and in doing so, change the index entry?


diff --git i/t/t0025-crlf-auto.sh w/t/t0025-crlf-auto.sh
index f5f67a6..7a9cd3a 100755
--- i/t/t0025-crlf-auto.sh
+++ w/t/t0025-crlf-auto.sh
@@ -46,6 +46,8 @@ test_expect_success 'crlf=true causes a CRLF file to be normalized' '
 	echo "two crlf" > .gitattributes &&
 	git read-tree --reset -u HEAD &&
 
+	test-chmtime +1 .git/index &&
+
 	# Note, "normalized" means that git will normalize it if added
 	has_cr two &&
 	twodiff=`git diff two` &&
@@ -58,6 +60,8 @@ test_expect_success 'text=true causes a CRLF file to be normalized' '
 	echo "two text" > .gitattributes &&
 	git read-tree --reset -u HEAD &&
 
+	test-chmtime +1 .git/index &&
+
 	# Note, "normalized" means that git will normalize it if added
 	has_cr two &&
 	twodiff=`git diff two` &&

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
