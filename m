From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH] Fix buffer overflow in git-grep
Date: Wed, 16 Jul 2008 14:15:45 +0400
Message-ID: <1216203345-18233-1-git-send-email-dpotapov@gmail.com>
Cc: Dmitry Potapov <dpotapov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 12:16:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ442-0002TU-VF
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 12:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755969AbYGPKPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 06:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755970AbYGPKPw
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 06:15:52 -0400
Received: from gv-out-0910.google.com ([216.239.58.189]:12721 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755706AbYGPKPv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 06:15:51 -0400
Received: by gv-out-0910.google.com with SMTP id e6so1022161gvc.37
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 03:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=o0dpKl9rBfXKZQ/B7drnEZQ3vHuPyXD/FMY827z/w1A=;
        b=TH6rsPHUpj+k9Ot8qCF/K2+GCLK1I8cDEDFk4MEi4yY9P5Qe+2SggVOpW9GWZVL1w+
         7Zqsz8RkjvCmKqAy8OU1SnCPAATvnR7ftF4qovE2qBYmZDkBrYtanGGjlYuBuLLT8eP0
         fcOteVLrixFwcylxNWyTC0QwoOj9XddBGXIIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=qt5eg9kQ0xGfHGwMaLvkgVb/bp0DQwy0TcJQEkURoA99+jGBopXCh/tzuDlxEz2GUV
         wkL/LLdCHVJq49x18jAsWow/avDnRwlyS9RZjo6BPeyDPgsBVHMsheCwDqn4Lm7ny5Bn
         JxgGKFbMFqxFPUuqC1U3Juu+Qz0P8+as2fXHw=
Received: by 10.86.54.3 with SMTP id c3mr1768077fga.55.1216203350067;
        Wed, 16 Jul 2008 03:15:50 -0700 (PDT)
Received: from localhost ( [85.141.237.219])
        by mx.google.com with ESMTPS id d4sm981211fga.8.2008.07.16.03.15.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Jul 2008 03:15:49 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3.1.gb5587a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88655>

If PATH_MAX on your system is smaller than any path stored in the git
repository, that can cause memory corruption inside of the grep_tree
function used by git-grep.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 builtin-grep.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index ef29910..530a53d 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -441,14 +441,17 @@ static int grep_tree(struct grep_opt *opt, const char **paths,
 	len = strlen(path_buf);
 
 	while (tree_entry(tree, &entry)) {
-		strcpy(path_buf + len, entry.path);
+		int te_len = tree_entry_len(entry.path, entry.sha1);
+		if (len + te_len >= PATH_MAX + tn_len)
+			die ("path too long: %s", path_buf+tn_len);
+		memcpy(path_buf + len, entry.path, te_len);
 
 		if (S_ISDIR(entry.mode))
 			/* Match "abc/" against pathspec to
 			 * decide if we want to descend into "abc"
 			 * directory.
 			 */
-			strcpy(path_buf + len + tree_entry_len(entry.path, entry.sha1), "/");
+			strcpy(path_buf + len + te_len, "/");
 
 		if (!pathspec_matches(paths, down))
 			;
-- 
1.5.6.3.1.gb5587a
