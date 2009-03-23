From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/7] check-ref-format --branch: give Porcelain a way to
 grok branch shorthand
Date: Mon, 23 Mar 2009 00:58:36 -0700
Message-ID: <a31dca0393fefae894b7a155ae24000107bcc383.1237791716.git.gitster@pobox.com>
References: <cover.1237791716.git.gitster@pobox.com>
 <431b1969fcde69959a23355fba6894fb69c8fa0c.1237791716.git.gitster@pobox.com>
 <a552de75eb01f78046feaf7dc88e5e4833624ad5.1237791716.git.gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 09:01:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llf5t-0003W2-Ca
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 09:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756824AbZCWH7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 03:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756795AbZCWH67
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 03:58:59 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47547 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756770AbZCWH6z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 03:58:55 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 368E18689
	for <git@vger.kernel.org>; Mon, 23 Mar 2009 03:58:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B158B8687 for
 <git@vger.kernel.org>; Mon, 23 Mar 2009 03:58:53 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.349.ga64c
In-Reply-To: <a552de75eb01f78046feaf7dc88e5e4833624ad5.1237791716.git.gitster@pobox.com>
In-Reply-To: <cover.1237791716.git.gitster@pobox.com>
References: <cover.1237791716.git.gitster@pobox.com>
X-Pobox-Relay-ID: 744CEE6A-1780-11DE-9EC6-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114255>

The command may not be the best place to add this new feature, but

    $ git check-ref-format --branch "@{-1}"

allows Porcelains to figure out what branch you were on before the last
branch switching.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-check-ref-format.txt |   12 ++++++++++++
 builtin-check-ref-format.c             |   10 ++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 034223c..51579f6 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -7,7 +7,9 @@ git-check-ref-format - Make sure ref name is well formed
 
 SYNOPSIS
 --------
+[verse]
 'git check-ref-format' <refname>
+'git check-ref-format' [--branch] <branchname-shorthand>
 
 DESCRIPTION
 -----------
@@ -49,6 +51,16 @@ refname expressions (see linkgit:git-rev-parse[1]).  Namely:
   It may also be used to select a specific object such as with
   'git-cat-file': "git cat-file blob v1.3.3:refs.c".
 
+With the `--branch` option, it expands a branch name shorthand and
+prints the name of the branch the shorthand refers to.
+
+EXAMPLE
+-------
+
+git check-ref-format --branch @{-1}::
+
+Print the name of the previous branch.
+
 
 GIT
 ---
diff --git a/builtin-check-ref-format.c b/builtin-check-ref-format.c
index 701de43..39db6cb 100644
--- a/builtin-check-ref-format.c
+++ b/builtin-check-ref-format.c
@@ -5,9 +5,19 @@
 #include "cache.h"
 #include "refs.h"
 #include "builtin.h"
+#include "strbuf.h"
 
 int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 {
+	if (argc == 3 && !strcmp(argv[1], "--branch")) {
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_branchname(&sb, argv[2]);
+		strbuf_splice(&sb, 0, 0, "refs/heads/", 11);
+		if (check_ref_format(sb.buf))
+			die("'%s' is not a valid branch name", argv[2]);
+		printf("%s\n", sb.buf + 11);
+		exit(0);
+	}
 	if (argc != 2)
 		usage("git check-ref-format refname");
 	return !!check_ref_format(argv[1]);
-- 
1.6.2.1.349.ga64c
