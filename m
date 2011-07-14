From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] Add a 'generation' number to commits
Date: Thu, 14 Jul 2011 11:34:09 -0700 (PDT)
Message-ID: <alpine.LFD.2.02.1107141126300.4159@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 14 20:34:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhQju-0008Si-FG
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 20:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755522Ab1GNSeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 14:34:17 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40853 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755383Ab1GNSeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 14:34:16 -0400
Received: by iyb12 with SMTP id 12so471270iyb.19
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 11:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:x-x-sender:to:subject:message-id:user-agent
         :mime-version:content-type;
        bh=Qt38nAyrvI1eFekp1n8MQnaxLdrjWk9tnOUpF+Ve4eI=;
        b=Y361huFICaPJpNbdYqdRHABFp7j0vtkjnvPqWmdYqdhSyXReT1VUCHJy+NBgI8wMdB
         dJ1X+JNrYfMDub7c1xU/uDSer+vwGahbGKv96Jz41EqRwm8zlM1qw6N60PFP11nNn9VP
         O+FCf7NjWXY4GtBecjOZJC/pZA1M1H9a0NXT4=
Received: by 10.42.154.8 with SMTP id o8mr812206icw.503.1310668455779;
        Thu, 14 Jul 2011 11:34:15 -0700 (PDT)
Received: from [192.168.1.87] (c-24-22-0-219.hsd1.or.comcast.net [24.22.0.219])
        by mx.google.com with ESMTPS id d8sm534403icy.9.2011.07.14.11.34.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jul 2011 11:34:14 -0700 (PDT)
X-X-Sender: torvalds@i5.linux-foundation.org
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177149>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Jul 2011 11:09:46 -0700
Subject: [PATCH] Add a 'generation' number to commits

It turns out that it's ok with git-fsck, and it's really not that
complicated.

We unconditionally add the generation number to new commits, but we
don't require it in old ones.  Even if mix old and new versions of git,
once you have the occasional new user, it's all good: there will be
generation numbers every once in a while, which means that computing new
ones will get cheaper (it's expensive to compute the generation number
for a deep tree that doesn't currently have any).

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Comments? This is pretty simplistic, and yes, it's slow. On the kernel, it 
now takes a few seconds to generate a new commit when there are no 
generation numbers - and that's on a fast machine.

But if I as a maintainer start using this, even if nobody else does, my 
merges and my releases will start having generation numbers in the 
commits, and once people start using those as the bases for their 
development, the "generate the numbers" cost will quickly start going 
down. It will always exist for old commits, but those get progressively 
less relevant as time goes by, and soon enough all merging will be based 
on stuff that has generation numbers somewhere reasonably recent.

And the thing is, we don't actually have to generate the generation 
numbers very often. New commits, yes (but if you have a series of new 
commits due to something like quilt import usage, it's only the first one 
that ends up having that cost). But for the "might this be a merge base", 
we could easily decide to never do any dynamic generation, and only say 
that "IF we have pre-generated generation numbers, then we'll use them to 
say "this cannot possibly be an ancestor, because it has a bigger 
generation number".

So we'd not see the advantages immediately, but the downsides would be 
pretty small too. And the upside is that eventually new commits _will_ 
have those generation numbers that we should have added to git originally.

 commit.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 commit.h |    1 +
 2 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index ac337c7d7dc1..6a6b9978f252 100644
--- a/commit.c
+++ b/commit.c
@@ -89,6 +89,28 @@ static unsigned long parse_commit_date(const char *buf, const char *tail)
 	return strtoul(dateptr, NULL, 10);
 }
 
+static long parse_commit_generation(const char *author, const char *tail)
+{
+	const char *p = author;
+	while (p + 13 < tail) {
+		/* Empty line before commit message? */
+		if (*p == '\n')
+			break;
+		if (!memcmp(p, "generation ", 11)) {
+			long value;
+			char *end;
+
+			value = strtoul(p+11, &end, 10);
+			if (!value || *end != '\n')
+				break;
+			return value;
+		}
+		while (p < tail && *p++ != '\n')
+			/* nothing */;
+	}
+	return -1;
+}
+
 static struct commit_graft **commit_graft;
 static int commit_graft_alloc, commit_graft_nr;
 
@@ -296,6 +318,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 		}
 	}
 	item->date = parse_commit_date(bufptr, tail);
+	item->generation = parse_commit_generation(bufptr, tail);
 
 	return 0;
 }
@@ -824,6 +847,26 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 	return result;
 }
 
+static long commit_generation(struct commit *commit)
+{
+	struct commit_list *parents;
+	unsigned long max = 0;
+
+	if (parse_commit(commit))
+		return -1;
+	if (commit->generation >= 0)
+		return commit->generation;
+	parents = commit->parents;
+	while (parents) {
+		long gen = commit_generation(parents->item);
+		if (gen >= max)
+			max = gen+1;
+		parents = parents->next;
+	}
+	commit->generation = max;
+	return max;
+}
+
 static const char commit_utf8_warn[] =
 "Warning: commit message does not conform to UTF-8.\n"
 "You may want to amend it after fixing the message, or set the config\n"
@@ -836,6 +879,7 @@ int commit_tree(const char *msg, unsigned char *tree,
 	int result;
 	int encoding_is_utf8;
 	struct strbuf buffer;
+	unsigned long generation = 0;
 
 	assert_sha1_type(tree, OBJ_TREE);
 
@@ -851,9 +895,13 @@ int commit_tree(const char *msg, unsigned char *tree,
 	 * if everything else stays the same.
 	 */
 	while (parents) {
+		long parent_gen;
 		struct commit_list *next = parents->next;
 		strbuf_addf(&buffer, "parent %s\n",
 			sha1_to_hex(parents->item->object.sha1));
+		parent_gen = commit_generation(parents->item);
+		if (parent_gen >= generation)
+			generation = parent_gen+1;
 		free(parents);
 		parents = next;
 	}
@@ -865,6 +913,8 @@ int commit_tree(const char *msg, unsigned char *tree,
 	strbuf_addf(&buffer, "committer %s\n", git_committer_info(IDENT_ERROR_ON_NO_NAME));
 	if (!encoding_is_utf8)
 		strbuf_addf(&buffer, "encoding %s\n", git_commit_encoding);
+	if (generation)
+		strbuf_addf(&buffer, "generation %lu\n", generation);
 	strbuf_addch(&buffer, '\n');
 
 	/* And add the comment */
diff --git a/commit.h b/commit.h
index a2d571b97410..fd36274a2b0a 100644
--- a/commit.h
+++ b/commit.h
@@ -16,6 +16,7 @@ struct commit {
 	void *util;
 	unsigned int indegree;
 	unsigned long date;
+	long generation;
 	struct commit_list *parents;
 	struct tree *tree;
 	char *buffer;
-- 
1.7.6.1.g7f306
