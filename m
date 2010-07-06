From: newren@gmail.com
Subject: [PATCHv2 5/5] fast-import: Fix minor data-loss issue with directories becoming symlinks
Date: Tue,  6 Jul 2010 12:51:35 -0600
Message-ID: <1278442295-23033-6-git-send-email-newren@gmail.com>
References: <1278442295-23033-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, spearce@spearce.org, agladysh@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 06 20:44:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWD8R-0007Kd-K5
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 20:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754974Ab0GFSoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 14:44:16 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57951 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591Ab0GFSoM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 14:44:12 -0400
Received: by mail-pv0-f174.google.com with SMTP id 7so2756986pvc.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 11:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=S3pzrZvum+yzFypCZx6DBmhXi+RIhB7ahn7nVfu5260=;
        b=V0lwR4j4OUq8KoE1mp/CJz45GTDyx99D7TcfYRHZWnteJlzTi4Eznvrx88qHOaVUoR
         5SwYkI8c5FOz3JUdrs318jZm+qNUF4PtkGoXbMbtZ5iIAE4zbhRLMxECg+/pBQ/dvRCJ
         B7IH/BA3rTPb3hu6z4uTv8sPY2rWTM3WgKPXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kw/dWY0YlUTdK2fuEgOG/Z/Kek/xS1ln2LQJBpgDqWCc+oAOjJAkHs2Ez0J7pb5m16
         u/u6+3t0ZQFGSk9891Y5s1OYNi8xow1iGrX1/jee+dRVMJodAVc16rHMo8TsqEzFOqkV
         UVdWNZrULvhc+d8d8M5iUsBh8uUdxQGzJInac=
Received: by 10.114.112.3 with SMTP id k3mr5791275wac.199.1278441852297;
        Tue, 06 Jul 2010 11:44:12 -0700 (PDT)
Received: from localhost.localdomain ([76.113.59.120])
        by mx.google.com with ESMTPS id c24sm86219693wam.7.2010.07.06.11.44.10
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 11:44:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1.9.g45c1c
In-Reply-To: <1278442295-23033-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150390>

From: Elijah Newren <newren@gmail.com>

When fast-export runs across a directory changing to a symlink, it will
output the changes in the form
  M 120000 :239821 dir-changing-to-symlink
  D dir-changing-to-symlink/filename1
When fast-import sees the first line, it deletes the directory named
dir-changing-to-symlink (and any files below it) and creates a symlink in
its place.  When fast-import came across the second line, it was previously
trying to remove the file and relevant leading directories in
tree_content_remove(), and as a side effect it would delete the symlink
that was just created.  This resulted in the symlink silently missing from
the resulting repository.

We fix this by ignoring file deletions underneath directory names that
correspond to symlinks.  This can also be viewed as a minor optimization:
since there cannot be a symlink and a directory with the same name in the
same directory, the file clearly can't exist so nothing needs to be done to
delete it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 fast-import.c          |    5 +++++
 t/t9350-fast-export.sh |    2 +-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 309f2c5..10462d8 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1528,6 +1528,11 @@ static int tree_content_remove(
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
 		if (e->name->str_len == n && !strncmp(p, e->name->str_dat, n)) {
+			if (slash1 && S_ISLNK(e->versions[1].mode))
+				/* If a parent directory of p is a symlink, then
+				 * p cannot exist and need not be deleted.
+				 */
+				return 1;
 			if (!slash1 || !S_ISDIR(e->versions[1].mode))
 				goto del_entry;
 			if (!e->tree)
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 69179c6..1ee1461 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -376,7 +376,7 @@ test_expect_success 'tree_tag-obj'    'git fast-export tree_tag-obj'
 test_expect_success 'tag-obj_tag'     'git fast-export tag-obj_tag'
 test_expect_success 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-obj'
 
-test_expect_failure 'directory becomes symlink'        '
+test_expect_success 'directory becomes symlink'        '
 	git init dirtosymlink &&
 	git init result &&
 	(
-- 
1.7.1.1.6.gc3cd6
