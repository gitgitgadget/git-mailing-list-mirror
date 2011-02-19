From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/3] diffcore-rename: improve estimate_similarity()
 heuristics
Date: Fri, 18 Feb 2011 20:30:02 -0800 (PST)
Message-ID: <alpine.LFD.2.02.1102182028410.4165@i5.linux-foundation.org>
References: <alpine.LFD.2.02.1102182023120.4165@i5.linux-foundation.org> <alpine.LFD.2.02.1102182025270.4165@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 19 05:30:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqeSQ-0001vV-0H
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 05:30:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110Ab1BSEaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 23:30:06 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62255 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961Ab1BSEaE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 23:30:04 -0500
Received: by pwj3 with SMTP id 3so682945pwj.19
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 20:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:x-x-sender:to:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=KW3sBSU8gjw8YqUzAJvnvMl17jTd+vSQXw/ihZGcz38=;
        b=rU8dt/IPOniTHgTlWUp8So+q1JwNYt+Q95cKquIR/YeIX37AS9JUa5aPP5IudF8+8E
         vmzTUdeGFmb9tMoy59JHBno9KCF9+q/HVKJ4M96K+lFumdp9280Evw2fEl9BuKYVlQCH
         8P5bS7eIMxq3PudvgwZ3wQJhNGtj6N7ZFkMgs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:x-x-sender:to:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=pFOBSxpC5P11jkYAbnArdspUk+BZW05jRiFZOyOAtPQ5R4jj3So6VabVFrUS5+bxIu
         +zGk8FdG0W2yL19+PphGNWpdsd4HKN2PWC7fAXlxB/Vb9/fMEhLMVcPskSUycP769ENc
         gzqgvcqXc1w1WvxuD6pvOqrCjB6lWxiV+OeoU=
Received: by 10.142.250.23 with SMTP id x23mr1120513wfh.449.1298089803983;
        Fri, 18 Feb 2011 20:30:03 -0800 (PST)
Received: from i5.linux-foundation.org (c-24-22-0-219.hsd1.or.comcast.net [24.22.0.219])
        by mx.google.com with ESMTPS id n4sm3146753wfl.2.2011.02.18.20.30.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Feb 2011 20:30:03 -0800 (PST)
X-X-Sender: torvalds@i5.linux-foundation.org
In-Reply-To: <alpine.LFD.2.02.1102182025270.4165@i5.linux-foundation.org>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167250>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 Feb 2011 20:12:06 -0800

The logic to quickly dismiss potential rename pairs was broken.  It
would too eagerly dismiss possible renames when all of the difference
was due to pure new data (or deleted data).

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This is the trivial one-liner, now with a changelog and sign-off. It 
changes the percentage of the size difference (delta_size) to be compared 
against the larger file size rather than the smaller file size.

 diffcore-rename.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index b9b039d..0cd4c13 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -170,7 +170,7 @@ static int estimate_similarity(struct diff_filespec *src,
 	 * and the final score computation below would not have a
 	 * divide-by-zero issue.
 	 */
-	if (base_size * (MAX_SCORE-minimum_score) < delta_size * MAX_SCORE)
+	if (max_size * (MAX_SCORE-minimum_score) < delta_size * MAX_SCORE)
 		return 0;
 
 	if (!src->cnt_data && diff_populate_filespec(src, 0))
-- 
1.7.4.1.51.g2bf8a
