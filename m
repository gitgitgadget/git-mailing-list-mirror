From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] require pathspec for "git add -u/-A"
Date: Fri,  8 Mar 2013 15:54:48 -0800
Message-ID: <1362786889-28688-2-git-send-email-gitster@pobox.com>
References: <1362786889-28688-1-git-send-email-gitster@pobox.com>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 09 00:55:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE78K-0002c3-F6
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 00:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759955Ab3CHXy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 18:54:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38062 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754610Ab3CHXyy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 18:54:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 773F2BF6B;
	Fri,  8 Mar 2013 18:54:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Oeq0
	4onH3uMYp5eQ5JVRFgGhexQ=; b=ppsQATWpW0F6ajEepQJLWmk20M/0obgfyOIa
	A2zanzmFuXOjz/oE7Czzj+AZrymUIwuuqjAWFrGc3OrpzAQNPQzA1dOVfSEbZyTh
	gvkR4HBwQNGg8vQJqrdu7iZYEZOPhLrRKbcLDNJISjzLi7kMdCo+y6fW5KSHf0lZ
	uU798Kw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Dejo5v+7Gx/dFi0W/ObkF5Nv+hH67xaT/TU1KmVyx1s1RdlhpGQhc3j+MuO5XRbR
	x99lDaIC40cS/9EUWgOWNWqoAB+rODw1Rctq0BBSNvRYsdLJv6tfECHLdcYxPlKh
	wPUgrtCWbhEVCkHJK5xUTn8riqYJwLwjxeMgTMOzfWQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BBCCBF6A;
	Fri,  8 Mar 2013 18:54:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B4317BF5D; Fri,  8 Mar 2013
 18:54:52 -0500 (EST)
X-Mailer: git-send-email 1.8.2-rc3-196-gfcda97c
In-Reply-To: <1362786889-28688-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 91F89802-884B-11E2-932B-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217692>

As promised in 0fa2eb530fb7 (add: warn when -u or -A is used without
pathspec, 2013-01-28), "git add -u/-A" that is run without pathspec
in a subdirectory will stop working sometime before Git 2.0, to wean
users off of the old default, in preparation for adopting the new
default in Git 2.0.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-add.txt | 12 ++++++++----
 builtin/add.c             | 38 ++++++++++++++++++--------------------
 2 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 388a225..1ea1d39 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -107,10 +107,14 @@ apply to the index. See EDITING PATCHES below.
 	from the index if the corresponding files in the working tree
 	have been removed.
 +
-If no <pathspec> is given, the current version of Git defaults to
-"."; in other words, update all tracked files in the current directory
-and its subdirectories. This default will change in a future version
-of Git, hence the form without <pathspec> should not be used.
+If no <pathspec> is given when `-u` or `-A` option is used, Git used
+to update all tracked files in the current directory and its
+subdirectories. We would eventually want to change this to operate
+on the entire working tree, not limiting it to the current
+directory, to make it consistent with `git commit -a` and other
+commands.  In order to avoid harming users who are used to the old
+default, Git *errors out* when no <pathspec> is given to train their
+fingers to explicitly type `git add -u .` when they mean it.
 
 -A::
 --all::
diff --git a/builtin/add.c b/builtin/add.c
index 0dd014e..4b9d57c 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -321,30 +321,28 @@ static int add_files(struct dir_struct *dir, int flags)
 	return exit_status;
 }
 
-static void warn_pathless_add(const char *option_name, const char *short_name) {
+static void die_on_pathless_add(const char *option_name, const char *short_name)
+{
 	/*
 	 * To be consistent with "git add -p" and most Git
 	 * commands, we should default to being tree-wide, but
 	 * this is not the original behavior and can't be
 	 * changed until users trained themselves not to type
-	 * "git add -u" or "git add -A". For now, we warn and
-	 * keep the old behavior. Later, this warning can be
-	 * turned into a die(...), and eventually we may
-	 * reallow the command with a new behavior.
+	 * "git add -u" or "git add -A". In the previous release,
+	 * we kept the old behavior but gave a big warning.
 	 */
-	warning(_("The behavior of 'git add %s (or %s)' with no path argument from a\n"
-		  "subdirectory of the tree will change in Git 2.0 and should not be used anymore.\n"
-		  "To add content for the whole tree, run:\n"
-		  "\n"
-		  "  git add %s :/\n"
-		  "  (or git add %s :/)\n"
-		  "\n"
-		  "To restrict the command to the current directory, run:\n"
-		  "\n"
-		  "  git add %s .\n"
-		  "  (or git add %s .)\n"
-		  "\n"
-		  "With the current Git version, the command is restricted to the current directory."),
+	die(_("The behavior of 'git add %s (or %s)' with no path argument from a\n"
+	      "subdirectory of the tree will change in Git 2.0 and should not be "
+	      "used anymore.\n"
+	      "To add content for the whole tree, run:\n"
+	      "\n"
+	      "  git add %s :/\n"
+	      "  (or git add %s :/)\n"
+	      "\n"
+	      "To restrict the command to the current directory, run:\n"
+	      "\n"
+	      "  git add %s .\n"
+	      "  (or git add %s .)"),
 		option_name, short_name,
 		option_name, short_name,
 		option_name, short_name);
@@ -392,8 +390,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (option_with_implicit_dot && !argc) {
 		static const char *here[2] = { ".", NULL };
 		if (prefix)
-			warn_pathless_add(option_with_implicit_dot,
-					  short_option_with_implicit_dot);
+			die_on_pathless_add(option_with_implicit_dot,
+					    short_option_with_implicit_dot);
 		argc = 1;
 		argv = here;
 	}
-- 
1.8.2-rc3-196-gfcda97c
