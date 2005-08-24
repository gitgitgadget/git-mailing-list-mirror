From: Junio C Hamano <junkio@cox.net>
Subject: Re: Automatic merge failed, fix up by hand
Date: Tue, 23 Aug 2005 18:07:50 -0700
Message-ID: <7v3bp0m9ax.fsf@assigned-by-dhcp.cox.net>
References: <1124831571.13042.27.camel@firebird.lenb.worldpath.net>
	<7vhddgnw9q.fsf@assigned-by-dhcp.cox.net>
	<1124836282.14730.4.camel@toshiba>
	<7vzmr8mci2.fsf@assigned-by-dhcp.cox.net>
	<7vek8kmb2a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 03:09:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7jlV-0007Y9-Pz
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 03:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVHXBHy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 21:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVHXBHy
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 21:07:54 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:167 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750785AbVHXBHx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 21:07:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050824010749.ESXI19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 23 Aug 2005 21:07:49 -0400
To: Len Brown <len.brown@intel.com>
In-Reply-To: <7vek8kmb2a.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 23 Aug 2005 17:29:49 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7695>

Junio C Hamano <junkio@cox.net> writes:

> Probably the ideal way would be to give merge-base an option to
> spit out all the candidates, and have the script try to see
> which ones yield the least number of non-trivial merges.

I first checked out your 702c7e.. commit, and slurped Linus tip
(back then, 81065e2f415af6c028eac13f481fb9e60a0b487b).  Then I
ran git resolve with the attached patch (against the tip of
git.git "master" branch).  Here is what happened, which seems to
work a little bit better, at least to me.

    prompt$ git checkout -f
    prompt$ git status
    nothing to commit
    prompt$ ls -l .git/HEAD
    lrwxrwxrwx  1 junio src 26 Aug 23 15:43 .git/HEAD -> refs/heads/lenb
    prompt$ git resolve HEAD origin 'Merge Linus into Lenb'
    Trying to find the optimum merge base
    Trying to merge 81065e2f415af6c028eac13f481fb9e60a0b487b into 702c7e7626deeabb057b6f529167b65ec2eefbdb using 3edea4833a1efcd43e1dff082bc8001fdfe74b34
    Simple merge failed, trying Automatic merge
    Auto-merging Documentation/acpi-hotkey.txt.
    merge: warning: conflicts during merge
    ERROR: Merge conflict in Documentation/acpi-hotkey.txt.
    Auto-merging drivers/acpi/osl.c.
    fatal: merge program failed
    Automatic merge failed, fix up by hand

Only lightly tested, in the sense that I did only this one case
and nothing else.  For a large repository and with complex
merges, "merge-base -a" _might_ end up reporting many
candidates, in which case the pre-merge step to figure out the
best merge base may turn out to be disastrously slow.  I dunno.


---
git diff HEAD
diff --git a/git-resolve-script b/git-resolve-script
--- a/git-resolve-script
+++ b/git-resolve-script
@@ -49,7 +49,42 @@ if [ "$common" == "$head" ]; then
 	dropheads
 	exit 0
 fi
-echo "Trying to merge $merge into $head"
+
+# Find optimum merge base if there are more than one candidate.
+LF='
+'
+common=$(git-merge-base -a $head $merge)
+case "$common" in
+?*"$LF"?*)
+	echo "Trying to find the optimum merge base"
+	G=.tmp-index$$
+	best=
+	best_cnt=-1
+	for c in $common
+	do
+		rm -f $G
+		GIT_INDEX_FILE=$G git-read-tree -m $c $head $merge \
+			2>/dev/null || continue
+		if GIT_INDEX_FILE=$G git-write-tree 2>/dev/null
+		then
+			# This one results in just a Simple merge;
+			# It cannot become better than this.
+			best=$c
+			break
+		fi
+		# Otherwise, count the paths that are unmerged.
+		cnt=`GIT_INDEX_FILE=$G git-ls-files --unmerged | wc -l`
+		if test $best_cnt -le 0 -o $cnt -le $best_cnt
+		then
+			best=$c
+			best_cnt=$cnt
+		fi
+	done
+	rm -f $G
+	common="$best"
+esac
+
+echo "Trying to merge $merge into $head using $common"
 git-read-tree -u -m $common $head $merge || exit 1
 result_tree=$(git-write-tree  2> /dev/null)
 if [ $? -ne 0 ]; then
diff --git a/merge-base.c b/merge-base.c
--- a/merge-base.c
+++ b/merge-base.c
@@ -82,13 +82,17 @@ static struct commit *interesting(struct
  * commit B.
  */
 
-static struct commit *common_ancestor(struct commit *rev1, struct commit *rev2)
+static int show_all = 0;
+
+static int merge_base(struct commit *rev1, struct commit *rev2)
 {
 	struct commit_list *list = NULL;
 	struct commit_list *result = NULL;
 
-	if (rev1 == rev2)
-		return rev1;
+	if (rev1 == rev2) {
+		printf("%s\n", sha1_to_hex(rev1->object.sha1));
+		return 0;
+	}
 
 	parse_commit(rev1);
 	parse_commit(rev2);
@@ -108,7 +112,7 @@ static struct commit *common_ancestor(st
 		if (flags == 3) {
 			insert_by_date(commit, &result);
 
-			/* Mark children of a found merge uninteresting */
+			/* Mark parents of a found merge uninteresting */
 			flags |= UNINTERESTING;
 		}
 		parents = commit->parents;
@@ -122,26 +126,46 @@ static struct commit *common_ancestor(st
 			insert_by_date(p, &list);
 		}
 	}
-	return interesting(result);
+
+	if (!result)
+		return 1;
+
+	while (result) {
+		struct commit *commit = result->item;
+		result = result->next;
+		if (commit->object.flags & UNINTERESTING)
+			continue;
+		printf("%s\n", sha1_to_hex(commit->object.sha1));
+		if (!show_all)
+			return 0;
+		commit->object.flags |= UNINTERESTING;
+	}
+	return 0;
 }
 
+static const char merge_base_usage[] =
+"git-merge-base [--all] <commit-id> <commit-id>";
+
 int main(int argc, char **argv)
 {
-	struct commit *rev1, *rev2, *ret;
+	struct commit *rev1, *rev2;
 	unsigned char rev1key[20], rev2key[20];
 
+	while (1 < argc && argv[1][0] == '-') {
+		char *arg = argv[1];
+		if (!strcmp(arg, "-a") || !strcmp(arg, "--all"))
+			show_all = 1;
+		else
+			usage(merge_base_usage);
+		argc--; argv++;
+	}
 	if (argc != 3 ||
 	    get_sha1(argv[1], rev1key) ||
-	    get_sha1(argv[2], rev2key)) {
-		usage("git-merge-base <commit-id> <commit-id>");
-	}
+	    get_sha1(argv[2], rev2key))
+		usage(merge_base_usage);
 	rev1 = lookup_commit_reference(rev1key);
 	rev2 = lookup_commit_reference(rev2key);
 	if (!rev1 || !rev2)
 		return 1;
-	ret = common_ancestor(rev1, rev2);
-	if (!ret)
-		return 1;
-	printf("%s\n", sha1_to_hex(ret->object.sha1));
-	return 0;
+	return merge_base(rev1, rev2);
 }
