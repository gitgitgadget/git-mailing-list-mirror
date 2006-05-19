From: Sean <seanlkml@sympatico.ca>
Subject: [PATCH] Allow pickaxe and diff-filter options to be used by git
 log.
Date: Fri, 19 May 2006 00:19:20 -0400
Message-ID: <BAYC1-PASMTP096010F052E9BF78B5FD4AAEA70@CEZ.ICE>
References: <BAYC1-PASMTP04945C92FB14DA65AB1AC7AEA70@CEZ.ICE>
	<7vac9elm2p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 06:25:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgwYe-0008P7-7B
	for gcvg-git@gmane.org; Fri, 19 May 2006 06:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWESEZF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 00:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWESEZF
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 00:25:05 -0400
Received: from bayc1-pasmtp09.bayc1.hotmail.com ([65.54.191.169]:1812 "EHLO
	BAYC1-PASMTP09.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S932219AbWESEZD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 00:25:03 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP09.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 18 May 2006 21:26:44 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 2BCF3644C28;
	Fri, 19 May 2006 00:25:02 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060519001920.42990900.seanlkml@sympatico.ca>
In-Reply-To: <7vac9elm2p.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 19 May 2006 04:26:45.0171 (UTC) FILETIME=[6FBE0830:01C67AFC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Handle the -S option when passed to git log such that only the
appropriate commits are displayed.  Also per Junio's comments, do
the same for "--diff-filter", so that it too can be used as an option
to git log.  By default no patch or diff information is displayed.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>

---

> If your goal is to make whatchanged less necessary, I think you
> would need to special case --diff-filter as well for "git log",
> although nobody on #git channel seems to have noticed.  I often
> run --diff-filter=A when I am trying to see when I added a
> particular file, to avoid getting distracted by other types of
> changes; log would be still shown if do not disable --always.

Makes sense.  This patch should cover that case too.

Sean


a2221c07a94bc378ef40182fa6b260ac88804073
 builtin-log.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

a2221c07a94bc378ef40182fa6b260ac88804073
diff --git a/builtin-log.c b/builtin-log.c
index d5bbc1c..12a6d19 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -23,6 +23,13 @@ static int cmd_log_wc(int argc, const ch
 	rev->commit_format = CMIT_FMT_DEFAULT;
 	rev->verbose_header = 1;
 	argc = setup_revisions(argc, argv, rev, "HEAD");
+	if (rev->always_show_header) {
+		if (rev->diffopt.pickaxe || rev->diffopt.filter) {
+			rev->always_show_header = 0;
+			if (rev->diffopt.output_format == DIFF_FORMAT_RAW)
+				rev->diffopt.output_format = DIFF_FORMAT_NO_OUTPUT;
+		}
+	}
 
 	if (argc > 1)
 		die("unrecognized argument: %s", argv[1]);
-- 
1.3.GIT
