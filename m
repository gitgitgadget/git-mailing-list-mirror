From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] Demonstrate bugs when a directory is replaced with
 a symlink
Date: Wed, 29 Jul 2009 15:08:12 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907291440480.3161@localhost.localdomain>
References: <1248819198-13921-1-git-send-email-james.e.pickens@intel.com> <1248819198-13921-2-git-send-email-james.e.pickens@intel.com> <4A70062A.4040008@drmicha.warpmail.net> <7v4osvyjl2.fsf@alter.siamese.dyndns.org> <3BA20DF9B35F384F8B7395B001EC3FB342402AD9@azsmsx507.amr.corp.intel.com>
 <7v63dbuyru.fsf@alter.siamese.dyndns.org> <3BA20DF9B35F384F8B7395B001EC3FB342402D3C@azsmsx507.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Kjetil Barvik <barvik@broadpark.no>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: "Pickens, James E" <james.e.pickens@intel.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 00:09:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWHKs-00069z-Cz
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 00:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248AbZG2WJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 18:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754192AbZG2WJM
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 18:09:12 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42064 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751581AbZG2WJL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 18:09:11 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6TM8C8T008093
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 29 Jul 2009 15:08:13 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6TM8CBZ025754;
	Wed, 29 Jul 2009 15:08:12 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <3BA20DF9B35F384F8B7395B001EC3FB342402D3C@azsmsx507.amr.corp.intel.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.968 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124396>



On Wed, 29 Jul 2009, Pickens, James E wrote:
>
> This test creates two directories, a/b and a/b-2, then replaces a/b with
> a symlink to a/b-2, then merges that change into the 'baseline' commit,
> which contains an unrelated change.

Great tests.

This patch should fix the 'checkout' issue.

I made it use a new generic helper function ("check_path()"), since there 
are other cases like this that use just 'lstat()', and I bet we want to 
change that.

The 'merge' issue is different, though: it's not due to a blind 'lstat()', 
but due to a blind 'unlink()' done by 'remove_path()'. I think 
'remove_path()' should be taught to look for symlinks, and remove just the 
symlink - but that's a bit more work, especially since the symlink cache 
doesn't seem to expose any way to get the "what is the first symlink path" 
information.

Kjetil, can you look at that? 

		Linus

---
 cache.h |    3 +++
 entry.c |   15 ++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index e6c7f33..9222774 100644
--- a/cache.h
+++ b/cache.h
@@ -468,6 +468,9 @@ extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_obje
 extern int index_path(unsigned char *sha1, const char *path, struct stat *st, int write_object);
 extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 
+/* "careful lstat()" */
+extern int check_path(const char *path, int len, struct stat *st);
+
 #define REFRESH_REALLY		0x0001	/* ignore_valid */
 #define REFRESH_UNMERGED	0x0002	/* allow unmerged */
 #define REFRESH_QUIET		0x0004	/* be quiet about it */
diff --git a/entry.c b/entry.c
index d3e86c7..f276cf3 100644
--- a/entry.c
+++ b/entry.c
@@ -175,6 +175,19 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 	return 0;
 }
 
+/*
+ * This is like 'lstat()', except it refuses to follow symlinks
+ * in the path.
+ */
+int check_path(const char *path, int len, struct stat *st)
+{
+	if (has_symlink_leading_path(path, len)) {
+		errno = ENOENT;
+		return -1;
+	}
+	return lstat(path, st);
+}
+
 int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath)
 {
 	static char path[PATH_MAX + 1];
@@ -188,7 +201,7 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 	strcpy(path + len, ce->name);
 	len += ce_namelen(ce);
 
-	if (!lstat(path, &st)) {
+	if (!check_path(path, len, &st)) {
 		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID);
 		if (!changed)
 			return 0;
