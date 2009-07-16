From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH next] branch.c: if remote is not config'd for branch, don't try delete push config
Date: Thu, 16 Jul 2009 16:26:15 -0500
Message-ID: <W0GiRm9n1NEO0ox1puhqZPKGDpWW0rbH6Cp2gxr7ofSuhyo4HCl88lyU5dRIkYdZUK1rEnxQExw@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>,
	bonzini@gnu.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 16 23:26:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRYTU-0001ME-0a
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 23:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933425AbZGPV0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 17:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933410AbZGPV0k
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 17:26:40 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53112 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933406AbZGPV0k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 17:26:40 -0400
Received: by mail.nrlssc.navy.mil id n6GLQWag018101; Thu, 16 Jul 2009 16:26:32 -0500
X-OriginalArrivalTime: 16 Jul 2009 21:26:31.0850 (UTC) FILETIME=[168BD0A0:01CA065C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123429>

From: Brandon Casey <drafnel@gmail.com>

If a remote is not configured for the branch configuration being deleted,
then don't try to delete the remote.<remote>.push configuration for the
branch.  When the remote is not configured, branch->remote_name is not
filled in.  When this NULL branch->remote_name is passed to strbuf_addf()
it will result in an attempt to remove a bogus configuration statement in
the best case (i.e. "remote.(null).push" for platforms which guard against
supplying NULL to a %s conversion spec) and a segfault in the worst case.

So check whether branch->remote_name is non-NULL before trying to use it.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 branch.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/branch.c b/branch.c
index dfde568..6dc9175 100644
--- a/branch.c
+++ b/branch.c
@@ -116,13 +116,16 @@ void delete_branch_config (const char *name)
 
 	/* git config --unset-all remote.foo.push ^\+?refs/heads/bar:  */
 	branch = branch_get(name + 11);
-	strbuf_addf(&buf, "remote.%s.push", branch->remote_name);
-	strbuf_addstr(&push_re, "^\\+?");
-	strbuf_addstr_escape_re(&push_re, name);
-	strbuf_addch(&push_re, ':');
-	if (git_config_set_multivar(buf.buf, NULL, push_re.buf, 1) < 0) {
-		warning("Update of config-file failed");
-		goto fail;
+	if (branch->remote_name) {
+		strbuf_addf(&buf, "remote.%s.push", branch->remote_name);
+		strbuf_addstr(&push_re, "^\\+?");
+		strbuf_addstr_escape_re(&push_re, name);
+		strbuf_addch(&push_re, ':');
+		if (git_config_set_multivar(buf.buf, NULL, push_re.buf, 1) < 0)
+		{
+			warning("Update of config-file failed");
+			goto fail;
+		}
 	}
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "branch.%s", name + 11);
-- 
1.6.3.1.24.g152f4
