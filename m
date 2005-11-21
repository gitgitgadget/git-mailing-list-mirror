From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Make grafts versionable
Date: Mon, 21 Nov 2005 13:35:46 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511211326110.13959@g5.osdl.org>
References: <Pine.LNX.4.63.0511212152110.4611@wbgn013.biozentrum.uni-wuerzburg.de>
 <43823654.2060904@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 22:38:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeJLb-0008GR-MZ
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 22:37:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbVKUVgJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 16:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbVKUVgI
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 16:36:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62876 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750921AbVKUVgG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2005 16:36:06 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jALLZsnO011350
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 21 Nov 2005 13:35:56 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jALLZkql002056;
	Mon, 21 Nov 2005 13:35:50 -0800
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43823654.2060904@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12487>



On Mon, 21 Nov 2005, H. Peter Anvin wrote:
> 
> Now, CVS has a reserved namespace (CVSROOT/) for things under version control
> which are still significant to CVS.  The logical equivalent to git would be to
> have .git/ be such a namespace, if it makes sense.

Well, there's two reasons for disallowing git from tracking it's own .git 
directory:

 - it protects against people doing somethin glike

	git-update-cache --add -- $(find . -type f | cut -c3..)

   and finding the pre-existing files in ".git"

   This used to literally be how I imported trees into git. These days, 
   you can just do it with "git-ls-files --others", and in fact that is 
   exactly what "git add" does, so now you can just do

	git add .

   and be done with it - without getting that ".git" directory by mistake.

   So that _old_ reason may not be as valid any more.

However, there's one fundamental reason:

 - if you have a file in ".git", that implies that even a "raw git repo" 
   would have versions matter, since technically such a file would be 
   inside the "raw" part. And that I find to be confusing. One of the 
   whole points of a raw git repo is that because it doesn't have anything 
   that is version-controlled and checked out, none of the branches or 
   tags are special, and nothing needs to be updated when you push to such 
   a repo.

   Now, if you have files in .git, suddenly that fundamental nature of a 
   raw repository is no longer clear.

In general, making any internal git data versionable is very confusing. So 
you make the grafts file versionable - that suddenly means that different 
branches may have different parents for the same commit. And that 
depending on which branch you have checked out, git-fsck-cache may result 
in an error, or it may not. That's _nasty_, in my opinion.

So I much prefer to say: everything under ".git" is not versionable, for 
the fundamental reason that the files under .git are "global" to that git 
repository. 

And I think .git/grafts in particular makes no sense to version.

If you want to track a git "grafts" file, you can do it as another git 
repository and a symlink.

		Linus
