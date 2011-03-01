From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 5/7] fetch/pull: Don't recurse into a submodule when commits
 are already present
Date: Wed, 02 Mar 2011 00:03:37 +0100
Message-ID: <4D6D7B49.3030005@web.de>
References: <4D6D7A50.5090802@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 02 00:03:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuYbX-0001xM-Ht
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 00:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884Ab1CAXDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 18:03:39 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:41913 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756643Ab1CAXDi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 18:03:38 -0500
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 77A291896A4EB;
	Wed,  2 Mar 2011 00:03:37 +0100 (CET)
Received: from [93.240.102.247] (helo=[192.168.178.43])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PuYbR-000148-00; Wed, 02 Mar 2011 00:03:37 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D6D7A50.5090802@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX189lFxdRlkZOOzZiJqNqbYZcbH0lHv2MDldOYsd
	XGeB/7sQjRvUFUl4qh4ysyd70RQK5sW5EP/qWvbWWnxylD1fN8
	dQXcYNGAojjtDsmj9VQA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168278>

When looking for submodules where new commits have been recorded in the
superproject ignore those cases where the submodules commits are already
present locally. This can happen e.g. when the submodule has been rewound
to an earlier state. Then there is no need to fetch the submodule again
as the commit recorded in the newly fetched superproject commit has
already been fetched earlier into the submodule.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 submodule.c                 |   29 ++++++++++++++++++++++++++++-
 t/t5526-fetch-submodules.sh |   19 +++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/submodule.c b/submodule.c
index 3be6654..11e0ef5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -263,6 +263,33 @@ void set_config_fetch_recurse_submodules(int value)
 	config_fetch_recurse_submodules = value;
 }

+static int is_submodule_commit_present(const char *path, unsigned char sha1[20])
+{
+	int is_present = 0;
+	if (!add_submodule_odb(path) && lookup_commit_reference(sha1)) {
+		/* Even if the submodule is checked out and the commit is
+		 * present, make sure it is reachable from a ref. */
+		struct child_process cp;
+		const char *argv[] = {"rev-list", "-n", "1", NULL, "--not", "--all", NULL};
+		struct strbuf buf = STRBUF_INIT;
+
+		argv[3] = sha1_to_hex(sha1);
+		memset(&cp, 0, sizeof(cp));
+		cp.argv = argv;
+		cp.env = local_repo_env;
+		cp.git_cmd = 1;
+		cp.no_stdin = 1;
+		cp.out = -1;
+		cp.dir = path;
+		if (!run_command(&cp) && !strbuf_read(&buf, cp.out, 1024))
+			is_present = 1;
+
+		close(cp.out);
+		strbuf_release(&buf);
+	}
+	return is_present;
+}
+
 static void submodule_collect_changed_cb(struct diff_queue_struct *q,
 					 struct diff_options *options,
 					 void *data)
@@ -280,7 +307,7 @@ static void submodule_collect_changed_cb(struct diff_queue_struct *q,
 			 * being moved around. */
 			struct string_list_item *path;
 			path = unsorted_string_list_lookup(&changed_submodule_paths, p->two->path);
-			if (!path)
+			if (!path && !is_submodule_commit_present(p->two->path, p->two->sha1))
 				string_list_append(&changed_submodule_paths, xstrdup(p->two->path));
 		} else {
 			/* Submodule is new or was moved here */
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 09701aa..3decfae 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -428,4 +428,23 @@ test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' override
 	test_cmp expect.err.2 actual.err
 '

+test_expect_success "don't fetch submodule when newly recorded commits are already present" '
+	(
+		cd submodule &&
+		git checkout -q HEAD^^
+	) &&
+	head1=$(git rev-parse --short HEAD) &&
+	git add submodule &&
+	git commit -m "submodule rewound" &&
+	head2=$(git rev-parse --short HEAD) &&
+	echo "From $pwd/." > expect.err &&
+	echo "   $head1..$head2  master     -> origin/master" >> expect.err &&
+	(
+		cd downstream &&
+		git fetch >../actual.out 2>../actual.err
+	) &&
+	! test -s actual.out &&
+	test_cmp expect.err actual.err
+'
+
 test_done
-- 
1.7.4.1.291.g6060
