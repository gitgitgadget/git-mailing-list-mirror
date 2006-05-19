From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Allow pickaxe to be used via git log.
Date: Thu, 18 May 2006 23:38:03 -0400
Message-ID: <BAYC1-PASMTP10904A6D8E8EC08830C8F3AEA70@CEZ.ICE>
References: <BAYC1-PASMTP04945C92FB14DA65AB1AC7AEA70@CEZ.ICE>
	<7v4pzmn32g.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP07581788E7BAAC19B2A159AEA70@CEZ.ICE>
	<7vk68ilnoi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 05:43:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fgvu1-0002Lf-PI
	for gcvg-git@gmane.org; Fri, 19 May 2006 05:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWESDnr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 23:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWESDnr
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 23:43:47 -0400
Received: from bayc1-pasmtp10.bayc1.hotmail.com ([65.54.191.170]:60878 "EHLO
	BAYC1-PASMTP10.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S932216AbWESDnq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 23:43:46 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP10.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 18 May 2006 20:45:45 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id E3C32644C28;
	Thu, 18 May 2006 23:43:44 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060518233803.7e4ca954.seanlkml@sympatico.ca>
In-Reply-To: <7vk68ilnoi.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 19 May 2006 03:45:46.0234 (UTC) FILETIME=[B61A05A0:01C67AF6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 18 May 2006 20:05:01 -0700
Junio C Hamano <junkio@cox.net> wrote:


> User's scripts.  The point is the set of arguments rev-list as
> the lowest level machinery should not be modified by an
> arbitrary policy decision that happens to suit "git log" usage.
> 

Okay, thanks.

This moves the policy up a level and into the log/show/whatchanged code
and makes the code match the commit message better.  However, it will still
"disobey" user options if the user tries to combine both pickaxe and
--always for these commands; but hopefully that's okay at this level.

Sean

diff --git a/builtin-log.c b/builtin-log.c
index d5bbc1c..d2c3df0 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -23,6 +23,11 @@ static int cmd_log_wc(int argc, const ch
 	rev->commit_format = CMIT_FMT_DEFAULT;
 	rev->verbose_header = 1;
 	argc = setup_revisions(argc, argv, rev, "HEAD");
+	if (rev->diffopt.pickaxe && rev->always_show_header) {
+		rev->always_show_header = 0;
+		if (rev->diffopt.output_format == DIFF_FORMAT_RAW)
+			rev->diffopt.output_format = DIFF_FORMAT_NO_OUTPUT;
+	}
 
 	if (argc > 1)
 		die("unrecognized argument: %s", argv[1]);
