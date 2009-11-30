From: David Soria Parra <sn_@gmx.net>
Subject: [PATCH 1/2] Teach clone to clone just one remote branch using --track
Date: Mon, 30 Nov 2009 14:16:43 +0100
Message-ID: <1259587004-14633-2-git-send-email-sn_@gmx.net>
References: <1259587004-14633-1-git-send-email-sn_@gmx.net>
Cc: David Soria Parra <dsp@php.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 14:16:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF67b-0006SB-4F
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 14:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbZK3NQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 08:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752284AbZK3NQp
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 08:16:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:38922 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752042AbZK3NQn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 08:16:43 -0500
Received: (qmail invoked by alias); 30 Nov 2009 13:16:48 -0000
Received: from e180064012.adsl.alicedsl.de (EHLO localhost.localdomain) [85.180.64.12]
  by mail.gmx.net (mp012) with SMTP; 30 Nov 2009 14:16:48 +0100
X-Authenticated: #4427663
X-Provags-ID: V01U2FsdGVkX1/3t70Cn/j3zyiM+AUxc9FzRwD1f4kef0Aa+aT52w
	MNrHCCcprWXiNE
X-Mailer: git-send-email 1.6.6.rc0.268.g1c272
In-Reply-To: <1259587004-14633-1-git-send-email-sn_@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134098>

From: David Soria Parra <dsp@php.net>

Add a --track option that can be used to clone just the
given branch from the remote and nothing else. This is done
by setting the remote.<branch>.fetch option before cloning.
This option cannot be used together with --mirror.
For example using

    git clone --track next git://git.kernel.org/pub/scm/git/git.git

will just clone the next branch from the git.git repository.

The option is called --track to ensure clean wording with
'git remote add --track'.

Signed-off-by: David Soria Parra <dsp@php.net>
---
 builtin-clone.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 5df8b0f..bc335ee 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -43,6 +43,7 @@ static char *option_template, *option_reference, *option_depth;
 static char *option_origin = NULL;
 static char *option_branch = NULL;
 static char *option_upload_pack = "git-upload-pack";
+static char *option_track = NULL;
 static int option_verbose;
 
 static struct option builtin_clone_options[] = {
@@ -76,6 +77,8 @@ static struct option builtin_clone_options[] = {
 		   "path to git-upload-pack on the remote"),
 	OPT_STRING(0, "depth", &option_depth, "depth",
 		    "create a shallow clone of that depth"),
+	OPT_STRING('t', "track", &option_track, "branch",
+			"remote branche to track"),
 
 	OPT_END()
 };
@@ -483,7 +486,14 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
 	}
 
-	strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
+	if (option_track) {
+		if (option_mirror)
+			return error("Cannot use --track together with --mirror");
+		strbuf_addf(&value, "+%s%s:%s%s", src_ref_prefix, option_track, branch_top.buf, option_track);
+		option_branch = option_track;
+	} else {
+		strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
+	}
 
 	if (option_mirror || !option_bare) {
 		/* Configure the remote */
-- 
1.6.6.rc0.268.g1c272
