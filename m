From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2] dir.c: Avoid c99 array initialization
Date: Thu, 28 Aug 2008 18:03:53 -0500
Message-ID: <PoNr7CsqaC77b7na-0n9ocrQHgIwPZQYjCwhtbz7ydhXjU05wVKI5w@cipher.nrlssc.navy.mil>
References: <7vwsi0dh61.fsf@gitster.siamese.dyndns.org> <DvgiWt6vf5dOJWwhJg6Uvvb1c1lr9AZ9KS6iObwhTbjxnzKL45PkCw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>,
	Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 01:06:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYqYt-0004yT-GF
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 01:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368AbYH1XEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 19:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754291AbYH1XEV
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 19:04:21 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:59896 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920AbYH1XEV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 19:04:21 -0400
Received: by mail.nrlssc.navy.mil id m7SN3sOI011833; Thu, 28 Aug 2008 18:03:54 -0500
In-Reply-To: <DvgiWt6vf5dOJWwhJg6Uvvb1c1lr9AZ9KS6iObwhTbjxnzKL45PkCw@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 28 Aug 2008 23:03:53.0678 (UTC) FILETIME=[578886E0:01C90962]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94200>

Brandon Casey wrote:
> The following syntax:
> 
>         char foo[] = {
>                 [0] = 1,
>                 [7] = 2,
>                 [15] = 3
>         };
> 
> is a c99 construct which some compilers do not support even though they
> support other c99 constructs. This construct can be avoided by folding
> these 'special' test cases into the sane_ctype array and making use of
> the related infrastructure.

You probably would want to squash this in:

diff --git a/dir.c b/dir.c
index e6a2556..acf1001 100644
--- a/dir.c
+++ b/dir.c
@@ -52,11 +52,6 @@ int common_prefix(const char **pathspec)
	return prefix;
 }
 
-static inline int special_char(unsigned char c1)
-{
-	return !c1 || c1 == '*' || c1 == '[' || c1 == '?' || c1 == '\\';
-}
-
 /*
  * Does 'match' matches the given name?
  * A match is found if
@@ -80,7 +75,7 @@ static int match_one(const char *match, const char *name, int 
 	for (;;) {
 		unsigned char c1 = *match;
 		unsigned char c2 = *name;
-		if (special_char(c1))
+		if (isspecial(c1))
 			break;
 		if (c1 != c2)
 			return 0;
