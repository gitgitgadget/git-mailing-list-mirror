From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/3] Avoid doing extra 'lstat()'s for d_type if we have
 an up-to-date cache entry
Date: Thu, 9 Jul 2009 10:13:32 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907091011280.3352@localhost.localdomain>
References: <20090707000500.GA5594@dpotapov.dyndns.org> <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain> <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain> <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain> <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain> <7vskh646bw.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain>
 <7vws6h3ji4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 19:15:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOxCh-0001ui-MS
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 19:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbZGIROe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 13:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752936AbZGIROd
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 13:14:33 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56679 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752892AbZGIROd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 13:14:33 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n69HDWcI032409
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Jul 2009 10:13:34 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n69HDW9F022465;
	Thu, 9 Jul 2009 10:13:32 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vws6h3ji4.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.965 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122994>



> > +	ce = cache_name_exists(path, len, 0);
> > +	if (ce) {
> > +		if (ce_uptodate(ce))
> > +			return ce->ce_mode;
> 
> You return ce->ce_mode for up-to-date entries.  I do not remember what
> ce_uptodate(ce) says for gitlinks, but ce->ce_mode for them would be
> 160000 that is not very kosher to give to S_ISDIR().  I realize that this
> worry actually applies to your patch from yesterday, the one Dmitry
> already tested.

Yeah. I guess we don't have a lot of coverage for subprojects.

Here's an alternative version that just makes the thing return the DT_xyz 
flag rather than the mode (and it returns DT_REG for symlinks too, because 
it knows nobody cares - we only really care about "directory or not")

		Linus

---
 dir.c |   47 ++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index 8a9e7d8..e05b850 100644
--- a/dir.c
+++ b/dir.c
@@ -566,18 +566,55 @@ static int in_pathspec(const char *path, int len, const struct path_simplify *si
 	return 0;
 }
 
+static int get_index_dtype(const char *path, int len)
+{
+	int pos;
+	struct cache_entry *ce;
+
+	ce = cache_name_exists(path, len, 0);
+	if (ce) {
+		if (!ce_uptodate(ce))
+			return DT_UNKNOWN;
+		if (S_ISGITLINK(ce->ce_mode))
+			return DT_DIR;
+		/*
+		 * Nobody actually cares about the
+		 * difference between DT_LNK and DT_REG
+		 */
+		return DT_REG;
+	}
+
+	/* Try to look it up as a directory */
+	pos = cache_name_pos(path, len);
+	if (pos >= 0)
+		return DT_UNKNOWN;
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
+		return DT_DIR;
+	}
+	return DT_UNKNOWN;
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
+	dtype = get_index_dtype(path, len);
+	if (dtype != DT_UNKNOWN)
+		return dtype;
+	if (lstat(path, &st))
 		return dtype;
 	if (S_ISREG(st.st_mode))
 		return DT_REG;
