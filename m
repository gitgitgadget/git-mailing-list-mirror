From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] diff/status: refactor opportunistic index update
Date: Mon, 21 Mar 2011 10:16:10 -0700
Message-ID: <7vtyewqtmk.fsf@alter.siamese.dyndns.org>
References: <AANLkTikV4S51DXLADiRXWqjXdTD1OBLSdKjEWALZ9Ebh@mail.gmail.com>
 <7vipvcs9xt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lasse Makholm <lasse.makholm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 18:19:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1ilD-0008Ly-P2
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 18:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449Ab1CURTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 13:19:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39559 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365Ab1CURTK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 13:19:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E12AD4DB0;
	Mon, 21 Mar 2011 13:20:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=TnTK3jT9VFeHaEPIBqYvHBvFyD0=; b=fTxjs8YlrquMYfk5c27F
	twA6iRhIfQHE2Wfbx0mwfPrsCdB9uU0+068wew4kgIGZuxx75TNbDEtw3VXS+svR
	id8NQAbF/g8T0QPgsHftDYAO7wtLdU7WzoWlVYkuG8gc+ud3C+0IzdfzobPYelXV
	fhZTG4XdkiHDUNawxNqnF4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=CAMgTVdt3OqE0dIU+FlxUtx18sWQcxNTDKNLS1CQfkNwBE
	kLxTKP2sET5IbIEQpS7is/LFD0vgjz2EefZsROIU49lShf8fR/jwmSwXAmqJWloo
	guHplLJ0nUkAfuKHYQ/wXtrTy2kXV0R6NBjamysstTbl+24Dtk6Y12LF3g1SQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BFE004DAB;
	Mon, 21 Mar 2011 13:20:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 92BD54DA9; Mon, 21 Mar 2011
 13:20:38 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C382704-53DF-11E0-A139-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169613>

When we had to refresh the index internally before running diff or status,
we opportunistically updated the $GIT_INDEX_FILE so that later invocation
of git can use the lstat(2) we already did in this invocation.

Make them share a helper function to do so.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 > I think we opportunistically update the .git/index file in "git status" to
 > refresh the stat bits (but we don't error out when we cannot write a new
 > index, as you may be only browsing somebody else's repository with only a
 > read access to it).  It probably should be just the matter of adding a bit
 > of logic to notice that your index is racily clean.
 >
 > Let me cook something real quick.

 builtin/commit.c |    9 ++-------
 builtin/diff.c   |    7 +------
 cache.h          |    1 +
 read-cache.c     |   12 ++++++++++++
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 66fdd22..0b6ce2f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1090,13 +1090,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, s.pathspec, NULL, NULL);
 
 	fd = hold_locked_index(&index_lock, 0);
-	if (0 <= fd) {
-		if (active_cache_changed &&
-		    !write_cache(fd, active_cache, active_nr))
-			commit_locked_index(&index_lock);
-		else
-			rollback_lock_file(&index_lock);
-	}
+	if (0 <= fd)
+		update_index_if_able(&the_index, &index_lock);
 
 	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
 	s.in_merge = in_merge;
diff --git a/builtin/diff.c b/builtin/diff.c
index a43d326..bab4bd9 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -197,12 +197,7 @@ static void refresh_index_quietly(void)
 	discard_cache();
 	read_cache();
 	refresh_cache(REFRESH_QUIET|REFRESH_UNMERGED);
-
-	if (active_cache_changed &&
-	    !write_cache(fd, active_cache, active_nr))
-		commit_locked_index(lock_file);
-
-	rollback_lock_file(lock_file);
+	update_index_if_able(&the_index, lock_file);
 }
 
 static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv)
diff --git a/cache.h b/cache.h
index 2ef2fa3..9a3cc8e 100644
--- a/cache.h
+++ b/cache.h
@@ -520,6 +520,7 @@ extern NORETURN void unable_to_lock_index_die(const char *path, int err);
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
 extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
 extern int commit_lock_file(struct lock_file *);
+extern void update_index_if_able(struct index_state *, struct lock_file *);
 
 extern int hold_locked_index(struct lock_file *, int);
 extern int commit_locked_index(struct lock_file *);
diff --git a/read-cache.c b/read-cache.c
index 1f42473..561dc66 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1545,6 +1545,18 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce)
 	return result;
 }
 
+/*
+ * Opportunisticly update the index but do not complain if we can't
+ */
+void update_index_if_able(struct index_state *istate, struct lock_file *lockfile)
+{
+	if (istate->cache_changed) &&
+	    !write_index(istate, lockfile->fd))
+		commit_locked_index(lockfile);
+	else
+		rollback_lock_file(lockfile);
+}
+
 int write_index(struct index_state *istate, int newfd)
 {
 	git_SHA_CTX c;
-- 
1.7.4.1.554.gfdad8
