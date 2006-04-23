From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: lstat() call in rev-parse.c
Date: Sun, 23 Apr 2006 09:19:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604230906370.3701@g5.osdl.org>
References: <17483.27938.890830.375324@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 23 18:19:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXhJM-0007Jq-NM
	for gcvg-git@gmane.org; Sun, 23 Apr 2006 18:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWDWQTg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Apr 2006 12:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWDWQTg
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Apr 2006 12:19:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48063 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751416AbWDWQTf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Apr 2006 12:19:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3NGJVtH011527
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 23 Apr 2006 09:19:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3NGJUZJ025409;
	Sun, 23 Apr 2006 09:19:30 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17483.27938.890830.375324@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19069>



On Sun, 23 Apr 2006, Paul Mackerras wrote:
>
> Why does git-rev-parse do an lstat on some of its arguments, at line
> 345 of rev-parse.c, and die if the lstat fails?  It doesn't seem to do
> anything with the result.
> 
> The effect is that if you do "gitk a b", it works as long as a and b
> exist (as files or directories), but fails if they don't, and some
> users have found this confusing.

Because it's even _more_ common to do

	gitk v2.6.16

(in the git directory) and be very confused when that returns an empty 
history. 

So the rule is: if you don't give that "--", then we have to be able to 
confirm that the filenames are really files. Not a misspelled revision 
name, or a revision name that was correctly spelled, but for the wrong 
project, because you were in the wrong subdirectory ;)

And yes, this actually happened to me. I was demonstrating git before we 
did that fix, and I used the wrong tag-name, and gitk would think for a 
minute and them show "No commits selected" with no error, because 
"v2.6.16" didn't exist at that time, and it used the "tag-name" as a 
filename, and that filename didn't actually exist, so the number of 
commits that changed it was exactly zero.

So now, if you do "gitk v2.6.16" in the git directory, it will return a 
nice and understandable 

	Error reading commits: fatal: 'v2.6.16': No such file or directory

which is _exactly_ what you want. The only problem is that gitk will 
actually open the big window too, and the error window is small and can be 
non-obvious if the window manager hides it in some corner. So I actually 
think you should try to make the error window come up smack dab in front 
of the main gitk window and make the error clearer.

So the rules are simple:
 - the filenames are _always_ separated by "--"
 - we have a short-hand, which allows the "--" to be dropped iff it is 
   unambiguous

Where "unambiguous" means that
 - the revision name cannot possible be interpreted as a filename (we 
   don't check this part yet, but I think we should)
 - all filenames are obviously not revision names, since they not 
   only aren't valid revisions, they actually exist as files.

Otherwise, misspellings, typos, and thinkos result in total confusion.

		Linus
