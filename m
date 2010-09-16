From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] fetch: Get submodule paths from index and not from .gitmodules
Date: Thu, 16 Sep 2010 15:55:02 +0200
Message-ID: <4C9221B6.7070807@web.de>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Sep 16 15:55:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwEw2-0005HK-GJ
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 15:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019Ab0IPNzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 09:55:10 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:55300 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755016Ab0IPNzI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 09:55:08 -0400
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id DD82C170DF8B9;
	Thu, 16 Sep 2010 15:55:06 +0200 (CEST)
Received: from [93.246.43.244] (helo=[192.168.178.29])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #24)
	id 1OwEva-0001sC-00; Thu, 16 Sep 2010 15:55:06 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.9) Gecko/20100825 Thunderbird/3.1.3
In-Reply-To: <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/ArHe3hEejXoBjvqBnqAz7yry3X8OuJljZKvKp
	+Pb+jU4sw4P5pANojaLTY2T9gMQ1AvJuKv/CXmFB8ZfAZrFe1z
	g60la8k5FXuLReA89GsA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156332>

In the first version the .gitmodules file was parsed and all submodules
found there were recursively fetched. This lead to problems when the
.gitmodules file was not properly set up. "git submodule update" gets
this information from the index via "git ls-files", lets do the same here.

Reported-by: Kevin Ballard <kevin@sb.org>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Could it be that the information in your .gitmodules files is not
quite right? Then this patch should fix your problems with the
recursion. Please test it and let me know if the submodules are
now recursively fetched as they should.


 submodule.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/submodule.c b/submodule.c
index 05661e2..13a694b 100644
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
@@ -251,6 +251,10 @@ int fetch_populated_submodules(int forced)
 	if (!work_tree)
 		return 0;

+	if (!the_index.initialized)
+		if (read_cache() < 0)
+			die("index file corrupt");
+
 	memset(&cp, 0, sizeof(cp));
 	cp.argv = argv;
 	cp.env = local_repo_env;
@@ -258,25 +262,34 @@ int fetch_populated_submodules(int forced)
 	cp.no_stdin = 1;
 	cp.out = -1;

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
1.7.3.rc2.232.g3328
