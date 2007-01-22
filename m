From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-push through git protocol
Date: Sun, 21 Jan 2007 16:17:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701211554450.14248@woody.osdl.org>
References: <17843.29798.866272.414435@lisa.zopyra.com> <ep00nl$mop$1@sea.gmane.org>
 <Pine.LNX.4.64.0701211034490.14248@woody.osdl.org> <17843.55730.456139.247155@lisa.zopyra.com>
 <Pine.LNX.4.64.0701211341300.14248@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 22 01:17:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8msV-0002X3-5i
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 01:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbXAVAR2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 19:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbXAVAR2
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 19:17:28 -0500
Received: from smtp.osdl.org ([65.172.181.24]:44981 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751802AbXAVAR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 19:17:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0M0HLhB007993
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 21 Jan 2007 16:17:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0M0HKKh012671;
	Sun, 21 Jan 2007 16:17:21 -0800
To: Bill Lear <rael@zopyra.com>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0701211341300.14248@woody.osdl.org>
X-Spam-Status: No, hits=-0.66 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37368>



On Sun, 21 Jan 2007, Linus Torvalds wrote:
> 
>  - git-send-pack wants expects the status report, and doesn't get one. 
>    That, in turn, seems to be because it expects "out" and "in" to be 
>    different file descriptors, and with the git:// protocol they aren't 
>    (they're the same file descriptor)
> 
> This attached patch should fix the second problem. Maybe.

This actually looks like potentially a generic real problem.

It so *happens* that git_connect() is different from all the other 
connection types in that it returns the same socket for both input and 
output. All the others return separate fd's for the input and output 
sides, because they end up using pipes.

This is not normally a problem, since people just use "read()" and 
"write()" on the things. Who cares if they are the same fd or not? Nobody.

Well, almost nobody. Anybody who ends up closing the file descriptors will 
inevitably care. In this case it was git-send-pack (through send_pack() 
that happened to close the two file descriptors, but because they were 
actually the same one, it would end up (a) closing the same thing twice 
and (b) doing some operations on an already-closed fd).

I really think this should be fixed, regardless of whether we want to have 
git:// usable for pushing or not, because it's really conceptually a bug. 

We could do it either with my stupid patch (which just makes "send_pack()" 
do the dup itself when they happen to be identical, and thus avoids the 
problem in the caller), but it might actually make sense to just make the 
rule be that "git_connect()" always returns separate file descriptors for 
the input/output cases so that nobody can ever be confused, and so that 
you can always close those things independently.

In fact, looking more closely, a lot of the other users of git_connect() 
seem to avoid it by simply leaking file descriptors (ie builtin-archive.c 
closes only one of the file descriptors). Others (like receive-pack.c) 
close both, but make sure that they always close them together, and 
apparently fetch-pack.c just makes sure to close them together (so the 
second close might cause EBADF, but in the absense of any threading or 
signals, you're ok).

Same goes for peek-remote: it also just closes the same fd twice, and 
depends on it having no bad side effects (which is true, modulo race 
conditions that we don't have because we're single-threaded).

But everything considered, I'd almost suggest just solving this by the 
trivial one-liner to make git_connect() _always_ return two separate file 
descriptors, so that nobody needs to do strange tests and so that we don't 
call "close()" on the same file descriptor twice.

So I'd suggest this simple change to "connect.c". Yeah, it adds an 
"unnecessary" (but cheap) system call to the git:// case, but it allows 
all users to stop worrying about whether the result is a single in-out 
file descriptor or two separate file descriptors for the in/out cases.

As shown by the send-pack example, there was actually code out there that 
depended on the "two separate file descriptors" case, which we get for all 
the normal and secure cases anyway (since they use pipe() to create the 
communication channels with a proxy or ssh or whatever).

So Junio, I'd suggest adding this whether you then want to add the trivial 
code to allow pushing over git:// too or not. One less special case to 
worry about.

		Linus

---
diff --git a/connect.c b/connect.c
index 66daa11..7844888 100644
--- a/connect.c
+++ b/connect.c
@@ -529,7 +529,7 @@ static void git_tcp_connect(int fd[2], char *host)
 	int sockfd = git_tcp_connect_sock(host);
 
 	fd[0] = sockfd;
-	fd[1] = sockfd;
+	fd[1] = dup(sockfd);
 }
 
 
