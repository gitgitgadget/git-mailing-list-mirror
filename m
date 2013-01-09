From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH 14/19] reset [--mixed]: don't write index file twice
Date: Wed,  9 Jan 2013 00:16:11 -0800
Message-ID: <1357719376-16406-15-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 09:17:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsqqn-0001yR-T4
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 09:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757349Ab3AIIRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 03:17:09 -0500
Received: from mail-yh0-f74.google.com ([209.85.213.74]:54230 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757251Ab3AIIRF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 03:17:05 -0500
Received: by mail-yh0-f74.google.com with SMTP id w68so191102yhw.1
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 00:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=zj0DMzTxdKxtDL2UgxmHlG7lZJpHR6P0SLDuoRS9UnM=;
        b=ZxaTd/MSip4My4PHyP5quR2E1HtqXj11t5tQT78bZOwwdMwC9c3HZnfUjy/N+Umnle
         w1WvVhxU1LQ/+CX/o9FZSD3rc88/o3/J2Sjy5OXxGJ9qFQKnTm8zSBGj689O/vdbPlSU
         M/q5w7sRtWloWqZzcRAMG0nOpB6uDu6dHw3BP3zfI7WHb9RtJaz9wodPUjs3t6YVzOXh
         z+UJyM9vNbr2pavzVX7MdY7bZsMXyIF5IzH7yb43K4bd7BLv+SLEUeC/032B7nQ3bokw
         P2zf0ecjdmao7DGhamG5M7q76/asOpGnl8jhGrLeLMR8J8AH6svMK6IkvIGP3mGLfURc
         aQwg==
X-Received: by 10.100.237.4 with SMTP id k4mr9708135anh.25.1357719424877;
        Wed, 09 Jan 2013 00:17:04 -0800 (PST)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id p19si5739538yhi.1.2013.01.09.00.17.04
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 09 Jan 2013 00:17:04 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id C2B2F82004A;
	Wed,  9 Jan 2013 00:17:04 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 6E612102DA9; Wed,  9 Jan 2013 00:17:04 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.331.g1ef2165
In-Reply-To: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQmqc+e6BEF1FrIMCIHHrSs1r+Ma5t1fkv3nVAVX9twXvwtSlKbzqKXyW0DSkT2jn4v9dr3Mbbdc4+0eUzqSznpzAk3jQhVlRO9UP6eFW4zSWj6sIQrvOh5WBeDtQat4pnfXhwKDFptQwP/sN38rDIv5L38kLhbuZsPuaidJitkqPwF9AqqYx26OviLfMIbSZ3SowLXn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213032>

When doing a mixed reset without paths, the index is locked, read,
reset, and written back as part of the actual reset operation (in
reset_index()). Then, when showing the list of worktree modifications,
we lock the index again, refresh it, and write it.

Change this so we only write the index once, making "git reset" a
little faster. It does mean that the index lock will be held a little
longer, but the difference is small compared to the time spent
refreshing the index.

There is one minor functional difference: We used to say "Could not
write new index file." if the first write failed, and "Could not
refresh index" if the second write failed. Now, we will only use the
first message.

This speeds up "git reset" a little on the linux-2.6 repo (best of
five, warm cache):

        Before      After
real    0m0.239s    0m0.214s
user    0m0.160s    0m0.130s
sys     0m0.070s    0m0.080s
---
 builtin/reset.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 2243b95..254afa9 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -335,6 +335,11 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			err = reset_index(sha1, MIXED, quiet);
 		if (err)
 			die(_("Could not reset index file to revision '%s'."), rev);
+
+		if (reset_type == MIXED) /* Report what has not been updated. */
+			update_index_refresh(
+				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
+
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    commit_locked_index(lock))
 			die(_("Could not write new index file."));
@@ -346,15 +351,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	if (reset_type == HARD && !update_ref_status && !quiet)
 		print_new_head_line(commit);
-	else if (reset_type == MIXED) { /* Report what has not been updated. */
-		struct lock_file *index_lock = xcalloc(1, sizeof(struct lock_file));
-		int fd = hold_locked_index(index_lock, 1);
-		update_index_refresh(
-			quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
-		if (write_cache(fd, active_cache, active_nr) ||
-		    commit_locked_index(index_lock))
-			error("Could not refresh index");
-	}
 
 	remove_branch_state();
 
-- 
1.8.1.rc3.331.g1ef2165
