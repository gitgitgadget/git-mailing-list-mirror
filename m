From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v3 5/7] fetch/pull: Don't recurse into a submodule when commits
 are already present
Date: Sun, 06 Mar 2011 23:12:58 +0100
Message-ID: <4D7406EA.4070308@web.de>
References: <4D74061C.5050908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 06 23:13:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwMCH-0000b6-7m
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 23:13:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736Ab1CFWNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 17:13:00 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:39770 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222Ab1CFWNA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 17:13:00 -0500
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate01.web.de (Postfix) with ESMTP id 1CC4518A8D525;
	Sun,  6 Mar 2011 23:12:59 +0100 (CET)
Received: from [93.246.45.11] (helo=[192.168.178.43])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PwMCA-0007ff-00; Sun, 06 Mar 2011 23:12:58 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.14) Gecko/20110221 Thunderbird/3.1.8
In-Reply-To: <4D74061C.5050908@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18GqZvj7eBmM7We08jLzyLaNvh0Fitfz7XJwm6T
	FCGqKgm9/4T1vdcM1k9rfOf7pwUDei+febf+5jQp32KGAnre1P
	TlkZButSUq1rFHFT+ZGw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168540>

When looking for submodules where new commits have been recorded in the
superproject ignore those cases where the submodules commits are already
present locally. This can happen e.g. when the submodule has been rewound
to an earlier state. Then there is no need to fetch the submodule again
as the commit recorded in the newly fetched superproject commit has
already been fetched earlier into the submodule.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/fetch-options.txt |    3 ++-
 submodule.c                     |   29 ++++++++++++++++++++++++++++-
 t/t5526-fetch-submodules.sh     |   19 +++++++++++++++++++
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index d287028..39d326a 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -73,7 +73,8 @@ ifndef::git-pull[]
 	'yes', which is the default when this option is used without any
 	value. Use 'on-demand' to only recurse into a populated submodule
 	when the superproject retrieves a commit that updates the submodule's
-	reference.
+	reference to a commit that isn't already in the local submodule
+	clone.

 --no-recurse-submodules::
 	Disable recursive fetching of submodules (this has the same effect as
diff --git a/submodule.c b/submodule.c
index 924b156..88c7488 100644
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
1.7.4.1.300.g29eea0
