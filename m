From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/10] Migrate git-clone to use git-rev-parse --parseopt
Date: Tue, 06 Nov 2007 11:32:49 -0800
Message-ID: <7vr6j3gof2.fsf@gitster.siamese.dyndns.org>
References: <1194172262-1563-1-git-send-email-madcoder@debian.org>
	<1194172262-1563-2-git-send-email-madcoder@debian.org>
	<1194172262-1563-3-git-send-email-madcoder@debian.org>
	<1194172262-1563-4-git-send-email-madcoder@debian.org>
	<1194172262-1563-5-git-send-email-madcoder@debian.org>
	<alpine.LFD.0.9999.0711061355330.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Nov 06 20:33:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpUAx-0003me-HW
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 20:33:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650AbXKFTc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 14:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754586AbXKFTc5
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 14:32:57 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:48814 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754160AbXKFTc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 14:32:56 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8DE992F0;
	Tue,  6 Nov 2007 14:33:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id EF9E992DF5;
	Tue,  6 Nov 2007 14:33:12 -0500 (EST)
In-Reply-To: <alpine.LFD.0.9999.0711061355330.21255@xanadu.home> (Nicolas
	Pitre's message of "Tue, 06 Nov 2007 14:04:07 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63704>

Gaah.

I'd blame Linus for suggesting to make parseopt part of
rev-parse, the latter of which makes sense only inside git while
the former of which makes sense outside git.

Would something like this help?

---
 builtin-rev-parse.c |    4 ++--
 git.c               |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 054519b..d1038a0 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -337,11 +337,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 	int i, as_is = 0, verify = 0;
 	unsigned char sha1[20];
 
-	git_config(git_default_config);
-
 	if (argc > 1 && !strcmp("--parseopt", argv[1]))
 		return cmd_parseopt(argc - 1, argv + 1, prefix);
 
+	prefix = setup_git_directory();
+	git_config(git_default_config);
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
diff --git a/git.c b/git.c
index 6c5f9af..204a6f7 100644
--- a/git.c
+++ b/git.c
@@ -340,7 +340,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "rerere", cmd_rerere, RUN_SETUP },
 		{ "reset", cmd_reset, RUN_SETUP },
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
-		{ "rev-parse", cmd_rev_parse, RUN_SETUP },
+		{ "rev-parse", cmd_rev_parse },
 		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
 		{ "rm", cmd_rm, RUN_SETUP },
 		{ "runstatus", cmd_runstatus, RUN_SETUP | NEED_WORK_TREE },
