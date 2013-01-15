From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 14/19] reset [--mixed]: only write index file once
Date: Mon, 14 Jan 2013 21:47:46 -0800
Message-ID: <1358228871-7142-15-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Matt Kraai <kraai@ftbfs.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 06:49:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuzOf-0007Y3-JP
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 06:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755935Ab3AOFsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 00:48:51 -0500
Received: from mail-gg0-f202.google.com ([209.85.161.202]:35497 "EHLO
	mail-gg0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755596Ab3AOFs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 00:48:27 -0500
Received: by mail-gg0-f202.google.com with SMTP id k1so588146ggn.3
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 21:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=xuDH/3uKg9tJ65XqzmHZRAhCfg5x3mJcRWq/hJYCW4I=;
        b=RfQE4eygPNeCGI4sEkeRKndcv7nVouR0gXLISWbjn+KW5XPwaaU/ntHKaHwubUB6Pl
         H6uOpKaO/tg6yXWOai3gj69V5Rr10PJ3SgAfcIVmr2pUNgMTOVMtXmom/rB8BPPdkYI8
         kJ9qhJg2twpUTFKUZ47k8Ml01qXT/k0ZsL6f6aP2TpbEDuPVd5BWPElhmMgQimJcGIng
         Uw5NJlSgTqzi4ZyskqpQXmUa4ShfSnj7vfQ+GWtYoS1ghIMlEye8Bd23lVFR93BkqGyP
         KCx3rxwW8TlOFiI25BaFfetHM0SR6j5LF6/FQEclqbwk0MdMwjVYTRXZyBU7ZVzZ07gn
         ulww==
X-Received: by 10.236.124.102 with SMTP id w66mr48884120yhh.38.1358228906923;
        Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id h36si451526anq.0.2013.01.14.21.48.26
        (version=TLSv1 cipher=AES128-SHA bits=128/128);
        Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id CC2BE82004A;
	Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 98B3E101449; Mon, 14 Jan 2013 21:48:26 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.454.gce43f05
In-Reply-To: <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQlq3N4UO3BSB6JuQHHGHcQEMmHGbYvHi4FNTIo2jtCIpJZ4iQWWN57XI0v5WgLLza+rmM+anjooW8HhZvZEUoNAMZ2wsBlzxqlxeK2UCHGCKmzVIFh4eD3MSqbB02wM+FkVyZ0cl/1xla6MHHkcHrSONooubvif/IauuGkgNmKndAYLb/afY/JePWmMyI1bLAaTqL0x
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213582>

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

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
 builtin/reset.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index c1d6ef2..e8a3e41 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -336,6 +336,11 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
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
@@ -347,15 +352,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
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
1.8.1.1.454.gce43f05
