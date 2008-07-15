From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [RFC/PATCH 2/2] Do not try to detect move/copy for entries below threshold.
Date: Wed, 16 Jul 2008 02:00:58 +0400
Organization: TEPKOM
Message-ID: <200807160200.58603.angavrilov@gmail.com>
References: <200807160158.34994.angavrilov@gmail.com> <200807160159.56228.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 00:02:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIsb5-0006qi-1L
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 00:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756818AbYGOWBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 18:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756416AbYGOWBL
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 18:01:11 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:36015 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755932AbYGOWBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 18:01:09 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2348856fgg.17
        for <git@vger.kernel.org>; Tue, 15 Jul 2008 15:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Fc+Osr6hyoyqky3K9EBPvmEW6nunlNa8oE1e+zvMxCU=;
        b=aJN7kI/DOjt2x5Yi9nvs4jf+CkRjvmMu0ikif4H/8oChc8QqpeSr1dEva7/Rfy4nkB
         0dwPZYam6F/V0z4LxDlZ7qMAiMv+N5oNRHH8h8wmyBNkrLAJxuBFfleQ48OforwZ+Bet
         eE6solyrPq3EEpqHr7jEs+n34/GiphvqFhb+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vgykP6zt/ty9OZBlzzLBV9jLq0aHbtmBZqSKCsBMdHDPbfDF4jBF1Esiwbr2/wrMc5
         2QSkQakCHR5KJa4gHnA2fi30lqeojPyiyXXynWpx/R+TtNmgB8l+erIp/5sRpl4cWM9P
         Z/AAg4lG1eMaaO5v9ypC31FT/Dymh7mFGGDnI=
Received: by 10.86.80.5 with SMTP id d5mr973845fgb.26.1216159267633;
        Tue, 15 Jul 2008 15:01:07 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id d6sm232260fga.2.2008.07.15.15.01.06
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 15 Jul 2008 15:01:06 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200807160159.56228.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88607>

Splits for such entries are rejected anyway, so there is no
point even trying to compute them.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 builtin-blame.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index a6cf6b6..01453e2 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1020,7 +1020,8 @@ static int find_move_in_parent(struct scoreboard *sb,
 	while (made_progress) {
 		made_progress = 0;
 		for (e = sb->ent; e; e = e->next) {
-			if (e->guilty || !same_suspect(e->suspect, target))
+			if (e->guilty || !same_suspect(e->suspect, target) ||
+			    blame_move_score >= ent_score(sb, e))
 				continue;
 			find_copy_in_blob(sb, e, parent, split, &file_p);
 			if (split[1].suspect &&
@@ -1045,6 +1046,7 @@ struct blame_list {
  */
 static struct blame_list *setup_blame_list(struct scoreboard *sb,
 					   struct origin *target,
+					   int min_score,
 					   int *num_ents_p)
 {
 	struct blame_entry *e;
@@ -1052,12 +1054,16 @@ static struct blame_list *setup_blame_list(struct scoreboard *sb,
 	struct blame_list *blame_list = NULL;
 
 	for (e = sb->ent, num_ents = 0; e; e = e->next)
-		if (!e->scanned && !e->guilty && same_suspect(e->suspect, target))
+		if (!e->scanned && !e->guilty &&
+		    same_suspect(e->suspect, target) &&
+		    ent_score(sb, e) > min_score)
 			num_ents++;
 	if (num_ents) {
 		blame_list = xcalloc(num_ents, sizeof(struct blame_list));
 		for (e = sb->ent, i = 0; e; e = e->next)
-			if (!e->scanned && !e->guilty && same_suspect(e->suspect, target))
+			if (!e->scanned && !e->guilty &&
+			    same_suspect(e->suspect, target) &&
+			    ent_score(sb, e) > min_score)
 				blame_list[i++].ent = e;
 	}
 	*num_ents_p = num_ents;
@@ -1092,7 +1098,7 @@ static int find_copy_in_parent(struct scoreboard *sb,
 	struct blame_list *blame_list;
 	int num_ents;
 
-	blame_list = setup_blame_list(sb, target, &num_ents);
+	blame_list = setup_blame_list(sb, target, blame_copy_score, &num_ents);
 	if (!blame_list)
 		return 1; /* nothing remains for this target */
 
@@ -1174,7 +1180,7 @@ static int find_copy_in_parent(struct scoreboard *sb,
 
 		if (!made_progress)
 			break;
-		blame_list = setup_blame_list(sb, target, &num_ents);
+		blame_list = setup_blame_list(sb, target, blame_copy_score, &num_ents);
 		if (!blame_list) {
 			retval = 1;
 			break;
-- 
1.5.6.2.39.gd084
