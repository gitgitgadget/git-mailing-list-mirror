From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] git-tar-tree: add a test case (resent)
Date: Fri, 03 Jun 2005 13:25:18 +0200
Message-ID: <42A03E1E.5060204@lsrfire.ath.cx>
References: <20050602185046.GA3717@lsrfire.ath.cx> <Pine.LNX.4.58.0506021830340.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jun 03 13:23:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeAG8-0008Ex-IS
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 13:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVFCLZa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 07:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVFCLZa
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 07:25:30 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:394 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261217AbVFCLZV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2005 07:25:21 -0400
Received: from [10.0.1.3] (p508E770B.dip.t-dialin.net [80.142.119.11])
	by neapel230.server4you.de (Postfix) with ESMTP id 8ECFD180;
	Fri,  3 Jun 2005 13:25:19 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: de-DE, de, en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506021830340.1876@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds schrieb:
> 
> On Thu, 2 Jun 2005, Rene Scharfe wrote:
> 
>>git-tar-tree: add a simple test case.
> 
> 
> I get:
> 
> 	* FAIL 6: extract tar archive (cd b && tar xf -) <b.tar
> 	* FAIL 7: validate filenames (cd b/a && find .) | sort >b.lst &&
> 	* FAIL 8: validate file contents diff -r a b/a
> 	* FAIL 11: validate filenames with prefix (cd c/prefix/a && find .) | sort >c.lst &&
> 	* FAIL 12: validate file contents with prefix diff -r a c/prefix/a

Meine Fresse, what a stoopid bug.  Fortunately I introduced it with one
of the other two patches sent together with the test case patch, namely
"[PATCH] git-tar-tree: cleanup write_trailer() (resent)".  Of course I
only wanted to demonstrate how useful those tests really are. ;-)

Btw., I got it right the first time and messed up when resending..

write_trailer() writes the last 10k (a full block) of the tar archive.
write_if_needed() writes out a block *if* it is full and then sets
the offset to 0.  In nine out of ten cases the messed up write_trailer()
function didn't manage to fill the block thus not writing anything at
all, truncating the archive.  I was "lucky" to hit the other case and so
my testing ran OK.

Here's a patch.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

--- a/tar-tree.c
+++ b/tar-tree.c
@@ -77,7 +77,7 @@
 	write_if_needed();
 	get_record();
 	write_if_needed();
-	if (offset) {
+	while (offset) {
 		get_record();
 		write_if_needed();
 	}

