From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH] Use Peter J. Weinberger's hash function in xdiff
Date: Mon, 23 Jul 2007 13:17:58 +0200
Message-ID: <e5bfff550707230417j3d4ac7f4sb310baf43a327684@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 13:18:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICvvQ-00038p-L8
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 13:18:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761442AbXGWLSA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 07:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761047AbXGWLSA
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 07:18:00 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:17166 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759764AbXGWLR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 07:17:59 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1952226wah
        for <git@vger.kernel.org>; Mon, 23 Jul 2007 04:17:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eUdkfX+XVcWF6eletV/Odgu8uOqb7AoQBJNkxHevFEqMvrFGmf+Iayj8SDNJOV53tIPULFZ73FCU1tJbk/OQz1cEZEawky4KXJvGBl3HzbkgD6kAFALiVos5gXTu2eGmN710t9iUfdlmMixEq+09BcMDWRywik56FnHHSjyATGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CWmE7ZEaGaPnV4OMBxg44d3+tUU2e+9O4Oc/mRYCPYZs3G+N+aVE4/r5arW2/M8sQ4f170j/TwPpNm7wxvNOhyqV5Pq9IofYaI1b1FYJ6gG/nMblHooE8X5WibbR4LUBPrz9eUT1/2ChUFvN0YpuK3MZB/cjXASihanWXvs5hWU=
Received: by 10.114.179.1 with SMTP id b1mr2877138waf.1185189478596;
        Mon, 23 Jul 2007 04:17:58 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Mon, 23 Jul 2007 04:17:58 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53429>

It seems a little bit faster then current one:

WITH CURRENT ONE

git tree
$ time git diff v0.99.. > /dev/null
0.91user 0.02system 0:01.03elapsed 91%CPU
(0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+3594minor)pagefaults 0swaps

Linux tree
$ time git diff v2.6.22.. > /dev/null
13.61user 0.19system 0:13.90elapsed 99%CPU
(0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+27279minor)pagefaults 0swaps

WITH NEW ONE

git tree
$ time git diff v0.99.. > /dev/null
0.87user 0.01system 0:00.98elapsed 90%CPU
(0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+3594minor)pagefaults 0swaps

Linux tree
$ time git diff v2.6.22.. > /dev/null
13.26user 0.21system 0:13.57elapsed 99%CPU
(0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+27277minor)pagefaults 0swaps

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---

This patch is not intended for inclusion, the time diff is very small,
but it would be interestiing to understand from where it comes from
possibly from people more versed then me in hashing functions.

BTW this modified Weinberger's hash function is the one used in Qt
library, for the QHash class.

 xdiff/xutils.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 2ade97b..c19ab6e 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -270,24 +270,32 @@ static unsigned long
 	return ha;
 }

+/*
+    This function is based on Peter J. Weinberger's hash function
+    (from the Dragon Book). The constant 24 in the original function
+    was replaced with 23 to produce fewer collisions on input such as
+    "a", "aa", "aaa", "aaaa", ...
+*/

 unsigned long xdl_hash_record(char const **data, char const *top, long flags) {
-	unsigned long ha = 5381;
+
+	unsigned long ha = 0;
+	unsigned long g;
 	char const *ptr = *data;

 	if (flags & XDF_WHITESPACE_FLAGS)
 		return xdl_hash_record_with_whitespace(data, top, flags);

-	for (; ptr < top && *ptr != '\n'; ptr++) {
-		ha += (ha << 5);
-		ha ^= (unsigned long) *ptr;
+	while (ptr < top && *ptr != '\n') {
+		ha = (ha << 4) + *ptr++;
+		if ((g = (ha & 0xf0000000)) != 0)
+			ha ^= g >> 23;
+		ha &= ~g;
 	}
 	*data = ptr < top ? ptr + 1: ptr;
-
 	return ha;
 }

-
 unsigned int xdl_hashbits(unsigned int size) {
 	unsigned int val = 1, bits = 0;

-- 
1.5.3.rc2.29.gc4640f-dirty
