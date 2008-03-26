From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix branches file configuration
Date: Wed, 26 Mar 2008 01:03:01 -0700
Message-ID: <7v7ifpgbey.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0803251931500.19665@iabervon.org>
 <7v3aqel5ms.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803260240570.19665@iabervon.org>
 <7v4paugcyn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 26 09:04:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeQc5-0006ft-TD
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 09:04:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbYCZIDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 04:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752604AbYCZIDT
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 04:03:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41473 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbYCZIDR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 04:03:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A1B2D2487;
	Wed, 26 Mar 2008 04:03:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9417C2486; Wed, 26 Mar 2008 04:03:10 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78272>

From: Daniel Barkalow <barkalow@iabervon.org>
Date: Tue, 25 Mar 2008 19:35:28 -0400
Subject: [PATCH] Fix branches file configuration

Fetched remote branch from .git/branches/foo should fetch into
refs/heads/foo.  Also when partial URL is given, the fetched head should
always be remote HEAD, and the result should not be stored anywhere.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Junio C Hamano <gitster@pobox.com> writes:

 > Daniel Barkalow <barkalow@iabervon.org> writes:
 >
 >> ... (See line 115 of 755225de:git-parse-remote.sh)
 >
 > Yeah, sounds like it.  Will queue in 'next', for eventual inclusion in
 > 'maint'.  This is a 1.5.4 regression fix, together with "push --tags" fix
 > we discussed today.

 Actually there seems to be one more difference.  Here is what I think is
 needed for 'maint'.

 remote.c |   28 ++++++++++++++++++++++------
 1 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/remote.c b/remote.c
index 95d65a0..d8a4671 100644
--- a/remote.c
+++ b/remote.c
@@ -171,7 +171,7 @@ static void read_branches_file(struct remote *remote)
 {
 	const char *slash = strchr(remote->name, '/');
 	char *frag;
-	char *branch;
+	struct strbuf branch;
 	int n = slash ? slash - remote->name : 1000;
 	FILE *f = fopen(git_path("branches/%.*s", n, remote->name), "r");
 	char *s, *p;
@@ -197,17 +197,33 @@ static void read_branches_file(struct remote *remote)
 	strcpy(p, s);
 	if (slash)
 		strcat(p, slash);
+
+	/*
+	 * With "slash", e.g. "git fetch jgarzik/netdev-2.6" when
+	 * reading from $GIT_DIR/branches/jgarzik fetches "HEAD" from
+	 * the partial URL obtained from the branches file plus
+	 * "/netdev-2.6" and does not store it in any tracking ref.
+	 * #branch specifier in the file is ignored.
+	 *
+	 * Otherwise, the branches file would have URL and optionally
+	 * #branch specified.  The "master" (or specified) branch is
+	 * fetched and stored in the local branch of the same name.
+	 */
+	strbuf_init(&branch, 0);
 	frag = strchr(p, '#');
 	if (frag) {
 		*(frag++) = '\0';
-		branch = xmalloc(strlen(frag) + 12);
-		strcpy(branch, "refs/heads/");
-		strcat(branch, frag);
+		strbuf_addf(&branch, "refs/heads/%s", frag);
+	} else
+		strbuf_addstr(&branch, "refs/heads/master");
+	if (!slash) {
+		strbuf_addf(&branch, ":refs/heads/%s", remote->name);
 	} else {
-		branch = "refs/heads/master";
+		strbuf_reset(&branch);
+		strbuf_addstr(&branch, "HEAD:");
 	}
 	add_url(remote, p);
-	add_fetch_refspec(remote, branch);
+	add_fetch_refspec(remote, strbuf_detach(&branch, 0));
 	remote->fetch_tags = 1; /* always auto-follow */
 }
 
-- 
1.5.5.rc1.128.g340c
