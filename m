From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: An interaction with ce_match_stat_basic() and autocrlf
Date: Tue, 8 Jan 2008 08:10:11 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801080748080.3148@woody.linux-foundation.org>
References: <7vfxx8tt1z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 17:11:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCH3S-0007bv-CA
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 17:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbYAHQL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 11:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752093AbYAHQL0
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 11:11:26 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41041 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750927AbYAHQL0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jan 2008 11:11:26 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m08GACnj017685
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 8 Jan 2008 08:10:13 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m08GAB6Y019657;
	Tue, 8 Jan 2008 08:10:12 -0800
In-Reply-To: <7vfxx8tt1z.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.722 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69887>



On Tue, 8 Jan 2008, Junio C Hamano wrote:
> 
> This is caused partly by the breakage in size_only codepath of
> diff.c::diff_populate_filespec().

Only partially.

The more fundamental behaviour (that of git update-index) is caused by 
ie_modified() thinking that when DATA_CHANGED is true, it cannot possibly 
need to call "ce_modified_check_fs()":

>From ie_modified():

        /* Immediately after read-tree or update-index --cacheinfo,
         * the length field is zero.  For other cases the ce_size
         * should match the SHA1 recorded in the index entry.
         */
        if ((changed & DATA_CHANGED) && ce->ce_size != htonl(0))
                return changed;

and that DATA_CHANGED comes from ce_match_stat_basic() which notices that 
the size has changed.

Similarly, I think that the problem with "diff" not realizing they might 
be the same comes from ie_match_stat(), which has a similar problem in not 
realizing that DATA_CHANGED could possibly still mean that it's the same.

This patch should fix it, but I suspect we should think hard about that 
change to ie_modified(), and see what the performance issues are (ie that 
code has tried to avoid doing the more expensive ce_modified_check_fs() 
for a reason).

The change to diff.c is similarly interesting. It is logically wrong to 
use the worktree_file there (since we have to read the object anyway), but 
since "reuse_worktree_file" is also tied into the whole refresh logic, I 
think the diff.c change is correct.

I dunno. This is not meant to be applied, it is meant to be thought about.

		Linus

---
 diff.c       |    2 +-
 read-cache.c |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index b18c140..9f699b7 100644
--- a/diff.c
+++ b/diff.c
@@ -1512,7 +1512,7 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 	ce = active_cache[pos];
 	if ((lstat(name, &st) < 0) ||
 	    !S_ISREG(st.st_mode) || /* careful! */
-	    ce_match_stat(ce, &st, 0) ||
+	    ce_modified(ce, &st, 0) ||
 	    hashcmp(sha1, ce->sha1))
 		return 0;
 	/* we return 1 only when we can stat, it is a regular file,
diff --git a/read-cache.c b/read-cache.c
index 7db5588..e1fc880 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -253,12 +253,14 @@ int ie_modified(struct index_state *istate,
 	if (changed & (MODE_CHANGED | TYPE_CHANGED))
 		return changed;
 
+#if 0
 	/* Immediately after read-tree or update-index --cacheinfo,
 	 * the length field is zero.  For other cases the ce_size
 	 * should match the SHA1 recorded in the index entry.
 	 */
 	if ((changed & DATA_CHANGED) && ce->ce_size != htonl(0))
 		return changed;
+#endif
 
 	changed_fs = ce_modified_check_fs(ce, st);
 	if (changed_fs)
