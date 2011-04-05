From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] pathspec: rename per-item field has_wildcard to use_wildcard
Date: Tue, 05 Apr 2011 15:10:22 -0700
Message-ID: <7vr59gl581.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 00:10:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7ESb-00083L-1y
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 00:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913Ab1DEWKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 18:10:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39912 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169Ab1DEWKg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 18:10:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BB6785034;
	Tue,  5 Apr 2011 18:12:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=O
	4x2S7njPFqscv4lWvRS0bA1ICA=; b=rbekie0EauAW6g0UwCSpD/wLGLrf41YIZ
	Rz7iAJ1ibdKUPDCdQ5ug9F31iFM8l4TjQLajecQpNzDSTKVoDHSTMHf/K/c6OM9t
	4CBlUjWSRBdE+EP2DcgtXSXP6MXwp6uRYaAOVa7I969LcvV2d30iPBrzGk+2QEY4
	6c3NpW8R+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=IL0XEO82ejQkt2D2zpqHa44rgNiZtTd282riVtJk23zrsCZW28KvnRFP
	aPCkuY9sL/2J0zhvplhV/UcPVO18my6aj3AOIQuZsdWIiT+lvByNVsTELYsw642V
	ft88NSq5yNEGv7Vl5GqV1uMpBEZ/cVHg5UxMkkH4m2+CskmSVy4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 71B815033;
	Tue,  5 Apr 2011 18:12:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 01F005031; Tue,  5 Apr 2011
 18:12:16 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C70F09C6-5FD1-11E0-82F2-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170925>

As the point of the last change is to allow use of strings as
literals no matter what characters are in them, "has_wildcard"
does not match what we use this field for anymore.

It is used to decide if the wildcard matching should be used, so
rename it to match the usage better.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I was looking at the codepaths that would need to be touched in order
   to properly support the "magic pathspec" we have been discussing, and
   am leaning to conclude that all the users of get_pathspec() need to be
   rewritten to throw the remainder of argv[] at a function that fills a
   struct pathspec (in other words, a combination of get_pathspec() and
   init_pathspec()).  Michael's "alternative approach to grep --full-tree"
   was operating at the get_pathspec() level, but that function is an
   interface to return an array of plain-vanilla strings only, and there
   is no place to hook richer per-item information on the elements.  We
   would need "struct pathspec" in the function where we parse the argv[]
   and combine its elements with prefix.

   In any case, pathspec.has_wildcard vs pathspec.item[i].has_wildcard was
   difficult to grep and find patterns, and this is an obvious fix to that
   problem, independent from the above observation.

 builtin/ls-files.c |    2 +-
 builtin/ls-tree.c  |    3 ++-
 cache.h            |    2 +-
 dir.c              |    6 +++---
 tree-walk.c        |    4 ++--
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 199af46..1570123 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -361,7 +361,7 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix)
 		matchbuf[0] = prefix;
 		matchbuf[1] = NULL;
 		init_pathspec(&pathspec, matchbuf);
-		pathspec.items[0].has_wildcard = 0;
+		pathspec.items[0].use_wildcard = 0;
 	} else
 		init_pathspec(&pathspec, NULL);
 	if (read_tree(tree, 1, &pathspec))
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 4290723..f08c5b0 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -168,7 +168,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 
 	init_pathspec(&pathspec, get_pathspec(prefix, argv + 1));
 	for (i = 0; i < pathspec.nr; i++)
-		pathspec.items[i].has_wildcard = 0;
+		pathspec.items[i].use_wildcard = 0;
+	pathspec.has_wildcard = 0;
 	tree = parse_tree_indirect(sha1);
 	if (!tree)
 		die("not a tree object");
diff --git a/cache.h b/cache.h
index edd5b5a..43d719d 100644
--- a/cache.h
+++ b/cache.h
@@ -509,7 +509,7 @@ struct pathspec {
 	struct pathspec_item {
 		const char *match;
 		int len;
-		unsigned int has_wildcard:1;
+		unsigned int use_wildcard:1;
 	} *items;
 };
 
diff --git a/dir.c b/dir.c
index 168dad6..91f1502 100644
--- a/dir.c
+++ b/dir.c
@@ -230,7 +230,7 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
 			return MATCHED_RECURSIVELY;
 	}
 
-	if (item->has_wildcard && !fnmatch(match, name, 0))
+	if (item->use_wildcard && !fnmatch(match, name, 0))
 		return MATCHED_FNMATCH;
 
 	return 0;
@@ -1286,8 +1286,8 @@ int init_pathspec(struct pathspec *pathspec, const char **paths)
 
 		item->match = path;
 		item->len = strlen(path);
-		item->has_wildcard = !no_wildcard(path);
-		if (item->has_wildcard)
+		item->use_wildcard = !no_wildcard(path);
+		if (item->use_wildcard)
 			pathspec->has_wildcard = 1;
 	}
 
diff --git a/tree-walk.c b/tree-walk.c
index 322becc..33f749e 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -598,7 +598,7 @@ int tree_entry_interesting(const struct name_entry *entry,
 					&never_interesting))
 				return 1;
 
-			if (ps->items[i].has_wildcard) {
+			if (ps->items[i].use_wildcard) {
 				if (!fnmatch(match + baselen, entry->path, 0))
 					return 1;
 
@@ -614,7 +614,7 @@ int tree_entry_interesting(const struct name_entry *entry,
 		}
 
 match_wildcards:
-		if (!ps->items[i].has_wildcard)
+		if (!ps->items[i].use_wildcard)
 			continue;
 
 		/*
-- 
1.7.5.rc0.131.gfa38c
