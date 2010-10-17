From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 2/2] merge-file: correctly find files when called in subdir
Date: Sun, 17 Oct 2010 21:23:22 +0200
Message-ID: <d0e540fdced31557e983d7503da3dcb75c622dc9.1287342969.git.trast@student.ethz.ch>
References: <64b470380b8f7bd8afe8f019553cb99f72091c7d.1287342969.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 17 21:23:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7YpZ-00045e-Jf
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 21:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591Ab0JQTXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Oct 2010 15:23:38 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:18520 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932362Ab0JQTXh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Oct 2010 15:23:37 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 17 Oct
 2010 21:23:34 +0200
Received: from localhost.localdomain (129.132.208.211) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sun, 17 Oct
 2010 21:23:35 +0200
X-Mailer: git-send-email 1.7.3.1.266.g3c065
In-Reply-To: <64b470380b8f7bd8afe8f019553cb99f72091c7d.1287342969.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159212>

Since b541248 (merge.conflictstyle: choose between "merge" and "diff3
-m" styles, 2008-08-29), git-merge-file uses setup_directory_gently(),
thus cd'ing around to find any possible config files to use.

This broke merge-file when it is called from within a subdirectory of
a repository, and the arguments are all relative paths.

Fix by prepending the prefix, as passed down from the main git
setup code, if there is any.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

With the last patch, we can safely pass a zero prefix length to say
"there was no prefix".

This is a slight semantic change on Windows, because it now
substitutes / for \ in paths, but I suppose that's harmless?


 builtin/merge-file.c  |    7 ++++++-
 t/t6023-merge-file.sh |    8 ++++++++
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index b6664d4..6c4afb5 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -28,6 +28,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	xmparam_t xmp = {{0}};
 	int ret = 0, i = 0, to_stdout = 0;
 	int quiet = 0;
+	int prefixlen = 0;
 	struct option options[] = {
 		OPT_BOOLEAN('p', "stdout", &to_stdout, "send results to standard output"),
 		OPT_SET_INT(0, "diff3", &xmp.style, "use a diff3 based merge", XDL_MERGE_DIFF3),
@@ -65,10 +66,14 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 				     "%s\n", strerror(errno));
 	}
 
+	if (prefix)
+		prefixlen = strlen(prefix);
+
 	for (i = 0; i < 3; i++) {
+		const char *fname = prefix_filename(prefix, prefixlen, argv[i]);
 		if (!names[i])
 			names[i] = argv[i];
-		if (read_mmfile(mmfs + i, argv[i]))
+		if (read_mmfile(mmfs + i, fname))
 			return -1;
 		if (buffer_is_binary(mmfs[i].ptr, mmfs[i].size))
 			return error("Cannot merge binary files: %s\n",
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index d486d73..d9f3439 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -64,6 +64,14 @@ cp new1.txt test.txt
 test_expect_success "merge without conflict" \
 	"git merge-file test.txt orig.txt new2.txt"
 
+test_expect_success 'works in subdirectory' '
+	mkdir dir &&
+	cp new1.txt dir/a.txt &&
+	cp orig.txt dir/o.txt &&
+	cp new2.txt dir/b.txt &&
+	( cd dir && git merge-file a.txt o.txt b.txt )
+'
+
 cp new1.txt test.txt
 test_expect_success "merge without conflict (--quiet)" \
 	"git merge-file --quiet test.txt orig.txt new2.txt"
-- 
1.7.3.1.266.g3c065
