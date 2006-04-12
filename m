From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Some Commit Messages Scare git-rev-list
Date: Wed, 12 Apr 2006 10:23:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604121002220.14565@g5.osdl.org>
References: <1144847462.5213.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 12 19:24:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTj4d-0005S2-N3
	for gcvg-git@gmane.org; Wed, 12 Apr 2006 19:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWDLRYI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Apr 2006 13:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWDLRYI
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Apr 2006 13:24:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14815 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932272AbWDLRYH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Apr 2006 13:24:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3CHNftH026382
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 12 Apr 2006 10:23:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3CHNckF012514;
	Wed, 12 Apr 2006 10:23:40 -0700
To: Darrin Thompson <darrint@progeny.com>
In-Reply-To: <1144847462.5213.6.camel@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18634>



On Wed, 12 Apr 2006, Darrin Thompson wrote:
>
> This scripts exhibits some odd behavior. Apparently git-rev-list
> mishandles commit messages which do not end in a newline. This as best I
> can tell this is a problem introduced since 1.1.5.

Fixed like so..

However, your script shows another problem: the "#" added at the end of 
the line for a 

	echo -n "duh" | git-commit -F - -a

seems to be because we append the "git status" output to it, and then we 
drop the lines that start with a '#', but due to the "-n", the first # 
ends up being at the end of the line. 

I suspect that when we get the commit message like that, we should _not_ 
do any of the commit message editing at all.

That's a separate issue, though, and not fixed by this patch.

		Linus

---
diff --git a/commit.c b/commit.c
index d534c9b..c7bb8db 100644
--- a/commit.c
+++ b/commit.c
@@ -400,11 +400,11 @@ static int get_one_line(const char *msg,
 
 	while (len--) {
 		char c = *msg++;
+		if (!c)
+			break;
 		ret++;
 		if (c == '\n')
 			break;
-		if (!c)
-			return 0;
 	}
 	return ret;
 }
