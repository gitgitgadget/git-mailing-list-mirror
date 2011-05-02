From: Michael Grubb <devel@dailyvoid.com>
Subject: [PATCH] Add default merge options for all branches
Date: Mon, 02 May 2011 11:19:42 -0500
Message-ID: <4DBED99E.3050709@dailyvoid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: vmiklos@frugalware.org, deskinm@umich.edu, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 20:03:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGxTL-00060c-9q
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 20:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755536Ab1EBSDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 14:03:39 -0400
Received: from 75.98.162.166.static.a2webhosting.com ([75.98.162.166]:36265
	"EHLO dailyvoid.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754344Ab1EBSDi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 14:03:38 -0400
X-Greylist: delayed 6231 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 May 2011 14:03:38 EDT
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=dailyvoid.com;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
	b=nlrRmlWMQiHlsXAdqde3GqvaJTQZecSU4QLr6o5t8mUyvDR7ZPRiuG0hLqkKz83W3cHY/bodaOFZBkO4bIGwXihQTGLRlBcmasoLRzND0D5T6bnaNJ2d3QKw/my0N1iK;
Received: from adsl-99-59-251-170.dsl.ltrkar.sbcglobal.net ([99.59.251.170] helo=macbook.local)
	by a2s24.a2hosting.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <devel@dailyvoid.com>)
	id 1QGvqZ-0003zi-A8; Mon, 02 May 2011 12:19:43 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - a2s24.a2hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - dailyvoid.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172610>

Introduce a new configuration variable, merge.mergeoptions.
The semantics of this new variable are the same as the branch specific
branch.<branch>.mergeoptions.  However, if a branch specific setting is
found, this option will not override it.

The need for this arises from the fact that there is currently not an
easy way to set merge options for all branches. Instead of having to
specify merge options for each individual branch there should be a way
to set defaults for all branches and then override a specific branch's
options.

The approach taken is to make note of whether a branch specific
mergeoptions key has been seen and only apply the global value if it
hasn't. An alternative method would be to keep the
branch.<branch>.mergeoptions semantics, but assign a special value for
<branch> to be the global default.

Signed-off-by: Michael Grubb <devel@dailyvoid.com>
---
 Documentation/merge-config.txt |    7 +++++++
 builtin/merge.c                |   27 ++++++++++++++++++++++-----
 t/t7600-merge.sh               |   27 +++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 8920258..0fc7511 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -57,6 +57,13 @@ merge.verbosity::
 	above outputs debugging information.  The default is level 2.
 	Can be overridden by the 'GIT_MERGE_VERBOSITY' environment variable.
 +merge.mergeoptions::
+	Sets default options for merging any branch. This value is only
+	used if there is not a branch.<name>.mergeoptions value set.
+	The syntax and supported options are the same as those of 'git
+	merge', but option values containing whitespace characters are
+	currently not supported.
+
 merge.<driver>.name::
 	Defines a human-readable name for a custom low-level
 	merge driver.  See linkgit:gitattributes[5] for details.
diff --git a/builtin/merge.c b/builtin/merge.c
index 0bdd19a..1d4f852 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -505,9 +505,18 @@ cleanup:
  static int git_merge_config(const char *k, const char *v, void *cb)
 {
-	if (branch && !prefixcmp(k, "branch.") &&
-		!prefixcmp(k + 7, branch) &&
-		!strcmp(k + 7 + strlen(branch), ".mergeoptions")) {
+	static int branch_merge_options_set = 0;
+	int merge_option_mode = 0;
+
+	if ( !strcmp(k, "merge.mergeoptions") )
+		merge_option_mode = 1;
+	else if ( branch && !prefixcmp(k, "branch.") &&
+			 !prefixcmp(k + 7, branch) &&
+			 !strcmp(k + 7 + strlen(branch), ".mergeoptions"))
+		merge_option_mode = 2;
+
+	if ( (merge_option_mode == 1 && !branch_merge_options_set) ||
+		  merge_option_mode == 2) {
 		const char **argv;
 		int argc;
 		char *buf;
@@ -515,14 +524,22 @@ static int git_merge_config(const char *k, const
char *v, void *cb)
 		buf = xstrdup(v);
 		argc = split_cmdline(buf, &argv);
 		if (argc < 0)
-			die(_("Bad branch.%s.mergeoptions string: %s"), branch,
-			    split_cmdline_strerror(argc));
+		{
+			if ( merge_option_mode == 1 )
+				die(_("Bad merge.mergeoptions string: %s"), +				
split_cmdline_strerror(argc));
+			else
+				die(_("Bad branch.%s.mergeoptions string: %s"), branch,
+					split_cmdline_strerror(argc));
+		}
 		argv = xrealloc(argv, sizeof(*argv) * (argc + 2));
 		memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
 		argc++;
 		parse_options(argc, argv, NULL, builtin_merge_options,
 			      builtin_merge_usage, 0);
 		free(buf);
+		if ( merge_option_mode == 2 )
+			branch_merge_options_set = 1;
 	}
  	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 87d5d78..15e9418 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -415,6 +415,33 @@ test_expect_success 'merge c0 with c1 (no-ff)' '
  test_debug 'git log --graph --decorate --oneline --all'
 +test_expect_success 'merge c0 with c1 (global no-ff)' '
+	git reset --hard c0 &&
+	git config --unset branch.master.mergeoptions &&
+	git config merge.mergeoptions "--no-ff" &&
+	test_tick &&
+	git merge c1 &&
+	git config --remove-section merge &&
+	verify_merge file result.1 &&
+	verify_parents $c0 $c1
+'
+
+test_debug 'git log --graph --decorate --oneline --all'
+
+test_expect_success 'combine merge.mergeoptions with
branch.x.mergeoptions' '
+	git reset --hard c0 &&
+	git config --remove-section branch.master &&
+	git config merge.mergeoptions "--no-ff" &&
+	git config branch.master.mergeoptions "--ff" &&
+	test_tick &&
+	git merge c1 &&
+	git config --remove-section merge &&
+	verify_merge file result.1 &&
+	verify_parents "$c0"
+'
+
+test_debug 'git log --graph --decorate --oneline --all'
+
 test_expect_success 'combining --squash and --no-ff is refused' '
 	test_must_fail git merge --squash --no-ff c1 &&
 	test_must_fail git merge --no-ff --squash c1
-- 
1.7.5
