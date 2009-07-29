From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] Demonstrate bugs when a directory is replaced with
 a symlink
Date: Wed, 29 Jul 2009 16:58:53 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907291656420.3161@localhost.localdomain>
References: <1248819198-13921-1-git-send-email-james.e.pickens@intel.com> <1248819198-13921-2-git-send-email-james.e.pickens@intel.com> <4A70062A.4040008@drmicha.warpmail.net> <7v4osvyjl2.fsf@alter.siamese.dyndns.org> <3BA20DF9B35F384F8B7395B001EC3FB342402AD9@azsmsx507.amr.corp.intel.com>
 <7v63dbuyru.fsf@alter.siamese.dyndns.org> <3BA20DF9B35F384F8B7395B001EC3FB342402D3C@azsmsx507.amr.corp.intel.com> <alpine.LFD.2.01.0907291440480.3161@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Kjetil Barvik <barvik@broadpark.no>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: "Pickens, James E" <james.e.pickens@intel.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 01:59:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWJ3i-0008Og-OE
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 01:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754030AbZG2X7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 19:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753965AbZG2X7b
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 19:59:31 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48669 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752935AbZG2X7a (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 19:59:30 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6TNwrbD016542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 29 Jul 2009 16:58:55 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6TNwrc9010816;
	Wed, 29 Jul 2009 16:58:53 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907291440480.3161@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.968 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124412>



On Wed, 29 Jul 2009, Linus Torvalds wrote:
>
> The 'merge' issue is different, though: it's not due to a blind 'lstat()', 
> but due to a blind 'unlink()' done by 'remove_path()'. I think 
> 'remove_path()' should be taught to look for symlinks, and remove just the 
> symlink - but that's a bit more work, especially since the symlink cache 
> doesn't seem to expose any way to get the "what is the first symlink path" 
> information.
> 
> Kjetil, can you look at that? 

Hmm... This looks like it should do it.

It doesn't make the test _pass_ (we don't seem to be creating a/b-2/c/d 
properly - I haven't checked why yet, but I suspect it is becasue we think 
it already exists due to the symlinked version lstat'ing fine), but it 
seems to do the right thing.

		Linus

---
 dir.c      |   20 --------------------
 symlinks.c |   26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/dir.c b/dir.c
index e05b850..2204826 100644
--- a/dir.c
+++ b/dir.c
@@ -911,23 +911,3 @@ void setup_standard_excludes(struct dir_struct *dir)
 	if (excludes_file && !access(excludes_file, R_OK))
 		add_excludes_from_file(dir, excludes_file);
 }
-
-int remove_path(const char *name)
-{
-	char *slash;
-
-	if (unlink(name) && errno != ENOENT)
-		return -1;
-
-	slash = strrchr(name, '/');
-	if (slash) {
-		char *dirs = xstrdup(name);
-		slash = dirs + (slash - name);
-		do {
-			*slash = '\0';
-		} while (rmdir(dirs) && (slash = strrchr(dirs, '/')));
-		free(dirs);
-	}
-	return 0;
-}
-
diff --git a/symlinks.c b/symlinks.c
index 4bdded3..349c8d5 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -306,3 +306,29 @@ void remove_scheduled_dirs(void)
 {
 	do_remove_scheduled_dirs(0);
 }
+
+int remove_path(const char *name)
+{
+	char *slash;
+
+	/*
+	 * If we have a leading symlink, we remove
+	 * just the symlink!
+	 */
+	if (has_symlink_leading_path(name, strlen(name)))
+		name = default_cache.path;
+
+	if (unlink(name) && errno != ENOENT)
+		return -1;
+
+	slash = strrchr(name, '/');
+	if (slash) {
+		char *dirs = xstrdup(name);
+		slash = dirs + (slash - name);
+		do {
+			*slash = '\0';
+		} while (rmdir(dirs) && (slash = strrchr(dirs, '/')));
+		free(dirs);
+	}
+	return 0;
+}
