From: "Alexander N. Gavrilov" <angavrilov@gmail.com>
Subject: [RFC PATCH] Fix quadratic performance in rewrite_one.
Date: Sat, 12 Jul 2008 22:00:57 +0400
Organization: TEPKOM
Message-ID: <200807122200.58187.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 12 20:02:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHjQQ-0001pN-2e
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 20:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbYGLSBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 14:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbYGLSBL
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 14:01:11 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:15359 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbYGLSBK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 14:01:10 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2300592fkq.5
        for <git@vger.kernel.org>; Sat, 12 Jul 2008 11:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=fmio27jtEzx5FMcoRA0YNTo/+qR0eqXmcaRpRoW6Vzo=;
        b=TLEuOwM86F87F2pDpkzvO3DucEsEYzkPzmJiBWEfCQfUiAzmkJvLmSrQDaPNPywCZo
         qHeCyrqX7XZh0m19ntxfFRGDzG1Xccualmmaob+PyS8lGmktFmZxj8rFnr+KOenxLn2X
         Tz9+7IKV0J80LWUWxdg1ceGJ1iJtgU7HJC8F4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=IIlLqBqcCtkTIxNeoVO1rvn3RCUDX5Qa/xn1Hrl2Jo9+I893LBf0piwIHKwHcQtVbr
         PntUiVc4ZUU/Mxd2tubXwLLxt02i2DnYtnmH4wfH3JMcZauhJx0m7xFrGGPaKL0l5sj8
         V9xPKYKE5snmOAguxzv1xRavVO2IAPgfo3Rlc=
Received: by 10.86.84.5 with SMTP id h5mr11818852fgb.58.1215885668641;
        Sat, 12 Jul 2008 11:01:08 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id 12sm2472981fgg.0.2008.07.12.11.01.07
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 12 Jul 2008 11:01:07 -0700 (PDT)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88260>

Parent commits are usually older than their children. Thus,
on each iteration of the loop in rewrite_one, add_parents_to_list
traverses all commits previously processed by the loop.
It performs very poorly in case of very long rewrite chains.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
	
	While experimenting with a large Git repository (~10 years of history), I noticed that
	gitk (and git-log) is very slow when asked to show history for a recently created directory:

	$ time git log --no-color --pretty=oneline --parents --boundary -- A_5_Year_Old_Dir | wc
	1620    8042  166759

	real    0m29.969s
	user    0m28.419s
	sys     0m0.304s

	$ time git log --no-color --pretty=oneline --parents --boundary -- A_3_Year_Old_Dir | wc
	66     315    6599
	
	real    1m41.523s
	user    1m38.585s
	sys     0m0.549s

	$ time git log --no-color --pretty=oneline --parents --boundary -- A_1_Year_Old_Dir | wc
	18     108    1898
	
	real    3m33.023s
	user    3m28.817s
	sys     0m0.859s
	
	Profiling showed that most of the time is spent manipulating commit lists:
	
	%   cumulative   self              self     total           
	time   seconds   seconds    calls   s/call   s/call  name    
	98.91    206.21   206.21    76909     0.00     0.00  insert_by_date
	0.36    206.97     0.76   409268     0.00     0.00  find_pack_entry_one
	0.17    207.33     0.36   258208     0.00     0.00  unpack_object_header_gently
	
	After some research and debugging I narrowed it down to this loop in rewrite_one (revision.c):
	
		for (;;) {
			struct commit *p = *pp;
			...
				if (add_parents_to_list(revs, p, &revs->commits) < 0)
			...
			*pp = p->parents->item;
		}
	
	When git-log is called for a recently created directory, all history before its creation ends up
	being processed in this loop. Since add_parents_to_list traverses the list linearly to find the
	point of insertion, which in this case is always at the end of the list, it actually works
	in quadratical time.
	
	I made a fix for it by caching a pointer to the farthest added element. The performance gain
	is obvious, but as it's my first ever change in Git source code, I believe that there is a better
	solution, or, at least, implementation.
	
	$ time git log --no-color --pretty=oneline --parents --boundary -- A_1_Year_Old_Dir | wc
	18     108    1898
	
	real    0m4.101s
	user    0m3.897s
	sys     0m0.123s
	
	Alexander.


 revision.c |   34 ++++++++++++++++++++++++++++------
 1 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/revision.c b/revision.c
index fc66755..5bf8039 100644
--- a/revision.c
+++ b/revision.c
@@ -412,11 +412,31 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 	commit->object.flags |= TREESAME;
 }
 
-static int add_parents_to_list(struct rev_info *revs, struct commit *commit, struct commit_list **list)
+static void insert_by_date_cached(struct commit *p, struct commit_list **head,
+		    struct commit_list *cached_base, struct commit_list **cache)
+{
+	struct commit_list *new_entry;
+    
+	if (cached_base && p->date < cached_base->item->date) {
+		new_entry = insert_by_date(p, &cached_base->next);
+	}
+	else {
+		new_entry = insert_by_date(p, head);
+	}
+	
+	if (cache && (!*cache || p->date < (*cache)->item->date)) {
+		*cache = new_entry;
+	}
+}
+
+static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
+		    struct commit_list **list, struct commit_list **cache_ptr)
 {
 	struct commit_list *parent = commit->parents;
 	unsigned left_flag;
 
+	struct commit_list *cached_base = cache_ptr ? *cache_ptr : NULL;
+
 	if (commit->object.flags & ADDED)
 		return 0;
 	commit->object.flags |= ADDED;
@@ -445,7 +465,7 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit, str
 			if (p->object.flags & SEEN)
 				continue;
 			p->object.flags |= SEEN;
-			insert_by_date(p, list);
+			insert_by_date_cached(p, list, cached_base, cache_ptr);
 		}
 		return 0;
 	}
@@ -470,7 +490,7 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit, str
 		p->object.flags |= left_flag;
 		if (!(p->object.flags & SEEN)) {
 			p->object.flags |= SEEN;
-			insert_by_date(p, list);
+			insert_by_date_cached(p, list, cached_base, cache_ptr);
 		}
 		if(revs->first_parent_only)
 			break;
@@ -611,7 +631,7 @@ static int limit_list(struct rev_info *revs)
 
 		if (revs->max_age != -1 && (commit->date < revs->max_age))
 			obj->flags |= UNINTERESTING;
-		if (add_parents_to_list(revs, commit, &list) < 0)
+		if (add_parents_to_list(revs, commit, &list, NULL) < 0)
 			return -1;
 		if (obj->flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
@@ -1458,10 +1478,12 @@ enum rewrite_result {
 
 static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp)
 {
+	struct commit_list *cache = NULL;
+
 	for (;;) {
 		struct commit *p = *pp;
 		if (!revs->limited)
-			if (add_parents_to_list(revs, p, &revs->commits) < 0)
+			if (add_parents_to_list(revs, p, &revs->commits, &cache) < 0)
 				return rewrite_one_error;
 		if (p->parents && p->parents->next)
 			return rewrite_one_ok;
@@ -1580,7 +1602,7 @@ static struct commit *get_revision_1(struct rev_info *revs)
 			if (revs->max_age != -1 &&
 			    (commit->date < revs->max_age))
 				continue;
-			if (add_parents_to_list(revs, commit, &revs->commits) < 0)
+			if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0)
 				return NULL;
 		}
 
-- 
1.5.6.2.24.ge09c4
