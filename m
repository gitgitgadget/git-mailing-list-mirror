From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH MISC 1/1] Make gcc warning about empty if body go away.
Date: Wed, 07 Nov 2007 18:01:51 -0800
Message-ID: <7vode57awg.fsf@gitster.siamese.dyndns.org>
References: <1194430832-6224-1-git-send-email-madcoder@debian.org>
	<1194430832-6224-2-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Nov 08 03:02:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipwiu-0003P4-EY
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 03:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203AbXKHCCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 21:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753966AbXKHCCE
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 21:02:04 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:45347 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539AbXKHCCB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 21:02:01 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 315B62EF;
	Wed,  7 Nov 2007 21:02:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id A84B49363C;
	Wed,  7 Nov 2007 21:02:20 -0500 (EST)
In-Reply-To: <1194430832-6224-2-git-send-email-madcoder@debian.org> (Pierre
	Habouzit's message of "Wed, 7 Nov 2007 11:20:26 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63922>

Pierre Habouzit <madcoder@debian.org> writes:

> diff --git a/builtin-diff.c b/builtin-diff.c
> index f77352b..80392a8 100644
> --- a/builtin-diff.c
> +++ b/builtin-diff.c
> @@ -204,7 +204,7 @@ static void refresh_index_quietly(void)
>  		if (write_cache(fd, active_cache, active_nr) ||
>  		    close(fd) ||
>  		    commit_locked_index(lock_file))
> -			; /*
> +			(void)0; /*
>  			   * silently ignore it -- we haven't mucked
>  			   * with the real index.
>  			   */

Wouldn't this be much easier to read, by the way?

The point is that if we touched the active_cache, we try to
write it out and make it the index file for later users to use
by calling "commit", but we do not really care about the failure
from this sequence because it is done purely as an optimization.

The original code called three functions primarily for their
side effects, which is admittedly a bad style.

 builtin-diff.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index f77352b..906c924 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -200,15 +200,9 @@ static void refresh_index_quietly(void)
 	discard_cache();
 	read_cache();
 	refresh_cache(REFRESH_QUIET|REFRESH_UNMERGED);
-	if (active_cache_changed) {
-		if (write_cache(fd, active_cache, active_nr) ||
-		    close(fd) ||
-		    commit_locked_index(lock_file))
-			; /*
-			   * silently ignore it -- we haven't mucked
-			   * with the real index.
-			   */
-	}
+	if (active_cache_changed &&
+	    !write_cache(fd, active_cache, active_nr) && !close(fd))
+		commit_locked_index(lock_file);
 	rollback_lock_file(lock_file);
 }
 
