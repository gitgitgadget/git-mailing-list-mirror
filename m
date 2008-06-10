From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git bugs
Date: Tue, 10 Jun 2008 10:44:43 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806101028040.3101@woody.linux-foundation.org>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ben Lynn <benlynn@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 19:45:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K67uf-0003Jb-6x
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 19:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbYFJRor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 13:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752709AbYFJRor
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 13:44:47 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50517 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751802AbYFJRoq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2008 13:44:46 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5AHiiEH031467
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Jun 2008 10:44:45 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5AHihAJ021600;
	Tue, 10 Jun 2008 10:44:43 -0700
In-Reply-To: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.384 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84530>



On Tue, 10 Jun 2008, Ben Lynn wrote:
> 
> Unfortunately, the solution isn't perfect. Try this:

Heh.

That's just because our "smudge_racily_clean_entry()" uses 0 as the magic 
smudging size.

You can fix this multiple ways. One would be to pick another size that is 
simply less likely (eg ~0 instead), which leaves the theoretical race, and 
just makes it practically impossible to hit (not that I think it's very 
practical to hit already).

The other approach is to know that an empty blob always has a very 
specific SHA1. Here's an trial patch.

		Linus

---
 read-cache.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 8e5fbb6..f83de8c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -138,6 +138,16 @@ static int ce_modified_check_fs(struct cache_entry *ce, struct stat *st)
 	return 0;
 }
 
+static int is_empty_blob_sha1(const unsigned char *sha1)
+{
+	static const unsigned char empty_blob_sha1[20] = {
+		0xe6,0x9d,0xe2,0x9b,0xb2,0xd1,0xd6,0x43,0x4b,0x8b,
+		0x29,0xae,0x77,0x5a,0xd8,0xc2,0xe4,0x8c,0x53,0x91
+	};
+
+	return !hashcmp(sha1, empty_blob_sha1);
+}
+
 static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 {
 	unsigned int changed = 0;
@@ -193,6 +203,12 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 	if (ce->ce_size != (unsigned int) st->st_size)
 		changed |= DATA_CHANGED;
 
+	/* Racily smudged entry? */
+	if (!ce->ce_size) {
+		if (!is_empty_blob_sha1(ce->sha1))
+			changed |= DATA_CHANGED;
+	}
+
 	return changed;
 }
 
