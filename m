From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Git 1.3.2 on Solaris
Date: Tue, 23 May 2006 11:24:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605231110230.5623@g5.osdl.org>
References: <19270.1148407414@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 23 20:25:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FibYn-0002vC-Q1
	for gcvg-git@gmane.org; Tue, 23 May 2006 20:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWEWSYr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 14:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWEWSYr
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 14:24:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52617 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751170AbWEWSYq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 14:24:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4NIOitH020287
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 May 2006 11:24:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4NIOhha015886;
	Tue, 23 May 2006 11:24:43 -0700
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <19270.1148407414@lotus.CS.Berkeley.EDU>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20618>



On Tue, 23 May 2006, Jason Riedy wrote:
>
>  - Btw, even SuS says:
> [...]
>  -      New implementations are discouraged from returning X_OK unless at 
>  -      least one execution permission bit is set."
> 
> Now there is one possible, cross-OS problem that I
> haven't tested.  You can chmod a-x and then use
> setfacl to grant one person execute access.  I'm not
> sure if access works in that case, but that might
> possibly just say that current ACL systems are crap.

I absolutely agree. That is why the OS has a "access()" system call. It's 
there to ask the OS whether the file is executable (or readable/writable).

Otherwise, we'd just do

   static inline int executable(const char *path)
   {
	struct stat st;
	return  !stat(pathname, &st) &&
		S_ISREG(st.st_mode) &&
		(st.st_mode & 0111) != 0;
   }

and be done with it. But exactly because the OS knows what "executable" 
means, we ask it. We don't know about all the ACL's etc, the OS does.

(Similar issues are true for writability too - the file may be "writable" 
in the sense that the write permission bits are on, but if the filesystem 
is mounted read-only, it sure as hell ain't W_OK _anyway_).

> Hmm.  Does access handle SELinux or the other systems?

Yup. 

Modulo bugs, of course, but yes, access() on linux should check both 
POSIX ACL's and SELinux security extensions. It uses exactly the same 
code-paths that open()/execve() does: it uses the "vfs_permission()" 
function which is also what execve() uses.

Now, I think access() actually misses a no-exec mount (it doesn't seem to 
check MNT_NOEXEC for X_OK), and that looks like it might actually be a 
real bug.

		Linus
