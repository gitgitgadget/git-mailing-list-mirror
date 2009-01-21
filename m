From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [VALGRIND PATCH for nth_last patch series] Fix invalid memory
 access
Date: Wed, 21 Jan 2009 00:45:58 -0800
Message-ID: <7vwscpgi7t.fsf@gitster.siamese.dyndns.org>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org>
 <1232163011-20088-1-git-send-email-trast@student.ethz.ch>
 <alpine.DEB.1.00.0901170646560.3586@pacific.mpi-cbg.de>
 <200901171438.22504.trast@student.ethz.ch>
 <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <7vljt97nld.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901172028470.3586@pacific.mpi-cbg.de>
 <7vmydp5tqj.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901180201070.3586@pacific.mpi-cbg.de>
 <7vprilyt1w.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901182152010.3586@pacific.mpi-cbg.de>
 <7vprijra52.fsf@gitster.siamese.dyndns.org>
 <7vljt7r9mq.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901191331590.3586@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0901210113500.19014@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 09:47:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPYkH-0000Pe-Fr
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 09:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757069AbZAUIqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 03:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756574AbZAUIqK
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 03:46:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59957 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755757AbZAUIqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 03:46:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9C84B1CA24;
	Wed, 21 Jan 2009 03:46:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 42E191C8EB; Wed,
 21 Jan 2009 03:46:00 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901210113500.19014@racer> (Johannes
 Schindelin's message of "Wed, 21 Jan 2009 01:16:37 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F1EE02DC-E797-11DD-B782-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106580>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>  sha1_name.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 4d10705..803f9d2 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -735,7 +735,7 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
>  	if ((target = strstr(match, " to ")) != NULL) {
>  		len = target - match;
>  		target += 4;
> -		if (target[len] == '\n' && !strncmp(match, target, len))
> +		if (len == strlen(target) && !strncmp(match, target, len))
>  			return 0;
>  	}
>  	else

Actually, I think this patch to a884d0c (sha1_name: tweak @{-N} lookup,
2009-01-17) would make more sense.

-- >8 --
Subject: [PATCH] Simplify parsing branch switching events in reflog

We only accept "checkout: moving from A to B" newer style reflog entries,
in order to pick up A.  There is no point computing where B begins at
after running strstr to locate " to ", nor adding 4 and then subtracting 4
from the same pointer.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 38c9f1b..7d95bbb 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -723,17 +723,13 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
 
 	if (!prefixcmp(message, "checkout: moving from ")) {
 		match = message + strlen("checkout: moving from ");
-		if ((target = strstr(match, " to ")) != NULL)
-			target += 4;
+		target = strstr(match, " to ");
 	}
 
 	if (!match || !target)
 		return 0;
 
-	len = target - match - 4;
-	if (target[len] == '\n' && !strncmp(match, target, len))
-		return 0;
-
+	len = target - match;
 	nth = cb->cnt++ % cb->alloc;
 	strbuf_reset(&cb->buf[nth]);
 	strbuf_add(&cb->buf[nth], match, len);
-- 
1.6.1.281.g16db
