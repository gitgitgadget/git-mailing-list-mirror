From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-daemon extra paranoia
Date: Tue, 18 Oct 2005 15:25:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510181517280.3369@g5.osdl.org>
References: <435560F7.4080006@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 00:26:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERztd-0008Ks-Cn
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 00:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbVJRWZU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 18:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVJRWZU
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 18:25:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64981 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932184AbVJRWZT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Oct 2005 18:25:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9IMPIFC013909
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Oct 2005 15:25:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9IMPH3A002249;
	Tue, 18 Oct 2005 15:25:17 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <435560F7.4080006@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10238>



On Tue, 18 Oct 2005, H. Peter Anvin wrote:
>
> This patch adds some extra paranoia to the git-daemon filename test.  In
> particular, it now rejects pathnames containing // or ending with /; it also
> adds a redundant test for pathname absoluteness (belts and suspenders.)

Hmm. The "not ending in /" is a bad test. 

Especially in light of the fact that the git-pack protocol quite by design 
tends to add a ".git" to the end as a fallback, so that a user that wants 
to specify a particular directory _without_ that fallback needs to have 
the slash at the end.

Now, git-daemon hasn't implemented that, but I think that was just a 
mistake that grew out of it not getting a lot of testing, since it wasn't 
used much. I personally use the "without the final .git" version quite 
often, because it just looks so much nicer for the user.

In fact, here's a patch that makes git-daemon allow it, and thus match the 
behaviour of the ssh transport.

The logic is simple: if the original "chdir()" fails, try another one with 
".git" appended. This is in _addition_ to doing the 'chdir(".git")' later, 
so that if you have a checked-out git repository in /home/linux-2.6.git, 
then doing a

	git pull git://host/home/linux-2.6

will on the remote end do:

	chmod("/home/linux-2.6")	// fails with ENOENT
	chmod("/home/linux-2.6.git")	// works
	chmod(".git")			// works

resulting in it ending up in /home/linux-2.6.git/.git, which is exactly 
correct, and where it wants to be.

I personally find it a nice bit of usability enhancement. You can name 
your git repositories with a ".git" suffix (which can help all kinds of 
automated tasks - like autopacking), but you don't force your users to 
care.

		Linus

---
diff --git a/daemon.c b/daemon.c
index 11fa3ed..a488512 100644
--- a/daemon.c
+++ b/daemon.c
@@ -128,8 +128,13 @@ static int upload(char *dir, int dirlen)
 	}
 
 	if (chdir(dir) < 0) {
-		logerror("Cannot chdir('%s'): %s", dir, strerror(errno));
-		return -1;
+		int err = errno;
+		strcpy(dir + dirlen, ".git");
+		if (err != ENOENT || chdir(dir) < 0) {
+			dir[dirlen] = 0;
+			logerror("Cannot chdir('%s'): %s", dir, strerror(err));
+			return -1;
+		}
 	}
 
 	chdir(".git");
@@ -164,7 +169,12 @@ static int execute(void)
 	static char line[1000];
 	int len;
 
-	len = packet_read_line(0, line, sizeof(line));
+	/*
+	 * Make sure that we leave room for an extra ".git" at
+	 * the end of the line. Note that the packet interfaces
+	 * already guarantee that there is an ending '\0'.
+	 */
+	len = packet_read_line(0, line, sizeof(line)-4);
 
 	if (len && line[len-1] == '\n')
 		line[--len] = 0;
