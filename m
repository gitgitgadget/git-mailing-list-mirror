X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Mon, 18 Dec 2006 14:04:38 -0800
Message-ID: <7vzm9kvp1l.fsf@assigned-by-dhcp.cox.net>
References: <7v64c93bs5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612181012280.3479@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 18 Dec 2006 22:04:50 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612181012280.3479@woody.osdl.org> (Linus
	Torvalds's message of "Mon, 18 Dec 2006 10:16:12 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34742>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwQbD-0000g0-Km for gcvg-git@gmane.org; Mon, 18 Dec
 2006 23:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754671AbWLRWEl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 17:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754676AbWLRWEl
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 17:04:41 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:41323 "EHLO
 fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1754671AbWLRWEk (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 17:04:40 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061218220439.YLOP2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>; Mon, 18
 Dec 2006 17:04:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 0N3x1W00o1kojtg0000000; Mon, 18 Dec 2006
 17:03:58 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 17 Dec 2006, Junio C Hamano wrote:
>> 
>>  - blame A..B's output shows lines attributed to the boundary
>>    commit with commit SHA-1 prefixed with '^';
>
> I wonder if it would make sense to have a flag or mode or something where 
> boundary commit attributions are simply left unattributed (ie just leave 
> that _empty_).

How about this?

-- >8 --
blame: -b (blame.blankboundary) and --root (blame.showroot)

When blame.blankboundary is set (or -b option is given), commit
object names are blanked out in the "human readable" output
format for boundary commits.

When blame.showroot is not set (or --root is not given), the
root commits are treated as boundary commits.  The code still
attributes the lines to them, but with -b their object names are
not shown.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 builtin-blame.c |   33 +++++++++++++++++++++++++++++++--
 1 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index a250724..211bdb3 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -22,7 +22,9 @@
 static char blame_usage[] =
 "git-blame [-c] [-l] [-t] [-f] [-n] [-p] [-L n,m] [-S <revs-file>] [-M] [-C] [-C] [commit] [--] file\n"
 "  -c, --compatibility Use the same output mode as git-annotate (Default: off)\n"
+"  -b                  Show blank SHA-1 for boundary commits (Default: off)\n"
 "  -l, --long          Show long commit SHA1 (Default: off)\n"
+"  --root              Do not treat root commits as boundaries (Default: off)\n"
 "  -t, --time          Show raw timestamp (Default: off)\n"
 "  -f, --show-name     Show original filename (Default: auto)\n"
 "  -n, --show-number   Show original linenumber (Default: off)\n"
@@ -36,6 +38,8 @@ static int longest_author;
 static int max_orig_digits;
 static int max_digits;
 static int max_score_digits;
+static int show_root;
+static int blank_boundary;
 
 #ifndef DEBUG
 #define DEBUG 0
@@ -1095,6 +1099,9 @@ static void assign_blame(struct scoreboard *sb, struct rev_info *revs, int opt)
 			if (commit->object.parsed)
 				mark_parents_uninteresting(commit);
 		}
+		/* treat root commit as boundary */
+		if (!commit->parents && !show_root)
+			commit->object.flags |= UNINTERESTING;
 
 		/* Take responsibility for the remaining entries */
 		for (ent = sb->ent; ent; ent = ent->next)
@@ -1318,8 +1325,12 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? 40 : 8;
 
 		if (suspect->commit->object.flags & UNINTERESTING) {
-			length--;
-			putchar('^');
+			if (!blank_boundary) {
+				length--;
+				putchar('^');
+			}
+			else
+				memset(hex, ' ', length);
 		}
 
 		printf("%.*s", length, hex);
@@ -1639,6 +1650,19 @@ static void prepare_blame_range(struct scoreboard *sb,
 		usage(blame_usage);
 }
 
+static int git_blame_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "blame.showroot")) {
+		show_root = git_config_bool(var, value);
+		return 0;
+	}
+	if (!strcmp(var, "blame.blankboundary")) {
+		blank_boundary = git_config_bool(var, value);
+		return 0;
+	}
+	return git_default_config(var, value);
+}
+
 int cmd_blame(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -1654,6 +1678,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	char type[10];
 	const char *bottomtop = NULL;
 
+	git_config(git_blame_config);
 	save_commit_buffer = 0;
 
 	opt = 0;
@@ -1662,6 +1687,10 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		const char *arg = argv[i];
 		if (*arg != '-')
 			break;
+		else if (!strcmp("-b", arg))
+			blank_boundary = 1;
+		else if (!strcmp("--root", arg))
+			show_root = 1;
 		else if (!strcmp("-c", arg))
 			output_option |= OUTPUT_ANNOTATE_COMPAT;
 		else if (!strcmp("-t", arg))
