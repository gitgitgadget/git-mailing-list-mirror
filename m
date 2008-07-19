From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] builtin-clone: Use is_dir_sep() instead of '/'
Date: Sat, 19 Jul 2008 15:49:56 +0200
Message-ID: <200807191549.56402.johannes.sixt@telecom.at>
References: <1216366485-12201-1-git-send-email-johannes.sixt@telecom.at> <7vk5fi67dx.fsf@gitster.siamese.dyndns.org> <200807191132.45648.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 15:50:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKCpv-0005kx-1B
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 15:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754603AbYGSNt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 09:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754599AbYGSNt7
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 09:49:59 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:53381 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493AbYGSNt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 09:49:59 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 4F66A9728F;
	Sat, 19 Jul 2008 15:49:57 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 7F7581D1F0;
	Sat, 19 Jul 2008 15:49:56 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <200807191132.45648.johannes.sixt@telecom.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89109>

On Samstag, 19. Juli 2008, Johannes Sixt wrote:
> On Samstag, 19. Juli 2008, Junio C Hamano wrote:
> > Ok, but the surrounding code in this function look very suspicious.
>
> How about this then?
>
> -- snip --
> builtin-clone: Rewrite guess_dir_name()
>
> The function has to do three small and independent tasks, but all of them
> were crammed into a single loop. This rewrites the function entirely by
> unrolling these tasks.

Sigh. I knew it, I knew it. If it had been that trivial, then Daniel had done
it this way in the first place. :-(

This needs to be squashed in. It makes sure that we handle 'foo/.git';
and .git was not stripped if we cloned from 'foo.git/'.

diff --git a/builtin-clone.c b/builtin-clone.c
index 91667d5..88616b3 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -98,10 +98,16 @@ static char *guess_dir_name(const char *repo, int is_bundle)
 	const char *end = repo + strlen(repo), *start, *dot;
 
 	/*
-	 * Strip trailing slashes
+	 * Strip trailing slashes and /.git
 	 */
 	while (repo < end && is_dir_sep(end[-1]))
 		end--;
+	if (end - repo > 5 && is_dir_sep(end[-5]) &&
+	    !strncmp(end - 4, ".git", 4)) {
+		end -= 5;
+		while (repo < end && is_dir_sep(end[-1]))
+			end--;
+	}
 
 	/*
 	 * Find last component, but be prepared that repo could have
@@ -116,10 +122,10 @@ static char *guess_dir_name(const char *repo, int is_bundle)
 	 * Strip .{bundle,git}.
 	 */
 	if (is_bundle) {
-		if (end - start > 7 && !strcmp(end - 7, ".bundle"))
+		if (end - start > 7 && !strncmp(end - 7, ".bundle", 7))
 			end -= 7;
 	} else {
-		if (end - start > 4 && !strcmp(end - 4, ".git"))
+		if (end - start > 4 && !strncmp(end - 4, ".git", 4))
 			end -= 4;
 	}
 
