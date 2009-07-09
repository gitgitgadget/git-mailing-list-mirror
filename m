From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/3] Avoid doing extra 'lstat()'s for d_type if we have
 an up-to-date cache entry
Date: Thu, 9 Jul 2009 08:52:37 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain>
References: <20090707000500.GA5594@dpotapov.dyndns.org> <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain> <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain> <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain> <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain> <7vskh646bw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 17:53:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOvvf-0004Ht-99
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 17:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758417AbZGIPww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 11:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757951AbZGIPwv
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 11:52:51 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48490 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757057AbZGIPwu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 11:52:50 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n69FqcJY024570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Jul 2009 08:52:39 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n69Fqb0D015048;
	Thu, 9 Jul 2009 08:52:38 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vskh646bw.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122983>



On Thu, 9 Jul 2009, Junio C Hamano wrote:
> 
> I was wondering if we could also say that D exists as a directory when we
> know there is D/F in the index and is up to date.

Yeah, that would probably be a good thing, but is slightly slower to look 
up (we have the name hashing for the case-ignoring code anyway, but that 
only works for exact names, so you can't look up directories that way).

You'd have to use the regular binary search for that (or we'd have to 
change it to hash directories too - which we might want to do for other 
reasons, but don't do now).

Something like this?

		Linus

---
 dir.c |   39 ++++++++++++++++++++++++++++++++++-----
 1 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index 8a9e7d8..fb7432e 100644
--- a/dir.c
+++ b/dir.c
@@ -566,18 +566,47 @@ static int in_pathspec(const char *path, int len, const struct path_simplify *si
 	return 0;
 }
 
+static int get_index_mode(const char *path, int len)
+{
+	int pos;
+	struct cache_entry *ce;
+
+	ce = cache_name_exists(path, len, 0);
+	if (ce) {
+		if (ce_uptodate(ce))
+			return ce->ce_mode;
+		return 0;
+	}
+
+	/* Try to look it up as a directory */
+	pos = cache_name_pos(path, len);
+	if (pos >= 0)
+		return 0;
+	pos = -pos-1;
+	while (pos < active_nr) {
+		ce = active_cache[pos++];
+		if (strncmp(ce->name, path, len))
+			break;
+		if (ce->name[len] > '/')
+			break;
+		if (ce->name[len] < '/')
+			continue;
+		if (!ce_uptodate(ce))
+			break;	/* continue? */
+		return S_IFDIR;
+	}
+	return 0;
+}
+
 static int get_dtype(struct dirent *de, const char *path, int len)
 {
 	int dtype = de ? DTYPE(de) : DT_UNKNOWN;
-	struct cache_entry *ce;
 	struct stat st;
 
 	if (dtype != DT_UNKNOWN)
 		return dtype;
-	ce = cache_name_exists(path, len, 0);
-	if (ce && ce_uptodate(ce))
-		st.st_mode = ce->ce_mode;
-	else if (lstat(path, &st))
+	st.st_mode = get_index_mode(path, len);
+	if (!st.st_mode && lstat(path, &st))
 		return dtype;
 	if (S_ISREG(st.st_mode))
 		return DT_REG;
