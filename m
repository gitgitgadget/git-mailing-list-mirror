From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/4] Make '--decorate' set an explicit 'show_decorations'
 flag
Date: Mon, 3 Nov 2008 11:39:48 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811031135410.3419@nehalem.linux-foundation.org>
References: <200811031439.12111.brian.foster@innova-card.com> <alpine.LFD.2.00.0811031129060.3419@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811031132520.3419@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0811031133590.3419@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Brian Foster <brian.foster@innova-card.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 20:41:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx5J0-0002lj-LD
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 20:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521AbYKCTk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 14:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754475AbYKCTk2
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 14:40:28 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35206 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754314AbYKCTk1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2008 14:40:27 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA3JdmuI022800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Nov 2008 11:39:49 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA3JdmqA025693;
	Mon, 3 Nov 2008 11:39:48 -0800
In-Reply-To: <alpine.LFD.2.00.0811031133590.3419@nehalem.linux-foundation.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.94 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99984>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Nov 2008 11:23:57 -0800
Subject: [PATCH 3/4] Make '--decorate' set an explicit 'show_decorations' flag

We will want to add decorations without necessarily showing them, so add
an explicit revisions info flag as to whether we're showing decorations
or not.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Another really trivial preparatory patch. Instead of writing to a totally 
unused and pointless local variable (yeah, don't ask me why it does that, 
it's probably my brainfart from long ago), set a "revs->show_decorations" 
flag that we actually _use_ to decide if we want to show decorations or 
not when outputting logs.

This makes no semantic difference, since there are only two users of 
decorations:
 - format_decoration() which does everything by hand
 - show_decorations() that now looks at the flag that we set when we 
   preload them.

It _will_ matter in the next commit, though. Because soon we'll start 
loading decorations without actually wanting to necessarily show them!

 builtin-log.c |    3 +--
 log-tree.c    |    2 ++
 revision.h    |    1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 176cbce..82ea07b 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -28,7 +28,6 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		      struct rev_info *rev)
 {
 	int i;
-	int decorate = 0;
 
 	rev->abbrev = DEFAULT_ABBREV;
 	rev->commit_format = CMIT_FMT_DEFAULT;
@@ -55,7 +54,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--decorate")) {
 			load_ref_decorations();
-			decorate = 1;
+			rev->show_decorations = 1;
 		} else if (!strcmp(arg, "--source")) {
 			rev->show_source = 1;
 		} else
diff --git a/log-tree.c b/log-tree.c
index cf7947b..5444f08 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -59,6 +59,8 @@ void show_decorations(struct rev_info *opt, struct commit *commit)
 
 	if (opt->show_source && commit->util)
 		printf(" %s", (char *) commit->util);
+	if (!opt->show_decorations)
+		return;
 	decoration = lookup_decoration(&name_decoration, &commit->object);
 	if (!decoration)
 		return;
diff --git a/revision.h b/revision.h
index 51a4863..0a1806a 100644
--- a/revision.h
+++ b/revision.h
@@ -54,6 +54,7 @@ struct rev_info {
 			rewrite_parents:1,
 			print_parents:1,
 			show_source:1,
+			show_decorations:1,
 			reverse:1,
 			reverse_output_stage:1,
 			cherry_pick:1,
-- 
1.6.0.3.616.gf1239d6.dirty
