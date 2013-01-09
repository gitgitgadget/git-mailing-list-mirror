From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH 19/19] reset [--mixed]: use diff-based reset whether or not pathspec was given
Date: Wed,  9 Jan 2013 00:16:16 -0800
Message-ID: <1357719376-16406-20-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 09:17:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsqr9-0002P4-MB
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 09:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757363Ab3AIIR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 03:17:27 -0500
Received: from mail-gg0-f202.google.com ([209.85.161.202]:53998 "EHLO
	mail-gg0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757261Ab3AIIRG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 03:17:06 -0500
Received: by mail-gg0-f202.google.com with SMTP id k1so191121ggn.3
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 00:17:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=Wh08yyzPrOTfBpllRVJNacmz7SXeVlEGbE5mo0ya4OU=;
        b=dUopOU2epaZV08QKNAzaqnJsM5fsobbC5xYxff0ZHJAIKjzWj5NfUmS4oMhsigRBtK
         prXr7BBuBtgHrxexg9g61LcwXFJAE2Chb+Fd9rFVCgNd0JAfhLsaZHPMaS3HO1cuHMh0
         RfSm2MzDP97S/HxxeHOkP2jbbN5S/+k2HOrgJmshCakGFrQXs7WXH7tW3W0uDOTd6QP/
         0xd519z9FDcsefcXbg2ejnIUPmpBTQ7mX6YcX1URh+w4PX3KiE9ZBlft8Tv2Nj6scjiS
         EYzxdPtXDPU4j0xlZxReD9/LxvOOSIfKR4z96Xa4cdvQtBGgELCnuncXwiObXg/iQeaF
         ad5w==
X-Received: by 10.236.159.2 with SMTP id r2mr5200788yhk.49.1357719425235;
        Wed, 09 Jan 2013 00:17:05 -0800 (PST)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id u20si2898554anj.3.2013.01.09.00.17.05
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 09 Jan 2013 00:17:05 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 180FA100047;
	Wed,  9 Jan 2013 00:17:05 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id AC84F102FBC; Wed,  9 Jan 2013 00:17:04 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.331.g1ef2165
In-Reply-To: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQlQrPn2keq+mUiGujapcEH3qQoLAyKZl7Zy9UJN+k8aI6BNsotWTPncMrT2ocg6VOr/guXmU4N8FX1Kh02RZqNYssggsP3q6AjNEUjoEpDYHrSyqZSlJSPUh0uvr8M7GnO76IooZe0KGepxhAVF1FgPOylUX+eDCr2rhYUsnTfAutU48VpBqXvJkff9FKCEeqA2Xo7q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213035>

Thanks to b65982b (Optimize "diff-index --cached" using cache-tree,
2009-05-20), resetting with paths is much faster than resetting
without paths. Some timings for the linux-2.6 repo to illustrate this
(best of five, warm cache):

        reset       reset .
real    0m0.219s    0m0.080s
user    0m0.140s    0m0.040s
sys     0m0.070s    0m0.030s

These two commands should do the same thing, so instead of having the
user type the trailing " ." to get the faster do_diff_cache()-based
implementation, always use it when doing a mixed reset, with or
without paths (so "git reset $rev" would also be faster).

Comparing before and after (best of five):

                       Before     After
reset    (warm cache):   0.21      0.07
reset -q (warm cache)    0.17      0.03
reset    (cold cache):  10.31      2.72
reset -q (cold cache)    7.64      0.38
---
Are unmerged entries handled the same? read_from_tree() calls
read_cache(), while reset_index() calls read_cache_unmerged(). I
haven't figured out if/why they should be different.

Are there other differences, or could unpack_trees() learn the same
optimization as do_diff_cache()? Actually, the commit mentioned above
does say

  Tweak unpack_trees() logic that is used to read in the tree object
  to catch the case where the tree entry we are looking at matches the
  index as a whole by looking at the cache-tree.

If there are differences, we are clearly missing tests for them. And
it seems like any difference between them should be fixed, so "git
reset" and "git reset ." (from root of tree) do the same thing even
before this patch.

 builtin/reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 5cd48ac..6db0a10 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -320,7 +320,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (reset_type != SOFT) {
 		struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 		int newfd = hold_locked_index(lock, 1);
-		if (pathspec) {
+		if (reset_type == MIXED) {
 			if (read_from_tree(pathspec, sha1))
 				return 1;
 		} else {
-- 
1.8.1.rc3.331.g1ef2165
