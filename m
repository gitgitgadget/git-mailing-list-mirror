From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] builtin-mv: minimum fix to avoid losing files
Date: Mon, 04 Feb 2008 00:09:56 -0800
Message-ID: <7vhcgpkuqz.fsf@gitster.siamese.dyndns.org>
References: <7v3as9mce7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 09:10:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLwPb-0007x9-57
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 09:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbYBDIKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 03:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbYBDIKL
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 03:10:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61411 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbYBDIKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 03:10:09 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 971BB2305;
	Mon,  4 Feb 2008 03:10:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CE4A522F3;
	Mon,  4 Feb 2008 03:10:03 -0500 (EST)
In-Reply-To: <7v3as9mce7.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 03 Feb 2008 23:03:28 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72476>

An incorrect command "git mv subdir /outer/space" threw the
subdirectory to outside of the repository and then noticed that
/outer/space/subdir/ would be outside of the repository.  The
error checking is backwards.

This fixes the issue by being careful about use of the return
value of get_pathspec().  Since the implementation already has
handcrafted loop to munge each path on the command line, we use
prefix_path() instead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This minimally fixes the issue and applies on top of the
   "setup: sanitize absolute and funny paths in get_pathspec()"
   patch I showed during the rc freeze.

   Dscho CC'ed as he owns the largest number of lines in this
   source file.

 builtin-mv.c  |    6 +++++-
 t/t7001-mv.sh |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/builtin-mv.c b/builtin-mv.c
index 94f6dd2..68aa2a6 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -19,6 +19,7 @@ static const char **copy_pathspec(const char *prefix, const char **pathspec,
 				  int count, int base_name)
 {
 	int i;
+	int len = prefix ? strlen(prefix) : 0;
 	const char **result = xmalloc((count + 1) * sizeof(const char *));
 	memcpy(result, pathspec, count * sizeof(const char *));
 	result[count] = NULL;
@@ -32,8 +33,11 @@ static const char **copy_pathspec(const char *prefix, const char **pathspec,
 			if (last_slash)
 				result[i] = last_slash + 1;
 		}
+		result[i] = prefix_path(prefix, len, result[i]);
+		if (!result[i])
+			exit(1); /* error already given */
 	}
-	return get_pathspec(prefix, result);
+	return result;
 }
 
 static void show_list(const char *label, struct path_list *list)
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index b1243b4..fa382c5 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -118,4 +118,42 @@ test_expect_success "Sergey Vlasov's test case" '
 	git mv ab a
 '
 
+test_expect_success 'absolute pathname' '(
+
+	rm -fr mine &&
+	mkdir mine &&
+	cd mine &&
+	test_create_repo one &&
+	cd one &&
+	mkdir sub &&
+	>sub/file &&
+	git add sub/file &&
+
+	git mv sub "$(pwd)/in" &&
+	! test -d sub &&
+	test -d in &&
+	git ls-files --error-unmatch in/file
+
+
+)'
+
+test_expect_success 'absolute pathname outside should fail' '(
+
+	rm -fr mine &&
+	mkdir mine &&
+	cd mine &&
+	out=$(pwd) &&
+	test_create_repo one &&
+	cd one &&
+	mkdir sub &&
+	>sub/file &&
+	git add sub/file &&
+
+	! git mv sub "$out/out" &&
+	test -d sub &&
+	! test -d ../in &&
+	git ls-files --error-unmatch sub/file
+
+)'
+
 test_done
-- 
1.5.4.18.gd0b8
