From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] reject @{-1} not at beginning of object name
Date: Thu, 28 Jan 2010 04:56:43 -0500
Message-ID: <20100128095643.GC14253@coredump.intra.peff.net>
References: <20100128094446.GA14244@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 10:57:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaR7g-00054x-RE
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 10:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960Ab0A1J4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 04:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753828Ab0A1J4t
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 04:56:49 -0500
Received: from peff.net ([208.65.91.99]:33475 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753789Ab0A1J4t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 04:56:49 -0500
Received: (qmail 20898 invoked by uid 107); 28 Jan 2010 09:56:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 28 Jan 2010 04:56:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jan 2010 04:56:43 -0500
Content-Disposition: inline
In-Reply-To: <20100128094446.GA14244@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138239>

Something like foo@{-1} is nonsensical, as the @{-N} syntax
is reserved for "the Nth last branch", and is not an actual
reflog selector. We should not feed such nonsense to
approxidate at all.

Signed-off-by: Jeff King <peff@peff.net>
---
We didn't discuss this one, but I came across it while trying to be
complete in testing the combinations. Right now "foo@{-1}" is
interpreted as a reflog entry at approxidate "-1". Approxidate doesn't
signal an error because it thinks it has found something useful. But
AFAIK we have declared all @{-...} to be Nth last branch, so it is
simply a semantic error.

Let me know if that is not the case (that is, if it was intentional to
leave foo@{-1} as the reflog at date "-1" because it has some meaning
that I am missing) and we can drop this patch.

 sha1_name.c                |    4 ++++
 t/t1508-at-combinations.sh |    2 +-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 00fc415..7729925 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -399,6 +399,10 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		unsigned long co_time;
 		int co_tz, co_cnt;
 
+		/* a @{-N} placed anywhere except the start is an error */
+		if (str[at+2] == '-')
+			return -1;
+
 		/* Is it asking for N-th entry, or approxidate? */
 		for (i = nth = 0; 0 <= nth && i < reflog_len; i++) {
 			char ch = str[at+2+i];
diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index 2a46af2..d5d6244 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -45,7 +45,7 @@ check "@{u}" upstream-two
 check "@{u}@{1}" upstream-one
 check "@{-1}@{u}" master-two
 check "@{-1}@{u}@{1}" master-one
-fail nonsense "@{u}@{-1}"
+nonsense "@{u}@{-1}"
 nonsense "@{1}@{u}"
 
 test_done
-- 
1.7.0.rc0.41.g538720
