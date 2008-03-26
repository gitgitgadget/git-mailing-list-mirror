From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote.c: Fix overtight refspec validation
Date: Tue, 25 Mar 2008 22:46:23 -0700
Message-ID: <7vtziughqo.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0803202049090.19665@iabervon.org>
 <7v4pb0vhrg.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803210014100.19665@iabervon.org>
 <7vmyosskyu.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803210134070.19665@iabervon.org>
 <7v3aqksic6.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803211148120.19665@iabervon.org>
 <7vlk4boh6v.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803251841420.2775@woody.linux-foundation.org>
 <7vod92jh3u.fsf@gitster.siamese.dyndns.org>
 <7vfxuejf9d.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803260130390.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Samuel Tardieu <sam@rfc1149.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 26 06:47:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeOTp-0001uo-2V
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 06:47:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbYCZFqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 01:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbYCZFqj
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 01:46:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61263 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbYCZFqj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 01:46:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 520BC2C80;
	Wed, 26 Mar 2008 01:46:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 31F242C5F; Wed, 26 Mar 2008 01:46:32 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0803260130390.19665@iabervon.org> (Daniel
 Barkalow's message of "Wed, 26 Mar 2008 01:42:02 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78258>

Daniel Barkalow <barkalow@iabervon.org> writes:

> OTOH, the only use for such a pattern is an octopus merge of whatever 
> branches a remote happens to have, right? I remember thinking this was a 
> non-useful refspec when I was dealing with the fetch code (and then 
> forgetting that it was useful for push). It might be better to just 
> disallow it in the direction-specific semantic checks.

I agree.  refs/*:refs/* could have been useful before --mirror, but refs/*
(fetch but not store) is not useful at all, so what I plan to commit looks
like this (i.e. "the third time lucky" edition).

-- >8 --
[PATCH] refspec: allow colon-less wildcard "refs/category/*"

"git push --tags elsewhere" is implemented in terms of wildcarded refspec
"refs/tags/*" these days, and the user wants to push the tags under the
same name to the other branch.  This resurrects the support for it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/remote.c b/remote.c
index 40ed246..04f7521 100644
--- a/remote.c
+++ b/remote.c
@@ -417,17 +417,21 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 			rhs++;
 			rlen = strlen(rhs);
 			is_glob = (2 <= rlen && !strcmp(rhs + rlen - 2, "/*"));
-			rs[i].dst = xstrndup(rhs, rlen - is_glob * 2);
+			if (is_glob)
+				rlen -= 2;
+			rs[i].dst = xstrndup(rhs, rlen);
 		}
 
 		llen = (rhs ? (rhs - lhs - 1) : strlen(lhs));
-		if (is_glob != (2 <= llen && !memcmp(lhs + llen - 2, "/*", 2)))
-			goto invalid;
-
-		if (is_glob) {
+		if (2 <= llen && !memcmp(lhs + llen - 2, "/*", 2)) {
+			if ((rhs && !is_glob) || (!rhs && fetch))
+				goto invalid;
+			is_glob = 1;
 			llen -= 2;
-			rlen -= 2;
+		} else if (rhs && is_glob) {
+			goto invalid;
 		}
j+
 		rs[i].pattern = is_glob;
 		rs[i].src = xstrndup(lhs, llen);
 
@@ -446,7 +450,7 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 			}
 			/*
 			 * RHS
-			 * - missing is allowed.
+			 * - missing is ok, and is same as empty.
 			 * - empty is ok; it means not to store.
 			 * - otherwise it must be a valid looking ref.
 			 */
-- 
1.5.5.rc1.128.g340c
