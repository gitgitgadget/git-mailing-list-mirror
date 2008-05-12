From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add a config option to ignore errors for git-add
Date: Mon, 12 May 2008 19:59:23 +0200
Message-ID: <20080512175923.GG3128@steel.home>
References: <47C95E34.1050306@dirk.my1.cc> <20080302154154.GC2973@steel.home> <20080302154238.GD2973@steel.home> <alpine.LSU.1.00.0803021555500.22527@racer.site> <7vtzjpoye6.fsf@gitster.siamese.dyndns.org> <20080512175654.GB3128@steel.home> <20080512175745.GC3128@steel.home> <20080512175810.GD3128@steel.home> <20080512175829.GE3128@steel.home> <20080512175848.GF3128@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dirk =?iso-8859-15?Q?S=FCsserott?= <newsletter@dirk.my1.cc>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 12 20:00:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvcJs-0007PS-CY
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 20:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756133AbYELR7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 13:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753635AbYELR7Z
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 13:59:25 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:17071 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756133AbYELR7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 13:59:25 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarO+BInc
Received: from tigra.home (Fab5c.f.strato-dslnet.de [195.4.171.92])
	by post.webmailer.de (klopstock mo48) (RZmta 16.34)
	with ESMTP id R03c80k4CFhFHC ; Mon, 12 May 2008 19:59:23 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 43FF9277BD;
	Mon, 12 May 2008 19:59:23 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 5B34E56D28; Mon, 12 May 2008 19:59:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080512175848.GF3128@steel.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81892>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 builtin-add.c  |   11 ++++++++++-
 t/t3700-add.sh |   12 ++++++++++++
 2 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 522519e..73235ed 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -206,6 +206,15 @@ static struct option builtin_add_options[] = {
 	OPT_END(),
 };
 
+static int add_config(const char *var, const char *value)
+{
+	if (!strcasecmp(var, "add.ignore-errors")) {
+		ignore_add_errors = git_config_bool(var, value);
+		return 0;
+	}
+	return git_default_config(var, value);
+}
+
 int cmd_add(int argc, const char **argv, const char *prefix)
 {
 	int exit_status = 0;
@@ -220,7 +229,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (add_interactive)
 		exit(interactive_add(argc, argv, prefix));
 
-	git_config(git_default_config);
+	git_config(add_config);
 
 	newfd = hold_locked_index(&lock_file, 1);
 
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index ca3e33d..08f1641 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -188,4 +188,16 @@ test_expect_success 'git add --ignore-errors' '
 	git ls-files |grep foo1
 '
 
+rm -f foo2
+
+test_expect_success 'git add (add.ignore-errors)' '
+	git config add.ignore-errors 1 &&
+	git reset --hard &&
+	date >foo1 &&
+	date >foo2 &&
+	chmod 0 foo2 &&
+	git add --verbose .
+	git ls-files |grep foo1
+'
+
 test_done
-- 
1.5.5.1.184.g5bee
