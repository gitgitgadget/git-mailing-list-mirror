From: Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH] merge-recursive: Fix copy-paste mistake
Date: Sun, 21 Sep 2014 22:49:46 +0200
Message-ID: <1411332586-18275-1-git-send-email-stefanbeller@gmail.com>
Cc: Stefan Beller <stefanbeller@gmail.com>
To: eyvind.bernhardsen@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 21 22:50:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVo55-0008Mc-A9
	for gcvg-git-2@plane.gmane.org; Sun, 21 Sep 2014 22:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbaIUUtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2014 16:49:50 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:44364 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbaIUUtu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2014 16:49:50 -0400
Received: by mail-wi0-f173.google.com with SMTP id r20so1874984wiv.12
        for <git@vger.kernel.org>; Sun, 21 Sep 2014 13:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=1MIVZ201VCTyv0x1MlumYGYQNPFDTWKndDtdpFsfD/0=;
        b=MjGXinAWXxhHxLuPQ7rwg4/CxRQ0uI4OAsRbTk3X3NZBGFsweLf+dW4uLnHdWmpxdJ
         h+MgcfhbpD/VFmyZ6dJ0+qHszmOE5ySGgQ+GLF7lqH/YLgryrS2WG17Iw2NyaQDPUmHl
         aaz+54+ZQcielD4AvQa7yuwuqK5gknyXBFoxgVLfmGecKHC++2ei+q/VLw+dbtrAGHDo
         j5uS2bllpE18h15nnyQTPeUlWByKGyAVpJdPvjia1W4UHq5Di0ANqVhtwBoLiRA6eyYR
         CJ/ZyoRT6gA1E24jp28016eFRhI3T2Je1k7wLN4SYfHiKuAKEPtrNMibOdlJDIp1faAr
         VJvw==
X-Received: by 10.180.10.230 with SMTP id l6mr10862625wib.62.1411332588456;
        Sun, 21 Sep 2014 13:49:48 -0700 (PDT)
Received: from localhost (p578F81B0.dip0.t-ipconnect.de. [87.143.129.176])
        by mx.google.com with ESMTPSA id hy9sm10046529wjb.27.2014.09.21.13.49.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 21 Sep 2014 13:49:47 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.238.gce1d3a9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257357>

The following issue was found by scan.coverity.com (ID: 1049510),
and claimed to be likely a copy-paste mistake.

Introduced in 331a1838b (2010-07-02, Try normalizing files
to avoid delete/modify conflicts when merging), which is
quite a long time ago, so I'm rather unsure if it's of any impact
or just went unnoticed.

The line after the changed line has a comparison of 'o.len' to 'a.len',
so we should assume the lengths may be different.

I'd be happy to have a test for this bug(?) attached to
t6031-merge-recursive.sh, but I did not manage to
come up with a test in a reasonable amount of time.

Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
---
 merge-recursive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 22315c3..d63524c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1555,7 +1555,7 @@ static int blob_unchanged(const unsigned char *o_sha,
 	 * unchanged since their sha1s have already been compared.
 	 */
 	if (renormalize_buffer(path, o.buf, o.len, &o) |
-	    renormalize_buffer(path, a.buf, o.len, &a))
+	    renormalize_buffer(path, a.buf, a.len, &a))
 		ret = (o.len == a.len && !memcmp(o.buf, a.buf, o.len));
 
 error_return:
-- 
2.1.0.238.gce1d3a9
