From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Basename matching during rename/copy detection
Date: Wed, 20 Jun 2007 20:42:38 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706202031200.3593@woody.linux-foundation.org>
References: <20070621030622.GD8477@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, govindsalinas <govindsalinas@yahoo.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 21 05:42:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1DZL-0002TB-Ks
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 05:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745AbXFUDmu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 23:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753586AbXFUDmu
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 23:42:50 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59330 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753494AbXFUDmt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jun 2007 23:42:49 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5L3gi1K016598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 20 Jun 2007 20:42:45 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5L3gc0I020970;
	Wed, 20 Jun 2007 20:42:38 -0700
In-Reply-To: <20070621030622.GD8477@spearce.org>
X-Spam-Status: No, hits=-2.52 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50589>



On Wed, 20 Jun 2007, Shawn O. Pearce wrote:
> 
> I'm wondering if we shouldn't play the game of trying to match
> delete/add pairs up by not only similarity, but also by path
> basename.

I think we should just consider the basename as an "added 
similarity bonus".

IOW, we currently sort purely by data similarity, but how about just 
adding a small increment for "same base name".

We could make it actually use the similarity of the filename itself as the 
basis for the increment, which would be even better, but the trivial thing 
is to do something like

	--- a/diffcore-rename.c
	+++ b/diffcore-rename.c
	@@ -186,8 +186,11 @@ static int estimate_similarity(struct diff_filespec *src,
	 	 */
	 	if (!dst->size)
	 		score = 0; /* should not happen */
	-	else
	+	else {
	 		score = (int)(src_copied * MAX_SCORE / max_size);
	+		if (basename_same(src, dst))
	+			score++;
	+	}
	 	return score;
	 }
 
and just implement that "basename_same()" function.

Or something.

I do agree that the filename logically can and probably _should_ count 
towards the "similarity". The filename _is_ part of the data in the global 
notion of "content", after all. It's the "index" to the data.

		Linus
