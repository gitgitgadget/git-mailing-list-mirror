From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Efficient way to import snapshots?
Date: Mon, 30 Jul 2007 16:59:10 -0700
Message-ID: <7vsl75igtt.fsf@assigned-by-dhcp.cox.net>
References: <20070730180710.GA64467@nowhere>
	<alpine.LFD.0.999.0707301144180.4161@woody.linux-foundation.org>
	<20070730192922.GB64467@nowhere>
	<alpine.LFD.0.999.0707301240330.4161@woody.linux-foundation.org>
	<7vy7gximkc.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.999.0707301624050.4161@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Craig Boston <craig@olyun.gank.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 31 01:59:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFf8u-0001ZF-2u
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 01:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932721AbXG3X7N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 19:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932691AbXG3X7M
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 19:59:12 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:58691 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760847AbXG3X7M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 19:59:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070730235910.FOMG1349.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 30 Jul 2007 19:59:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VzzA1X00c1kojtg0000000; Mon, 30 Jul 2007 19:59:11 -0400
In-Reply-To: <alpine.LFD.0.999.0707301624050.4161@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 30 Jul 2007 16:27:34 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54293>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 30 Jul 2007, Junio C Hamano wrote:
>> 
>> We would need to do something like this patch, perhaps?  This
>> function has three callers, two in builtin-add and another in
>> builtin-mv.
>
> I think you need to check that ce is in stage 0 too.

I guess so, but can higher stage entries have cached stat
information that are valid and match the working tree?

---
 read-cache.c  |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
diff --git a/read-cache.c b/read-cache.c
index a363f31..9c00ccb 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -380,7 +380,7 @@ static int index_name_pos_also_unmerged(struct index_state *istate,
 
 int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 {
-	int size, namelen;
+	int size, namelen, pos;
 	struct stat st;
 	struct cache_entry *ce;
 
@@ -414,6 +414,15 @@ int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 		ce->ce_mode = ce_mode_from_stat(ent, st.st_mode);
 	}
 
+	pos = index_name_pos(istate, ce->name, namelen);
+	if (0 <= pos && 
+	    !ce_stage(istate->cache[pos]) &&
+	    !ie_modified(istate, istate->cache[pos], &st, 1)) {
+		/* Nothing changed, really */
+		free(ce);
+		return 0;
+	}
+
 	if (index_path(ce->sha1, path, &st, 1))
 		die("unable to index file %s", path);
 	if (add_index_entry(istate, ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE))
