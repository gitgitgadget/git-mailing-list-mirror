From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/5] branch: factor out delete_branch_config()
Date: Thu, 18 Oct 2012 14:04:08 +0200
Message-ID: <507FF038.6090202@lsrfire.ath.cx>
References: <CALKQrgfnvV+1XHjeSytj+LxkAabZJK3hewxH7WT0nkX-ewOKUA@mail.gmail.com> <507D315E.8040101@lsrfire.ath.cx> <7vr4oytn4q.fsf@alter.siamese.dyndns.org> <507FEF0B.1060309@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Miklos Vajna <vmiklos@suse.cz>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 14:04:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOopw-0005Jq-MM
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 14:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154Ab2JRMES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 08:04:18 -0400
Received: from india601.server4you.de ([85.25.151.105]:44738 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359Ab2JRMER (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 08:04:17 -0400
Received: from [192.168.2.105] (p4FFDA222.dip.t-dialin.net [79.253.162.34])
	by india601.server4you.de (Postfix) with ESMTPSA id 931D123E;
	Thu, 18 Oct 2012 14:04:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <507FEF0B.1060309@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207998>

Provide a small helper function for deleting branch config sections.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin/branch.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 852019e..97c7361 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -172,6 +172,15 @@ static int check_branch_commit(const char *branchname, const char *refname,
 	return 0;
 }
 
+static void delete_branch_config(const char *branchname)
+{
+	struct strbuf buf = STRBUF_INIT;
+	strbuf_addf(&buf, "branch.%s", branchname);
+	if (git_config_rename_section(buf.buf, NULL) < 0)
+		warning(_("Update of config-file failed"));
+	strbuf_release(&buf);
+}
+
 static int delete_branches(int argc, const char **argv, int force, int kinds,
 			   int quiet)
 {
@@ -237,17 +246,13 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			      bname.buf);
 			ret = 1;
 		} else {
-			struct strbuf buf = STRBUF_INIT;
 			if (!quiet)
 				printf(remote_branch
 				       ? _("Deleted remote branch %s (was %s).\n")
 				       : _("Deleted branch %s (was %s).\n"),
 				       bname.buf,
 				       find_unique_abbrev(sha1, DEFAULT_ABBREV));
-			strbuf_addf(&buf, "branch.%s", bname.buf);
-			if (git_config_rename_section(buf.buf, NULL) < 0)
-				warning(_("Update of config-file failed"));
-			strbuf_release(&buf);
+			delete_branch_config(bname.buf);
 		}
 	}
 
-- 
1.7.12
