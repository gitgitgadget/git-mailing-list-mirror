From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] commit-tree: teach -m/-F options to read logs from
 elsewhere
Date: Wed,  9 Nov 2011 13:01:34 -0800
Message-ID: <1320872495-7545-3-git-send-email-gitster@pobox.com>
References: <1320872495-7545-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 22:01:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROFHI-0000X7-UF
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 22:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756788Ab1KIVBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 16:01:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46922 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753104Ab1KIVBl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 16:01:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B598659C
	for <git@vger.kernel.org>; Wed,  9 Nov 2011 16:01:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=pmgZ
	dg8LvPIgi37xIjbWYt/7/p8=; b=mgNhq7Mp9dnJB++oUIGWBKIcLZuQnRRib+rI
	WLLHBB4i4nVUCExi/JpPrL2B+rQmZQAWKw9qow9ARmukEmeawd1agsBu/dLNMjbv
	GncqWgfNae/K6uUKYorwYanWzAWaV3/hV+qGeojbCn0e1ASxsnrHTEI00OYCtmoi
	hjEr7Rg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=uYL1At
	UN2q9cuD/IFoQhjx30OYDlbn5ltLz5jYj+V6bV/nbR9vvvTlVfjGhyhyzbjlJkHe
	CKjucRo3tEPli8QeKxNHyTZ1Dwfbqvp/+CHZObu4XKkZv/M1yHM6XaGfVPDLcFOb
	Eok/OxQ6MH0oS4M3X57kPCXWaCC7Wdg9mX2N8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12761659B
	for <git@vger.kernel.org>; Wed,  9 Nov 2011 16:01:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63CEF6598 for
 <git@vger.kernel.org>; Wed,  9 Nov 2011 16:01:40 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc1.82.gde0f9
In-Reply-To: <1320872495-7545-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0550A682-0B16-11E1-B94A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185170>

Just like "git commit" does.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-commit-tree.txt |   16 +++++++++++--
 builtin/commit-tree.c             |   43 ++++++++++++++++++++++++++++++++++--
 2 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 02133d5..cfb9906 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -9,7 +9,8 @@ git-commit-tree - Create a new commit object
 SYNOPSIS
 --------
 [verse]
-'git commit-tree' <tree> [(-p <parent commit>)...] < changelog
+'git commit-tree' <tree> [(-p <parent>)...] < changelog
+'git commit-tree' [(-p <parent>)...] [(-m <message>)...] [(-F <file>)...] <tree>
 
 DESCRIPTION
 -----------
@@ -17,7 +18,8 @@ This is usually not what an end user wants to run directly.  See
 linkgit:git-commit[1] instead.
 
 Creates a new commit object based on the provided tree object and
-emits the new commit object id on stdout.
+emits the new commit object id on stdout. The log message is read
+from the standard input, unless `-m` or `-F` options are given.
 
 A commit object may have any number of parents. With exactly one
 parent, it is an ordinary commit. Having more than one parent makes
@@ -39,9 +41,17 @@ OPTIONS
 <tree>::
 	An existing tree object
 
--p <parent commit>::
+-p <parent>::
 	Each '-p' indicates the id of a parent commit object.
 
+-m <message>::
+	A paragraph in the commig log message. This can be given more than
+	once and each <message> becomes its own paragraph.
+
+-F <file>::
+	Read the commit log message from the given file. Use `-` to read
+	from the standard input.
+
 
 Commit Information
 ------------------
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 92cfbaf..db5b6e5 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -9,7 +9,7 @@
 #include "builtin.h"
 #include "utf8.h"
 
-static const char commit_tree_usage[] = "git commit-tree <sha1> [(-p <sha1>)...] < changelog";
+static const char commit_tree_usage[] = "git commit-tree [(-p <sha1>)...] [-m <message>] <sha1> < changelog";
 
 static void new_parent(struct commit *parent, struct commit_list **parents_p)
 {
@@ -51,6 +51,41 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
+		if (!strcmp(arg, "-m")) {
+			if (argc <= ++i)
+				usage(commit_tree_usage);
+			if (buffer.len)
+				strbuf_addch(&buffer, '\n');
+			strbuf_addstr(&buffer, argv[i]);
+			strbuf_complete_line(&buffer);
+			continue;
+		}
+
+		if (!strcmp(arg, "-F")) {
+			int fd;
+
+			if (argc <= ++i)
+				usage(commit_tree_usage);
+			if (buffer.len)
+				strbuf_addch(&buffer, '\n');
+			if (!strcmp(argv[i], "-"))
+				fd = 0;
+			else {
+				fd = open(argv[i], O_RDONLY);
+				if (fd < 0)
+					die_errno("git commit-tree: failed to open '%s'",
+						  argv[i]);
+			}
+			if (strbuf_read(&buffer, fd, 0) < 0)
+				die_errno("git commit-tree: failed to read '%s'",
+					  argv[i]);
+			if (fd && close(fd))
+				die_errno("git commit-tree: failed to close '%s'",
+					  argv[i]);
+			strbuf_complete_line(&buffer);
+			continue;
+		}
+
 		if (get_sha1(arg, tree_sha1))
 			die("Not a valid object name %s", arg);
 		if (got_tree)
@@ -58,8 +93,10 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 		got_tree = 1;
 	}
 
-	if (strbuf_read(&buffer, 0, 0) < 0)
-		die_errno("git commit-tree: failed to read");
+	if (!buffer.len) {
+		if (strbuf_read(&buffer, 0, 0) < 0)
+			die_errno("git commit-tree: failed to read");
+	}
 
 	if (commit_tree(buffer.buf, tree_sha1, parents, commit_sha1, NULL)) {
 		strbuf_release(&buffer);
-- 
1.7.8.rc1.82.gde0f9
