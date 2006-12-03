X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Roman Zippel <zippel@linux-m68k.org>
Subject: problem in unpack-trees.c
Date: Sun, 3 Dec 2006 02:21:39 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0612022125530.1867@scrub.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 3 Dec 2006 01:21:48 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-X-Sender: roman@scrub.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33075>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqg36-000214-S8 for gcvg-git@gmane.org; Sun, 03 Dec
 2006 02:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935003AbWLCBVl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 20:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935005AbWLCBVl
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 20:21:41 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:3731 "EHLO
 scrub.xs4all.nl") by vger.kernel.org with ESMTP id S935003AbWLCBVk (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 20:21:40 -0500
Received: from roman (helo=localhost) by scrub.xs4all.nl with local-esmtp
 (Exim 3.36 #1 (Debian)) id 1Gqg31-0004am-00 for <git@vger.kernel.org>; Sun,
 03 Dec 2006 02:21:39 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

Git currently fails to succeed the tests as you can see here:
http://buildd.debian.org/fetch.cgi?&pkg=git-core&ver=1%3A1.4.4-2&arch=m68k&stamp=1164303729&file=log

I looked into it and the problem is during the "git-read-tree --reset" 
step and it seems that the local df_conflict_entry variable of 
unpack_trees() survives past that function. If you check in 
add_cache_entry() it's called with this variable and only because 
verify_path() fails it's not added to the tree on the other archs, but on 
m68k the data on the stack is a bit different and thus verify_path() 
succeeds and the stack variable is added to the tree and later saved.

Using the patch below, you can simulate what's happing on m68k and now I 
need some help fixing this properly, as I'm not that familiar with the 
internals.
Thanks.

bye, Roman

diff -ur git-core-1.4.4.1/unpack-trees.c git-core-1.4.4.1/unpack-trees.c
--- git-core-1.4.4.1/unpack-trees.c	2006-11-23 03:38:07.000000000 +0100
+++ git-core-1.4.4.1/unpack-trees.c	2006-12-03 01:54:04.000000000 +0100
@@ -370,7 +370,10 @@
 	int i;
 	struct object_list *posn = trees;
 	struct tree_entry_list df_conflict_list;
-	struct cache_entry df_conflict_entry;
+	static struct {
+		struct cache_entry entry;
+		char name[4];
+	} df_conflict_entry;
 
 	memset(&df_conflict_list, 0, sizeof(df_conflict_list));
 	df_conflict_list.next = &df_conflict_list;
@@ -382,7 +385,8 @@
 
 	o->merge_size = len;
 	memset(&df_conflict_entry, 0, sizeof(df_conflict_entry));
-	o->df_conflict_entry = &df_conflict_entry;
+	o->df_conflict_entry = &df_conflict_entry.entry;
+	df_conflict_entry.entry.name[0] = 'x';
 
 	if (len) {
 		posns = xmalloc(len * sizeof(struct tree_entry_list *));
@@ -399,6 +403,7 @@
 		die("Merge requires file-level merging");
 
 	check_updates(active_cache, active_nr, o);
+	memset(&df_conflict_entry, 0x11, sizeof(df_conflict_entry));
 	return 0;
 }
