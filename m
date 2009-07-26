From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] t9143: do not fail if Compress::Zlib is missing
Date: Sun, 26 Jul 2009 03:01:52 -0700
Message-ID: <20090726100152.GA25775@dcvr.yhbt.net>
References: <7vd47r298e.fsf@alter.siamese.dyndns.org> <20090724093847.GA20338@dcvr.yhbt.net> <7vk51ykm42.fsf@alter.siamese.dyndns.org> <20090725103821.GA13534@dcvr.yhbt.net> <20090725111044.GA7969@dcvr.yhbt.net> <7v3a8jsvyu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Robert Allan Zeh <robert.a.zeh@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 12:06:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MV0cE-0007Z6-KU
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 12:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbZGZKBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 06:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752551AbZGZKBx
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 06:01:53 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55400 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751415AbZGZKBw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 06:01:52 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 0D3C71F5F3;
	Sun, 26 Jul 2009 10:01:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v3a8jsvyu.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124114>

"git svn gc" will not compress unhandled.log files if
Compress::Zlib is missing.  However, leftover index files should
always be removed, so add a test for this behavior as well.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
  Junio C Hamano <gitster@pobox.com> wrote:
  > Eric Wong <normalperson@yhbt.net> writes:
  > 
  > >   # I thought I had pushed this out earlier:
  > >   Robert Allan Zeh (1):
  > >         git svn: add gc command
  > 
  > Note that with this commit, the test fails needlessly if Compress::Zlib is
  > not found, even though otherwise "svn gc" succeeds (for some definition of
  > "success")..

  Oops, this test completely slipped my mind even though I caught the
  issue in the original code.  Pushed out to git://git.bogomips.org/git-svn

 t/t9143-git-svn-gc.sh |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/t/t9143-git-svn-gc.sh b/t/t9143-git-svn-gc.sh
index aaa3af0..f2ba2d1 100755
--- a/t/t9143-git-svn-gc.sh
+++ b/t/t9143-git-svn-gc.sh
@@ -31,11 +31,20 @@ test_expect_success 'make backup copy of unhandled.log' '
 	 cp .git/svn/git-svn/unhandled.log tmp
 	'
 
+test_expect_success 'create leftover index' '> .git/svn/git-svn/index'
+
 test_expect_success 'git svn gc runs' 'git svn gc'
 
-test_expect_success 'git svn gc produces a valid gzip file' '
-	 gunzip .git/svn/git-svn/unhandled.log.gz
-	'
+test_expect_success 'git svn index removed' '! test -f .git/svn/git-svn/index'
+
+if perl -MCompress::Zlib -e 0 2>/dev/null
+then
+	test_expect_success 'git svn gc produces a valid gzip file' '
+		 gunzip .git/svn/git-svn/unhandled.log.gz
+		'
+else
+	say "Perl Compress::Zlib unavailable, skipping gunzip test"
+fi
 
 test_expect_success 'git svn gc does not change unhandled.log files' '
 	 test_cmp .git/svn/git-svn/unhandled.log tmp/unhandled.log
-- 
Eric Wong
