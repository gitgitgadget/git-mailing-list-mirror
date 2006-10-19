From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] Don't use $author_name undefined when $from contains no /\s</.
Date: Thu, 19 Oct 2006 10:33:01 +0200
Message-ID: <87vemgn1s2.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Oct 19 10:33:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaTKx-00048K-M0
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 10:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbWJSIdI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 04:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030318AbWJSIdI
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 04:33:08 -0400
Received: from mx.meyering.net ([82.230.74.64]:11225 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S1030317AbWJSIdF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 04:33:05 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id EA5BC6A4E; Thu, 19 Oct 2006 10:33:01 +0200 (CEST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29331>

I noticed a case not handled in a recent patch.
Demonstrate it like this:

  $ touch new-file
  $ git-send-email --dry-run --from j --to k new-file 2>err
  new-file
  OK. Log says:
  Date: Thu, 19 Oct 2006 10:26:24 +0200
  Sendmail: /usr/sbin/sendmail
  From: j
  Subject:
  Cc:
  To: k

  Result: OK
  $ cat err
  Use of uninitialized value in pattern match (m//) at /p/bin/git-send-email line 416.
  Use of uninitialized value in concatenation (.) or string at /p/bin/git-send-email line 420.
  Use of uninitialized value in concatenation (.) or string at /p/bin/git-send-email line 468.

There's a patch for the $author_name part below.

The example above shows that $subject may also be used uninitialized.
That should be easy to fix, too.

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index b17d261..1c6d2cc 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -412,7 +412,7 @@ sub send_message
 	}

 	my ($author_name) = ($from =~ /^(.*?)\s+</);
-	if ($author_name =~ /\./ && $author_name !~ /^".*"$/) {
+	if ($author_name && $author_name =~ /\./ && $author_name !~ /^".*"$/) {
 		my ($name, $addr) = ($from =~ /^(.*?)(\s+<.*)/);
 		$from = "\"$name\"$addr";
 	}
--
1.4.3.g72bb
