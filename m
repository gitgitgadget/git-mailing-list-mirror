From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/7] check_ref_format(): tighten refname rules
Date: Mon, 23 Mar 2009 00:58:39 -0700
Message-ID: <345e795e1891c628ad8356b730fade9f7a81e2f6.1237791716.git.gitster@pobox.com>
References: <cover.1237791716.git.gitster@pobox.com>
 <431b1969fcde69959a23355fba6894fb69c8fa0c.1237791716.git.gitster@pobox.com>
 <a552de75eb01f78046feaf7dc88e5e4833624ad5.1237791716.git.gitster@pobox.com>
 <a31dca0393fefae894b7a155ae24000107bcc383.1237791716.git.gitster@pobox.com>
 <03d3aada5a2a68a7acdb6286fd72155f01626e41.1237791716.git.gitster@pobox.com>
 <a2fab531bbb00ff64335906e22854365be2eb5c7.1237791716.git.gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 09:01:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llf5v-0003W2-Kn
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 09:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756962AbZCWH7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 03:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756920AbZCWH7L
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 03:59:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57667 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756854AbZCWH7E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 03:59:04 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E90EBA45BC
	for <git@vger.kernel.org>; Mon, 23 Mar 2009 03:59:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0FFB9A45BB for
 <git@vger.kernel.org>; Mon, 23 Mar 2009 03:59:00 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.349.ga64c
In-Reply-To: <a2fab531bbb00ff64335906e22854365be2eb5c7.1237791716.git.gitster@pobox.com>
In-Reply-To: <cover.1237791716.git.gitster@pobox.com>
References: <cover.1237791716.git.gitster@pobox.com>
X-Pobox-Relay-ID: 78E68058-1780-11DE-80A8-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114256>

This changes the rules for refnames to forbid:

 (1) a refname that contains "@{" in it.

     Some people and foreign SCM converter may have named their branches
     as frotz@24 and we still want to keep supporting it.

     However, "git branch frotz@{24}" is a disaster.  It cannot even
     checked out because "git checkout frotz@{24}" will interpret it as
     "detach the HEAD at twenty-fourth reflog entry of the frotz branch".

 (2) a refname that ends with a dot.

     We already reject a path component that begins with a dot, primarily
     to avoid ambiguous range interpretation.  If we allowed ".B" as a
     valid ref, it is unclear if "A...B" means "in dot-B but not in A" or
     "either in A or B but not in both".

     But for this to be complete, we need also to forbid "A." to avoid "in
     B but not in A-dot".  This was not a problem in the original range
     notation, but we should have added this restriction when three-dot
     notation was introduced.

     Unlike "no dot at the beginning of any path component" rule, this
     rule does not have to be "no dot at the end of any path component",
     because you cannot abbreviate the tail end away, similar to you can
     say "dot-B" to mean "refs/heads/dot-B".

For these reasons, it is not likely people created branches with these
names on purpose, but we have allowed such names to be used for quite some
time, and it is possible that people created such branches by mistake or
by accident.

To help people with branches with such unfortunate names to recover,
we still allow "branch -d 'bad.'" to delete such branches, and also allow
"branch -m bad. good" to rename them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-check-ref-format.txt |    6 +++++-
 builtin-branch.c                       |   16 ++++++++++++++--
 refs.c                                 |   13 +++++++++----
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 51579f6..58e53cc 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -32,7 +32,9 @@ imposes the following rules on how refs are named:
   caret `{caret}`, colon `:`, question-mark `?`, asterisk `*`,
   or open bracket `[` anywhere;
 
-. It cannot end with a slash `/`.
+. It cannot end with a slash `/` nor a dot `.`.
+
+. It cannot contain a sequence `@{`.
 
 These rules makes it easy for shell script based tools to parse
 refnames, pathname expansion by the shell when a refname is used
@@ -51,6 +53,8 @@ refname expressions (see linkgit:git-rev-parse[1]).  Namely:
   It may also be used to select a specific object such as with
   'git-cat-file': "git cat-file blob v1.3.3:refs.c".
 
+. at-open-brace `@{` is used as a notation to access a reflog entry.
+
 With the `--branch` option, it expands a branch name shorthand and
 prints the name of the branch the shorthand refers to.
 
diff --git a/builtin-branch.c b/builtin-branch.c
index afeed68..330e0c3 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -464,12 +464,21 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	struct strbuf oldref = STRBUF_INIT, newref = STRBUF_INIT, logmsg = STRBUF_INIT;
 	unsigned char sha1[20];
 	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
+	int recovery = 0;
 
 	if (!oldname)
 		die("cannot rename the current branch while not on any.");
 
-	if (strbuf_check_branch_ref(&oldref, oldname))
-		die("Invalid branch name: '%s'", oldname);
+	if (strbuf_check_branch_ref(&oldref, oldname)) {
+		/*
+		 * Bad name --- this could be an attempt to rename a
+		 * ref that we used to allow to be created by accident.
+		 */
+		if (resolve_ref(oldref.buf, sha1, 1, NULL))
+			recovery = 1;
+		else
+			die("Invalid branch name: '%s'", oldname);
+	}
 
 	if (strbuf_check_branch_ref(&newref, newname))
 		die("Invalid branch name: '%s'", newname);
@@ -484,6 +493,9 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 		die("Branch rename failed");
 	strbuf_release(&logmsg);
 
+	if (recovery)
+		warning("Renamed a misnamed branch '%s' away", oldref.buf + 11);
+
 	/* no need to pass logmsg here as HEAD didn't really move */
 	if (!strcmp(oldname, head) && create_symref("HEAD", newref.buf, NULL))
 		die("Branch renamed to %s, but HEAD is not updated!", newname);
diff --git a/refs.c b/refs.c
index 8d3c502..e355489 100644
--- a/refs.c
+++ b/refs.c
@@ -693,7 +693,7 @@ static inline int bad_ref_char(int ch)
 
 int check_ref_format(const char *ref)
 {
-	int ch, level, bad_type;
+	int ch, level, bad_type, last;
 	int ret = CHECK_REF_FORMAT_OK;
 	const char *cp = ref;
 
@@ -717,19 +717,24 @@ int check_ref_format(const char *ref)
 				return CHECK_REF_FORMAT_ERROR;
 		}
 
+		last = ch;
 		/* scan the rest of the path component */
 		while ((ch = *cp++) != 0) {
 			bad_type = bad_ref_char(ch);
-			if (bad_type) {
+			if (bad_type)
 				return CHECK_REF_FORMAT_ERROR;
-			}
 			if (ch == '/')
 				break;
-			if (ch == '.' && *cp == '.')
+			if (last == '.' && ch == '.')
+				return CHECK_REF_FORMAT_ERROR;
+			if (last == '@' && ch == '{')
 				return CHECK_REF_FORMAT_ERROR;
+			last = ch;
 		}
 		level++;
 		if (!ch) {
+			if (ref <= cp - 2 && cp[-2] == '.')
+				return CHECK_REF_FORMAT_ERROR;
 			if (level < 2)
 				return CHECK_REF_FORMAT_ONELEVEL;
 			return ret;
-- 
1.6.2.1.349.ga64c
