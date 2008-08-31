From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add help.autocorrect to enable/disable autocorrecting
Date: Sun, 31 Aug 2008 15:54:58 +0200
Message-ID: <20080831135458.GB6616@blimp.local>
References: <20080828171533.GA6024@blimp.local> <20080828212722.GF6439@steel.home> <7vsksm1pmd.fsf@gitster.siamese.dyndns.org> <81b0412b0808300944p29199600ie95c65404b6cb380@mail.gmail.com> <20080830171331.GA26932@steel.home> <7vprnqifd2.fsf@gitster.siamese.dyndns.org> <20080831135023.GA6616@blimp.local>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 15:56:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZnPX-0007Hv-4o
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 15:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756896AbYHaNzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 09:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756843AbYHaNzF
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 09:55:05 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:32085 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793AbYHaNzE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 09:55:04 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg201f4EPXSQ==
Received: from tigra.home (Faf6f.f.strato-dslnet.de [195.4.175.111])
	by post.webmailer.de (fruni mo64) (RZmta 16.47)
	with ESMTP id t0152dk7V9STUO ; Sun, 31 Aug 2008 15:55:00 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 80C64277AE;
	Sun, 31 Aug 2008 15:54:58 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 64D4436D1D; Sun, 31 Aug 2008 15:54:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080831135023.GA6616@blimp.local>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94482>

It is off(0) by default, to avoid scaring people unless they asked to.
If set to a non-0 value, wait for that amount of deciseconds before
running the corrected command.

Suggested by Junio, so he has a chance to hit Ctrl-C.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
Alex Riesen, Sun, Aug 31, 2008 15:50:23 +0200:
> Junio C Hamano, Sat, Aug 30, 2008 19:26:17 +0200:
> > Please reroll the whole f66dd34 (git wrapper: DWIM mistyped commands,
> > 2008-08-28), as it is not part of any solid integration branch yet.
> 
> I think I better reroll (now) both
> 

 Documentation/config.txt |    9 +++++++++
 help.c                   |   19 ++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index af57d94..8c644ab 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -790,6 +790,15 @@ help.format::
 	Values 'man', 'info', 'web' and 'html' are supported. 'man' is
 	the default. 'web' and 'html' are the same.
 
+help.autocorrect::
+	Automatically correct and execute mistyped commands after
+	waiting for the given number of deciseconds (0.1 sec). If more
+	than one command can be deduced from the entered text, nothing
+	will be executed.  If the value of this option is negative,
+	the corrected command will be executed immediately. If the
+	value is 0 - the command will be just shown but not executed.
+	This is the default.
+
 http.proxy::
 	Override the HTTP proxy, normally configured using the 'http_proxy'
 	environment variable (see linkgit:curl[1]).  This can be overridden
diff --git a/help.c b/help.c
index aaba809..300cd38 100644
--- a/help.c
+++ b/help.c
@@ -261,6 +261,16 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
 	return 0;
 }
 
+static int autocorrect;
+
+static int git_unknown_cmd_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "help.autocorrect"))
+		autocorrect = git_config_int(var,value);
+
+	return git_default_config(var, value, cb);
+}
+
 static int levenshtein_compare(const void *p1, const void *p2)
 {
 	const struct cmdname *const *c1 = p1, *const *c2 = p2;
@@ -278,6 +288,8 @@ const char *help_unknown_cmd(const char *cmd)
 	memset(&main_cmds, 0, sizeof(main_cmds));
 	memset(&other_cmds, 0, sizeof(main_cmds));
 
+	git_config(git_unknown_cmd_config, NULL);
+
 	load_command_list("git-", &main_cmds, &other_cmds);
 
 	ALLOC_GROW(main_cmds.names, main_cmds.cnt + other_cmds.cnt,
@@ -302,7 +314,7 @@ const char *help_unknown_cmd(const char *cmd)
 	n = 1;
 	while (n < main_cmds.cnt && best_similarity == main_cmds.names[n]->len)
 		++n;
-	if (n == 1) {
+	if (autocorrect && n == 1) {
 		const char *assumed = main_cmds.names[0]->name;
 		main_cmds.names[0] = NULL;
 		clean_cmdnames(&main_cmds);
@@ -310,6 +322,11 @@ const char *help_unknown_cmd(const char *cmd)
 			"which does not exist.\n"
 			"Continuing under the assumption that you meant '%s'\n",
 			cmd, assumed);
+		if (autocorrect > 0) {
+			fprintf(stderr, "in %0.1f seconds automatically...\n",
+				(float)autocorrect/10.0);
+			poll(NULL, 0, autocorrect * 100);
+		}
 		return assumed;
 	}
 
-- 
1.6.0.1.168.gdf6f0
