From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Remove duplicate pathspecs from ls-files command line
Date: Wed, 29 Aug 2007 23:15:19 +0200
Message-ID: <20070829211519.GE11824@steel.home>
References: <20070829081122.GA604@piper.oerlikon.madduck.net> <20070829194410.GA11824@steel.home> <7v4piioyu1.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>,
	439992-quiet@bugs.debian.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 23:15:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQUss-00036a-2W
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 23:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377AbXH2VP0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 17:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbXH2VP0
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 17:15:26 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:24796 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbXH2VP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 17:15:26 -0400
Received: from tigra.home (Fc9fa.f.strato-dslnet.de [195.4.201.250])
	by post.webmailer.de (klopstock mo62) (RZmta 12.1)
	with ESMTP id v03534j7TGvxQv ; Wed, 29 Aug 2007 23:15:20 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id B98D3277BD;
	Wed, 29 Aug 2007 23:15:19 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 2FD28BE06; Wed, 29 Aug 2007 23:15:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v4piioyu1.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAciAx4=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56985>

Junio C Hamano, Wed, Aug 29, 2007 22:44:22 +0200:
> 
> That loop is plain old O(n^2) that penalizes everybody.
> 

Maybe something in pathspec matching code could be reused to notice
the duplications? It has to go through all of them anyway...

> Please do not penalize sane callers when you try to improve
> support of mistaken usage.  Move expensive error recovery in the
> error path when possible, and have _only_ mistaken users pay the
> price.
> 
> Like this perhaps.
> 

I just would write it shorter (except for that ugly label before
closing brace).

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index d36181a..258868e 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -511,11 +511,28 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 		 */
 		int num, errors = 0;
 		for (num = 0; pathspec[num]; num++) {
+			int other;
+
 			if (ps_matched[num])
 				continue;
+			/*
+			 * The caller might have fed identical pathspec
+			 * twice.  Do not barf on such a mistake.
+			 */
+			for (other = 0; pathspec[other]; other++) {
+				if (other == num || !ps_matched[other])
+					continue;
+				if (!strcmp(pathspec[other], pathspec[num]))
+					/*
+					 * Ok, we have a match already.
+					 */
+					goto found_dup;
+			}
+
 			error("pathspec '%s' did not match any file(s) known to git.",
 			      pathspec[num] + prefix_offset);
 			errors++;
+		found_dup:;
 		}
 
 		if (errors)
-- 
1.5.3.rc7.26.g5f7e4
