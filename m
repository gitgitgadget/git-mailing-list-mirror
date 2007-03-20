From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/2] Avoid unnecessary strlen() calls
Date: Tue, 20 Mar 2007 04:05:10 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703200400230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703162257560.18328@xanadu.home>
 <Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
 <118833cc0703171814n4e56ab9fwfaaea81c903ae235@mail.gmail.com>
 <Pine.LNX.4.64.0703171822280.4964@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172136440.18328@xanadu.home>
 <Pine.LNX.4.64.0703171854270.6730@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172200060.18328@xanadu.home>
 <Pine.LNX.4.64.0703171911120.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171949190.6730@woody.linux-foundation.org>
 <7v8xdunavr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0703180848580.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	Morten Welinder <mwelinder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 04:05:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTUfG-0002AH-W2
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 04:05:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbXCTDFO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 23:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbXCTDFO
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 23:05:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:50951 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932282AbXCTDFM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 23:05:12 -0400
Received: (qmail invoked by alias); 20 Mar 2007 03:05:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 20 Mar 2007 04:05:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18hFAIJsu8h6FqlnuN/t/lTG6lpeLUqTUuAP7Psk3
	byKyHdpnkSxbQ5
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0703180848580.6730@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42695>

Hi,

On Sun, 18 Mar 2007, Linus Torvalds wrote:

> All the top profiling hits are about generating the patches and 
> assigning blame:
> 
> 	samples  %        image name               app name                 symbol name
> 	470352   15.5813  git                      git                      xdl_hash_record

I felt a little left out in all that performance slashing, and so I 
thought maybe, just maybe, a small change in xdl_hash_record() can do 
wonders (since it _is_ really simple, but still takes almost a 6th of the 
CPU time). I don't have a proper test case setup, so maybe you want to try 
this:

-- snipsnap --
[PATCH] xdiff/xutils.c(xdl_hash_record): factor out whitespace handling

Since in at least one use case, xdl_hash_record() takes over 15% of the
CPU time, it makes sense to even micro-optimize it. For many cases, no
whitespace special handling is needed, and in these cases we should not
even bother to check for whitespace in _every_ iteration of the loop.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	Please do not consider this patch _unless_ it is proven to enhance 
	the profile statistics substantially.

 xdiff/xutils.c |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 3653864..bf91c0f 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -236,12 +236,13 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 	return 0;
 }
 
-unsigned long xdl_hash_record(char const **data, char const *top, long flags) {
+static unsigned long xdl_hash_record_with_whitespace(char const **data,
+		char const *top, long flags) {
 	unsigned long ha = 5381;
 	char const *ptr = *data;
 
 	for (; ptr < top && *ptr != '\n'; ptr++) {
-		if (isspace(*ptr) && (flags & XDF_WHITESPACE_FLAGS)) {
+		if (isspace(*ptr)) {
 			const char *ptr2 = ptr;
 			while (ptr + 1 < top && isspace(ptr[1])
 					&& ptr[1] != '\n')
@@ -270,6 +271,23 @@ unsigned long xdl_hash_record(char const **data, char const *top, long flags) {
 }
 
 
+unsigned long xdl_hash_record(char const **data, char const *top, long flags) {
+	unsigned long ha = 5381;
+	char const *ptr = *data;
+
+	if (flags & XDF_WHITESPACE_FLAGS)
+		return xdl_hash_record_with_whitespace(data, top, flags);
+
+	for (; ptr < top && *ptr != '\n'; ptr++) {
+		ha += (ha << 5);
+		ha ^= (unsigned long) *ptr;
+	}
+	*data = ptr < top ? ptr + 1: ptr;
+
+	return ha;
+}
+
+
 unsigned int xdl_hashbits(unsigned int size) {
 	unsigned int val = 1, bits = 0;
 
