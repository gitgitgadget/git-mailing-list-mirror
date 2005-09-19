From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Joining cg-*-id
Date: Mon, 19 Sep 2005 15:16:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509191505470.2553@g5.osdl.org>
References: <1127166049.26772.26.camel@dv> <20050919215608.GA13845@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pavel Roskin <proski@gnu.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 20 00:17:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHTwE-0006Yk-Fp
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 00:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932682AbVISWQc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 18:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbVISWQc
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 18:16:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37025 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932682AbVISWQb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 18:16:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8JMG4Bo011774
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Sep 2005 15:16:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8JMG3Jg019517;
	Mon, 19 Sep 2005 15:16:04 -0700
To: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <20050919215608.GA13845@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8916>



On Mon, 19 Sep 2005, Petr Baudis wrote:
> 
> There is git-rev-parse, but it is not as powerful (cannot take dates and
> sha1 completion does not work when listing parents)

Hmm.

That lack of sha1 completion is a bug. 

How does the date thing work? It sounds like something horribly ambiguous, 
but hey, maybe some useful semantics could be found.

The short sha1 problem is fixed thus,

		Linus

----
Fix extended short SHA1 name completion

get_sha1() would not do sha1 completion of short SHA1's when they were 
part of a more complex expression. So doing

	git-rev-parse 727132834e6be48a93c1bd6458a29d474ce7d5d5^

would work, and return 87c6aeb4efdd4355918d127a91bd0adc5a02f8ff. But using 
the shorthand version 

	git-rev-list 72713^

wouldn't work.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/sha1_name.c b/sha1_name.c
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -84,19 +84,19 @@ static int find_short_packed_object(int 
 	return 0;
 }
 
-static int get_short_sha1(const char *name, unsigned char *sha1)
+static int get_short_sha1(const char *name, int len, unsigned char *sha1)
 {
 	int i;
 	char canonical[40];
 	unsigned char res[20];
 
+	if (len < 4)
+		return -1;
 	memset(res, 0, 20);
 	memset(canonical, 'x', 40);
-	for (i = 0;;i++) {
+	for (i = 0; i < len ;i++) {
 		unsigned char c = name[i];
 		unsigned char val;
-		if (!c || i > 40)
-			break;
 		if (c >= '0' && c <= '9')
 			val = c - '0';
 		else if (c >= 'a' && c <= 'f')
@@ -112,8 +112,6 @@ static int get_short_sha1(const char *na
 			val <<= 4;
 		res[i >> 1] |= val;
 	}
-	if (i < 4)
-		return -1;
 	if (find_short_object_filename(i, canonical, sha1))
 		return 0;
 	if (find_short_packed_object(i, res, sha1))
@@ -254,7 +252,7 @@ static int get_sha1_1(const char *name, 
 	ret = get_sha1_basic(name, len, sha1);
 	if (!ret)
 		return 0;
-	return get_short_sha1(name, sha1);
+	return get_short_sha1(name, len, sha1);
 }
 
 /*
