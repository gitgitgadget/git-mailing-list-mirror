From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Microoptimize strbuf_cmp
Date: Thu, 19 Mar 2009 23:27:32 +0100
Message-ID: <20090319222732.GB8433@blimp.localdomain>
References: <20090319210931.GB31014@blimp.localdomain> <7vvdq56ukb.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 23:29:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkQkN-0003bg-8z
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 23:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761533AbZCSW1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 18:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760636AbZCSW1o
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 18:27:44 -0400
Received: from mout0.freenet.de ([195.4.92.90]:41318 "EHLO mout0.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759298AbZCSW1n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 18:27:43 -0400
Received: from [195.4.92.27] (helo=17.mx.freenet.de)
	by mout0.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #79)
	id 1LkQi8-0007jm-7d; Thu, 19 Mar 2009 23:27:36 +0100
Received: from x62b3.x.pppool.de ([89.59.98.179]:59354 helo=tigra.home)
	by 17.mx.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 587) (Exim 4.69 #76)
	id 1LkQi8-00023W-0f; Thu, 19 Mar 2009 23:27:36 +0100
Received: from blimp.localdomain (ubuntu.home [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id 84564277D8;
	Thu, 19 Mar 2009 23:27:32 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 45BAA36D27; Thu, 19 Mar 2009 23:27:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vvdq56ukb.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113851>

It can be less object code and may be even faster, even if at the
moment there is no callers to take an advantage of that. This
implementation can be trivially made inlinable later.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Junio C Hamano, Thu, Mar 19, 2009 23:01:40 +0100:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > Make it inline and cleanup a bit. It is definitely less code
> > including object code, but it is not always measurably faster
> > (but mostly is).
> 
> The only in-tree user seems to be rerere, so inlining for that single
> caller will reduce the object side, but I am not sure if this is a good
> change in the longer term if we want to encourage the use of strbuf
> library.
> 
> The rewrite of the logic does seem worth doing, though.

But then it is only a half of the micro-optimization. In this case,
the cost of call to the function's code is comparable with the change
of the code.

Anyway, FWIW.

 strbuf.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 6ed0684..bfbd816 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -139,14 +139,11 @@ void strbuf_list_free(struct strbuf **sbs)
 
 int strbuf_cmp(const struct strbuf *a, const struct strbuf *b)
 {
-	int cmp;
-	if (a->len < b->len) {
-		cmp = memcmp(a->buf, b->buf, a->len);
-		return cmp ? cmp : -1;
-	} else {
-		cmp = memcmp(a->buf, b->buf, b->len);
-		return cmp ? cmp : a->len != b->len;
-	}
+	int len = a->len < b->len ? a->len: b->len;
+	int cmp = memcmp(a->buf, b->buf, len);
+	if (cmp)
+		return cmp;
+	return a->len < b->len ? -1: a->len != b->len;
 }
 
 void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
-- 
1.6.2.1.237.g7206c6
