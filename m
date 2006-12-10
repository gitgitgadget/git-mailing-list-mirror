X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] remove "[PATCH]" prefix from shortlog output
Date: Sun, 10 Dec 2006 15:32:57 -0800
Message-ID: <7vac1v2uom.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0612091954010.2630@xanadu.home>
	<Pine.LNX.4.63.0612102337090.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 23:33:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612102337090.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 10 Dec 2006 23:40:56 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33959>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtYAI-0000AV-Rw for gcvg-git@gmane.org; Mon, 11 Dec
 2006 00:33:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762367AbWLJXc7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 18:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762369AbWLJXc7
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 18:32:59 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:56199 "EHLO
 fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1758281AbWLJXc6 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006
 18:32:58 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061210233258.FQMX25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>; Sun, 10
 Dec 2006 18:32:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id xBYL1V00H1kojtg0000000; Sun, 10 Dec 2006
 18:32:21 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It tries not only to strip "[PATCH]", but also "[PATCH 0/n]" and basically 
> every prefix beginning with "[PATCH" and ending in "]". I do not remember 
> if I really tested that code, but it should work.

The problem is that you forgot that the lines are indented when
acting as a filter.

How about this?  It also contains the extra whitespace removal
from the author name.

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 7a2ddfe..3fc43dd 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -188,18 +188,25 @@ static void read_from_stdin(struct path_list *list)
 				bob = buffer + strlen(buffer);
 			else {
 				offset = 8;
-				if (isspace(bob[-1]))
+				while (buffer + offset < bob &&
+				       isspace(bob[-1]))
 					bob--;
 			}
 
 			while (fgets(buffer2, sizeof(buffer2), stdin) &&
 					buffer2[0] != '\n')
 				; /* chomp input */
-			if (fgets(buffer2, sizeof(buffer2), stdin))
+			if (fgets(buffer2, sizeof(buffer2), stdin)) {
+				int l2 = strlen(buffer2);
+				int i;
+				for (i = 0; i < l2; i++)
+					if (!isspace(buffer2[i]))
+						break;
 				insert_author_oneline(list,
 						buffer + offset,
 						bob - buffer - offset,
-						buffer2, strlen(buffer2));
+						buffer2 + i, l2 - i);
+			}
 		}
 	}
 }
