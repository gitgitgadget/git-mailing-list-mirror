From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/2] fast-import: Handle directories changing into symlinks
Date: Tue, 15 Jun 2010 10:16:01 -0600
Message-ID: <1276618562-24447-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, spearce@spearce.org, Johannes.Schindelin@gmx.de,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 15 18:14:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOYmh-0006bT-MI
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 18:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565Ab0FOQOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 12:14:38 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56637 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622Ab0FOQOh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 12:14:37 -0400
Received: by wyb40 with SMTP id 40so4954494wyb.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 09:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=9E7qscm7EyYSBlx5PzaqPCzP8BnLhhJEz9EWFwLEIQc=;
        b=Eat9c3JX4NRKB+7TVvLCXNZMriwyJHbeZfGgxNobmG4doHTTNJFpP1a0BZwgTCnFHz
         mF7BKCIFuA8KSjhJmhqfqFBJ9U0Tjft020hjchkAHRiQ3b/pkAzcVoQiMhofp45lKM/I
         Np+pbwHGgvbeI6wGkH31dhkBnLo0xKL+57iMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=rAHC91GjgngbqpAYHe1xpMH45Ym1Y9/+X00sDwGZtkO5wzrAVavRBi4YhwPFv9kHa7
         laP4hJBpzFuQjDmSEGWI1tCatCbhViOQBm/tGUNNjIzBxhFJFPHE0uczY2NpBiJdQ11x
         laHm80/92inueReCkiRCM/thhI6rhMZdB+M9U=
Received: by 10.227.146.200 with SMTP id i8mr7339712wbv.169.1276618475673;
        Tue, 15 Jun 2010 09:14:35 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-59-120.hsd1.nm.comcast.net [76.113.59.120])
        by mx.google.com with ESMTPS id l46sm1855900wed.34.2010.06.15.09.14.32
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 15 Jun 2010 09:14:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.339.gd291e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149195>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
I hesitated a bit to put the testcase in t9350-fast-export.sh instead of
t9300-fast-import.sh.  However, this patch fixes a bug where
  fast-export <args> | fast-import
accidentally munges data, and t9300-fast-import.sh has no calls to
fast-export while t9350-fast-export.sh has calls to both fast-export and
fast-import.  If I should design a test for t9300-fast-import.sh instead
of (or in addition to) what I have here, let me know. 

 fast-import.c          |    5 +++++
 t/t9350-fast-export.sh |   24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 129a786..064348e 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1528,6 +1528,11 @@ static int tree_content_remove(
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
 		if (e->name->str_len == n && !strncmp(p, e->name->str_dat, n)) {
+			if (slash1 && S_ISLNK(e->versions[1].mode))
+				/* p was already removed by an earlier change
+				 * of a parent directory to a symlink.
+				 */
+				return 1;
 			if (!slash1 || !S_ISDIR(e->versions[1].mode))
 				goto del_entry;
 			if (!e->tree)
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index d43f37c..1ee1461 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -376,4 +376,28 @@ test_expect_success 'tree_tag-obj'    'git fast-export tree_tag-obj'
 test_expect_success 'tag-obj_tag'     'git fast-export tag-obj_tag'
 test_expect_success 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-obj'
 
+test_expect_success 'directory becomes symlink'        '
+	git init dirtosymlink &&
+	git init result &&
+	(
+		cd dirtosymlink &&
+		mkdir foo &&
+		mkdir bar &&
+		echo hello > foo/world &&
+		echo hello > bar/world &&
+		git add foo/world bar/world &&
+		git commit -q -mone &&
+		git rm -r foo &&
+		ln -s bar foo &&
+		git add foo &&
+		git commit -q -mtwo
+	) &&
+	(
+		cd dirtosymlink &&
+		git fast-export master -- foo |
+		(cd ../result && git fast-import --quiet)
+	) &&
+	(cd result && git show master:foo)
+'
+
 test_done
-- 
1.6.6.1
