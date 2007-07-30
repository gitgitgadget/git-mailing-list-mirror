From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Efficient way to import snapshots?
Date: Mon, 30 Jul 2007 14:55:15 -0700
Message-ID: <7vy7gximkc.fsf@assigned-by-dhcp.cox.net>
References: <20070730180710.GA64467@nowhere>
	<alpine.LFD.0.999.0707301144180.4161@woody.linux-foundation.org>
	<20070730192922.GB64467@nowhere>
	<alpine.LFD.0.999.0707301240330.4161@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Craig Boston <craig@olyun.gank.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 23:55:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFdCz-00025x-TX
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 23:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968049AbXG3VzT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 17:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938298AbXG3VzS
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 17:55:18 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:60866 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932308AbXG3VzR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 17:55:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070730215517.KNEL23215.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Mon, 30 Jul 2007 17:55:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VxvG1X0021kojtg0000000; Mon, 30 Jul 2007 17:55:16 -0400
In-Reply-To: <alpine.LFD.0.999.0707301240330.4161@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 30 Jul 2007 12:52:52 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54282>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Junio? I _thought_ we already took the index into account with "git add", 
> but we obviously don't. 

I think 366bfcb6 "broke" it by moving read_cache() call down,
because it wanted the directory walking code to grab paths that
are already in the index.  The change serves its purpose, but
introduces this regression now the responsibility of avoiding
unnecessary reindexing by matching the cached stat is shifted
nowhere.

We would need to do something like this patch, perhaps?  This
function has three callers, two in builtin-add and another in
builtin-mv.

---
 read-cache.c  |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index a363f31..c346d88 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -380,7 +380,7 @@ static int index_name_pos_also_unmerged(struct index_state *istate,
 
 int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 {
-	int size, namelen;
+	int size, namelen, pos;
 	struct stat st;
 	struct cache_entry *ce;
 
@@ -414,6 +414,13 @@ int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 		ce->ce_mode = ce_mode_from_stat(ent, st.st_mode);
 	}
 
+	pos = index_name_pos(istate, ce->name, namelen);
+	if (0 <= pos && !ie_modified(istate, istate->cache[pos], &st, 1)) {
+		/* Nothing changed, really */
+		free(ce);
+		return 0;
+	}
+
 	if (index_path(ce->sha1, path, &st, 1))
 		die("unable to index file %s", path);
 	if (add_index_entry(istate, ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE))
