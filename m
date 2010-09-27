From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH] wt-status.c: don't leak directory entries when processing untracked,ignored
Date: Sun, 26 Sep 2010 21:49:13 -0500
Message-ID: <1285555753-15858-1-git-send-email-drafnel@gmail.com>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 27 04:49:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P03mt-0005DR-8v
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 04:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758734Ab0I0Ctd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 22:49:33 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52564 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758248Ab0I0Ctc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 22:49:32 -0400
Received: by gwj17 with SMTP id 17so1408324gwj.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 19:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=3KuLygBDkPbXoNhskgYLMaiLLy/+GWm2iWOxBDQ+wKs=;
        b=ILrkR2ec8OEEt5nD15z/tH4x2JH8e/bUoZnFPEgwtHXxwXXorvjxZX+MRxMgNPmUBf
         3O1r2HElg7kCydF+JjwnLBHh9DQQNEeJd4UNlGw1mwryq1rIrZQGmp8Ds/ot/ocJVTiG
         bqZ/rlDmt6ML5aHJRh6Nc+upqfY4S5X+acHTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=dMa3R93pdKrCCOd65TkvCKhHUT156Y04/H9/AKHACFHDIXL77Hwb+jUk6kr6DLI4D4
         OdT9S2peCU8c1bnPCN4v73YGoSWE6wK1Gem3mLBf4s3QrPmPF3RNnuf4Zv7zDoH7w0xB
         g+WDcI7DPmWU3izqYCthlqO0o1lcAhOfq53RU=
Received: by 10.150.47.37 with SMTP id u37mr8147504ybu.47.1285555771415;
        Sun, 26 Sep 2010 19:49:31 -0700 (PDT)
Received: from localhost.localdomain ([96.19.141.3])
        by mx.google.com with ESMTPS id q21sm7575552ybk.23.2010.09.26.19.49.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 19:49:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.g6772.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157288>

When iterating through the list of directory entries, searching for
untracked entries, only the entries added to the string_list were free'd.
The rest (tracked or not matching the pathspec) were leaked.

Ditto for the "ignored" loop.

Rearrange the loops so that all entries are free'd.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 wt-status.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 54b6b03..fc2438f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -390,11 +390,9 @@ static void wt_status_collect_untracked(struct wt_status *s)
 	fill_directory(&dir, s->pathspec);
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
-		if (!cache_name_is_other(ent->name, ent->len))
-			continue;
-		if (!match_pathspec(s->pathspec, ent->name, ent->len, 0, NULL))
-			continue;
-		string_list_insert(&s->untracked, ent->name);
+		if (cache_name_is_other(ent->name, ent->len) &&
+		    match_pathspec(s->pathspec, ent->name, ent->len, 0, NULL))
+			string_list_insert(&s->untracked, ent->name);
 		free(ent);
 	}
 
@@ -404,11 +402,9 @@ static void wt_status_collect_untracked(struct wt_status *s)
 		fill_directory(&dir, s->pathspec);
 		for (i = 0; i < dir.nr; i++) {
 			struct dir_entry *ent = dir.entries[i];
-			if (!cache_name_is_other(ent->name, ent->len))
-				continue;
-			if (!match_pathspec(s->pathspec, ent->name, ent->len, 0, NULL))
-				continue;
-			string_list_insert(&s->ignored, ent->name);
+			if (cache_name_is_other(ent->name, ent->len) &&
+			    match_pathspec(s->pathspec, ent->name, ent->len, 0, NULL))
+				string_list_insert(&s->ignored, ent->name);
 			free(ent);
 		}
 	}
-- 
1.7.3.1.geb284
