From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v6 8/8] push: cleanup push rules comment
Date: Thu, 29 Nov 2012 19:41:40 -0600
Message-ID: <1354239700-3325-9-git-send-email-chris@rorvick.com>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
Cc: Chris Rorvick <chris@rorvick.com>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 30 02:44:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeFdu-0007Rx-06
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 02:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755505Ab2K3Bn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 20:43:28 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:43897 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755493Ab2K3Bn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 20:43:26 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so13169118iea.19
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 17:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=WyWtBTeX7SE1PuynpRjv0dB/AMj3oc9hdgNjvzDVEEI=;
        b=tTxHUFdFEtYrTllHft6sK3fFuus1MT9eT0eMVJtbHVoXd3e+Yj2i8Wi6xXD6s9teAj
         NI5CQZKnknzJ9Et28NSa84svz2PwpW0kVZ3Hxf40J++lv43kWk5VuKKSOxuNX+Q2Lv92
         90cQ9PVGz/RWxNDZ0WBfQ15szzEr3cM//tTtuQg7ZeLj/lXb955QhqC0YTg1vw4/epdP
         dCKlbjQkwVnI2Lp3R3jSB6gTOpDXfmRHh4+0Hv52qk8XgnZyQkMtP582eWpKEVoMOwKB
         8XRAHHbHEFU3Z/WOqVAA7ZsiNR5vDcQ3fTN8xW6Wh9Bdwbs6RShVNhh16lYAyiXh1FTL
         wGOw==
Received: by 10.50.188.167 with SMTP id gb7mr24588916igc.66.1354239806115;
        Thu, 29 Nov 2012 17:43:26 -0800 (PST)
Received: from marlin.localdomain ([70.131.98.170])
        by mx.google.com with ESMTPS id c3sm8955228igj.1.2012.11.29.17.43.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Nov 2012 17:43:25 -0800 (PST)
X-Mailer: git-send-email 1.8.0.158.g0c4328c
In-Reply-To: <1354239700-3325-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210893>

Rewrite to remove inter-dependencies amongst the rules.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 remote.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/remote.c b/remote.c
index ee0c1e5..6309a87 100644
--- a/remote.c
+++ b/remote.c
@@ -1319,27 +1319,29 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 			continue;
 		}
 
-		/* This part determines what can overwrite what.
-		 * The rules are:
+		/*
+		 * The below logic determines whether an individual
+		 * refspec A:B can be pushed.  The push will succeed
+		 * if any of the following are true:
 		 *
-		 * (0) you can always use --force or +A:B notation to
-		 *     selectively force individual ref pairs.
+		 * (1) the remote reference B does not exist
 		 *
-		 * (1) if the old thing does not exist, it is OK.
+		 * (2) the remote reference B is being removed (i.e.,
+		 *     pushing :B where no source is specified)
 		 *
-		 * (2) if the destination is under refs/tags/ you are
-		 *     not allowed to overwrite it; tags are expected
-		 *     to be static once created
+		 * (3) the update meets all fast-forwarding criteria:
 		 *
-		 * (3) if you do not have the old thing, you are not allowed
-		 *     to overwrite it; you would not know what you are losing
-		 *     otherwise.
+		 *     (a) the destination is not under refs/tags/
+		 *     (b) the old is a commit
+		 *     (c) the new is a descendant of the old
 		 *
-		 * (4) if old is a commit and new is a descendant of old
-		 *     (implying new is commit-ish), it is OK.
+		 *     NOTE: We must actually have the old object in
+		 *     order to overwrite it in the remote reference,
+		 *     and that the new object must be commit-ish.
+		 *     These are implied by (b) and (c) respectively.
 		 *
-		 * (5) regardless of all of the above, removing :B is
-		 *     always allowed.
+		 * (4) it is forced using the +A:B notation, or by
+		 *     passing the --force argument
 		 */
 
 		ref->not_forwardable = !is_forwardable(ref);
-- 
1.8.0.158.g0c4328c
