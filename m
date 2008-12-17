From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4/5] Make 'diff_populate_filespec()' use the new
 'strbuf_readlink()'
Date: Wed, 17 Dec 2008 10:44:06 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812171043440.14014@localhost.localdomain>
References: <alpine.LFD.2.00.0812171034520.14014@localhost.localdomain> <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain> <alpine.LFD.2.00.0812171042500.14014@localhost.localdomain> <alpine.LFD.2.00.0812171043180.14014@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 19:46:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD1PA-0004q8-MX
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 19:45:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbYLQSoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 13:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbYLQSoj
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 13:44:39 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57988 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751199AbYLQSoi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Dec 2008 13:44:38 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBHIi7C4030889
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Dec 2008 10:44:08 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBHIi6ps009991;
	Wed, 17 Dec 2008 10:44:06 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0812171043180.14014@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.923 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103369>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Dec 2008 10:26:13 -0800

This makes all tests pass on a system where 'lstat()' has been hacked to
return bogus data in st_size for symlinks.

Of course, the test coverage isn't complete, but it's a good baseline.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 diff.c |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index afefe08..4b2029c 100644
--- a/diff.c
+++ b/diff.c
@@ -1773,19 +1773,17 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 		s->size = xsize_t(st.st_size);
 		if (!s->size)
 			goto empty;
-		if (size_only)
-			return 0;
 		if (S_ISLNK(st.st_mode)) {
-			int ret;
-			s->data = xmalloc(s->size);
-			s->should_free = 1;
-			ret = readlink(s->path, s->data, s->size);
-			if (ret < 0) {
-				free(s->data);
+			struct strbuf sb = STRBUF_INIT;
+
+			if (strbuf_readlink(&sb, s->path, s->size))
 				goto err_empty;
-			}
+			s->data = strbuf_detach(&sb, &s->size);
+			s->should_free = 1;
 			return 0;
 		}
+		if (size_only)
+			return 0;
 		fd = open(s->path, O_RDONLY);
 		if (fd < 0)
 			goto err_empty;
-- 
1.6.1.rc3.3.gcc3e3
