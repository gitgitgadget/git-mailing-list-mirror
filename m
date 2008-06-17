From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 'setup_work_tree()' considered harmful
Date: Mon, 16 Jun 2008 17:52:03 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806161746170.2949@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806161723081.2949@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 17 02:53:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8PRs-0005en-F7
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 02:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbYFQAwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 20:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbYFQAwZ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 20:52:25 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60991 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750911AbYFQAwY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jun 2008 20:52:24 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5H0q4pQ019632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 16 Jun 2008 17:52:05 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5H0q3tG022540;
	Mon, 16 Jun 2008 17:52:03 -0700
In-Reply-To: <alpine.LFD.1.10.0806161723081.2949@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.359 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85252>



On Mon, 16 Jun 2008, Linus Torvalds wrote:
> 
> After that, I fixed "write_loose_object()" to not unnecessarily try to 
> open a git object file, because every single caller has already done a 
> "has_sha1_file(sha1)" or "has_loose_object(sha1)" check before calling 
> that function, so trying to open it again is just pointless.

In case anybody cares, the obvious diff for this part is appended. The 
FIXME! was wrong anyway - any collision detection needs to be done by the 
callers when they do the "do we already have this object". Doing it in 
write_loose_object() is too late (not to mention the wrong place to try to 
do so anyway - not all callers generate new objects: some callers just 
turn a packed object into a loose one).

			Linus

---
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Jun 2008 17:17:10 -0700
Subject: [PATCH] write_loose_object: don't bother trying to read an old object

Before even calling this, all callers have done a "has_sha1_file(sha1)"
or "has_loose_object(sha1)" check, so there is no point in doing a
second check.

If something races with us on object creation, we handle that in the
final link() that moves it to the right place.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 sha1_file.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index f9ec069..4255099 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2160,20 +2160,6 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	static char tmpfile[PATH_MAX];
 
 	filename = sha1_file_name(sha1);
-	fd = open(filename, O_RDONLY);
-	if (fd >= 0) {
-		/*
-		 * FIXME!!! We might do collision checking here, but we'd
-		 * need to uncompress the old file and check it. Later.
-		 */
-		close(fd);
-		return 0;
-	}
-
-	if (errno != ENOENT) {
-		return error("sha1 file %s: %s\n", filename, strerror(errno));
-	}
-
 	fd = create_tmpfile(tmpfile, sizeof(tmpfile), filename);
 	if (fd < 0) {
 		if (errno == EPERM)
-- 
1.5.6.rc3.7.g336d0.dirty
