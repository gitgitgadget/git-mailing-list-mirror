From: Junio C Hamano <junkio@cox.net>
Subject: Re: problem with http clone/pull
Date: Tue, 12 Sep 2006 17:06:07 -0700
Message-ID: <7v7j08eikw.fsf@assigned-by-dhcp.cox.net>
References: <17671.16741.995661.664789@cargo.ozlabs.ibm.com>
	<7vodtkejm9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 13 02:05:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNIFc-00055w-O7
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 02:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbWIMAFI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Sep 2006 20:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbWIMAFI
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Sep 2006 20:05:08 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:55953 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030383AbWIMAFG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Sep 2006 20:05:06 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060913000505.KHWI12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Tue, 12 Sep 2006 20:05:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Mc4v1V00Y1kojtg0000000
	Tue, 12 Sep 2006 20:04:55 -0400
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <7vodtkejm9.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 12 Sep 2006 16:43:42 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26896>

Junio C Hamano <junkio@cox.net> writes:

> I've seen this "last character of hostname dropped" symptom
> mentioned on the #git channel long time ago, but I do not
> remember if somebody figured out what the problem was.  I know
> that nobody did a patch to specifically fix it.

Perhaps this would fix it?

I am at work now and I haven't looked at the logic aruond it
too deeply (e.g. I do not know if this breaks the relative
alternate or http specific cases, nor the same or similar
breakages were there in these other cases in the original code
to begin with)

---

diff --git a/http-fetch.c b/http-fetch.c
index fac1760..d870390 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -559,7 +559,13 @@ static void process_alternates_response(
 			char *target = NULL;
 			char *path;
 			if (data[i] == '/') {
-				serverlen = strchr(base + 8, '/') - base;
+				/* This counts
+				 * http://git.host/pub/scm/linux.git
+				 * 1234567----here^
+				 * so strcpy(dst, base, serverlen) will
+				 * copy up to "...git.host/"
+				 */
+				serverlen = strchr(base + 7, '/') - base;
 				okay = 1;
 			} else if (!memcmp(data + i, "../", 3)) {
 				i += 3;
@@ -586,7 +592,7 @@ static void process_alternates_response(
 			/* skip 'objects' at end */
 			if (okay) {
 				target = xmalloc(serverlen + posn - i - 6);
-				strlcpy(target, base, serverlen);
+				memcpy(target, base, serverlen);
 				strlcpy(target + serverlen, data + i, posn - i - 6);
 				if (get_verbosely)
 					fprintf(stderr,
