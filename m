From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/6] revert: Fix buffer overflow in insn sheet parser
Date: Sat,  8 Oct 2011 23:06:44 +0530
Message-ID: <1318095407-26429-4-git-send-email-artagnon@gmail.com>
References: <1318095407-26429-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 08 19:37:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCapr-0004l3-I3
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 19:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339Ab1JHRhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 13:37:11 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:35970 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230Ab1JHRhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 13:37:09 -0400
Received: by mail-pz0-f42.google.com with SMTP id 1so12271226pzk.1
        for <git@vger.kernel.org>; Sat, 08 Oct 2011 10:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Hha+CK2y5d9bQjsz5qPM1e/LQpzhDuIwxKPPFQJLD+g=;
        b=OD5IEAP2o3AUWWRgqo5BSDDU+wX/dEC/9Q7aabrEx5ybij5gpTgutiUHOTpHxoChTl
         zvh+j+Nner1FfHoJn59xhcuZGBKNl/tSfrQlnOQAkMwwlIs7pbT6vaHoyr5EomsuOoHe
         q/aICLgnaVlNe1X1p5K6MjoyxMo+w3qwoMJhA=
Received: by 10.68.6.98 with SMTP id z2mr23624196pbz.36.1318095428793;
        Sat, 08 Oct 2011 10:37:08 -0700 (PDT)
Received: from localhost.localdomain ([122.174.152.157])
        by mx.google.com with ESMTPS id h5sm45151528pbq.11.2011.10.08.10.37.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 08 Oct 2011 10:37:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1318095407-26429-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183161>

Check that the commit name argument to a "pick" or "revert" action in
'.git/sequencer/todo' is not too long, to avoid overflowing an
on-stack buffer.  This fixes a regression introduced by 5a5d80f4
(revert: Introduce --continue to continue the operation, 2011-08-04).

Reported-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c                |    2 +-
 t/t3510-cherry-pick-sequence.sh |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index b3c5e0e..6451089 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -707,7 +707,7 @@ static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
 		return NULL;
 
 	q = strchr(p, ' ');
-	if (!q)
+	if (!q || q - p + 1 > sizeof(sha1_abbrev))
 		return NULL;
 	q++;
 
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 3bca2b3..2113308 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -12,6 +12,9 @@ test_description='Test cherry-pick continuation features
 
 . ./test-lib.sh
 
+# Repeat first match 10 times
+_r10='\1\1\1\1\1\1\1\1\1\1'
+
 pristine_detach () {
 	git cherry-pick --reset &&
 	git checkout -f "$1^0" &&
@@ -211,4 +214,15 @@ test_expect_success 'malformed instruction sheet 2' '
 	test_must_fail git cherry-pick --continue
 '
 
+test_expect_success 'malformed instruction sheet 3' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	echo "resolved" >foo &&
+	git add foo &&
+	git commit &&
+	sed "s/pick \([0-9a-f]*\)/pick $_r10/" .git/sequencer/todo >new_sheet &&
+	cp new_sheet .git/sequencer/todo &&
+	test_must_fail git cherry-pick --continue
+'
+
 test_done
-- 
1.7.4.1
