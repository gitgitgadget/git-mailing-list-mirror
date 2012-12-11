From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] nedmalloc: Fix a compile warning (exposed as error) with
 GCC 4.7.2
Date: Tue, 11 Dec 2012 21:34:51 +0100
Message-ID: <50C798EB.5030408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 11 21:35:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiWY5-00066y-JJ
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 21:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074Ab2LKUfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 15:35:10 -0500
Received: from plane.gmane.org ([80.91.229.3]:33393 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753442Ab2LKUfI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 15:35:08 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TiWXt-0005va-HC
	for git@vger.kernel.org; Tue, 11 Dec 2012 21:35:17 +0100
Received: from brln-4d0c277f.pool.mediaways.net ([77.12.39.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Dec 2012 21:35:17 +0100
Received: from sschuberth by brln-4d0c277f.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Dec 2012 21:35:17 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: brln-4d0c277f.pool.mediaways.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211298>

On MinGW, GCC 4.7.2 complains about

    operation on 'p->m[end]' may be undefined

Fix this by replacing the faulty lines with those of 69825ca from

    https://github.com/ned14/nedmalloc/blob/master/nedmalloc.c

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 compat/nedmalloc/nedmalloc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
index d9a17a8..91c4e7f 100644
--- a/compat/nedmalloc/nedmalloc.c
+++ b/compat/nedmalloc/nedmalloc.c
@@ -603,7 +603,10 @@ static NOINLINE mstate FindMSpace(nedpool *p, threadcache *tc, int *lastUsed, si
 		}
 		/* We really want to make sure this goes into memory now but we
 		have to be careful of breaking aliasing rules, so write it twice */
-		*((volatile struct malloc_state **) &p->m[end])=p->m[end]=temp;
+		{
+			volatile struct malloc_state **_m=(volatile struct malloc_state **) &p->m[end];
+			*_m=(p->m[end]=temp);
+		}
 		ACQUIRE_LOCK(&p->m[end]->mutex);
 		/*printf("Created mspace idx %d\n", end);*/
 		RELEASE_LOCK(&p->mutex);
-- 
1.8.0.msysgit.1
