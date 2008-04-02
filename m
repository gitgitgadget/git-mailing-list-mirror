From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] commit: resurrect "gc --auto" at the end
Date: Wed, 2 Apr 2008 15:40:12 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0804021538220.4008@racer.site>
References: <20080330231408.GR11666@genesis> <20080330232612.GA23063@atjola.homenet> <alpine.LFD.1.00.0803301645020.14670@woody.linux-foundation.org> <7vr6drsl47.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 16:41:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jh49b-0007tX-If
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 16:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756682AbYDBOkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 10:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756268AbYDBOkA
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 10:40:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:43960 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756548AbYDBOj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 10:39:59 -0400
Received: (qmail invoked by alias); 02 Apr 2008 14:39:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 02 Apr 2008 16:39:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+qYigNNRiq+jH6LA2kH+dOydfDaGzlM/1xPnxoTN
	wTJLQdDB1chTvA
X-X-Sender: gene099@racer.site
In-Reply-To: <7vr6drsl47.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78693>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As the scripted version of git-commit did, we now call gc --auto just 
before the post-commit hook.

Any errors of gc --auto should be non-fatal, so we do not catch those; the 
user should see them anyway.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Junio wrote:
	>
	>  * "git commit" used to have one [call to 'gc --auto'] at the 
	>    end in the scripted version, but seems to have lost it in C
	>    rewrite.

	How about this?

 builtin-commit.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 660a345..bec62b2 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -863,6 +863,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	char *nl, *p;
 	unsigned char commit_sha1[20];
 	struct ref_lock *ref_lock;
+	const char *argv_gc_auto[] = { "gc", "--auto", NULL };
 
 	git_config(git_commit_config);
 
@@ -987,6 +988,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		     "not exceeded, and then \"git reset HEAD\" to recover.");
 
 	rerere();
+	/* We ignore errors in 'gc --auto', since the user should see them. */
+	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 	run_hook(get_index_file(), "post-commit", NULL);
 	if (!quiet)
 		print_summary(prefix, commit_sha1);
-- 
1.5.5.rc2.30.gf2056
