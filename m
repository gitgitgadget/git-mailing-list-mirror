From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] fetch: skip on-demand checking when no submodules are configured
Date: Fri, 09 Sep 2011 20:22:03 +0200
Message-ID: <4E6A594B.9030108@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Martin Fick <mfick@codeaurora.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 20:22:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R25iX-0003rw-QG
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 20:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759562Ab1IISWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 14:22:16 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:59784 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759380Ab1IISWP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 14:22:15 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate02.web.de (Postfix) with ESMTP id 7E6651AAA96B0;
	Fri,  9 Sep 2011 20:22:14 +0200 (CEST)
Received: from [79.247.251.94] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1R25iQ-0001ib-00; Fri, 09 Sep 2011 20:22:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/JN6vK1OfDjoslxaf4fYZQuugzIC5FqmRvgn6k
	xYGReUPKWfa1cu8cXOegGzXTf+B8Uwqch7HGvUTvYP+tdy9P0K
	7HyKuLkX5/8ehlyKe1VA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181101>

It makes no sense to do the - possibly very expensive - call to "rev-list
<new-ref-sha1> --not --all" in check_for_new_submodule_commits() when
there aren't any submodules configured.

Leave check_for_new_submodule_commits() early when no name <-> path
mappings for submodules are found in the configuration. To make that work
reading the configuration had to be moved further up in cmd_fetch(), as
doing that after the actual fetch of the superproject was too late.

Reported-by: Martin Fick <mfick@codeaurora.org>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

This achieves the first goal: Don't let people pay a performance penalty
when they don't even use submodules. On Michael's test repo from [1] the
time for a full fetch went down from 142 seconds (current master) to one
second which is - not surprisingly - the same as using current master
with the --no-recurse-submodules option.

Now back to the drawing board to fix the performance regression for those
people who are using submodules ...

[1] http://comments.gmane.org/gmane.comp.version-control.git/177103

 builtin/fetch.c |   15 +++++++++------
 submodule.c     |    4 ++++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 93c9938..e422ced 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -941,6 +941,15 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);

+	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
+		if (recurse_submodules_default) {
+			int arg = parse_fetch_recurse_submodules_arg("--recurse-submodules-default", recurse_submodules_default);
+			set_config_fetch_recurse_submodules(arg);
+		}
+		gitmodules_config();
+		git_config(submodule_config, NULL);
+	}
+
 	if (all) {
 		if (argc == 1)
 			die(_("fetch --all does not take a repository argument"));
@@ -976,12 +985,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (!result && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
 		const char *options[10];
 		int num_options = 0;
-		if (recurse_submodules_default) {
-			int arg = parse_fetch_recurse_submodules_arg("--recurse-submodules-default", recurse_submodules_default);
-			set_config_fetch_recurse_submodules(arg);
-		}
-		gitmodules_config();
-		git_config(submodule_config, NULL);
 		add_options_to_argv(&num_options, options);
 		result = fetch_populated_submodules(num_options, options,
 						    submodule_prefix,
diff --git a/submodule.c b/submodule.c
index 7a76edf..ad86534 100644
--- a/submodule.c
+++ b/submodule.c
@@ -481,6 +481,10 @@ void check_for_new_submodule_commits(unsigned char new_sha1[20])
 	const char *argv[] = {NULL, NULL, "--not", "--all", NULL};
 	int argc = ARRAY_SIZE(argv) - 1;

+	/* No need to check if there are no submodules configured */
+	if (!config_name_for_path.nr)
+		return;
+
 	init_revisions(&rev, NULL);
 	argv[1] = xstrdup(sha1_to_hex(new_sha1));
 	setup_revisions(argc, argv, &rev, NULL);
-- 
1.7.7.rc0.189.gf9175
