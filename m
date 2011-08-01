From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v11 2/7] bisect: use && to connect statements that are deferred with eval.
Date: Mon,  1 Aug 2011 21:56:12 +1000
Message-ID: <1312199777-10144-3-git-send-email-jon.seymour@gmail.com>
References: <1312199777-10144-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 01 13:57:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnr7Y-00062W-Fb
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 13:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308Ab1HAL5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 07:57:08 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61524 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab1HAL5A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 07:57:00 -0400
Received: by gxk21 with SMTP id 21so3367366gxk.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 04:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=r6a0XC+JoLqW1mGCVpcCki8XL+tV58MWtPs8dym2b48=;
        b=Jo4nrNpaJhe8IgljICSDkGs/N5NGPg6r8FNmwH6XtTBCMaLKygibHxfq6E/9EjQEPT
         ZZdhzIJddCKxdTk+MwFMOV1uqlL2+Td/4mFHv9CkTxSZAXOe1CzDLbCc071j+fMR6+ZI
         N4nNrVWB2Fn9sPOhwRo3KAr6Gefh33QA0HxkQ=
Received: by 10.142.59.21 with SMTP id h21mr2976057wfa.268.1312199819805;
        Mon, 01 Aug 2011 04:56:59 -0700 (PDT)
Received: from localhost.localdomain ([120.16.6.238])
        by mx.google.com with ESMTPS id a4sm3060009wfm.4.2011.08.01.04.56.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 04:56:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.352.g0c69b
In-Reply-To: <1312199777-10144-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178334>

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
1.7.6.352.g0c69b
