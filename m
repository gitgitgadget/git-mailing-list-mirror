From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH 16/19] reset [--mixed] --quiet: don't refresh index
Date: Wed,  9 Jan 2013 00:16:13 -0800
Message-ID: <1357719376-16406-17-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 09:24:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsqxh-0002Da-8R
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 09:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757345Ab3AIIYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 03:24:17 -0500
Received: from mail-wi0-f202.google.com ([209.85.212.202]:43325 "EHLO
	mail-wi0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757216Ab3AIIYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 03:24:16 -0500
Received: by mail-wi0-f202.google.com with SMTP id hn17so31061wib.3
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 00:24:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=7pV83ddRp8UUXbkCeYwH+8Tf59V08L+X4TQ0iNfMPCU=;
        b=gJ0lCSfNLKXJVlTHS9NVYVqw6tXxMcw8r9uvf58cFS8HLkY0SMDmTEopQyI6XYKGDl
         /nn2DU/nNKXvCxU3X50VrYiCAU4d7WwKxwbxHIRxihJswHn5oyOmQr+/5QLSoCemmDxh
         vhVG2OjA6YCnoUzoKxiC3Cs2CBobFzV6XSq1VqfrrN/tg2oHYs4o2pWtWYNSAiRoc9l8
         khgo+xM5gjpKaGDGbm5tfxAJ9c6XRgcTiz4OKVYC9yZMBpGys1PHw0zyXHhVF4BXh5d8
         sZ0wcyZkPa95T4VO0gayOvEJHCgrTFdSY35zHKR4YuttGAba//xIHJR621v/aflvuT51
         nvDQ==
X-Received: by 10.14.208.198 with SMTP id q46mr83817239eeo.0.1357719425794;
        Wed, 09 Jan 2013 00:17:05 -0800 (PST)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id z44si25287650een.0.2013.01.09.00.17.05
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 09 Jan 2013 00:17:05 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 5593F200070;
	Wed,  9 Jan 2013 00:17:05 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 8768B10308C; Wed,  9 Jan 2013 00:17:04 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.331.g1ef2165
In-Reply-To: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQn3SLrqSCNugYsHoqXqDtmwKOKbzV9O6BB/hLijK+Skl7zeY3URe8spSwbr1w/bN01AWKKjiDe2ciQY1S9OIHa97/3jGr0hf40xgwfC3XanfLwvZFh04vmslJLsR16c3PXV+LaVjQxwuFOf8oSyxo75Q3eJR/SSW+C7xtSZQzpxuJPnmvLZNj4ELwQCH/ckIo4w0lqD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213044>

"git reset [--mixed]" without --quiet refreshes the index in order to
display the "Unstaged changes after reset". When --quiet is given,
that output is suppressed, removing the need to refresh the index.
Other porcelain commands that care about a refreshed index should
already be refreshing it, so running e.g. "git reset -q && git diff"
is still safe.

This commit together with 686b2de (oneway_merge(): only lstat() when
told to update worktree, 2012-12-20) removes all calls to lstat() the
worktree from the command.

This speeds up "git reset -q" a little on the linux-2.6 repo (best
of five, warm cache):

        Before      After
real    0m0.215s    0m0.176s
user    0m0.150s    0m0.130s
sys     0m0.060s    0m0.040s

And with cold cache (best of five):

        Before      After
real    0m11.351s   0m8.420s
user    0m0.230s    0m0.220s
sys     0m0.270s    0m0.060s
---
There is a test case in t7102 called '--mixed refreshes the index',
but it only checks that right output it printed. Is the test case not
testing right or not named right? As you can see, I suspect it's the
name/description that should change.

 builtin/reset.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 9bcad29..a2e69eb 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -109,12 +109,6 @@ static void print_new_head_line(struct commit *commit)
 		printf("\n");
 }
 
-static void update_index_refresh(int flags)
-{
-	refresh_index(&the_index, (flags), NULL, NULL,
-		      _("Unstaged changes after reset:"));
-}
-
 static void update_index_from_diff(struct diff_queue_struct *q,
 		struct diff_options *opt, void *data)
 {
@@ -328,9 +322,9 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				die(_("Could not reset index file to revision '%s'."), rev);
 		}
 
-		if (reset_type == MIXED) /* Report what has not been updated. */
-			update_index_refresh(
-				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
+		if (reset_type == MIXED && !quiet) /* Report what has not been updated. */
+			refresh_index(&the_index, REFRESH_IN_PORCELAIN, NULL, NULL,
+				      _("Unstaged changes after reset:"));
 
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    commit_locked_index(lock))
-- 
1.8.1.rc3.331.g1ef2165
