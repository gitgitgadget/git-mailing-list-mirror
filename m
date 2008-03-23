From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] Introduce receive.guardCurrentBranch
Date: Sun, 23 Mar 2008 21:43:43 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803232142460.4353@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Mar 23 21:44:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdX3n-0005lC-4C
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 21:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbYCWUn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 16:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754147AbYCWUn7
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 16:43:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:48965 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753003AbYCWUn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 16:43:58 -0400
Received: (qmail invoked by alias); 23 Mar 2008 20:43:55 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp014) with SMTP; 23 Mar 2008 21:43:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19NXTJZprhNtUQbLKSUyHoSZBJbkAVwceCTCfDtiF
	YtY70iothO3kWI
X-X-Sender: gene099@racer.site
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77955>


Setting this config variable to "true" makes git-receive-pack refuse
to update whatever happens to be the current branch.

This option can be used to avoid havoc in a non-bare repository into
which somebody pushes.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I thought about this a while (see also
	http://thread.gmane.org/gmane.comp.version-control.git/66490),
	and I think it is time to push for this change.

	On the one hand, of course, it is nice to have so many users
	that not all of them know the Git source intimately.  On the
	other hand, we will have to introduce many more safeguards
	like this now.  Sigh...

	Maybe this is even 1.5.5 material.  I'm undecided.

 Documentation/config.txt           |    5 +++++
 Documentation/git-receive-pack.txt |    3 +++
 receive-pack.c                     |   18 ++++++++++++++++++
 t/t5400-send-pack.sh               |   13 +++++++++++++
 4 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5df8ea9..efde54d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1006,6 +1006,11 @@ receive.denyNonFastForwards::
 	even if that push is forced. This configuration variable is
 	set when initializing a shared repository.
 
+receive.guardCurrentBranch::
+	If set to true, git-receive-pack will deny to update the ref that
+	HEAD points to, if HEAD is not detached.  This configuration
+	variable is set when initializing a non-bare repository.
+
 transfer.unpackLimit::
 	When `fetch.unpackLimit` or `receive.unpackLimit` are
 	not set, the value of this variable is used instead.
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 4111434..0c82af9 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -32,6 +32,9 @@ git-receive-pack honours the receive.denyNonFastForwards config
 option, which tells it if updates to a ref should be denied if they
 are not fast-forwards.
 
+git-receive-pack honors the receive.guardCurrentBranch config options,
+which tells it if it is okay to update the branch HEAD points to.
+
 OPTIONS
 -------
 <directory>::
diff --git a/receive-pack.c b/receive-pack.c
index 828d490..6423c7c 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -15,6 +15,7 @@ static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int unpack_limit = 100;
 static int report_status;
+static char *guard_current_branch;
 
 static char capabilities[] = " report-status delete-refs ";
 static int capabilities_sent;
@@ -41,6 +42,19 @@ static int receive_pack_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.guardhead") == 0) {
+		guard_current_branch = NULL;
+		if (git_config_bool(var, value)) {
+			unsigned char sha1[20];
+			int flag;
+			const char *head = resolve_ref("HEAD", sha1, 0, &flag);
+			if (flag & REF_ISSYMREF)
+				guard_current_branch = xstrdup(head);
+		}
+
+		return 0;
+	}
+
 	return git_default_config(var, value);
 }
 
@@ -183,6 +197,10 @@ static const char *update(struct command *cmd)
 		      "but I can't find it!", sha1_to_hex(new_sha1));
 		return "bad pack";
 	}
+	if (guard_current_branch && !strcmp(name, guard_current_branch)) {
+		error("refusing to update current branch: '%s'", name);
+		return "current branch";
+	}
 	if (deny_non_fast_forwards && !is_null_sha1(new_sha1) &&
 	    !is_null_sha1(old_sha1) &&
 	    !prefixcmp(name, "refs/heads/")) {
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 2b6b6e3..af8d5a3 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -171,4 +171,17 @@ test_expect_success \
 	rewound_push_succeeded
 '
 
+test_expect_success 'receive.guardCurrentBranch' '
+
+	rewound_push_setup &&
+	(cd ../parent &&
+	 git config receive.guardCurrentBranch true) &&
+	test_must_fail git-send-pack ../parent/.git refs/heads/master &&
+	rewound_push_failed &&
+	(cd ../parent &&
+	 git config receive.guardCurrentBranch false) &&
+	git-send-pack ../parent/.git +refs/heads/*:refs/heads/* &&
+	rewound_push_succeeded
+'
+
 test_done
-- 
1.5.5.rc1.174.g591a9
