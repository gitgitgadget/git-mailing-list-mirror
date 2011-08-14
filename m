From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/7] revert: Fix buffer overflow in insn sheet parser
Date: Sun, 14 Aug 2011 14:03:04 +0530
Message-ID: <1313310789-10216-3-git-send-email-artagnon@gmail.com>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 10:36:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsWBI-0000Jh-W5
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 10:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238Ab1HNIgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 04:36:24 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63864 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab1HNIgX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 04:36:23 -0400
Received: by gxk21 with SMTP id 21so2760091gxk.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 01:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9HFeUhYZCi3B2NyzPNcpPLDnnXf8WhFdBct4TAdmkFs=;
        b=SrLsB0077TkrWbh4U63Mqz3KnVgr+eI/tJzJuVTOwEjDhLfv9gRa5K9HK2vzqh7vDL
         y0HRBJMOFMyku6HUuF8RzjiTC7ND4Yw6+e1dgs0cT+fYg9Ry+gPNJ60TzqRZO5/K4lGD
         TB456ook/nupHH/zOFSMGUk/Kmx4pzqj8RmaQ=
Received: by 10.142.218.11 with SMTP id q11mr1206562wfg.54.1313310982650;
        Sun, 14 Aug 2011 01:36:22 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id 14sm2642752wfl.5.2011.08.14.01.36.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 01:36:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179306>

Check that the commit name argument to a "pick" or "revert" action in
'.git/sequencer/todo' is not too long, to avoid overflowing an
on-stack buffer.  This fixes a regression introduced by a037033b
(revert: Introduce --continue to continue the operation, 2011-07-27).

Reported-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c                |    2 +-
 t/t3510-cherry-pick-sequence.sh |   11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 8a35bfd..8d29003 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -712,7 +712,7 @@ static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
 		return NULL;
 
 	q = strchr(p, ' ');
-	if (!q)
+	if (!q || q - p + 1 > sizeof(sha1_abbrev))
 		return NULL;
 	q++;
 
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 3bca2b3..6882acb 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -211,4 +211,15 @@ test_expect_success 'malformed instruction sheet 2' '
 	test_must_fail git cherry-pick --continue
 '
 
+test_expect_success 'malformed instruction sheet 3' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	echo "resolved" >foo &&
+	git add foo &&
+	git commit &&
+	sed "s/pick \([0-9a-f]\+\)\(.*\)/pick \1\1\1\1\1\1\1\1\2/" .git/sequencer/todo >new_sheet &&
+	cp new_sheet .git/sequencer/todo &&
+	test_must_fail git cherry-pick --continue
+'
+
 test_done
-- 
1.7.6.351.gb35ac.dirty
