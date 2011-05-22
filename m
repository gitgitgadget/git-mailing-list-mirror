From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] realloc failed
Date: Sun, 22 May 2011 12:42:55 -0700
Message-ID: <7v4o4my11c.fsf@alter.siamese.dyndns.org>
References: <20110521100126.E3CD.BA9123DE@callcc.net>
 <7vhb8o25tt.fsf@alter.siamese.dyndns.org>
 <20110521145056.E3F5.BA9123DE@callcc.net>
 <7v8vtyy1ft.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kazuki Tsujimoto <kazuki@callcc.net>
X-From: git-owner@vger.kernel.org Sun May 22 21:43:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOEYQ-0006ca-Jo
	for gcvg-git-2@lo.gmane.org; Sun, 22 May 2011 21:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787Ab1EVTnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 15:43:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56972 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378Ab1EVTnD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 15:43:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EC44B46DC;
	Sun, 22 May 2011 15:45:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xh3912gy0moIn6DfpH7ebq6UOA8=; b=Wks1gm
	uSZJuvR7mggqDAYBAYDwqGAjYW5haU/iX2afPN8eXReexFiJSpSOYWWnUHboIchT
	O/J7WRJtMm/RDsqWNHAmGedaxugBGq2XbmdzzsuvU6qIPsxskXGbVHkgezE/FYlM
	pBdJq9h5pGt5YIsWTb+xbfOMxfYHGVuDDy6f8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=okqka8TrcFu/utqnlCo8a3Bym0JbYCm8
	WHV+rDsrYZawoK1nGBf27sU1gMLgeGV1kI1lbgx7pKiqtmn78z4/rcS5RO62V1Cs
	I9sL/iF21g7h2WP/aLy5tLwIZbPDwy9qYmLGZxbmA8fVTnQzAD7bEDzHHEoapZt0
	HsKJOCJ/c4U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C9A8D46DA;
	Sun, 22 May 2011 15:45:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8488546D9; Sun, 22 May 2011
 15:45:04 -0400 (EDT)
In-Reply-To: <7v8vtyy1ft.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 22 May 2011 12:34:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF3B05EE-84AB-11E0-A3DF-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174198>

Junio C Hamano <gitster@pobox.com> writes:

> The immediate cause of the problem is that handle_options() returns a
> wrong count when it sees a "-c <config-specification>". If you look at its
> implementation, you see "handled++" paired with "(*argv)++" everywhere but
> the place it parsed "-c".

I said "immediate" above, because I think the "real" reason why we
suffered is because handle_options() helper function was created by
refactoring existing code with a poor taste in designing an API.

It is understandable that it is more convenent for one callsite, which is
git.c::main(), to make the helper automatically move the argc/argv
variables of the caller, and it certainly would have made the initial
patch look smaller when the helper was introduced, but as an API for a
more general callers, it is easier to follow the resulting code of the
caller if it didn't.

Refactored in a more reasonable way, the result may look like this, on top
of the previous patch.

*CAUTION* I was not very careful checking sites that increment these
variables and rely on the result when I was doing this, so there may be
places that need to be adjusted by adding or subtracting option_count)


 git.c |   51 +++++++++++++++++++++++++++------------------------
 1 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/git.c b/git.c
index df4306d..3596f5b 100644
--- a/git.c
+++ b/git.c
@@ -64,12 +64,12 @@ static void commit_pager_choice(void) {
 	}
 }
 
-static int handle_options(const char ***argv, int *argc, int *envchanged)
+static int handle_options(int argc, const char **argv, int *envchanged)
 {
-	const char **orig_argv = *argv;
+	const char **orig_argv = argv;
 
-	while (*argc > 0) {
-		const char *cmd = (*argv)[0];
+	while (argc > 0) {
+		const char *cmd = argv[0];
 		if (cmd[0] != '-')
 			break;
 
@@ -107,29 +107,29 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--git-dir")) {
-			if (*argc < 2) {
+			if (argc < 2) {
 				fprintf(stderr, "No directory given for --git-dir.\n" );
 				usage(git_usage_string);
 			}
-			setenv(GIT_DIR_ENVIRONMENT, (*argv)[1], 1);
+			setenv(GIT_DIR_ENVIRONMENT, argv[1], 1);
 			if (envchanged)
 				*envchanged = 1;
-			(*argv)++;
-			(*argc)--;
+			argv++;
+			argc--;
 		} else if (!prefixcmp(cmd, "--git-dir=")) {
 			setenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--work-tree")) {
-			if (*argc < 2) {
+			if (argc < 2) {
 				fprintf(stderr, "No directory given for --work-tree.\n" );
 				usage(git_usage_string);
 			}
-			setenv(GIT_WORK_TREE_ENVIRONMENT, (*argv)[1], 1);
+			setenv(GIT_WORK_TREE_ENVIRONMENT, argv[1], 1);
 			if (envchanged)
 				*envchanged = 1;
-			(*argv)++;
-			(*argc)--;
+			argv++;
+			argc--;
 		} else if (!prefixcmp(cmd, "--work-tree=")) {
 			setenv(GIT_WORK_TREE_ENVIRONMENT, cmd + 12, 1);
 			if (envchanged)
@@ -141,22 +141,22 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "-c")) {
-			if (*argc < 2) {
+			if (argc < 2) {
 				fprintf(stderr, "-c expects a configuration string\n" );
 				usage(git_usage_string);
 			}
-			git_config_push_parameter((*argv)[1]);
-			(*argv)++;
-			(*argc)--;
+			git_config_push_parameter(argv[1]);
+			argv++;
+			argc--;
 		} else {
 			fprintf(stderr, "Unknown option: %s\n", cmd);
 			usage(git_usage_string);
 		}
 
-		(*argv)++;
-		(*argc)--;
+		argv++;
+		argc--;
 	}
-	return (*argv) - orig_argv;
+	return argv - orig_argv;
 }
 
 static int handle_alias(int *argcp, const char ***argv)
@@ -198,14 +198,14 @@ static int handle_alias(int *argcp, const char ***argv)
 		if (count < 0)
 			die("Bad alias.%s string: %s", alias_command,
 			    split_cmdline_strerror(count));
-		option_count = handle_options(&new_argv, &count, &envchanged);
+		option_count = handle_options(count, new_argv, &envchanged);
+		count -= option_count;
 		if (envchanged)
 			die("alias '%s' changes environment variables\n"
 				 "You can use '!git' in the alias to do this.",
 				 alias_command);
-		memmove(new_argv - option_count, new_argv,
-				count * sizeof(char *));
-		new_argv -= option_count;
+		memmove(new_argv, new_argv + option_count,
+			count * sizeof(char *));
 
 		if (count < 1)
 			die("empty alias for %s", alias_command);
@@ -508,6 +508,7 @@ static int run_argv(int *argcp, const char ***argv)
 int main(int argc, const char **argv)
 {
 	const char *cmd;
+	int option_count;
 
 	startup_info = &git_startup_info;
 
@@ -535,7 +536,9 @@ int main(int argc, const char **argv)
 	/* Look for flags.. */
 	argv++;
 	argc--;
-	handle_options(&argv, &argc, NULL);
+	option_count = handle_options(argc, argv, NULL);
+	argv += option_count;
+	argc -= option_count;
 	if (argc > 0) {
 		if (!prefixcmp(argv[0], "--"))
 			argv[0] += 2;
