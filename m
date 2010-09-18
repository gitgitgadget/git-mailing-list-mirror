From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 2/2] fetch: Get submodule paths from index and not from .gitmodules
Date: Sun, 19 Sep 2010 00:35:08 +0200
Message-ID: <4C953E9C.1040107@web.de>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de> <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org> <4C9351A7.7050609@web.de> <4C9359D4.2030109@viscovery.net> <4C935D77.3080008@web.de> <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org> <4C953DE5.6020900@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kevin Ballard <kevin@sb.org>, Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 19 00:35:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ox605-0001uW-V1
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 00:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153Ab0IRWfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 18:35:11 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:39533 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804Ab0IRWfK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 18:35:10 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate01.web.de (Postfix) with ESMTP id 59F5B16917F14;
	Sun, 19 Sep 2010 00:35:09 +0200 (CEST)
Received: from [93.240.106.153] (helo=[192.168.178.29])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #24)
	id 1Ox5zx-0006OS-00; Sun, 19 Sep 2010 00:35:09 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <4C953DE5.6020900@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19OaotXjjR3j7eBE/dz+7je1mRZ6PchmW5C6Loj
	Y7SbhE8SbSfE2ccAY9QXgXL82kGWsElb1+5YCR/dJaKI5MW0Ku
	XtktaT4K5h5jiHVUC92w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156478>

In the first version the .gitmodules file was parsed and all submodules
found there were recursively fetched. This can lead to problems when the
.gitmodules file is not properly set up. "git submodule update" gets
this information from the index via "git ls-files", lets do the same here.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 submodule.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/submodule.c b/submodule.c
index a62cae5..209efa4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -240,7 +240,7 @@ void show_submodule_summary(FILE *f, const char *path,

 int fetch_populated_submodules(int forced)
 {
-	int result = 0;
+	int i, result = 0;
 	struct child_process cp;
 	const char *argv[] = {
 		"fetch",
@@ -251,31 +251,44 @@ int fetch_populated_submodules(int forced)
 	if (!work_tree)
 		return 0;

+	if (!the_index.initialized)
+		if (read_cache() < 0)
+			die("index file corrupt");
+
 	memset(&cp, 0, sizeof(cp));
 	cp.argv = argv;
 	cp.env = local_repo_env;
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;

-	for_each_string_list_item(name_for_path, &config_name_for_path) {
+	for (i = 0; i < active_nr; i++) {
 		struct strbuf submodule_path = STRBUF_INIT;
 		struct strbuf submodule_git_dir = STRBUF_INIT;
-		const char *git_dir;
+		struct cache_entry *ce = active_cache[i];
+		const char *git_dir, *name;
+
+		if (!S_ISGITLINK(ce->ce_mode))
+			continue;
+
+		name = ce->name;
+		name_for_path = unsorted_string_list_lookup(&config_name_for_path, ce->name);
+		if (name_for_path)
+			name = name_for_path->util;

 		if (!forced) {
 			struct string_list_item *fetch_option;
-			fetch_option = unsorted_string_list_lookup(&config_fetch_for_name, name_for_path->util);
+			fetch_option = unsorted_string_list_lookup(&config_fetch_for_name, name);
 			if (fetch_option && !fetch_option->util)
 				continue;
 		}

-		strbuf_addf(&submodule_path, "%s/%s", work_tree, name_for_path->string);
+		strbuf_addf(&submodule_path, "%s/%s", work_tree, ce->name);
 		strbuf_addf(&submodule_git_dir, "%s/.git", submodule_path.buf);
 		git_dir = read_gitfile_gently(submodule_git_dir.buf);
 		if (!git_dir)
 			git_dir = submodule_git_dir.buf;
 		if (is_directory(git_dir)) {
-			printf("Fetching submodule %s\n", name_for_path->string);
+			printf("Fetching submodule %s\n", ce->name);
 			cp.dir = submodule_path.buf;
 			if (run_command(&cp))
 				result = 1;
-- 
1.7.3.rc2.234.g00c0
