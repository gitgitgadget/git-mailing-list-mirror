From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Teach "git-read-tree -u" to check out submodules as
 a directory
Date: Thu, 12 Apr 2007 21:54:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704122143420.28042@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704122102320.4061@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704122104030.4061@woody.linux-foundation.org>
 <7v7isghp1r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 13 06:54:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcDoH-0008S7-M0
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 06:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbXDMEyi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 00:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbXDMEyi
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 00:54:38 -0400
Received: from smtp.osdl.org ([65.172.181.24]:47265 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778AbXDMEyh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 00:54:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3D4sYIs004377
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 12 Apr 2007 21:54:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3D4sYf9024949;
	Thu, 12 Apr 2007 21:54:34 -0700
In-Reply-To: <7v7isghp1r.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.956 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44386>



On Thu, 12 Apr 2007, Junio C Hamano wrote:
> 
> Hmm.  Perhaps something like this on top?
> 
> diff --git a/entry.c b/entry.c
> index 9545e89..0874d61 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -1,6 +1,23 @@
>  #include "cache.h"
>  #include "blob.h"
>  
> +static int make_directory(const char *path, int unlink_as_needed)

I actually tried to think this through, and I don't *think* we should need 
to do this. It should literally be sufficient to just do the "mkdir()" 
call.

Why? Because we've already done the "create_directories()" calls earlier, 
and if you actually look at "create_file()", that one also just does a 
simple "open(path, O_WRONLY | O_CREAT | O_EXCL, mode)" - so doing just the 
mkdir() for creating a subdirectory should be the logically equivalent 
operation.

Similarly, the S_IFLNK case just does a "symlink()" system call. No "try 
to unlink if there was an old entry there before" code.

Basically, once we are inside "write_entry()", we expect to get a success 
or a failure, not a "needs cleanup". If it needed resolving of other state 
before, we shouldn't even have gotten to that stage in the first place.

That said, looking closer, you're right - the cleanup that is done earlier 
is actually wrong for the gitlink case. So I think the *real* problem is 
the cleanup in "checkout_entry()". In particular, note the

	if (!lstat(path, &st)) {
		...
		if (S_ISDIR(st.st_mode)) {
			...
		}
	}

code. If there was a directory there, we should actually leave it alone 
for the gitlink case, because it is up to the *subproject* checkout (not 
the superproject checkout) to handle any issues within that 
subdirectory!

So I think the *right* patch (on top of the one I send out) is actually 
just this:

		Linus

---
diff --git a/entry.c b/entry.c
index 9545e89..50ffae4 100644
--- a/entry.c
+++ b/entry.c
@@ -195,6 +195,9 @@ int checkout_entry(struct cache_entry *ce, struct checkout *state, char *topath)
 		 */
 		unlink(path);
 		if (S_ISDIR(st.st_mode)) {
+			/* If it is a gitlink, leave it alone! */
+			if (S_ISDIRLNK(ntohl(ce->ce_mode)))
+				return 0;
 			if (!state->force)
 				return error("%s is a directory", path);
 			remove_subtree(path);
