From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v14 2/8] bisect: use && to connect statements that are deferred with eval.
Date: Wed,  3 Aug 2011 08:15:56 +1000
Message-ID: <1312323362-20096-3-git-send-email-jon.seymour@gmail.com>
References: <1312323362-20096-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 00:16:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoNGi-000433-99
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 00:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755735Ab1HBWQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 18:16:32 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39275 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755736Ab1HBWQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 18:16:26 -0400
Received: by gyh3 with SMTP id 3so155701gyh.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 15:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=63Od5HzHYQSZRrdZus0fCIwChllGfMzHbr1KmPtE6fU=;
        b=W10Axp/+f9NIHk8XdlqpaWkTpP96PxB7OEi2FmZjXH3yguvaoR0oTOHaArnsiFjm17
         g9YkXz89g7RQ/w8HJMV8BJ/1qW/+5OVyZqfk+YdFb6sUGEwA/0p8iRzN0dssKuzuQaT7
         6PuOPK4Ea4UG1aeIwXqjPbuuI+HgBdB83/MIU=
Received: by 10.68.66.7 with SMTP id b7mr8888pbt.45.1312323385647;
        Tue, 02 Aug 2011 15:16:25 -0700 (PDT)
Received: from localhost.localdomain ([120.16.93.94])
        by mx.google.com with ESMTPS id d3sm269987pbg.44.2011.08.02.15.16.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Aug 2011 15:16:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.353.gb3ae7e
In-Reply-To: <1312323362-20096-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178524>

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
1.7.6.353.gb3ae7e
