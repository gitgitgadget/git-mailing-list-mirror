From: Tom Miller <jackerran@gmail.com>
Subject: [PATCH/WIP] Repair DF conflicts during fetch.
Date: Fri, 29 Nov 2013 11:57:38 -0600
Message-ID: <1385747858-29343-2-git-send-email-jackerran@gmail.com>
References: <1385747858-29343-1-git-send-email-jackerran@gmail.com>
Cc: Tom Miller <jackerran@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 29 18:57:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmSK8-0007lr-KS
	for gcvg-git-2@plane.gmane.org; Fri, 29 Nov 2013 18:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619Ab3K2R5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Nov 2013 12:57:50 -0500
Received: from mail-yh0-f50.google.com ([209.85.213.50]:52679 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab3K2R5r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Nov 2013 12:57:47 -0500
Received: by mail-yh0-f50.google.com with SMTP id b6so7074379yha.9
        for <git@vger.kernel.org>; Fri, 29 Nov 2013 09:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pUjYBkQAEkNgHz91MAYafSwRoEYiGwIqwi3fikbVRGM=;
        b=NC2pzMmEhg16ql8hlj8K8KQVEbh93QR1VRcpnZ838Kha4wctOFWu5xRZCamhKsj2vO
         l9Vl2eXs7ko73TGBJnHIK03gCpjreApI1AkLhkNQCTQTg8fbxbR3Bbb9dIbXoUxOie3A
         6jjG+Rr/FHUHz5NuAYKts6pM/0OBEvn9N3K9tDIap5Zvf6Vswlxa+tt0Y9y1vLUld7JD
         INSEKxPblihMChSPfX3Xs8YPY/xRwqu2jA8IURtkVApcgk8AMdHoS2g3QefVB3/Xs9uM
         gYoLo5I3q00A4gVqDQeqI2qRT1TrI5q3+jp8/cGWzXj82L2p9DfIr3ZjdLLxeQTU/hQi
         wCQw==
X-Received: by 10.236.189.161 with SMTP id c21mr3332105yhn.114.1385747865533;
        Fri, 29 Nov 2013 09:57:45 -0800 (PST)
Received: from gf-tmiller.home (24-197-19-70.static.leds.al.charter.com. [24.197.19.70])
        by mx.google.com with ESMTPSA id g25sm21564767yhg.6.2013.11.29.09.57.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 29 Nov 2013 09:57:45 -0800 (PST)
X-Mailer: git-send-email 1.8.5.rc3.dirty
In-Reply-To: <1385747858-29343-1-git-send-email-jackerran@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238531>

When a DF conflict occurs during a fetch, --prune should be able to fix
it. When fetching with --prune, the fetching process happens before
pruning causing the DF conflict to persist and report an error. This
patch prunes before fetching, thus correcting DF conflicts during a
fetch.

Signed-off-by: Tom Miller <jackerran@gmail.com>
---
 builtin/fetch.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index bd7a101..f7959d0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -824,11 +824,6 @@ static int do_fetch(struct transport *transport,
 
 	if (tags == TAGS_DEFAULT && autotags)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
-	if (fetch_refs(transport, ref_map)) {
-		free_refs(ref_map);
-		retcode = 1;
-		goto cleanup;
-	}
 	if (prune) {
 		/*
 		 * If --tags was specified, pretend that the user gave us
@@ -857,6 +852,11 @@ static int do_fetch(struct transport *transport,
 			prune_refs(transport->remote->fetch, transport->remote->fetch_refspec_nr, ref_map);
 		}
 	}
+	if (fetch_refs(transport, ref_map)) {
+		free_refs(ref_map);
+		retcode = 1;
+		goto cleanup;
+	}
 	free_refs(ref_map);
 
 	/* if neither --no-tags nor --tags was specified, do automated tag
-- 
1.8.5.rc3.dirty
