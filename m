From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote.c: Fix overtight refspec validation
Date: Tue, 25 Mar 2008 21:11:42 -0700
Message-ID: <7vfxuejf9d.fsf@gitster.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Samuel Tardieu <sam@rfc1149.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 26 05:12:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeN0D-0000Xz-13
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 05:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbYCZEL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 00:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbYCZEL5
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 00:11:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51695 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbYCZEL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 00:11:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 49C982A38;
	Wed, 26 Mar 2008 00:11:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 18F982A32; Wed, 26 Mar 2008 00:11:44 -0400 (EDT)
In-Reply-To: <7vod92jh3u.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 25 Mar 2008 20:31:49 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78255>

Junio C Hamano <gitster@pobox.com> writes:

> Especially that "refs/tags/*" is sad in that it is leaking an internal
> implementation detail.  I do not think the original code ever used
> wildcards on the push side, and it probably was a good idea to allow
> wildcards when the code was rewritten.

Having thought about this a bit more, I think this patch would be more
useful.  Please discard the previous patch to builtin-push.c and replace
with this patch.

Now it allows you to say:

	[remote "neigh"]
        	url = ../neighbour
                push = refs/tags/*

to propagate all tags one-to-one, without having to say
"refs/tags/*:refs/tags/*".

This however has unintended side effect of allowing 

	[remote "bour"]
        	url = ../neighbour
                fetch = refs/heads/*

at the syntax level.  I do not know offhand the fetch backends are
prepared to deal with such wildcard patterns.

Daniel?

---
 remote.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/remote.c b/remote.c
index 40ed246..c39d831 100644
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
+			if (rhs && !is_glob)
+				goto invalid;
+			is_glob = 1;
 			llen -= 2;
-			rlen -= 2;
+		} else if (rhs && is_glob) {
+			goto invalid;
 		}
+
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
