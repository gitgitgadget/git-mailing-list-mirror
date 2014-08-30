From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] http-walker: simplify process_alternates_response() using
 strbuf
Date: Sat, 30 Aug 2014 17:55:45 +0200
Message-ID: <5401F401.8040607@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 30 17:56:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNl0q-0002A5-Rz
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 17:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbaH3P4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2014 11:56:18 -0400
Received: from mout.web.de ([212.227.17.12]:61809 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620AbaH3P4S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 11:56:18 -0400
Received: from [192.168.178.27] ([79.253.135.121]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Lcge3-1Y6xOg47uR-00kBYK; Sat, 30 Aug 2014 17:56:02
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-Provags-ID: V03:K0:RglXo5/UqIQiLk9XT0uhaA5VPm1bubKLPfSpvEEVinUtPls2p0c
 Vxxi8wVKAUN01M2D2n7eBhwcuHhV3RpDiFzTp6yiqnfmulofshF5CytmAyDSQxpJtl9YskZ
 OpdMFnmY0VYBkxXx8WEJRZa8MOMK+2I1olDH3oAjk52NSxAx8ol7pTW6uS6DLZzUQeP8znq
 pOjUcJbefQ3JDSF8qYUCA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256255>

Use strbuf to build the new base, which takes care of allocations and
the terminating NUL character automatically.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 http-walker.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index dbddfaa..88da546 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -230,7 +230,6 @@ static void process_alternates_response(void *callback_data)
 			int okay = 0;
 			int serverlen = 0;
 			struct alt_base *newalt;
-			char *target = NULL;
 			if (data[i] == '/') {
 				/*
 				 * This counts
@@ -287,17 +286,15 @@ static void process_alternates_response(void *callback_data)
 			}
 			/* skip "objects\n" at end */
 			if (okay) {
-				target = xmalloc(serverlen + posn - i - 6);
-				memcpy(target, base, serverlen);
-				memcpy(target + serverlen, data + i,
-				       posn - i - 7);
-				target[serverlen + posn - i - 7] = 0;
+				struct strbuf target = STRBUF_INIT;
+				strbuf_add(&target, base, serverlen);
+				strbuf_add(&target, data + i, posn - i - 7);
 				if (walker->get_verbosely)
-					fprintf(stderr,
-						"Also look at %s\n", target);
+					fprintf(stderr, "Also look at %s\n",
+						target.buf);
 				newalt = xmalloc(sizeof(*newalt));
 				newalt->next = NULL;
-				newalt->base = target;
+				newalt->base = strbuf_detach(&target, NULL);
 				newalt->got_indices = 0;
 				newalt->packs = NULL;
 
-- 
2.1.0
