From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Support author and commiter based revision list limiting
Date: Fri, 1 Sep 2006 00:57:14 +0200
Message-ID: <20060831225714.GD482@diku.dk>
References: <200608281459.26643.kai.blin@gmail.com> <20060828181626.GB2950@coredump.intra.peff.net> <Pine.LNX.4.64.0608281147420.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Kai Blin <kai.blin@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 01 00:58:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIvUG-0002tG-UQ
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 00:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWHaW5v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 18:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWHaW5v
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 18:57:51 -0400
Received: from [130.225.96.91] ([130.225.96.91]:27583 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S964804AbWHaW5U (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 18:57:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id ACAC577005B;
	Fri,  1 Sep 2006 00:57:16 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08526-12; Fri,  1 Sep 2006 00:57:15 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 215CA77005F;
	Fri,  1 Sep 2006 00:57:15 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 52DCC6DF893; Fri,  1 Sep 2006 00:55:48 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 019A962A06; Fri,  1 Sep 2006 00:57:14 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608281147420.27779@g5.osdl.org>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26283>

Adds the two options: --author=string and --committer=string, which can
be used to limit the set of interesting commits to the ones matching the
given idents.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

[ On top of the git-rev-list(1) update posted earlier ... ]

Linus Torvalds <torvalds@osdl.org> wrote Mon, Aug 28, 2006:
> Th[e] trivial approach doesn't allow "gitk" to show the results sanely, 
> though (to do that, you'd need to make the commit matching be part of the 
> parent simplification instead - that would be extra bonus points for the 
> intrpid git hacker-wannabe)

Hereby serving one patch doing the trivial thing very stupid, since I
didn't have the imagination to go and hunt for the bonus points just
yet.

 Documentation/git-rev-list.txt |    6 +++++
 builtin-rev-list.c             |    3 ++
 revision.c                     |   53 ++++++++++++++++++++++++++++++++++++++++
 revision.h                     |    2 ++
 4 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index d6c86db..4d5f5ab 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -12,6 +12,8 @@ SYNOPSIS
 'git-rev-list' [ \--max-count=number ]
 	     [ \--max-age=timestamp ]
 	     [ \--min-age=timestamp ]
+	     [ \--author=string ]
+	     [ \--committer=string ]
 	     [ \--sparse ]
 	     [ \--no-merges ]
 	     [ \--remove-empty ]
@@ -153,6 +155,10 @@ limiting may be applied.
 
 	Limit the commits output to specified time range.
 
+--author='string', --committer='string'::
+
+	Limit the commits output to specified author and/or committer.
+
 --remove-empty::
 
 	Stop when a given path disappears from the tree.
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 402af8e..09e3d37 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -352,7 +352,8 @@ int cmd_rev_list(int argc, const char **
 	    revs.diff)
 		usage(rev_list_usage);
 
-	save_commit_buffer = revs.verbose_header;
+	if (!revs.author_pattern && !revs.committer_pattern)
+		save_commit_buffer = revs.verbose_header;
 	track_object_refs = 0;
 	if (bisect_list)
 		revs.limited = 1;
diff --git a/revision.c b/revision.c
index b588f74..31618fe 100644
--- a/revision.c
+++ b/revision.c
@@ -671,6 +671,14 @@ int setup_revisions(int argc, const char
 				revs->min_age = approxidate(arg + 8);
 				continue;
 			}
+			if (!strncmp(arg, "--author=", 9)) {
+				revs->author_pattern = arg + 9;
+				continue;
+			}
+			if (!strncmp(arg, "--committer=", 12)) {
+				revs->committer_pattern = arg + 12;
+				continue;
+			}
 			if (!strcmp(arg, "--all")) {
 				handle_all(revs, flags);
 				continue;
@@ -1015,6 +1023,47 @@ static void mark_boundary_to_show(struct
 	}
 }
 
+static int commit_match_ident(struct commit *commit, const char *field, const char *pattern)
+{
+	const char *pos;
+	int field_len;
+	int pattern_len;
+
+	if (!pattern)
+		return 1;
+
+	field_len = strlen(field);
+	pattern_len = strlen(pattern);
+
+	for (pos = commit->buffer; *pos != '\n'; pos++) {
+		const char *line_end = strchr(pos, '\n');
+
+		if (!strncmp(pos, field, field_len) &&
+		    pos[field_len] == ' ') {
+			const char *ident_end = line_end;
+
+			pos += field_len;
+			while (ident_end > pos && ident_end[-1] != '>')
+				ident_end--;
+
+			/* A slow "strncasestr" */
+			while (pos + pattern_len <= ident_end) {
+				if (!strncasecmp(pos, pattern, pattern_len))
+					return 1;
+				pos++;
+			}
+
+			/* Assumes that fields that should be matched only
+			 * appear once in the commit header. */
+			return 0;
+		}
+
+		pos = line_end;
+	}
+
+	return 0;
+}
+
 struct commit *get_revision(struct rev_info *revs)
 {
 	struct commit_list *list = revs->commits;
@@ -1074,6 +1123,10 @@ struct commit *get_revision(struct rev_i
 		if (revs->no_merges &&
 		    commit->parents && commit->parents->next)
 			continue;
+		if (!commit_match_ident(commit, "author", revs->author_pattern))
+			continue;
+		if (!commit_match_ident(commit, "committer", revs->committer_pattern))
+			continue;
 		if (revs->prune_fn && revs->dense) {
 			/* Commit without changes? */
 			if (!(commit->object.flags & TREECHANGE)) {
diff --git a/revision.h b/revision.h
index d289781..7688e3a 100644
--- a/revision.h
+++ b/revision.h
@@ -71,6 +71,8 @@ struct rev_info {
 	int max_count;
 	unsigned long max_age;
 	unsigned long min_age;
+	const char *author_pattern;
+	const char *committer_pattern;
 
 	/* diff info for patches and for paths limiting */
 	struct diff_options diffopt;
-- 
1.4.2.g2ba6b-dirty

-- 
Jonas Fonseca
