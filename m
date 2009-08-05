From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 0/5] Revamping "git status"
Date: Wed, 5 Aug 2009 20:52:26 +0200
Message-ID: <200908052052.28067.trast@student.ethz.ch>
References: <1249463746-21538-1-git-send-email-gitster@pobox.com> <200908051940.48110.trast@student.ethz.ch> <7v3a869lw1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 20:53:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYlbb-00019c-5J
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 20:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbZHESwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 14:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144AbZHESwm
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 14:52:42 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:7016 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752143AbZHESwk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 14:52:40 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Wed, 5 Aug
 2009 20:52:39 +0200
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Wed, 5 Aug
 2009 20:52:39 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.2.98; x86_64; ; )
In-Reply-To: <7v3a869lw1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124951>

Junio C Hamano wrote:
> 
> -	while (pos <= active_nr) {
> +	while (pos < active_nr) {

Thanks, that fixes it.

It gives a weird output now, however:

  # On branch side
  # Unmerged paths:
  #   (use "git reset HEAD <file>..." to unstage)
  #   (use "git add <file>..." to mark resolution)
  #
  #	deleted by us       : foo
  #
  # Changed but not updated:
  #   (use "git add <file>..." to update what will be committed)
  #   (use "git checkout -- <file>..." to discard changes in working directory)
  #
  #
  no changes added to commit (use "git add" and/or "git commit -a")

So it detects there are worktree changes, but then decides not to show
them because it's an unmerged entry.  I think the following should go
in 3/5, but note that I haven't looked at the rest of the code to
check if it breaks anything:

-- 8< --
diff --git i/wt-status.c w/wt-status.c
index 6370fe2..5a68297 100644
--- i/wt-status.c
+++ w/wt-status.c
@@ -400,7 +400,8 @@ static int wt_status_check_worktree_changes(struct wt_status *s)
 	for (i = 0; i < s->change.nr; i++) {
 		struct wt_status_change_data *d;
 		d = s->change.items[i].util;
-		if (!d->worktree_status)
+		if (!d->worktree_status
+		    || d->index_status == DIFF_STATUS_UNMERGED)
 			continue;
 		changes = 1;
 		if (d->worktree_status == DIFF_STATUS_DELETED)
-- >8 --

And with that fixed, the test I posted earlier should be changed to
the following so that it checks the output (the old version detects
failure even for a working git-status, because that exits 1):

-- 8< --
diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index 5ad2cd1..76b20b2 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -28,4 +28,29 @@ test_expect_success 'Report new path with conflict' '
 	test_cmp expect actual
 '
 
+cat > expect <<EOF
+# On branch side
+# Unmerged paths:
+#   (use "git reset HEAD <file>..." to unstage)
+#   (use "git add <file>..." to mark resolution)
+#
+#	deleted by us       : foo
+#
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
+
+test_expect_success 'M/D conflict does not segfault' '
+	mkdir mdconflict &&
+	cd mdconflict &&
+	git init &&
+	test_commit initial foo '' &&
+	test_commit modify foo foo &&
+	git checkout -b side HEAD^ &&
+	git rm foo &&
+	git commit -m delete &&
+	test_must_fail git merge master &&
+	test_must_fail git status > ../actual &&
+	test_cmp ../expect ../actual
+'
+
 test_done
-- >8 --

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
