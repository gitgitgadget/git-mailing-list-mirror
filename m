From: Junio C Hamano <junkio@cox.net>
Subject: Re: problem with http clone/pull
Date: Tue, 12 Sep 2006 17:39:06 -0700
Message-ID: <7vvensd2hh.fsf@assigned-by-dhcp.cox.net>
References: <17671.16741.995661.664789@cargo.ozlabs.ibm.com>
	<7vodtkejm9.fsf@assigned-by-dhcp.cox.net>
	<7v7j08eikw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Sep 13 02:38:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNIlW-0002Ry-0Y
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 02:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWIMAiG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Sep 2006 20:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWIMAiG
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Sep 2006 20:38:06 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:9158 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751401AbWIMAiE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Sep 2006 20:38:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060913003803.FFAY2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Tue, 12 Sep 2006 20:38:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Mcdt1V00P1kojtg0000000
	Tue, 12 Sep 2006 20:37:53 -0400
To: git@vger.kernel.org
In-Reply-To: <7v7j08eikw.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 12 Sep 2006 17:06:07 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26897>

Junio C Hamano <junkio@cox.net> writes:

> Perhaps this would fix it?
>
> I am at work now and I haven't looked at the logic aruond it
> too deeply (e.g. I do not know if this breaks the relative
> alternate or http specific cases, nor the same or similar
> breakages were there in these other cases in the original code
> to begin with)

Side note:

> diff --git a/http-fetch.c b/http-fetch.c
> index fac1760..d870390 100644
> --- a/http-fetch.c
> +++ b/http-fetch.c
> @@ -559,7 +559,13 @@ static void process_alternates_response(
>  			char *target = NULL;
>  			char *path;
>  			if (data[i] == '/') {
> -				serverlen = strchr(base + 8, '/') - base;
> +				/* This counts
> +				 * http://git.host/pub/scm/linux.git
> +				 * 1234567----here^
> +				 * so strcpy(dst, base, serverlen) will
> +				 * copy up to "...git.host/"
> +				 */
> +				serverlen = strchr(base + 7, '/') - base;
>  				okay = 1;
>  			} else if (!memcmp(data + i, "../", 3)) {
>  				i += 3;

The change between 7 and 8 does not really matter, because the
hostname cannot be empty, and 8 was masking the breakage of this
code; it was (perhaps deliberately) being sloppy to allow us to
also skip over "protocol://" part for https:// case.  Call it
subtle if you want ;-).

I think the right thing for this part to do would be something
like this:

diff --git a/http-fetch.c b/http-fetch.c
index fac1760..c7545f2 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -559,8 +559,18 @@ static void process_alternates_response(
 			char *target = NULL;
 			char *path;
 			if (data[i] == '/') {
-				serverlen = strchr(base + 8, '/') - base;
-				okay = 1;
+				/* This counts
+				 * http://git.host/pub/scm/linux.git
+				 * -----------here^
+				 * so memcpy(dst, base, serverlen) will
+				 * copy up to "...git.host".
+				 */
+				const char *colon_ss = strstr(base,"://");
+				if (colon_ss) {
+					serverlen = (strchr(colon_ss + 3, '/')
+						     - base);
+					okay = 1;
+				}
 			} else if (!memcmp(data + i, "../", 3)) {
 				i += 3;
 				serverlen = strlen(base);
@@ -583,11 +593,13 @@ static void process_alternates_response(
 					okay = 1;
 				}
 			}
-			/* skip 'objects' at end */
+			/* skip "objects\n" at end */
 			if (okay) {
 				target = xmalloc(serverlen + posn - i - 6);
-				strlcpy(target, base, serverlen);
-				strlcpy(target + serverlen, data + i, posn - i - 6);
+				memcpy(target, base, serverlen);
+				memcpy(target + serverlen, data + i,
+				       posn - i - 7);
+				target[serverlen + posn - i - 7] = 0;
 				if (get_verbosely)
 					fprintf(stderr,
 						"Also look at %s\n", target);
