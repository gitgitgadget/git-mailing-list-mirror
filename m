From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rerere should not repeat the earlier hunks in later ones
Date: Wed, 4 Apr 2007 17:51:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0704041746580.4045@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v1wj1ujf5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 17:51:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ7ll-0008SR-Uq
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 17:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992970AbXDDPvZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 11:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992964AbXDDPvY
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 11:51:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:36445 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992945AbXDDPvX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 11:51:23 -0400
Received: (qmail invoked by alias); 04 Apr 2007 15:51:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 04 Apr 2007 17:51:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18L+1YmbHYLmwq+dsWXXZfV8/U2XfiskaenVQxKZ1
	u6KoelhqoNCA/5
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v1wj1ujf5.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43748>

Hi,

On Tue, 3 Apr 2007, Junio C Hamano wrote:

> When a file has more then one conflicting hunks, it repeated the
> contents of previous hunks in output for later ones.

/me wonders why our spell-checker has not replied yet: isn't it "than" 
instead of "then"?

> @@ -131,6 +138,8 @@ static int handle_file(const char *path,
>  				SHA1_Update(&ctx, two->ptr, two->nr);
>  				SHA1_Update(&ctx, "\0", 1);
>  			}
> +			clear_buffer(one);
> +			clear_buffer(two);
>  		} else if (hunk == 1)
>  			append_line(one, buf);
>  		else if (hunk == 2)

Ouch. Well spotted, thanks.

I wonder if we should also do

diff --git a/builtin-rerere.c b/builtin-rerere.c
index b8867ab..4eae27b 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -112,7 +112,8 @@ static int handle_file(const char *path,
 		else if (!prefixcmp(buf, ">>>>>>> ")) {
 			hunk_no++;
 			hunk = 0;
-			if (memcmp(one->ptr, two->ptr, one->nr < two->nr ?
+			if (one->nr > two->nr || memcmp(one->ptr, two->ptr,
+						one->nr < two->nr ?
 						one->nr : two->nr) > 0) {
 				struct buffer *swap = one;
 				one = two;

in case that one conflicting region is prefix of the other one.

Ciao,
Dscho
