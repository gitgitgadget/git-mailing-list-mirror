From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/24] merge-base --octopus to mimic show-branch
 --merge-base
Date: Tue, 17 Aug 2010 02:01:15 -0500
Message-ID: <20100817070115.GI22057@burratino>
References: <20100817065147.GA18293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 09:03:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlGCL-00087l-Ip
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 09:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756692Ab0HQHC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 03:02:56 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54125 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756641Ab0HQHCz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 03:02:55 -0400
Received: by gwj17 with SMTP id 17so1308237gwj.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 00:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=S4WufD5/tTI1Wh6QS2K/v1DpU5RrGDFdtr6DyO1Ivu8=;
        b=inKP+ejPIi96frQm8b1Z4Ap1DbXNWFDY4wJDdPx0HKPQkXKkAl/MvkXiZ27Yq85X6t
         YO+RemJtewDCSAPvRcns5QbV251PLdj6pQCB4cRcDkP0zXzOP2c7e69rYkukgF+T6UkY
         RQpPwmaQ2dIaqx7QBSfrPHvfCMovai1FaPVJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Z7GUem/v2iOb4xdldE76gYvd9UST8cPPyrXQ8M0h+upEmImvHpnyHMDGF8GY+w/sJU
         W3zJdEsDlDzRpxrDxaImmEeXvcRLjUeFNLF1d3PslM89WPOOIuj7XFZdU5CKviMCPFZ4
         jueFP2K5M4BmmT0aSADr1HlunZVDTWnJZybts=
Received: by 10.151.63.23 with SMTP id q23mr6816905ybk.133.1282028575294;
        Tue, 17 Aug 2010 00:02:55 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id u41sm568770yba.13.2010.08.17.00.02.54
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 00:02:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817065147.GA18293@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153712>

While show-branch --merge-base does not support more than MAX_REVS
revs, git supports more with a different algorithm
(v1.6.0-rc0~51^2~13, Introduce get_octopus_merge_bases() in commit.c,
2008-06-27).  Expose that functionality.

This should help scripts to catch up with builtin merge in supporting
dodecapus.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-merge-base.txt |   19 ++++++++++++-------
 builtin/merge-base.c             |   35 ++++++++++++++++++++++++++++++++---
 t/t6010-merge-base.sh            |    2 ++
 3 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 09b34b0..125207e 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -8,7 +8,7 @@ git-merge-base - Find as good common ancestors as possible for a merge
 
 SYNOPSIS
 --------
-'git merge-base' [-a|--all] <commit> <commit>...
+'git merge-base' [-a|--all] [--octopus] <commit> <commit>...
 
 DESCRIPTION
 -----------
@@ -20,12 +20,12 @@ that does not have any better common ancestor is a 'best common
 ancestor', i.e. a 'merge base'.  Note that there can be more than one
 merge base for a pair of commits.
 
-Among the two commits to compute the merge base from, one is specified by
-the first commit argument on the command line; the other commit is a
-(possibly hypothetical) commit that is a merge across all the remaining
-commits on the command line.  As the most common special case, specifying only
-two commits on the command line means computing the merge base between
-the given two commits.
+Unless `--octopus` is given, among the two commits to compute the merge
+base from, one is specified by the first commit argument on the command
+line; the other commit is a (possibly hypothetical) commit that is a merge
+across all the remaining commits on the command line.  As the most common
+special case, specifying only two commits on the command line means
+computing the merge base between the given two commits.
 
 As a consequence, the 'merge base' is not necessarily contained in each of the
 commit arguments if more than two commits are specified. This is different
@@ -37,6 +37,11 @@ OPTIONS
 --all::
 	Output all merge bases for the commits, instead of just one.
 
+--octopus::
+	Compute the best common ancestors of all supplied commits,
+	in preparation for an n-way merge.  This mimics the behavior
+	of 'git show-branch --merge-base'.
+
 DISCUSSION
 ----------
 
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 54e7ec2..c301286 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -23,7 +23,7 @@ static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 }
 
 static const char * const merge_base_usage[] = {
-	"git merge-base [-a|--all] <commit> <commit>...",
+	"git merge-base [-a|--all] [--octopus] <commit> <commit>...",
 	NULL
 };
 
@@ -41,21 +41,50 @@ static struct commit *get_commit_reference(const char *arg)
 	return r;
 }
 
+static int show_octopus_merge_bases(int count, const char **args, int show_all)
+{
+	struct commit_list *revs = NULL;
+	struct commit_list *result;
+	int i;
+
+	for (i = count - 1; i >= 0; i++)
+		commit_list_insert(get_commit_reference(args[i]), &revs);
+	result = get_octopus_merge_bases(revs);
+
+	if (!result)
+		return 1;
+
+	while (result) {
+		printf("%s\n", sha1_to_hex(result->item->object.sha1));
+		if (!show_all)
+			return 0;
+		result = result->next;
+	}
+
+	return 0;
+}
+
 int cmd_merge_base(int argc, const char **argv, const char *prefix)
 {
 	struct commit **rev;
 	int rev_nr = 0;
 	int show_all = 0;
+	int octopus = 0;
 
 	struct option options[] = {
-		OPT_BOOLEAN('a', "all", &show_all, "outputs all common ancestors"),
+		OPT_BOOLEAN('a', "all", &show_all, "output all common ancestors"),
+		OPT_BOOLEAN(0, "octopus", &octopus, "find ancestors for a single n-way merge"),
 		OPT_END()
 	};
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, merge_base_usage, 0);
-	if (argc < 2)
+	if (!octopus && argc < 2)
 		usage_with_options(merge_base_usage, options);
+
+	if (octopus)
+		return show_octopus_merge_bases(argc, argv, show_all);
+
 	rev = xmalloc(argc * sizeof(*rev));
 	while (argc-- > 0)
 		rev[rev_nr++] = get_commit_reference(*argv++);
diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index 4466e45..001431b 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -164,9 +164,11 @@ test_expect_success 'merge-base A B C' '
 	git rev-parse --verify MMR >expected.sb &&
 
 	git merge-base --all MMA MMB MMC >actual &&
+	git merge-base --all --octopus MMA MMB MMC >actual.common &&
 	git show-branch --merge-base MMA MMB MMC >actual.sb &&
 
 	test_cmp expected actual &&
+	test_cmp expected.sb actual.common &&
 	test_cmp expected.sb actual.sb
 '
 
-- 
1.7.2.1.544.ga752d.dirty
