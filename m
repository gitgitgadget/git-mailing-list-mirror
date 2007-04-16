From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Any objectsions to enhancing git-log to show tags/branch heads?
Date: Mon, 16 Apr 2007 16:00:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704161552160.5473@woody.linux-foundation.org>
References: <E1HdQah-0008Q2-7E@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 17 01:00:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdaBr-0003dw-S4
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 01:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023AbXDPXAv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 19:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754031AbXDPXAv
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 19:00:51 -0400
Received: from smtp.osdl.org ([65.172.181.24]:54968 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754023AbXDPXAv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 19:00:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3GN0dIs007491
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Apr 2007 16:00:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3GN0db9014429;
	Mon, 16 Apr 2007 16:00:39 -0700
In-Reply-To: <E1HdQah-0008Q2-7E@candygram.thunk.org>
X-Spam-Status: No, hits=-0.448 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44699>



On Mon, 16 Apr 2007, Theodore Ts'o wrote:
> 
> I've recently noticed that I'm often firing up gitk for no other purpose
> than to see which changesets have which tags and branch heads.  Often
> I'll fire up gitk, quickly look at the tags/branches, and then kill it
> before it's done parsing the repository, resulting in python errors as
> it dies.
> 
> So I'm wondering why we haven't arranged to have git-log show this
> information, and whether there would be any objections if "git-log"
> showed something like this:

Ok, the next few emails will send out a series of two patches to do this.

The patches are much larger than necessary, because the way I did it was 
to add a totally generic notion of "object decorations", ie random data 
structures that can be attached to an object.

I actually stole the implementation from "object-refs", and in fact made 
object refs just be a normal decoration.

The exact syntax is up in the air, but with this, I can say

	git log --decorate

(we could obviously make the "--decorate" thing be the default if really 
wants to), and it will result in something like this:

	commit 02cfc097c2351a2b6e3a65626ce619f038f73c03 (refs/heads/master)
	Author: Linus Torvalds <torvalds@osdl.org>
	Date:   Mon Apr 16 15:49:58 2007 -0700
	
	    Add support for "commit name decorations" to log family of commands
	
	    Right now, it adds "--decorate" as a log option, which prints out the
	    ref names that point to that object if any.
	
	    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
	
	commit b1beb21820bea9c2fb9c04019c485d7810cba710 (refs/tags/test-tag)
	Author: Linus Torvalds <torvalds@osdl.org>
	Date:   Mon Apr 16 15:11:54 2007 -0700
	
	    Add a generic "object decorator" interface, and make object refs use it
	
	    This allows you to add an arbitrary "decoration" of your choice to any
	    object.  It's a space- and time-efficient way to add information to
	    arbitrary objects, especially if most objects probably do not have the
	    decoration.
	
	    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
	
	commit 7a1593972c19df26aee7d14c7d7c8c4fce24fb26 (refs/heads/parent)
	Merge: b073211... 5f2e1df...
	Author: Junio C Hamano <junkio@cox.net>
	Date:   Sun Apr 15 17:52:07 2007 -0700
	
	    Merge branch 'maint'
	....

ie notice the "decorations" after the commit name that actually tell
what branch that commit is on. 

A commit may obviously be on multiple branches, in which case it will
have multiple decorations, and they will show up like so:

	commit 1ed91937e5cd59fdbdfa5f15f6fac132d2b21ce0 (tag: refs/tags/v1.0rc6, tag: refs/tags/v0.99.9n)

where that is an example of a commit that is tagged with two different
tag objects (it's also an example of the difference of having a direct
ref to it and having a ref that is a tag object that points to it: see
the "refs/tags/test-tag" example above on what a *direct* tag reference
will look like, while the "tag: refs/tags/xyzzy" format means that it's
an *indirect* reference through a tag object.

Patches to follow.

		Linus
