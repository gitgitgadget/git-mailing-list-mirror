From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Submodules: Add the new config option "ignore"
Date: Thu, 5 Aug 2010 11:21:36 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1008051025451.2983@bonsai2>
References: <4C4DD33F.4020104@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Aug 05 11:21:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ogwe9-0006yU-1C
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 11:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758870Ab0HEJVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 05:21:47 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:56802 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1756839Ab0HEJVo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 05:21:44 -0400
Received: (qmail invoked by alias); 05 Aug 2010 09:21:42 -0000
Received: from pD9EB21D2.dip0.t-ipconnect.de (EHLO noname) [217.235.33.210]
  by mail.gmx.net (mp026) with SMTP; 05 Aug 2010 11:21:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18CfsILPW8C5pQGfHwKosvdngSiqr4X0q0b9YtCjX
	iswGcYAhQQ61Lh
X-X-Sender: gene099@bonsai2
In-Reply-To: <4C4DD33F.4020104@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152627>

Hi,

On Mon, 26 Jul 2010, Jens Lehmann wrote:

> These two patches are extremly useful for those users who chose 
> submodules because they wanted to reduce the time it takes for "git 
> status" and "git diff" to recurse through the whole work tree by putting 
> sometimes large amounts of files into submodules, which weren't scanned 
> in the past.
> 
> Since 1.7.0 "git status" and "git diff" recurse through submodule work 
> trees, which has a - sometimes drastic - performance impact when large 
> submodules are present. Using the "ignore=dirty" config option restores 
> the former behaviour.
> 
> This option can be set in the .gitmodules file or in .git/config, any 
> settings found in the latter override those from .gitmodules. This 
> enables the distribution of a default setting for this option by simply 
> committing a modified .gitmodules file without each developer having to 
> call "git submodule sync". When using "git status" or "git diff" with 
> "--ignore-submodules=none" option the default behavior of scanning all 
> submodules work trees can be restored temporarily.

This is incredibly useful stuff. Indeed, the time for one "git status" 
went down from > 50 sec to < 2 sec again in my project. (I have the 
impression that it still does a little too much, but I will have to have 
some time for strace()ing to find out for real.) Therefore, I applied it 
to 4msysgit.git's 'devel' branch.

However, one thing is inconvenient: there are config options per 
submodule, but no single option to just turn the behavior back to before. 
I know the reasoning behind showing dirty submodules, so I am fine with 
that feature being opt-out, but for my real world scenario, it just slows 
me down, so I _need_ to turn it off.

To put my money where my mouth is (since I need it myself, I also pushed 
it to 4msysgit.git's 'devel' branch):

-- snipsnap --
From f7b1e98a0d850e5b1bc56a825fcfe5c87076dfa9 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Thu, 5 Aug 2010 10:49:55 +0200
Subject: [PATCH] Add the 'diff.ignoreSubmodules' config setting

When you have a lot of submodules checked out, the time penalty to check
for dirty submodules can easily imply a multiplication of the total time
by the factor 20. This makes the difference between almost instantaneous
(< 2 seconds) and unbearably slow (> 50 seconds) here, since the disk
caches are constantly overloaded.

To this end, the submodule.*.ignore config option was introduced, but it
is per-submodule.

This commit introduces a global config setting to set a default
(porcelain) value for the --ignore-submodules option, keeping the
default at 'none'. It can be overridden by the submodule.*.ignore
setting and by the --ignore-submodules option.

Incidentally, this commit fixes an issue with the overriding logic:
multiple --ignore-submodules options would not clear the previously
set flags.

While at it, fix a typo in the documentation for submodule.*.ignore.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt |    7 ++++++-
 diff.c                   |    6 +++++-
 submodule.c              |    4 ++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5594ce0..8384d12 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -832,6 +832,11 @@ diff.renames::
 	will enable basic rename detection.  If set to "copies" or
 	"copy", it will detect copies, as well.
 
+diff.ignoreSubmodules::
+	Sets the default value of --ignore-submodules. Note that this
+	affects only 'git diff' Porcelain, and not lower level 'diff'
+	commands such as 'git diff-files'.
+
 diff.suppressBlankEmpty::
 	A boolean to inhibit the standard behavior of printing a space
 	before each empty output line. Defaults to false.
@@ -1769,7 +1774,7 @@ submodule.<submodulename>.ignore::
 	submodules that have untracked files in their work tree as changed.
 	This setting overrides any setting made in .gitmodules for this submodule,
 	both settings can be overriden on the command line by using the
-	"--ignore-submodule" option.
+	"--ignore-submodules" option.
 
 tar.umask::
 	This variable can be used to restrict the permission bits of
diff --git a/diff.c b/diff.c
index 8206047..1ddfdfb 100644
--- a/diff.c
+++ b/diff.c
@@ -31,6 +31,7 @@ static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
 static int diff_no_prefix;
+static struct diff_options default_diff_options;
 
 static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
@@ -107,6 +108,9 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "diff.wordregex"))
 		return git_config_string(&diff_word_regex_cfg, var, value);
 
+	if (!strcmp(var, "diff.ignoresubmodules"))
+		handle_ignore_submodules_arg(&default_diff_options, value);
+
 	return git_diff_basic_config(var, value, cb);
 }
 
@@ -2816,7 +2820,7 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 
 void diff_setup(struct diff_options *options)
 {
-	memset(options, 0, sizeof(*options));
+	memcpy(options, &default_diff_options, sizeof(*options));
 	memset(&diff_queued_diff, 0, sizeof(diff_queued_diff));
 
 	options->file = stdout;
diff --git a/submodule.c b/submodule.c
index 1bcb0e9..75f3368 100644
--- a/submodule.c
+++ b/submodule.c
@@ -110,6 +110,10 @@ int parse_submodule_config_option(const char *var, const char *value)
 void handle_ignore_submodules_arg(struct diff_options *diffopt,
 				  const char *arg)
 {
+	DIFF_OPT_CLR(diffopt, IGNORE_SUBMODULES);
+	DIFF_OPT_CLR(diffopt, IGNORE_UNTRACKED_IN_SUBMODULES);
+	DIFF_OPT_CLR(diffopt, IGNORE_DIRTY_SUBMODULES);
+
 	if (!strcmp(arg, "all"))
 		DIFF_OPT_SET(diffopt, IGNORE_SUBMODULES);
 	else if (!strcmp(arg, "untracked"))
-- 
1.7.2.1.2240.gde5dd
