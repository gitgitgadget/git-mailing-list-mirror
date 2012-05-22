From: mhagger@alum.mit.edu
Subject: [PATCH] find_containing_dir(): allocate strbuf less extravagantly
Date: Tue, 22 May 2012 15:16:06 +0200
Message-ID: <1337692566-3718-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 22 15:16:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWox4-0000IU-Oz
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 15:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050Ab2EVNQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 09:16:34 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:48545 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752415Ab2EVNQd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2012 09:16:33 -0400
X-AuditID: 1207440e-b7f256d0000008c1-14-4fbb91b0f969
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 16.C8.02241.0B19BBF4; Tue, 22 May 2012 09:16:32 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4MDGPp2008940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 May 2012 09:16:31 -0400
X-Mailer: git-send-email 1.7.10
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsUixO6iqLth4m5/g0/LrCy6rnQzWTT0XmG2
	uL1iPrPFj5YeZgcWj7/vPzB5POvdw+hx8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGc2HLzIW
	fOWquPvxBksD42OOLkZODgkBE4kpJ74wQ9hiEhfurWfrYuTiEBK4zCjxded9VgjnDJPEzXkf
	2EGq2ASkJF429oDZIgKyEt8Pb2QEsZkFciUWv7sNFhcW8JKYtPEWC4jNIqAqsXLPNzCbV8BZ
	4sOXD0wQ2+Qlnt7vY5vAyL2AkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6xXm5miV5qSukm
	RkhA8O1gbF8vc4hRgINRiYfXsXKXvxBrYllxZe4hRkkOJiVR3pu9u/2F+JLyUyozEosz4otK
	c1KLDzFKcDArifBuagMq501JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ
	8KoAA19IsCg1PbUiLTOnBCHNxMEJIrhANvAAbVACKeQtLkjMLc5Mhyg6xagoJc7LDpIQAElk
	lObBDYDF7itGcaB/hHlFQKp4gHEP1/0KaDAT0OCgFztBBpckIqSkGhhLTTLlL33wNs5r37iO
	5b/Ljbff7i2cab9Lptp4V6NqnPDrGZuWf6jzuhobvFbNInxe77T9PLOPpwp8knmikJXVecE1
	4fnmDfVxwdfLyqft8PomYc5SumfipQfJF90PCFv38/tv/fLomMgE/sp3SlNbRNzXFcr5VrhI
	fomf3ZsqH7RvgZfCTy4lluKMREMt5qLiRADneqm+uAIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198197>

From: Michael Haggerty <mhagger@alum.mit.edu>

It might seem like allocating a fixed-length buffer of uninitialized
memory should be pretty cheap even if the buffer is of size PATH_MAX.
But empirically, it is measurably faster to allocated only the strlen
of the input string.

Thanks to Peff for pointing out a performance regression in this area
that might be fixed by this patch.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
I am not able to reproduce performance regressions as bad as those
observed by Peff.  It seems to depend on the amount of memory
pressure.  The smaller regression that I *did* see is fixed by this
patch, reducing the time for "git fetch . refs/*:refs/*" from 10.1 s
to 9.3 s.  The change is sensible in any case, but we will have to
wait for Peff's verdict about whether it fixes the whole problem for
him, too.

 refs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index d6bdb47..fffbb17 100644
--- a/refs.c
+++ b/refs.c
@@ -383,7 +383,7 @@ static struct ref_dir *find_containing_dir(struct ref_dir *dir,
 {
 	struct strbuf dirname;
 	const char *slash;
-	strbuf_init(&dirname, PATH_MAX);
+	strbuf_init(&dirname, strlen(refname));
 	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
 		struct ref_dir *subdir;
 		strbuf_add(&dirname,
-- 
1.7.10
