From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/24] merge-base --independent to print reduced parent
 list in a merge
Date: Tue, 17 Aug 2010 02:01:54 -0500
Message-ID: <20100817070154.GJ22057@burratino>
References: <20100817065147.GA18293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 09:03:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlGCt-0008HX-Tx
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 09:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756708Ab0HQHDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 03:03:30 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50784 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756573Ab0HQHDa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 03:03:30 -0400
Received: by gxk23 with SMTP id 23so2287634gxk.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 00:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=4jsX8Z5D05vOFaYPlqRI4S8Et4iP8HCBdN0A2YsYKsg=;
        b=JHL9r+9mSsHtQs+KBdfOWGCw7RXdYCwvFO7uq+i7V0B6eJeKT2C2SiHxWAs9J96GhN
         rO7hTmYXecNJytoelXxn4EffU41ReZROR9+pahqIg81lPF9IQ8/HazGy7nfiUOB9DeqR
         0FVnY9t8YEq7/rJyIzQp5YS11leF6XVvDzoyY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pXEak61O9lD97xqijc9SrKJ0RQal467sFvsGPNltvSerzqCve+s1LLYmbhwMjbjGB0
         nvM4O2z6Qz80tDdAbJvG/1+n/vjHiUHWx6Qx1gTJv9qeefhzXfQopw08js0b7M/hH1/A
         Mm86h1f2LGHsZDMvHyVyLmhPvnRkAMHlYvfwQ=
Received: by 10.100.154.15 with SMTP id b15mr7097513ane.20.1282028609318;
        Tue, 17 Aug 2010 00:03:29 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id p12sm11757229ane.14.2010.08.17.00.03.28
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 00:03:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817065147.GA18293@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153713>

While show-branch --independent does not support more than MAX_REVS
revs, git internally supports more with a different algorithm.
Expose that functionality as "git merge-base --independent".

This should help scripts to catch up with builtin merge in supporting
dodecapus.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-merge-base.txt |    9 ++++++++
 builtin/merge-base.c             |   21 ++++++++++++++-----
 t/t6010-merge-base.sh            |   39 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 125207e..eedef1b 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -8,7 +8,9 @@ git-merge-base - Find as good common ancestors as possible for a merge
 
 SYNOPSIS
 --------
+[verse]
 'git merge-base' [-a|--all] [--octopus] <commit> <commit>...
+'git merge-base' --independent <commit>...
 
 DESCRIPTION
 -----------
@@ -42,6 +44,13 @@ OPTIONS
 	in preparation for an n-way merge.  This mimics the behavior
 	of 'git show-branch --merge-base'.
 
+--independent::
+	Instead of printing merge bases, print a minimal subset of
+	the supplied commits with the same ancestors.  In other words,
+	among the commits given, list those which cannot be reached
+	from any other.  This mimics the behavior of 'git show-branch
+	--independent'.
+
 DISCUSSION
 ----------
 
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index c301286..96dd160 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -24,6 +24,7 @@ static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 
 static const char * const merge_base_usage[] = {
 	"git merge-base [-a|--all] [--octopus] <commit> <commit>...",
+	"git merge-base --independent <commit>...",
 	NULL
 };
 
@@ -41,15 +42,19 @@ static struct commit *get_commit_reference(const char *arg)
 	return r;
 }
 
-static int show_octopus_merge_bases(int count, const char **args, int show_all)
+static int handle_octopus(int count, const char **args, int reduce, int show_all)
 {
 	struct commit_list *revs = NULL;
 	struct commit_list *result;
 	int i;
 
-	for (i = count - 1; i >= 0; i++)
+	if (reduce)
+		show_all = 1;
+
+	for (i = count - 1; i >= 0; i--)
 		commit_list_insert(get_commit_reference(args[i]), &revs);
-	result = get_octopus_merge_bases(revs);
+
+	result = reduce ? reduce_heads(revs) : get_octopus_merge_bases(revs);
 
 	if (!result)
 		return 1;
@@ -70,20 +75,24 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	int rev_nr = 0;
 	int show_all = 0;
 	int octopus = 0;
+	int reduce = 0;
 
 	struct option options[] = {
 		OPT_BOOLEAN('a', "all", &show_all, "output all common ancestors"),
 		OPT_BOOLEAN(0, "octopus", &octopus, "find ancestors for a single n-way merge"),
+		OPT_BOOLEAN(0, "independent", &reduce, "list revs not reachable from others"),
 		OPT_END()
 	};
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, merge_base_usage, 0);
-	if (!octopus && argc < 2)
+	if (!octopus && !reduce && argc < 2)
 		usage_with_options(merge_base_usage, options);
+	if (reduce && (show_all || octopus))
+		die("--independent cannot be used with other options");
 
-	if (octopus)
-		return show_octopus_merge_bases(argc, argv, show_all);
+	if (octopus || reduce)
+		return handle_octopus(argc, argv, reduce, show_all);
 
 	rev = xmalloc(argc * sizeof(*rev));
 	while (argc-- > 0)
diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index 001431b..62197a3 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
-test_description='Merge base computation.
+test_description='Merge base and parent list computation.
 '
 
 . ./test-lib.sh
@@ -75,6 +75,26 @@ test_expect_success 'merge-base G H' '
 	test_cmp expected actual.sb
 '
 
+test_expect_success 'merge-base/show-branch --independent' '
+	git name-rev "$H" >expected1 &&
+	git name-rev "$H" "$G" >expected2 &&
+
+	parents=$(git merge-base --independent H) &&
+	git name-rev $parents >actual1.mb &&
+	parents=$(git merge-base --independent A H G) &&
+	git name-rev $parents >actual2.mb &&
+
+	parents=$(git show-branch --independent H) &&
+	git name-rev $parents >actual1.sb &&
+	parents=$(git show-branch --independent A H G) &&
+	git name-rev $parents >actual2.sb &&
+
+	test_cmp expected1 actual1.mb &&
+	test_cmp expected2 actual2.mb &&
+	test_cmp expected1 actual1.sb &&
+	test_cmp expected2 actual2.sb
+'
+
 test_expect_success 'unsynchronized clocks' '
 	# This test is to demonstrate that relying on timestamps in a distributed
 	# SCM to provide a _consistent_ partial ordering of commits leads to
@@ -125,6 +145,23 @@ test_expect_success 'unsynchronized clocks' '
 	test_cmp expected actual.all
 '
 
+test_expect_success '--independent with unsynchronized clocks' '
+	IB=$(doit 0 IB) &&
+	I1=$(doit -10 I1 $IB) &&
+	I2=$(doit  -9 I2 $I1) &&
+	I3=$(doit  -8 I3 $I2) &&
+	I4=$(doit  -7 I4 $I3) &&
+	I5=$(doit  -6 I5 $I4) &&
+	I6=$(doit  -5 I6 $I5) &&
+	I7=$(doit  -4 I7 $I6) &&
+	I8=$(doit  -3 I8 $I7) &&
+	IH=$(doit  -2 IH $I8) &&
+
+	echo $IH >expected &&
+	git merge-base --independent IB IH >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'merge-base for octopus-step (setup)' '
 	# Another set to demonstrate base between one commit and a merge
 	# in the documentation.
-- 
1.7.2.1.544.ga752d.dirty
