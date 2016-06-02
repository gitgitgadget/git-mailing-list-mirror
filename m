From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] pathspec: rename free_pathspec() to clear_pathspec()
Date: Thu, 02 Jun 2016 14:18:47 -0700
Message-ID: <xmqq60trthl4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 23:22:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8a13-00083Q-Uv
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 23:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbcFBVSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 17:18:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56864 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752502AbcFBVSw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 17:18:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F10CC20895;
	Thu,  2 Jun 2016 17:18:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=n
	6jSYbFq617sSBcNbKo8NGaD7HI=; b=TOhU6mNpRVyHNUzsDBPIfcDKaeUrhV3ej
	1NuYQ3PEJFh+ypLqYCw6kTG0eAFsLUNN9xm2bGwQkvEG3FyWhX771KjPYk2ZFBYj
	Siqp+ljEyCkGHXGjNgdY+xI3m44Ir3HdoaHd8IEJma+9LfIQ7CkAoj4yLRU75Uad
	6pT4t9YUPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Nm2
	HCe7tpf//3NJBxLEVqy24CptIL/uD/mtjkUabADhJC+G9C8Zi9PTPdgH6ObFhO+B
	efAgBo63cOaN7ZCXVZNnUeB8mvEWbdDX8Bv1rCFQ7iG+PHJN5xQ0PKu2KWOgbr4A
	mEMtDvbrXXdJrrV7Q3200ZEXnPvfi+xaD2cJVz6Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E92D420893;
	Thu,  2 Jun 2016 17:18:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E86B20892;
	Thu,  2 Jun 2016 17:18:50 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 99D81ABA-2907-11E6-B9F9-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296236>

The function takes a pointer to a pathspec structure, and releases
the resources held by it, but does not free() the structure itself.
Such a function should be called "clear", not "free".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is just something I noticed.  Among the hits in

    $ git grep free_ \*.h

   I think free_notes() is also a candidate for such renaming, but
   because we are not actively working on that subsystem, we may
   want to leave that dog sleeping to avoid unnecessary code churn.
   The same for diff_free_filespec_data(), for which a better name
   would have been diff_filespec_clear().

 archive.c              | 2 +-
 builtin/blame.c        | 6 +++---
 builtin/reset.c        | 2 +-
 builtin/update-index.c | 2 +-
 combine-diff.c         | 2 +-
 notes-merge.c          | 4 ++--
 pathspec.c             | 2 +-
 pathspec.h             | 4 ++--
 revision.c             | 2 +-
 tree-diff.c            | 4 ++--
 10 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/archive.c b/archive.c
index 5d735ae..42df974 100644
--- a/archive.c
+++ b/archive.c
@@ -322,7 +322,7 @@ static int path_exists(struct tree *tree, const char *path)
 	pathspec.recursive = 1;
 	ret = read_tree_recursive(tree, "", 0, 0, &pathspec,
 				  reject_entry, &pathspec);
-	free_pathspec(&pathspec);
+	clear_pathspec(&pathspec);
 	return ret != 0;
 }
 
diff --git a/builtin/blame.c b/builtin/blame.c
index 21f42b0..759d84a 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -609,7 +609,7 @@ static struct origin *find_origin(struct scoreboard *sb,
 		}
 	}
 	diff_flush(&diff_opts);
-	free_pathspec(&diff_opts.pathspec);
+	clear_pathspec(&diff_opts.pathspec);
 	return porigin;
 }
 
@@ -651,7 +651,7 @@ static struct origin *find_rename(struct scoreboard *sb,
 		}
 	}
 	diff_flush(&diff_opts);
-	free_pathspec(&diff_opts.pathspec);
+	clear_pathspec(&diff_opts.pathspec);
 	return porigin;
 }
 
@@ -1343,7 +1343,7 @@ static void find_copy_in_parent(struct scoreboard *sb,
 	} while (unblamed);
 	target->suspects = reverse_blame(leftover, NULL);
 	diff_flush(&diff_opts);
-	free_pathspec(&diff_opts.pathspec);
+	clear_pathspec(&diff_opts.pathspec);
 }
 
 /*
diff --git a/builtin/reset.c b/builtin/reset.c
index 092c3a5..acd6278 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -158,7 +158,7 @@ static int read_from_tree(const struct pathspec *pathspec,
 		return 1;
 	diffcore_std(&opt);
 	diff_flush(&opt);
-	free_pathspec(&opt.pathspec);
+	clear_pathspec(&opt.pathspec);
 
 	return 0;
 }
diff --git a/builtin/update-index.c b/builtin/update-index.c
index b8b8522..6cdfd5f 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -759,7 +759,7 @@ static int do_reupdate(int ac, const char **av,
 		if (save_nr != active_nr)
 			goto redo;
 	}
-	free_pathspec(&pathspec);
+	clear_pathspec(&pathspec);
 	return 0;
 }
 
diff --git a/combine-diff.c b/combine-diff.c
index 8f2313d..5920df8 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1525,7 +1525,7 @@ void diff_tree_combined(const unsigned char *sha1,
 		free(tmp);
 	}
 
-	free_pathspec(&diffopts.pathspec);
+	clear_pathspec(&diffopts.pathspec);
 }
 
 void diff_tree_combined_merge(const struct commit *commit, int dense,
diff --git a/notes-merge.c b/notes-merge.c
index 34bfac0..b7814c9 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -170,7 +170,7 @@ static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
 		       sha1_to_hex(mp->remote));
 	}
 	diff_flush(&opt);
-	free_pathspec(&opt.pathspec);
+	clear_pathspec(&opt.pathspec);
 
 	*num_changes = len;
 	return changes;
@@ -256,7 +256,7 @@ static void diff_tree_local(struct notes_merge_options *o,
 		       sha1_to_hex(mp->local));
 	}
 	diff_flush(&opt);
-	free_pathspec(&opt.pathspec);
+	clear_pathspec(&opt.pathspec);
 }
 
 static void check_notes_merge_worktree(struct notes_merge_options *o)
diff --git a/pathspec.c b/pathspec.c
index c9e9b6c..24e0dd5 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -489,7 +489,7 @@ void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
 	       sizeof(struct pathspec_item) * dst->nr);
 }
 
-void free_pathspec(struct pathspec *pathspec)
+void clear_pathspec(struct pathspec *pathspec)
 {
 	free(pathspec->items);
 	pathspec->items = NULL;
diff --git a/pathspec.h b/pathspec.h
index 0c11262..4a80f6f 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -19,7 +19,7 @@
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern satisfies GFNM_ONESTAR */
 
 struct pathspec {
-	const char **_raw; /* get_pathspec() result, not freed by free_pathspec() */
+	const char **_raw; /* get_pathspec() result, not freed by clear_pathspec() */
 	int nr;
 	unsigned int has_wildcard:1;
 	unsigned int recursive:1;
@@ -74,7 +74,7 @@ extern void parse_pathspec(struct pathspec *pathspec,
 			   const char *prefix,
 			   const char **args);
 extern void copy_pathspec(struct pathspec *dst, const struct pathspec *src);
-extern void free_pathspec(struct pathspec *);
+extern void clear_pathspec(struct pathspec *);
 
 static inline int ps_strncmp(const struct pathspec_item *item,
 			     const char *s1, const char *s2, size_t n)
diff --git a/revision.c b/revision.c
index d30d1c4..2f60062 100644
--- a/revision.c
+++ b/revision.c
@@ -1425,7 +1425,7 @@ static void prepare_show_merge(struct rev_info *revs)
 		       ce_same_name(ce, active_cache[i+1]))
 			i++;
 	}
-	free_pathspec(&revs->prune_data);
+	clear_pathspec(&revs->prune_data);
 	parse_pathspec(&revs->prune_data, PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
 		       PATHSPEC_PREFER_FULL | PATHSPEC_LITERAL_PATH, "", prune);
 	revs->limited = 1;
diff --git a/tree-diff.c b/tree-diff.c
index ff4e0d3..edb4de9 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -607,7 +607,7 @@ static void try_to_follow_renames(const unsigned char *old, const unsigned char
 	diff_setup_done(&diff_opts);
 	ll_diff_tree_sha1(old, new, base, &diff_opts);
 	diffcore_std(&diff_opts);
-	free_pathspec(&diff_opts.pathspec);
+	clear_pathspec(&diff_opts.pathspec);
 
 	/* Go through the new set of filepairing, and see if we find a more interesting one */
 	opt->found_follow = 0;
@@ -630,7 +630,7 @@ static void try_to_follow_renames(const unsigned char *old, const unsigned char
 			/* Update the path we use from now on.. */
 			path[0] = p->one->path;
 			path[1] = NULL;
-			free_pathspec(&opt->pathspec);
+			clear_pathspec(&opt->pathspec);
 			parse_pathspec(&opt->pathspec,
 				       PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
 				       PATHSPEC_LITERAL_PATH, "", path);
-- 
2.9.0-rc1-228-gd00d833
