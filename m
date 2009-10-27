From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Add '--bisect' revision machinery argument
Date: Tue, 27 Oct 2009 11:28:07 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0910271124110.31845@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 19:28:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2qmm-0001xt-8h
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 19:28:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755777AbZJ0S2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 14:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755683AbZJ0S2i
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 14:28:38 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49633 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755635AbZJ0S2h (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2009 14:28:37 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n9RIS7Kv022307
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 27 Oct 2009 11:28:08 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n9RIS74A015997;
	Tue, 27 Oct 2009 11:28:07 -0700
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.463 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131365>


I personally use "git bisect visualize" all the time when I bisect, but it 
turns out that that is not a very flexible model. Sometimes I want to do 
bisection based on all commits (no pathname limiting), but then visualize 
the current bisection tree with just a few pathnames because I _suspect_ 
those pathnames are involved in the problem but am not totally sure about 
them.

And at other times, I want to use other revision parsing logic, none of 
which is available with "git bisect visualize".

So this adds "--bisect" as a revision parsing argument, and as a result it 
just works with all the normal logging tools. So now I can just do

	gitk --bisect --simplify-by-decoration filename-here

etc.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 builtin-rev-parse.c |   11 +++++++++++
 revision.c          |   18 +++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 45bead6..9526aaf 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -180,6 +180,12 @@ static int show_reference(const char *refname, const unsigned char *sha1, int fl
 	return 0;
 }
 
+static int anti_reference(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+{
+	show_rev(REVERSED, sha1, refname);
+	return 0;
+}
+
 static void show_datestring(const char *flag, const char *datestr)
 {
 	static char buffer[100];
@@ -548,6 +554,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				for_each_ref(show_reference, NULL);
 				continue;
 			}
+			if (!strcmp(arg, "--bisect")) {
+				for_each_ref_in("refs/bisect/bad", show_reference, NULL);
+				for_each_ref_in("refs/bisect/good", anti_reference, NULL);
+				continue;
+			}
 			if (!strcmp(arg, "--branches")) {
 				for_each_branch_ref(show_reference, NULL);
 				continue;
diff --git a/revision.c b/revision.c
index 9fc4e8d..80a0528 100644
--- a/revision.c
+++ b/revision.c
@@ -994,7 +994,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	if (!strcmp(arg, "--all") || !strcmp(arg, "--branches") ||
 	    !strcmp(arg, "--tags") || !strcmp(arg, "--remotes") ||
 	    !strcmp(arg, "--reflog") || !strcmp(arg, "--not") ||
-	    !strcmp(arg, "--no-walk") || !strcmp(arg, "--do-walk"))
+	    !strcmp(arg, "--no-walk") || !strcmp(arg, "--do-walk") ||
+	    !strcmp(arg, "--bisect"))
 	{
 		unkv[(*unkc)++] = arg;
 		return 1;
@@ -1218,6 +1219,16 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 	ctx->argc -= n;
 }
 
+static int for_each_bad_bisect_ref(each_ref_fn fn, void *cb_data)
+{
+	return for_each_ref_in("refs/bisect/bad", fn, cb_data);
+}
+
+static int for_each_good_bisect_ref(each_ref_fn fn, void *cb_data)
+{
+	return for_each_ref_in("refs/bisect/good", fn, cb_data);
+}
+
 /*
  * Parse revision information, filling in the "rev_info" structure,
  * and removing the used arguments from the argument list.
@@ -1259,6 +1270,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				handle_refs(revs, flags, for_each_branch_ref);
 				continue;
 			}
+			if (!strcmp(arg, "--bisect")) {
+				handle_refs(revs, flags, for_each_bad_bisect_ref);
+				handle_refs(revs, flags ^ UNINTERESTING, for_each_good_bisect_ref);
+				continue;
+			}
 			if (!strcmp(arg, "--tags")) {
 				handle_refs(revs, flags, for_each_tag_ref);
 				continue;
