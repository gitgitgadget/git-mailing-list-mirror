From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] read-trees: refactor the unpack_trees() part
Date: Mon, 31 Jul 2006 02:14:24 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607310205260.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607302024090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4pwydbbr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 31 02:14:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7LQV-0004YH-2F
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 02:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWGaAO1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 20:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWGaAO1
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 20:14:27 -0400
Received: from mail.gmx.de ([213.165.64.21]:39361 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932476AbWGaAO0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jul 2006 20:14:26 -0400
Received: (qmail invoked by alias); 31 Jul 2006 00:14:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp014) with SMTP; 31 Jul 2006 02:14:25 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4pwydbbr.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24478>

Hi,

On Sun, 30 Jul 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > diff --git a/unpack-trees.h b/unpack-trees.h
> > new file mode 100644
> > index 0000000..babfcd7
> > --- /dev/null
> > +++ b/unpack-trees.h
> > @@ -0,0 +1,30 @@
> > +#ifndef UNPACK_TREES_H
> > +#define UNPACK_TREES_H
> >...
> > +struct unpack_trees_options {
> > +	int reset;
> > +	int merge;
> > +	int update;
> > +	int index_only;
> > +	int nontrivial_merge;
> > +	int trivial_merges_only;
> > +	int verbose_update;
> > +	int aggressive;
> > +	const char *prefix;
> > +	merge_fn_t fn;
> > +
> > +	int head_idx;
> > +	int merge_size;
> > +
> > +	struct cache_entry df_conflict_entry;
> > +};
> 
> Hmmmm.....
> 
> gcc -o unpack-trees.o -c -O2 -Werror -ansi -pedantic -std=c99 -D_XOPEN_SOURCE=500 -D_BSD_SOURCE -Wall -Wdeclaration-after-statement -g -DSHA1_HEADER='<openssl/sha.h>' -DNO_STRLCPY unpack-trees.c
> cc1: warnings being treated as errors
> In file included from unpack-trees.c:7:
> unpack-trees.h:24: warning: invalid use of structure with flexible array member
> make: *** [unpack-trees.o] Error 1

Darn, darn, DARN!

As far as I can see, that flexible array member is the member "name" of 
cache_entry. And as I can see further, it is used _nowhere_. At least not 
inside that structure.

How about this (on top of that patch):

-- 8< --
[PATCH 1.5/3] unpack-trees: please C99 standard

Even if it is not a technical error in _this_ case, a struct with
a flexible array member should not be put inside another struct.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 unpack-trees.c |   10 ++++++----
 unpack-trees.h |    2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index b8a355f..3cb92cb 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -168,7 +168,7 @@ #endif
 			}
 
 			if (posns[i] == df_conflict_list) {
-				src[i + o->merge] = &o->df_conflict_entry;
+				src[i + o->merge] = o->df_conflict_entry;
 				continue;
 			}
 
@@ -178,7 +178,7 @@ #endif
 				parse_tree(tree);
 				subposns[i] = create_tree_entry_list(tree);
 				posns[i] = posns[i]->next;
-				src[i + o->merge] = &o->df_conflict_entry;
+				src[i + o->merge] = o->df_conflict_entry;
 				continue;
 			}
 
@@ -370,6 +370,7 @@ int unpack_trees(struct object_list *tre
 	int i;
 	struct object_list *posn = trees;
 	struct tree_entry_list df_conflict_list;
+	struct cache_entry df_conflict_entry;
 
 	memset(&df_conflict_list, 0, sizeof(df_conflict_list));
 	df_conflict_list.next = &df_conflict_list;
@@ -380,6 +381,7 @@ int unpack_trees(struct object_list *tre
 	state.refresh_cache = 1;
 
 	o->merge_size = len;
+	o->df_conflict_entry = &df_conflict_entry;
 
 	if (len) {
 		posns = xmalloc(len * sizeof(struct tree_entry_list *));
@@ -562,12 +564,12 @@ int threeway_merge(struct cache_entry **
 	index = stages[0];
 	head = stages[o->head_idx];
 
-	if (head == &o->df_conflict_entry) {
+	if (head == o->df_conflict_entry) {
 		df_conflict_head = 1;
 		head = NULL;
 	}
 
-	if (remote == &o->df_conflict_entry) {
+	if (remote == o->df_conflict_entry) {
 		df_conflict_remote = 1;
 		remote = NULL;
 	}
diff --git a/unpack-trees.h b/unpack-trees.h
index 826b263..c460162 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -21,7 +21,7 @@ struct unpack_trees_options {
 	int head_idx;
 	int merge_size;
 
-	struct cache_entry df_conflict_entry;
+	struct cache_entry *df_conflict_entry;
 };
 
 extern int unpack_trees(struct object_list *trees,
-- 
1.4.2.rc2.g53906
