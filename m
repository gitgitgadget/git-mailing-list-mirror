From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] builtin-merge: avoid non-strategy git-merge commands in error message
Date: Sat, 26 Jul 2008 19:12:47 +0200
Message-ID: <1217092367-29114-1-git-send-email-vmiklos@frugalware.org>
References: <alpine.DEB.1.00.0807261900180.26810@eeepc-johanness>
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 26 19:13:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMnKs-0000Sf-So
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 19:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbYGZRMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 13:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753736AbYGZRMV
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 13:12:21 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:52936 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207AbYGZRMU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 13:12:20 -0400
Received: from vmobile.example.net (dsl5401C493.pool.t-online.hu [84.1.196.147])
	by yugo.frugalware.org (Postfix) with ESMTP id 7A7B31DDC5B;
	Sat, 26 Jul 2008 19:12:18 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 3DAA11AA738; Sat, 26 Jul 2008 19:12:47 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <alpine.DEB.1.00.0807261900180.26810@eeepc-johanness>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90263>

If an invalid strategy is supplied, like -s foobar, then git-merge
listed all git-merge-* commands. This is not perfect, since for example
git-merge-index is not a valid strategy.

These are now removed from the output by scanning the list of main
commands; if the git-merge-foo command is listed in the all_strategy
list, then it's shown, otherwise excluded. This does not exclude
commands somewhere else in the PATH, where custom strategies are
expected.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Sat, Jul 26, 2008 at 07:01:16PM +0200, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hmm. So let's say ent->name is "ours.exe", ent->len is set to 4.
> >
> > Then !strncmp(ent->name, all_strategy[j].name, ent->len) will be
> > true,
> > and the command will not be added to the exclude list.
>
> What I meant is: if you change the strcmp to strncmp because one of
> the
> both strings is not supposed to be NUL terminated, you still want to
> make
> sure that one is not a strict prefix of the other.

Aah, I forgot about all_strategy[j].name is NUL terminated.

Updated patch below.

 builtin-merge.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index cdbc692..29826b1 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -88,8 +88,21 @@ static struct strategy *get_strategy(const char *name)
 			return &all_strategy[i];
 
 	if (!is_git_command(name, "git-merge-")) {
+		struct cmdnames not_strategies;
+
+		memset(&not_strategies, 0, sizeof(struct cmdnames));
+		for (i = 0; i < main_cmds.cnt; i++) {
+			int j, found = 0;
+			struct cmdname *ent = main_cmds.names[i];
+			for (j = 0; j < ARRAY_SIZE(all_strategy); j++)
+				if (!strncmp(ent->name, all_strategy[j].name, ent->len)
+						&& !all_strategy[j].name[ent->len])
+					found = 1;
+			if (!found)
+				add_cmdname(&not_strategies, ent->name, ent->len);
+		}
 		fprintf(stderr, "Could not find merge strategy '%s'.\n\n", name);
-		list_commands("git-merge-", "strategies");
+		list_commands("git-merge-", "strategies", &not_strategies);
 		exit(1);
 	}
 
-- 
1.6.0.rc0.14.g95f8.dirty
