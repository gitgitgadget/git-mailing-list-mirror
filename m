From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] git-log -g --pretty=oneline should display the reflog message
Date: Sat, 27 Jan 2007 22:40:36 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701272235190.3021@xanadu.home>
References: <7vps90lvoh.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0701271415280.3021@xanadu.home>
 <7vhcuci0z0.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0701272049480.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jan 28 04:40:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HB0uS-0003pa-16
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 04:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbXA1Dki (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 22:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbXA1Dki
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 22:40:38 -0500
Received: from relais.videotron.ca ([24.201.245.36]:48978 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932378AbXA1Dkh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 22:40:37 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCK00NV77JO2O80@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 27 Jan 2007 22:40:37 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0701272049480.3021@xanadu.home>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38017>

In the context of reflog output the reflog message is more useful than 
the commit message's first line.  When relevant the reflog message 
will contain 
that line anyway.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

On Sat, 27 Jan 2007, Nicolas Pitre wrote:

> The --pretty=oneline output when using -g should probably display the 
> reflog message instead of the commit message as well.

And this patch does just that.

diff --git a/log-tree.c b/log-tree.c
index c0fa096..d8ca36b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -224,9 +224,14 @@ void show_log(struct rev_info *opt, const char *sep)
 		printf("%s",
 		       diff_get_color(opt->diffopt.color_diff, DIFF_RESET));
 		putchar(opt->commit_format == CMIT_FMT_ONELINE ? ' ' : '\n');
-		if (opt->reflog_info)
+		if (opt->reflog_info) {
 			show_reflog_message(opt->reflog_info,
 				    opt->commit_format == CMIT_FMT_ONELINE);;
+			if (opt->commit_format == CMIT_FMT_ONELINE) {
+				printf("%s", sep);
+				return;
+			}
+		}
 	}
 
 	/*
diff --git a/reflog-walk.c b/reflog-walk.c
index 8e2cd2f..8262160 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -233,7 +233,7 @@ void show_reflog_message(struct reflog_walk_info* info, int oneline)
 			else
 				printf("%d", commit_reflog->reflogs->nr
 				       - 2 - commit_reflog->recno);
-			printf("}: ");
+			printf("}: %s", info->message);
 		}
 		else {
 			printf("Reflog: %s@{", commit_reflog->reflogs->ref);
