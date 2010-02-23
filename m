From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] rerere: fix memory leak if rerere images can't be read
Date: Tue, 23 Feb 2010 21:11:53 +0100
Message-ID: <1266955913-4943-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 23 21:12:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk16z-0004vc-J8
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 21:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038Ab0BWUMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 15:12:00 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:34427 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab0BWUL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 15:11:59 -0500
Received: by fxm19 with SMTP id 19so4237925fxm.21
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 12:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=gQgSUDpQedlImWdD1jyyQn8J+DhQKqitUALyGoRhCQE=;
        b=kxENySRE97QoZhqSUQdazRjoJTF0lZrKLHsJ3tDuvRRgcW4MPHnUBst0e7iZxCQYpY
         VNSqlqaH5/6AaI1kebKnrBEPViA/BzVaOnj2OrwSaXNr+/qmI3d0YuiPZE2B6W2FFfVe
         ST9FJNuG3SMyKWvNFU4vWSX17JiW2tIyX3gwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=s8iWpPpUKQz0vEUmIE5wzpP21hbPlvm7B6w0Onwug2fJMY55u5EeJp7+vdzf1uQ4kj
         UFZEboDbM74/dU2n/U95O33LCRQ6Wsj8j+768krbbDzW9f5ohl+odv+1Tzc4Z1tBzfSc
         ZK2esH/3yLAI8OVHu0R7fNS5I6sKsmY2P/G3Y=
Received: by 10.87.40.26 with SMTP id s26mr2637838fgj.72.1266955917949;
        Tue, 23 Feb 2010 12:11:57 -0800 (PST)
Received: from localhost (drsd-4dbd880b.pool.mediaWays.net [77.189.136.11])
        by mx.google.com with ESMTPS id l12sm12231469fgb.27.2010.02.23.12.11.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 12:11:56 -0800 (PST)
X-Mailer: git-send-email 1.7.0.500.ge51cb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140829>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 rerere.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/rerere.c b/rerere.c
index d1d3e75..9ca4cb8 100644
--- a/rerere.c
+++ b/rerere.c
@@ -364,16 +364,17 @@ static int find_conflict(struct string_list *conflict)
 static int merge(const char *name, const char *path)
 {
 	int ret;
-	mmfile_t cur, base, other;
+	mmfile_t cur = {NULL, 0}, base = {NULL, 0}, other = {NULL, 0};
 	mmbuffer_t result = {NULL, 0};
 
 	if (handle_file(path, NULL, rerere_path(name, "thisimage")) < 0)
 		return 1;
 
+	ret = 1;
 	if (read_mmfile(&cur, rerere_path(name, "thisimage")) ||
 			read_mmfile(&base, rerere_path(name, "preimage")) ||
 			read_mmfile(&other, rerere_path(name, "postimage")))
-		return 1;
+		goto out;
 	ret = ll_merge(&result, path, &base, &cur, "", &other, "", 0);
 	if (!ret) {
 		FILE *f = fopen(path, "w");
@@ -387,6 +388,7 @@ static int merge(const char *name, const char *path)
 				     strerror(errno));
 	}
 
+out:
 	free(cur.ptr);
 	free(base.ptr);
 	free(other.ptr);
-- 
1.7.0.500.ge51cb
