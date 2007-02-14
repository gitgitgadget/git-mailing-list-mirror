From: Junio C Hamano <junkio@cox.net>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Wed, 14 Feb 2007 08:39:55 -0800
Message-ID: <7v64a4snfo.fsf@assigned-by-dhcp.cox.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mdl123@verizon.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 17:40:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHNAz-0008Go-N1
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 17:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbXBNQkJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 11:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbXBNQkJ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 11:40:09 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:44696 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932370AbXBNQkH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 11:40:07 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214163957.MOPJ4586.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 11:39:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PUfv1W00f1kojtg0000000; Wed, 14 Feb 2007 11:39:56 -0500
In-Reply-To: <Pine.LNX.4.64.0702140745110.3604@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 14 Feb 2007 07:51:00 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39675>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Actually, my patch already had one that you didn't mention: 
>  6) CR never shows up alone.

Older Macs ;-)?

> So the patch I sent out basicallyhad the following rules:
>  - no more than ~10% of all characters being other than regular printable 
>    ASCII (where any control character except for newline/cr/tab was deemed 
>    nonprintable)
>  - any "lonely" CR automatically means it's binary, and I would refuse 
>    to convert that to a LF (the test in the code is that CRLF count must 
>    match CR count)
> ...
> I think that to help asian languages (or strange text-files in utf8 or 
> Latin1 too, for that matter: test-files with _just_ special characters), I 
> should probably make the rule be that only the 0-31 range is special.

I would agree.  0-31 except HT, CR, LF and ESC would be a good
idea; that would not harm text in UTF-8, EUC based various
locales nor ISO 2022.

Patch is relative to 'pu'.
-- >8 --

diff --git a/convert.c b/convert.c
index ebcf717..b6b7c66 100644
--- a/convert.c
+++ b/convert.c
@@ -13,7 +13,7 @@ struct text_stat {
 	unsigned cr, lf, crlf;
 
 	/* These are just approximations! */
-	unsigned printable, nonprintable, nul;
+	unsigned printable, nonprintable;
 };
 
 static void gather_stats(const char *buf, unsigned long size, struct text_stat *stats)
@@ -34,13 +34,11 @@ static void gather_stats(const char *buf, unsigned long size, struct text_stat *
 			stats->lf++;
 			continue;
 		}
-		if (c == '\t' || (c >= 32 && c < 127)) {
-			stats->printable++;
+		if ((c < 32) && (c != '\t' && c != '\033')) {
+			stats->nonprintable++;
 			continue;
 		}
-		if (!c)
-			stats->nul++;
-		stats->nonprintable++;
+		stats->printable++;
 	}
 }
 
@@ -50,7 +48,7 @@ static void gather_stats(const char *buf, unsigned long size, struct text_stat *
 static int is_binary(unsigned long size, struct text_stat *stats)
 {
 
-	if (stats->nul)
+	if (stats->nonprintable)
 		return 1;
 	/*
 	 * Other heuristics? Average line length might be relevant,
