From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] tree-diff: make diff_tree return void
Date: Tue, 22 Mar 2011 20:28:44 -0500
Message-ID: <20110323012844.GB10621@elie>
References: <cover.1300798069.git.johannes.schindelin@gmx.de>
 <91afab0d46939238dd7c90ea2902b02cae083316.1300798069.git.johannes.schindelin@gmx.de>
 <7v7hbrkovz.fsf@alter.siamese.dyndns.org>
 <20110323012654.GA10621@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 02:28:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Csa-0005BO-NT
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 02:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188Ab1CWB2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 21:28:51 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60713 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827Ab1CWB2t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 21:28:49 -0400
Received: by gxk21 with SMTP id 21so3151578gxk.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 18:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Bi0a66TpLxd8xfM0pSjfR4ZizO3+E90nlRgRaL93U9A=;
        b=HaEKts009LbbwCikxi8Rw0Bw8rup504iuV0CWcqxYV7dX9fK5vgtNqSh2hC8cVi7R+
         3/6gPwqDWq0Lj22S+DsMTzqbfnt/Y2eFfpJFvYFccukuIDYovRmh2jRDaCgrp8ZZ4XYF
         pzBhrfxA71qDfjmYYDJNgaLitv64xsba+6adQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NCdjnhUk60OCMLtdNqWGdSzPq/1Wr6KfH9LFUnjCLCwgVlZ3M9pk0/gdG8CgotadBE
         4xcxO1XjiOmLCb2FNlK87xRaHAkESnE94hp5Et2EvTzgxvQ9mBFfdylHAG8sXmfkAfd+
         1pkinqVGwqBJ5mYCyDFlZKbjc0UpX1+pJc7A0=
Received: by 10.236.180.99 with SMTP id i63mr677931yhm.104.1300843729121;
        Tue, 22 Mar 2011 18:28:49 -0700 (PDT)
Received: from elie (adsl-68-255-102-141.dsl.chcgil.ameritech.net [68.255.102.141])
        by mx.google.com with ESMTPS id f32sm1530408yhc.28.2011.03.22.18.28.47
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Mar 2011 18:28:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110323012654.GA10621@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169793>

diff_tree (which runs a diff between two trees) always returns 0 and
dies on errors.  Some day it may change to change it to return -1 on
error but it will be easy to adjust callers then and until then the
return value is just confusing.

This way at least callers are consistent in ignoring the return value
and new readers don't have to wonder if diff_tree returns its diff
result like "diff --exit-code" would.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 diff.h      |    2 +-
 revision.c  |    5 ++---
 tree-diff.c |   13 +++++--------
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/diff.h b/diff.h
index 007a055..4fde7f3 100644
--- a/diff.h
+++ b/diff.h
@@ -163,7 +163,7 @@ extern const char mime_boundary_leader[];
 
 extern void diff_tree_setup_paths(const char **paths, struct diff_options *);
 extern void diff_tree_release_paths(struct diff_options *);
-extern int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
+extern void diff_tree(struct tree_desc *t1, struct tree_desc *t2,
 		     const char *base, struct diff_options *opt);
 extern int diff_tree_sha1(const unsigned char *old, const unsigned char *new,
 			  const char *base, struct diff_options *opt);
diff --git a/revision.c b/revision.c
index 86d2470..a6e78c9 100644
--- a/revision.c
+++ b/revision.c
@@ -337,7 +337,6 @@ static int rev_compare_tree(struct rev_info *revs, struct commit *parent, struct
 
 static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
 {
-	int retval;
 	void *tree;
 	unsigned long size;
 	struct tree_desc empty, real;
@@ -354,10 +353,10 @@ static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
 
 	tree_difference = REV_TREE_SAME;
 	DIFF_OPT_CLR(&revs->pruning, HAS_CHANGES);
-	retval = diff_tree(&empty, &real, "", &revs->pruning);
+	diff_tree(&empty, &real, "", &revs->pruning);
 	free(tree);
 
-	return retval >= 0 && (tree_difference == REV_TREE_SAME);
+	return tree_difference == REV_TREE_SAME;
 }
 
 static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
diff --git a/tree-diff.c b/tree-diff.c
index 3954281..d1a7ae9 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -138,7 +138,7 @@ static void skip_uninteresting(struct tree_desc *t, struct strbuf *base,
 	}
 }
 
-int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
+void diff_tree(struct tree_desc *t1, struct tree_desc *t2,
 	      const char *base_str, struct diff_options *opt)
 {
 	struct strbuf base;
@@ -190,7 +190,6 @@ int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
 	}
 
 	strbuf_release(&base);
-	return 0;
 }
 
 /*
@@ -285,7 +284,6 @@ int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const cha
 	void *tree1, *tree2;
 	struct tree_desc t1, t2;
 	unsigned long size1, size2;
-	int retval;
 
 	tree1 = read_object_with_reference(old, tree_type, &size1, NULL);
 	if (!tree1)
@@ -295,7 +293,7 @@ int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const cha
 		die("unable to read destination tree (%s)", sha1_to_hex(new));
 	init_tree_desc(&t1, tree1, size1);
 	init_tree_desc(&t2, tree2, size2);
-	retval = diff_tree(&t1, &t2, base, opt);
+	diff_tree(&t1, &t2, base, opt);
 	if (!*base && DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rename()) {
 		init_tree_desc(&t1, tree1, size1);
 		init_tree_desc(&t2, tree2, size2);
@@ -303,12 +301,11 @@ int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const cha
 	}
 	free(tree1);
 	free(tree2);
-	return retval;
+	return 0;
 }
 
 int diff_root_tree_sha1(const unsigned char *new, const char *base, struct diff_options *opt)
 {
-	int retval;
 	void *tree;
 	unsigned long size;
 	struct tree_desc empty, real;
@@ -319,9 +316,9 @@ int diff_root_tree_sha1(const unsigned char *new, const char *base, struct diff_
 	init_tree_desc(&real, tree, size);
 
 	init_tree_desc(&empty, "", 0);
-	retval = diff_tree(&empty, &real, base, opt);
+	diff_tree(&empty, &real, base, opt);
 	free(tree);
-	return retval;
+	return 0;
 }
 
 void diff_tree_release_paths(struct diff_options *opt)
-- 
1.7.4.1
