From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: [PATCH] fix git-checkout-cache segfault on parisc
Date: Sat, 13 Aug 2005 10:29:32 -0500
Message-ID: <1123946972.5115.4.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	PARISC list <parisc-linux@lists.parisc-linux.org>
X-From: git-owner@vger.kernel.org Sat Aug 13 17:31:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3xxO-0004as-RP
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 17:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbVHMP3r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 11:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbVHMP3r
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 11:29:47 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:47289 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751336AbVHMP3r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2005 11:29:47 -0400
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id j7DFTXA01462;
	Sat, 13 Aug 2005 11:29:33 -0400
To: junkio@cox.net
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This one I think is Linus' fault, so send him a brown paper bag with my
complements ...

The index cleanup code is executed via atexit() which is *after* main
has completed, so the stack allocated cache_file has gone out of scope.
Parisc seems to use stack in the destructor functions, so cache_file
gets partially overwritten leading to the predictable disastrous
consequences.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

---

James

diff --git a/checkout-cache.c b/checkout-cache.c
--- a/checkout-cache.c
+++ b/checkout-cache.c
@@ -80,10 +80,11 @@ static int checkout_all(void)
 static const char checkout_cache_usage[] =
 "git-checkout-cache [-u] [-q] [-a] [-f] [-n] [--prefix=<string>] [--] <file>...";
 
+static struct cache_file cache_file;
+
 int main(int argc, char **argv)
 {
 	int i, force_filename = 0;
-	struct cache_file cache_file;
 	int newfd = -1;
 
 	if (read_cache() < 0) {
diff --git a/index.c b/index.c
