From: Junio C Hamano <junkio@cox.net>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Wed, 14 Feb 2007 09:29:39 -0800
Message-ID: <7v3b58r6kc.fsf@assigned-by-dhcp.cox.net>
References: <45CFA30C.6030202@verizon.net>
	<200702130932.51601.litvinov2004@gmail.com>
	<Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
	<Pine.LNX.4.64.0702130919100.8424@woody.linux-foundation.org>
	<7v7iumx7hu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702131053110.8424@woody.linux-foundation.org>
	<7v8xf1uxme.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702132127330.3604@woody.linux-foundation.org>
	<Pine.LNX.4.63.0702141208020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45D31C0E.2040206@verizon.net>
	<Pine.LNX.4.64.0702140745110.3604@woody.linux-foundation.org>
	<7v64a4snfo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702140855080.3604@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mdl123@verizon.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 18:29:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHNwu-0004Ct-3v
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 18:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbXBNR3l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 12:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbXBNR3l
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 12:29:41 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:41539 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbXBNR3k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 12:29:40 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214172940.NTXN4586.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 12:29:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PVVf1W00E1kojtg0000000; Wed, 14 Feb 2007 12:29:39 -0500
In-Reply-To: <Pine.LNX.4.64.0702140855080.3604@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 14 Feb 2007 09:01:41 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39698>

Linus Torvalds <torvalds@linux-foundation.org> writes:

>> -	if (stats->nul)
>> +	if (stats->nonprintable)
>
> But this is too harsh.
>
> It's quite common to have the occasional FF character. Some things really 
> do use it for page breaks. So saying that *any* nonprintable character is 
> bad is not a good idea.
>
> Same goes for BS (some programs use it to show bold and underlined text: 
> man-pages, for example).

Ok.  How about adding BS and FF to the Ok set, and checking if
bad ones are less than 1% of the good ones?

diff --git a/convert.c b/convert.c
index b6b7c66..b0c7641 100644
--- a/convert.c
+++ b/convert.c
@@ -34,11 +34,22 @@ static void gather_stats(const char *buf, unsigned long size, struct text_stat *
 			stats->lf++;
 			continue;
 		}
-		if ((c < 32) && (c != '\t' && c != '\033')) {
+		if (c == 127)
+			/* DEL */
 			stats->nonprintable++;
-			continue;
+		else if (c < 32) {
+			switch (c) {
+				/* BS, HT, ESC and FF */
+			case '\b': case '\t': case '\033': case '\014':
+				stats->printable++;
+				break;
+			default:
+				stats->nonprintable++;
+			}
+			
 		}
-		stats->printable++;
+		else
+			stats->printable++;
 	}
 }
 
@@ -48,7 +59,7 @@ static void gather_stats(const char *buf, unsigned long size, struct text_stat *
 static int is_binary(unsigned long size, struct text_stat *stats)
 {
 
-	if (stats->nonprintable)
+	if ((stats->printable >> 7) < stats->nonprintable)
 		return 1;
 	/*
 	 * Other heuristics? Average line length might be relevant,
