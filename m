From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] remote: simplify match_name_with_pattern() using strbuf
Date: Sun, 21 Sep 2014 10:23:37 +0200
Message-ID: <541E8B09.80502@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 21 10:24:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVcRW-0006oj-LO
	for gcvg-git-2@plane.gmane.org; Sun, 21 Sep 2014 10:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050AbaIUIYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2014 04:24:03 -0400
Received: from mout.web.de ([212.227.15.3]:63452 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792AbaIUIYA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2014 04:24:00 -0400
Received: from [192.168.178.27] ([79.253.137.51]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LpwMZ-1XyvIw46J5-00fgtp; Sun, 21 Sep 2014 10:23:58
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
X-Provags-ID: V03:K0:lu7dhbcg4T5pBrgICKdZ0q1ExrkCjws11O3EXgC5n1Lyy7FMZAW
 2MVQiAdqENIn5gu8jJXIDIjAHtZnyZx3P0gsAQpCRl7bDeNg/pk0Zf53c1gtulvlUiZSYEg
 6IJh6Dr3Sdn2AZZcdinI/4coauzMouW2s9CA+joaTShigG2Ief7vcp9xWg2dxICx+H8fPGG
 BvkFww+IXlpbwuawki/pA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257343>

Make the code simpler and shorter by avoiding repetitive use of
string length variables and leaving memory allocation to strbuf
functions.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 remote.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/remote.c b/remote.c
index 35e62ee..ce785f8 100644
--- a/remote.c
+++ b/remote.c
@@ -862,21 +862,14 @@ static int match_name_with_pattern(const char *key, const char *name,
 	ret = !strncmp(name, key, klen) && namelen >= klen + ksuffixlen &&
 		!memcmp(name + namelen - ksuffixlen, kstar + 1, ksuffixlen);
 	if (ret && value) {
+		struct strbuf sb = STRBUF_INIT;
 		const char *vstar = strchr(value, '*');
-		size_t vlen;
-		size_t vsuffixlen;
 		if (!vstar)
 			die("Value '%s' of pattern has no '*'", value);
-		vlen = vstar - value;
-		vsuffixlen = strlen(vstar + 1);
-		*result = xmalloc(vlen + vsuffixlen +
-				  strlen(name) -
-				  klen - ksuffixlen + 1);
-		strncpy(*result, value, vlen);
-		strncpy(*result + vlen,
-			name + klen, namelen - klen - ksuffixlen);
-		strcpy(*result + vlen + namelen - klen - ksuffixlen,
-		       vstar + 1);
+		strbuf_add(&sb, value, vstar - value);
+		strbuf_add(&sb, name + klen, namelen - klen - ksuffixlen);
+		strbuf_addstr(&sb, vstar + 1);
+		*result = strbuf_detach(&sb, NULL);
 	}
 	return ret;
 }
-- 
2.1.1
