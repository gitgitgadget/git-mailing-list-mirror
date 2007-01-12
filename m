From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 11 Jan 2007 22:15:07 -0800
Message-ID: <7vr6u0wz2s.fsf@assigned-by-dhcp.cox.net>
References: <7vr6u3cmsi.fsf@assigned-by-dhcp.cox.net>
	<7v3b6i75i5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701102241230.4964@xanadu.home>
	<20070111080035.GA28222@spearce.org> <45A6016B.4030800@op5.se>
	<Pine.LNX.4.64.0701110955100.4964@xanadu.home>
	<45A65F15.6040606@op5.se> <20070112004927.GB23864@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 07:15:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5Fh3-0004RD-Ph
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 07:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160995AbXALGPK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 01:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbXALGPK
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 01:15:10 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:51407 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1160995AbXALGPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 01:15:09 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070112061508.GTGR18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jan 2007 01:15:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id A6EG1W00K1kojtg0000000; Fri, 12 Jan 2007 01:14:17 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070112004927.GB23864@spearce.org> (Shawn O. Pearce's message
	of "Thu, 11 Jan 2007 19:49:27 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36662>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Only on tags which are considered possible matches.  What we do
> now is we walk back along the commit history until we find a commit
> which has a tag pointing at it.  As soon as we find that commit we
> enqueue its corresponding tag into a list and completely ignore its
> parents, aborting listing any further back.  So we really only pay
> the bare minimum price here.

This actually is QUITE bad.

With the tip of linux-2.6 repository, v1.4.4 series takes 0.03s
while v1.5.0-rc1 takes about 3.6s.  That is 100x fold, not just
4x.

It turns out that to describe 0404f87f (tip of linux-2.6) the
new one picks up 61 tags in the posible-tag loop.

Since this loop uses the usual date-order, we can limit the
number of candidate tags without losing too much precision.
When limiting the candidates to only 6 (attached patch), the
time drops to 0.25s.

--- 
diff --git a/builtin-describe.c b/builtin-describe.c
index a8c98ce..a1ecec2 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -12,6 +12,7 @@ static const char describe_usage[] =
 
 static int all;	/* Default to annotated tags only */
 static int tags;	/* But allow any tags if --tags is specified */
+static int debug;
 
 static int abbrev = DEFAULT_ABBREV;
 
@@ -113,6 +114,7 @@ static void describe(const char *arg, int last_one)
 	static int initialized = 0;
 	struct commit_name *n;
 	struct possible_tag *all_matches, *min_match, *cur_match;
+	int cnt;
 
 	if (get_sha1(arg, sha1))
 		die("Not a valid object name %s", arg);
@@ -136,6 +138,7 @@ static void describe(const char *arg, int last_one)
 	all_matches = NULL;
 	cur_match = NULL;
 	commit_list_insert(cmit, &list);
+	cnt = 6;
 	while (list) {
 		struct commit *c = pop_commit(&list);
 		n = match(c);
@@ -148,6 +151,8 @@ static void describe(const char *arg, int last_one)
 			else
 				all_matches = p;
 			cur_match = p;
+			if (--cnt <= 0)
+				break;
 		} else {
 			struct commit_list *parents = c->parents;
 			while (parents) {
@@ -161,6 +166,18 @@ static void describe(const char *arg, int last_one)
 			}
 		}
 	}
+	if (list)
+		free_commit_list(list);
+
+	if (debug) {
+		int cnt = 0;
+		for (cur_match = all_matches;
+		     cur_match;
+		     cur_match = cur_match->next)
+			cnt++;
+		fprintf(stderr, "%d candidates for %s\n", cnt,
+			sha1_to_hex(cmit->object.sha1));
+	}
 
 	if (!all_matches)
 		die("cannot describe '%s'", sha1_to_hex(cmit->object.sha1));
@@ -210,6 +227,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			all = 1;
 		else if (!strcmp(arg, "--tags"))
 			tags = 1;
+		else if (!strcmp(arg, "--debug"))
+			debug = 1;
 		else if (!strncmp(arg, "--abbrev=", 9)) {
 			abbrev = strtoul(arg + 9, NULL, 10);
 			if (abbrev < MINIMUM_ABBREV || 40 < abbrev)
