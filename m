X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: problem in unpack-trees.c
Date: Mon, 04 Dec 2006 02:00:32 -0800
Message-ID: <7vhcwcq8u7.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0612022125530.1867@scrub.home>
	<7vodqkq956.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 10:00:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vodqkq956.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 04 Dec 2006 01:53:57 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33179>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrAcm-0004Tw-KY for gcvg-git@gmane.org; Mon, 04 Dec
 2006 11:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934423AbWLDKAe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 05:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935285AbWLDKAe
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 05:00:34 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:41465 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S934423AbWLDKAd
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 05:00:33 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061204100032.KXRN18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>; Mon, 4
 Dec 2006 05:00:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id uZzx1V00Q1kojtg0000000; Mon, 04 Dec 2006
 04:59:58 -0500
To: Roman Zippel <zippel@linux-m68k.org>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> If the alignment requirement of the platform is smaller, we may
> be overstepping the struct when we access its name[] member.

Would this help?

I do not think we need a separate identity for df_conflict_entry
per invocation of unpack_trees(), so this allocates one such
entry with NUL name at the first call to the function and reuses
it from the variable.

diff --git a/unpack-trees.c b/unpack-trees.c
index 7cfd628..47aa804 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -370,7 +370,7 @@ int unpack_trees(struct object_list *trees, struct unpack_trees_options *o)
 	int i;
 	struct object_list *posn = trees;
 	struct tree_entry_list df_conflict_list;
-	struct cache_entry df_conflict_entry;
+	static struct cache_entry *dfc;
 
 	memset(&df_conflict_list, 0, sizeof(df_conflict_list));
 	df_conflict_list.next = &df_conflict_list;
@@ -381,8 +381,10 @@ int unpack_trees(struct object_list *trees, struct unpack_trees_options *o)
 	state.refresh_cache = 1;
 
 	o->merge_size = len;
-	memset(&df_conflict_entry, 0, sizeof(df_conflict_entry));
-	o->df_conflict_entry = &df_conflict_entry;
+
+	if (!dfc)
+		dfc = xcalloc(1, sizeof(struct cache_entry) + 1);
+	o->df_conflict_entry = dfc;
 
 	if (len) {
 		posns = xmalloc(len * sizeof(struct tree_entry_list *));
