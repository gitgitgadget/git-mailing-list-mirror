From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] Teach rm to remove submodules when given with a trailing
 '/'
Date: Mon, 29 Oct 2012 00:28:18 +0100
Message-ID: <508DBF92.9090200@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 29 00:35:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TScNx-0005AL-6J
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 00:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757357Ab2J1XfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 19:35:01 -0400
Received: from mout.web.de ([212.227.15.3]:59406 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756950Ab2J1X2U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 19:28:20 -0400
Received: from [192.168.178.41] ([91.3.156.115]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0LyDph-1TMiRi0P6T-0162ow; Mon, 29 Oct 2012 00:28:19
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
X-Enigmail-Version: 1.4.5
X-Provags-ID: V02:K0:I072OfnDaaNzz1odGMPUk72bvnD0Rim4bxF1gX2pL7H
 ovRe7BtcbuB/W6GdzzHX1K+VDBtWZq+HR0b+SZbJKHBSZRjuQz
 gm5An1y61ajm9rlE2QTfXZyLJgJuaZ09KgNMDw+VeXPJq7adSD
 tZu035blBaiNdpuZTJCDRPYc/RGaSzP3T9EdDW2yp5GiFnyueO
 w8u5AhYW62wZFb6mCSmGg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208576>

Doing a "git rm submod/" on a submodule results in an error:
	fatal: pathspec 'submod/' did not match any files
This is really inconvenient as e.g. using TAB completion in a shell on a
submodule automatically adds the trailing '/' when it completes the path
of the submodule directory. The user has then to remove the '/' herself to
make a "git rm" succeed. Doing a "git rm -r somedir/" is working fine, so
there is no reason why that shouldn't work for submodules too.

Teach git rm to not error out when a '/' is appended to the path of a
submodule. Achieve this by chopping off trailing slashes from the path
names given if they represent directories. Add tests to make sure that
logic only applies to directories and not to files.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


This patch applies on top of the jl/submodule-rm branch merged into
current next.


 builtin/rm.c  |  7 +++++++
 t/t3600-rm.sh | 17 +++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/builtin/rm.c b/builtin/rm.c
index 2aea3b5..5381d3f 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -234,6 +234,13 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (read_cache() < 0)
 		die(_("index file corrupt"));

+	/* Remove trailing '/' from directories to find submodules in the index */
+	for (i = 0; i < argc; i++) {
+		size_t pathlen = strlen(argv[i]);
+		if (pathlen && is_directory(argv[i]) && (argv[i][pathlen - 1] == '/'))
+			argv[i] = xmemdupz(argv[i], pathlen - 1);
+	}
+
 	pathspec = get_pathspec(prefix, argv);
 	refresh_index(&the_index, REFRESH_QUIET, pathspec, NULL, NULL);

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 97254e8..06f6384 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -302,6 +302,23 @@ test_expect_success 'rm removes work tree of unmodified submodules' '
 	test_cmp expect actual
 '

+test_expect_success 'rm removes a submodule with a trailing /' '
+	git reset --hard &&
+	git submodule update &&
+	git rm submod/ &&
+	test ! -d submod &&
+	git status -s -uno --ignore-submodules=none > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rm fails when given a file with a trailing /' '
+	test_must_fail git rm empty/
+'
+
+test_expect_success 'rm succeeds when given a directory with a trailing /' '
+	git rm -r frotz/
+'
+
 test_expect_success 'rm of a populated submodule with different HEAD fails unless forced' '
 	git reset --hard &&
 	git submodule update &&
-- 
1.8.0.42.g3346551
