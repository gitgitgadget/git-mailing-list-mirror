From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v17 2/7] bisect: use && to connect statements that are deferred with eval.
Date: Thu,  4 Aug 2011 22:00:58 +1000
Message-ID: <1312459263-16911-3-git-send-email-jon.seymour@gmail.com>
References: <1312459263-16911-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, jrnieder@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 14:01:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qowcg-0003qe-GH
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 14:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712Ab1HDMBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 08:01:50 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:47679 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552Ab1HDMBu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 08:01:50 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so1943426pzk.1
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 05:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Iu3k9ruBJjHkf3jC4DLxaeWU0PG1CuRUIQSMzkZ7c/U=;
        b=a8wn81IcDQdSEw6RQzwo/irVBhfTGE+A6Kv9E1UX0ajkOsIiFZkWysPTy8FW0/teZk
         I93m9KHqYiVAVgwsgfSCTu4DhapotRenquY2W44J+1xH1g4d/OcYpoPPdUN37MTcBP4c
         eVcvFE48YTeAS/BN9UYK6E31GyqxRjn2hMWVw=
Received: by 10.142.118.23 with SMTP id q23mr650137wfc.257.1312459309820;
        Thu, 04 Aug 2011 05:01:49 -0700 (PDT)
Received: from localhost.localdomain ([120.16.214.215])
        by mx.google.com with ESMTPS id i5sm249965wff.18.2011.08.04.05.01.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Aug 2011 05:01:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.353.g50d6f
In-Reply-To: <1312459263-16911-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178740>

Christian Couder pointed out that the existing eval strategy
swallows an initial non-zero return. Using && to connect
the statements should fix this.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-bisect.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 20f6dd5..a44ffe1 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -86,7 +86,7 @@ bisect_start() {
 		0) state='bad' ; bad_seen=1 ;;
 		*) state='good' ;;
 		esac
-		eval="$eval bisect_write '$state' '$rev' 'nolog'; "
+		eval="$eval bisect_write '$state' '$rev' 'nolog' &&"
 		shift
 		;;
 	    esac
@@ -145,7 +145,7 @@ bisect_start() {
 	#
 	echo "$start_head" >"$GIT_DIR/BISECT_START" &&
 	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
-	eval "$eval" &&
+	eval "$eval true" &&
 	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
 	#
 	# Check if we can proceed to the next bisect state.
-- 
1.7.6.353.g50d6f
