From: Mike Edgar <adgar@google.com>
Subject: [PATCH v2] fetch-pack: check for shallow if depth given
Date: Wed, 17 Jun 2015 20:31:04 -0400
Message-ID: <1434587464-18337-1-git-send-email-adgar@google.com>
Cc: git@vger.kernel.org, Mike Edgar <adgar@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 18 02:31:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Nk2-0004Gn-Ji
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 02:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbbFRAbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 20:31:23 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:32863 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbbFRAbV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 20:31:21 -0400
Received: by igbqq3 with SMTP id qq3so3177461igb.0
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 17:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=8CdduFKHPzU+KEAfslQUI1oapecoBcJy/r07W7YbqaQ=;
        b=F9MTH0iXtl/EVl+KBWYQT56BcWDDs9Ny28B+gTnz4k9P9THwCp643SRqOl563HLYQ3
         +rhJepEIZEh0itbIO1Sry3a85rcLtg/z/EraWUul4FBNf9ZTLAK/9uUsJP0vGmeCu8uX
         G+tKuCjwLm1kB4724gMJosgTvC0AHollhcCI07Mqy5fPFvMuT5QxBoHnmtoAq2gEbMG9
         MxB25QYQsPDFWdb2ZOpjF+mk5918wdF2Gqes/Y/MQ0lT4O5JM9hPX8eqfzYz+k9pBi4w
         qpSF6K4UnqXUl5tepSpYMPCA6+Ow5p2KmzFdhYNnkkIq2c8WqzSv8tEwzXnjxToVnCyQ
         S1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8CdduFKHPzU+KEAfslQUI1oapecoBcJy/r07W7YbqaQ=;
        b=PeLnU2T6y0FdUPfU6DQUVts5Z4PQ4T6IfMYjZrMXivJ7KZeEGZYSSj21noGVdhHz9Z
         GiCgKrPlpR9vQtlNQL5TMeBn2xr67noGbZgTvFULAtJGhRZIcTBIal+Dzr+zDJhPdFeE
         8LrCny7BLorUmMeVjVCXhohdqNrGKheNpO5kIBSB+MFyNQF5TDbF1kpLCEqTTNHfmcd3
         Hc+X2fcVhukZkSlsOBBZcEtHxxuJHCtZo/2aBmNxMmBiW+RXr4JGRKJkij0Hf8l8d9qj
         /WhimjUeNrKfZaOM0U3aW2uGNTBbYPamUN49UR4255CE4DfjyAXdoZPGH7TkGjdRO+z8
         nvGw==
X-Gm-Message-State: ALoCoQminjQsZO8BrAXQMp3BsdE9y3HfGK04fmKi1fcA4X7fhnwRp18xUm6Q8B15XOUtDgeImwpn
X-Received: by 10.50.56.104 with SMTP id z8mr14776977igp.45.1434587480960;
        Wed, 17 Jun 2015 17:31:20 -0700 (PDT)
Received: from smtp.gmail.com ([172.26.9.125])
        by mx.google.com with ESMTPSA id j3sm4307768igx.21.2015.06.17.17.31.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Jun 2015 17:31:17 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.493.g7974889.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271931>

When a repository is first fetched as a shallow clone, either by
git-clone or by fetching into an empty repo, the server's capabilities
are not currently consulted. The client will send shallow requests even
if the server does not understand them, and the resulting error may be
unhelpful to the user. This change pre-emptively checks so we can exit
with a helpful error if necessary.

Signed-off-by: Mike Edgar <adgar@google.com>
Acked-by: Jeff King <peff@peff.net>
---
 fetch-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 48526aa..849a9d6 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -790,7 +790,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	sort_ref_list(&ref, ref_compare_name);
 	qsort(sought, nr_sought, sizeof(*sought), cmp_ref_by_name);
 
-	if (is_repository_shallow() && !server_supports("shallow"))
+	if ((args->depth > 0 || is_repository_shallow()) && !server_supports("shallow"))
 		die("Server does not support shallow clients");
 	if (server_supports("multi_ack_detailed")) {
 		if (args->verbose)
-- 
2.4.3.573.g4eafbef
