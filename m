From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: file rename causes history to disappear
Date: Wed, 6 Sep 2006 09:14:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609060858050.27779@g5.osdl.org>
References: <44FEE0BB.2060601@garzik.org> <Pine.LNX.4.64.0609060834520.27779@g5.osdl.org>
 <44FEED4B.30909@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 06 18:17:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL05Q-0000US-Oh
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 18:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWIFQRJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 12:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWIFQRJ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 12:17:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40322 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751410AbWIFQRH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 12:17:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k86GEjnW007542
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 6 Sep 2006 09:14:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k86GEi3A014600;
	Wed, 6 Sep 2006 09:14:45 -0700
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <44FEED4B.30909@garzik.org>
X-Spam-Status: No, hits=-0.483 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26539>



On Wed, 6 Sep 2006, Jeff Garzik wrote:
> 
> Since I'm just interested in the log (ATM), even the lack of "-M" seems to
> produce useful results.  Thanks.

Sure, if you don't actually want the diff, the "-M" isn't worthwhile.

> IMO it is highly counter-intuitive that renames are -not- followed.  I don't
> see the point of a "--follow-rename", it should Just Work(tm).

No, it should not. 

You haven't thought it through, and I excuse you, because even people who 
should know better (and design SCM's) often haven't thought it through.

There's a huge difference between "pathname" and "inode". And git operates 
on _pathnames_, not on inodes. So when you give a pathname specifier, 
that's _exactly_ what it is. It's a pathname specifier, _not_ an "inode" 
specifier.

And pathnames don't change. They're just names for paths to possibly 
_find_ a file/inode. They can't be "renamed". The data that is found 
behind a pathname may be moved to _another_ pathname (and we call that a 
rename), but that doesn't change the original pathname in any way, shape, 
or form.

Now, you can say "git shouldn't work with pathnames, it should work with 
inodes, and use the pathnames to look them up", but you'd be wrong. You'd 
be wrong for many reasons, so let me explain:

 - pathnames are actually often a hell of a lot more interesting that 
   "inodes". Doing thing by pathname means that you have sane and 
   well-defined semantics for something like

	git log -- drivers/scsi drivers/ata include/linux/ata.h

   even if (for example) some of those files or directories don't 
   necessarily even exist at one particular point in time. Exactly 
   _because_ a pathname is not actually affected by the contents of the 
   repository.

   So taking a filename-based approach is actually more _powerful_. You 
   can emulate the "follow a single file" behaviour on top of it, but you 
   can't sanely go the other way.

 - following inodes/files instead of following pathnames happens to also 
   be fundamentally ambiguous when you split or merge the file contents. 
   What happens? You simply _cannot_ describe that in the form of "files". 
   It's impossible. Really. Yet it's actually fairly common.

   In contrast, if you think of pathnames of _pathnames_ (rather than the 
   contents they point to), that particular sticky wicket simply doesn't 
   exist. It's a non-issue. File contents that get split? Big deal. We 
   don't care. We care about a particular set of pathnames, and if the 
   file content came from (or got split into) that set of pathnames, we 
   show it.

So thinking in terms of pathnames is not only fundamentally more powerful, 
it also very fundamentally avoids a confusing situation that you cannot 
avoid with a "inode" based model.

You just need to get used to the fact that the arguments you give to "git 
log" and friends really have _nothing_ to do with any particular "file" or 
"content at any particular time". They are immutable path specifiers. When 
you say

	git log -- drivers/scsi/libata.c

you're asking git "tell me what happened to this _pathname_". Not file. 
Not content (although if you ask for diffs it will show you the diff, 
but not for that "file", but simple AS IT PERTAINS TO THAT PATHNAME!)

It may take a bit of getting used to, but once you realize that git talks 
about immutable pathnames, and once you do get used to it, it's a hell of 
a powerful thing.

And then we can have "--follow-renames" when we are lazy and we 
_understand_ that git talks about pathnames, but we want git to show us 
the data _as_if_ it cared about how the inodes moved around.

			Linus
