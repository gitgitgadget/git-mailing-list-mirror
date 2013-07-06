From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] lockfile: fix buffer overflow in path handling
Date: Sat,  6 Jul 2013 21:48:52 +0200
Message-ID: <1373140132-12351-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 06 21:49:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvYUL-0001Q5-1R
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jul 2013 21:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757Ab3GFTtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 15:49:39 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:46407 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752460Ab3GFTtf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Jul 2013 15:49:35 -0400
X-AuditID: 1207440e-b7f0f6d0000043b7-1f-51d874ce6a1c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 14.38.17335.EC478D15; Sat,  6 Jul 2013 15:49:34 -0400 (EDT)
Received: from michael.fritz.box (p57A24089.dip0.t-ipconnect.de [87.162.64.137])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r66JnQSC023444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 6 Jul 2013 15:49:33 -0400
X-Mailer: git-send-email 1.8.3.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsUixO6iqHuu5EagQdM2U4uuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M5oa97CWrBTrOLX4xvsDYwN
	Ql2MnBwSAiYS77Y9ZoKwxSQu3FvP1sXIxSEkcJlRYv++q6wQznkmif+fjzCDVLEJ6Eos6mkG
	6xARUJOY2HaIBcRmFnCQ2Py5kbGLkYNDWMBeYtM/BZAwi4CqxNWud+wgNq+Ai8T2L1fZIZYp
	SCz7spZ5AiP3AkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6xnq5mSV6qSmlmxghvufbwdi+
	XuYQowAHoxIPb8LFa4FCrIllxZW5hxglOZiURHkPFd8IFOJLyk+pzEgszogvKs1JLT7EKMHB
	rCTCW3jqeqAQb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mClwcY4kKC
	RanpqRVpmTklCGkmDk4QwQWygQdow3eQ7bzFBYm5xZnpEEWnGBWlxHnZQCYIgCQySvPgBsCi
	9BWjONA/wrwPQNp5gBEO1/0KaDAT0OCu+9dABpckIqSkGhgb335jqs3rEb6wTGDe5M4NZz4z
	ckbP3Pev6r52/FH7ayy5elOCnLtbTkWzedqVysgdepPEnXTkUOmdNN/pT0rXCwtNF10+/+OV
	neotwi9Kf/ROXyRy8v5CHjX73df+uLmoheUlVt9+0vcqzcjkvIf19R8x2u9WiApoXe/q+Z7Q
	G26zUO71bxslluKMREMt5qLiRAB4KqpvrQIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229705>

The path of the file to be locked is held in lock_file::filename,
which is a fixed-length buffer of length PATH_MAX.  This buffer is
also (temporarily) used to hold the path of the lock file, which is
the path of the file being locked plus ".lock".  Because of this, the
path of the file being locked must be less than (PATH_MAX - 5)
characters long (5 chars are needed for ".lock" and one character for
the NUL terminator).

On entry into lock_file(), the path length was only verified to be
less than PATH_MAX characters, not less than (PATH_MAX - 5)
characters.

When and if resolve_symlink() is called, then that function is
correctly told to treat the buffer as (PATH_MAX - 5) characters long.
This part is correct.  However:

* If LOCK_NODEREF was specified, then resolve_symlink() is never
  called.

* If resolve_symlink() is called but the path is not a symlink, then
  the length check is never applied.

So it is possible for a path with length (PATH_MAX - 5 <= len <
PATH_MAX) to make it through the checks.  When ".lock" is strcat()ted
to such a path, the lock_file::filename buffer is overflowed.

Fix the problem by adding a check when entering lock_file() that the
original path is less than (PATH_MAX - 5) characters.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This patch applies to maint.  I discovered it when working on
something else.  From a brief check of history, it looks like this
code has always been vulnerable to buffer overflows in one way or
another.

I haven't tried to evaluate whether this problem could be exploited
remotely.  Even if so, the ramifications are likely to be limited to
denial-of-service, because the data that are written past the end of
the buffer are not under the control of the user; they would be one of
the strings "lock\0", "ock\0", "ck\0", "k\0", or "\0", depending on
the length of the path to be locked.

I'm thinking of rewriting this code to use strbufs to prevent similar
problems in the future, but that is a more extensive change that
wouldn't be appropriate for maint.

 lockfile.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index c6fb77b..3ac49cb 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -124,13 +124,13 @@ static char *resolve_symlink(char *p, size_t s)
 
 static int lock_file(struct lock_file *lk, const char *path, int flags)
 {
-	if (strlen(path) >= sizeof(lk->filename))
-		return -1;
-	strcpy(lk->filename, path);
 	/*
 	 * subtract 5 from size to make sure there's room for adding
 	 * ".lock" for the lock file name
 	 */
+	if (strlen(path) >= sizeof(lk->filename)-5)
+		return -1;
+	strcpy(lk->filename, path);
 	if (!(flags & LOCK_NODEREF))
 		resolve_symlink(lk->filename, sizeof(lk->filename)-5);
 	strcat(lk->filename, ".lock");
-- 
1.8.3.2
