From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Tue, 10 Apr 2007 11:45:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704101122510.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org>
 <200704101828.37453.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 11 03:59:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbLLw-0002rd-B8
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 20:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031444AbXDJSpj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 14:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031443AbXDJSpj
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 14:45:39 -0400
Received: from smtp.osdl.org ([65.172.181.24]:40564 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031435AbXDJSph (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 14:45:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3AIjOVZ007074
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Apr 2007 11:45:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3AIjMAL014703;
	Tue, 10 Apr 2007 11:45:23 -0700
In-Reply-To: <200704101828.37453.Josef.Weidendorfer@gmx.de>
X-Spam-Status: No, hits=-0.958 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44162>



On Tue, 10 Apr 2007, Josef Weidendorfer wrote:

> On Tuesday 10 April 2007, Linus Torvalds wrote:
> > ...
> > +	if (resolve_gitlink_ref(ce->name, "HEAD", sha1) < 0)
> > +		return 0;
> > +	return hashcmp(sha1, ce->sha1);
> 
> So this does mean that the SHA1 of a gitlink entry corresponds
> to the commit in the subproject?

Yes.

> I wonder if it is not useful to be able to add some attribute(s)
> to a gitlink, i.e. first reference a gitlink object in the superproject,
> which then references the submodule commit, and also holds some
> further attributes. These attributes can not be put into the subproject,
> as it should be independent.

The special "link" object has come up before, and I actually thought I'd 
do it that way first, but there were a few reasons why I didn't:

 - I tend to like "minimal", and the patches I sent out really are pretty 
   minimal, in the sense that they introduce just _one_ new concept, in 
   one place (it's basically a "tree entry" - so it shows up in tree 
   reading and writing, and nowhere else. The index, of course, is the 
   staging area for trees, so the index was also affected, but that was 
   really a very direct result of that "it's a new tree entry" thing).

 - in a "link" object, the only thing that would normally *change* is 
   really just the commit SHA1. Everything else is really pretty static. 
   As such, I decided that it's just a waste of a perfectly fine object to 
   have several thousands of the "link" objects that really only differ in 
   the pointer to the commit.

 - the "static" part, which you might as well have somewhere else, tends 
   to be stuff that you would need to be able to override locally, and as 
   such it does *not* really have a global meaning that is useful 
   historically.

   For example, the things that you'd want to associate with the gitlink 
   are things like "where would I find the repository that the commit is 
   part of" and "what is a description of that submodule" and "what are 
   the relationships between the submodules". These are things that aren't 
   necessarily even totally independent: in CVS, for example, you have 
   module names that are really not submodules themselves, but are really 
   just aliases for *collections* of submodules.

   So a 1:1 link object simply wouldn't make much sense anyway, and you'd 
   want to override those defaults with site-specific ones (maybe there is 
   a "canonical" address for the submodule repository, but if you have a 
   copy of it locally on-site, when you clone, you'd rather use the 
   *local* copy over the standard site, for example).

So all of this just made me say:
 - the tree entry just contains the commit ID of the subproject, and 
   *nothing* else.
 - any incidental data probably isn't 1:1 with tree entries anyway (both 
   over time: you have tree entries being updated with new commit ID's, 
   but the incidental data does *not* change, and over "space": different 
   repositories might want to use their local preferences for incidental 
   rules)
 - which all implies that the extra information should go in a separate 
   file that actually describes the modules.

In fact, it shouldn't be _one_ separate file: it should be at least two, 
since you'd want to have the *defaults* (which get cloned along with the 
superproject) in a revision-controlled file, and then have local *extra* 
information that is local. 

This is exactly the same as the situation with the ".gitignore" file 
(which is revision-controlled and cloned with the respository) and the 
".git/ignore" file (which is repository-local).

I've been thinking either ".gitmodules" (and ".git/modules") or to just 
extend the ".git/config" file parser to *also* parse a version-controlled 
".gitconfig" file, and just describe the modules there. The config file 
really has pretty nice syntax, and I think module descriptions in many 
ways end up similar to remote branch descriptions, so it would fit in 
there, I think.

(But there's nothing that says that the ".gitmodules" file couldn't just 
use the same parser as the git config file, so I don't really strongly 
care either way. I just think it would be nice to be able to say

	[module "kdelibs"]
		dir = kdelibs
		url = git://git.kde.org/kdelibs
		description = "Basic KDE libraries module"

	[module "base"]
		alias = "kdelibs", "kdebase", "kdenetwork"

or whatever. You get the idea..)

		Linus
