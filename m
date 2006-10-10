From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Approxidate licensing
Date: Tue, 10 Oct 2006 11:17:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610101102560.3952@g5.osdl.org>
References: <Pine.LNX.4.64.0610101246241.9789@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, dwmw2@infradead.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 20:18:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXMAr-0002Iy-EI
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 20:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWJJSRu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 14:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbWJJSRu
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 14:17:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27075 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964987AbWJJSRt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 14:17:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9AIHbaX007875
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Oct 2006 11:17:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9AIHakX017704;
	Tue, 10 Oct 2006 11:17:36 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0610101246241.9789@iabervon.org>
X-Spam-Status: No, hits=-0.467 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28649>



On Tue, 10 Oct 2006, Daniel Barkalow wrote:
> 
> Would the three of you agree to license date.c under the LGPL or BSD? It 
> looks like you're the only authors of non-trivial changes [1]. And it seems 
> reasonable to want the date parsing thing under non-GPL terms outside of 
> git.

I'm not a huge fan of the LGPL, especially with the recent issues of 
GPLv3. The reason? The LGPL is expressly designed to be compatible with 
the GPL, but it's designed to be compatible with any version (and you 
can't limit it, the way you can the real GPL).

So you can take LGPL 2.1 code, and relicense it under GPLv3, and make 
changes to it, and those changes won't be available to a GPLv2 project.

That said, I don't think the date.c code is all that important, and I 
don't see why anybody would do something nasty like that anyway, so I 
guess I don't actually care. A lot of the approxidate code was actually 
written as a joke, and it will parse just about anything without any 
error, and without telling you that it returned a date that may not make 
any sense at all.

For example, currently

	./test-date "$(cat date.c)"

returns

	Tue Nov 30 11:58:59 1937

for me, but don't ask me why. It's just put together the random numbers 
and month-names embedded in the source and made some insane decision that 
it must be a date (since you told it so). And it never returned an error.

Some other things are just silly and not even correct

	./test-date "One year ago yesterday at tea-time"

which doesn't even give the right answer (because it will go _backwards_ 
to tea-time on Oct 8th, even though it obviously _should_ return "Oct 9, 
17:00". I don't have the energy to try to fix it.

It also needs this important patch to be complete. I don't know how this 
could ever have fallen through the cracks!

		Linus
---
diff --git a/date.c b/date.c
index 1825922..0b06994 100644
--- a/date.c
+++ b/date.c
@@ -657,6 +657,7 @@ static const struct typelen {
 	{ "hours", 60*60 },
 	{ "days", 24*60*60 },
 	{ "weeks", 7*24*60*60 },
+	{ "fortnights", 2*7*24*60*60 },
 	{ NULL }
 };	
 
