From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Libification project (SoC)
Date: Fri, 16 Mar 2007 00:59:28 -0400
Message-ID: <20070316045928.GB31606@spearce.org>
References: <20070316042406.7e750ed0@home.brethil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
X-From: git-owner@vger.kernel.org Fri Mar 16 05:59:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS4XQ-0008TW-Jx
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 05:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbXCPE7e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 00:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbXCPE7e
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 00:59:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35322 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbXCPE7d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 00:59:33 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HS4XL-0003AQ-1x; Fri, 16 Mar 2007 00:59:31 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6488620FBAE; Fri, 16 Mar 2007 00:59:29 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070316042406.7e750ed0@home.brethil>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42324>

"Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> wrote:
>  I'm going to apply for the libification project and, in order to help
> me to get started, would be good to get some feedback regarding the
> project's goal and your expectations.

Excellent!
 
>  1. This' a more complete todo list, based on the wiki and a
> quick look at the code.
> 
>     o Remove static variables

Yes.  Removing all of these is not completely necessary in the
first version; in fact I would recommened against it.

For example the active_cache variable and its related friends
is referenced a lot. lt contains the index in memory.  I think
its perfectly OK to say that in the first iteration of a public
libgit.a that the process may only use one index at a time, if it
can even use the index at all (see below).  But if you eventually
got around to even helping the index parts of "the Git library",
that would certainly be appreciated!

On the other hand, many of the variables declared in environment.c
are repository specific configuration variables.  These probably
should be abstracted into some sort of wrapper, so that multiple
repositories can be accessed from within the same process.  Why?
a future mod_perl running gitweb.cgi accessing repositories through
libgit.a and Perl bindings of course!

But static variable removal is low on the priority list for this
project I think.  Our more important issues are related to some of
the other items.

>     o Avoid dying when a function call fails (eg, malloc())

malloc is a huge problem in the Git code today.  Almost all
of our malloc calls are actually through the xmalloc wrapper.
All xmalloc callers assume xmalloc will *never* fail.  This
makes it, uh, interesting.  ;-)

Although one could argue that being unable to malloc needed memory
probably means you're toast, so die()'ing is good.

But other areas die when they get given a bad SHA-1 (for example).
If the library caller can supply that (possibly bad) SHA-1 to an
API function, that's just mean to die out.  ;-)

>     o Input parameter checking (plus errno setting)

Yes, of course.  But most functions (at least those that should be
made public) probably already do check their arguments.  Some return
an error code back to their caller; others die() and abort the
current process.  And there are probably a few that don't check
their arguments enough.  But I think input parameter checking is
probably going to be a relatively small task here.

Although sometimes the input checking is done in the program that
calls the function, and not the function itself.  So that might
need to be refactored in a few spots.

>     o Documentation (eg, doxygen)

Yes; very important for the library to be of any use to anyone else.

>     o Unit-tests

Of the public API, yes.  Our current test suite covers some of that
code that we want to make public, but does so through programs that
call those functions.  We would want unit tests to verify the public
API conforms to the expectations of the unit test's writer.  ;-)

>     o Add prefix (eg, git_*) to public API functions

Yes.  But which functions shall we expose?  ;-)

See below for functionality I'm thinking about; others may have
different ideas.
 
      o Build system issues

You missed this, but I think its an important consideration.
Our current libgit.a is a static library that has a relatively large
number of symbols its modules are exporting.  These symbol names
aren't namespace-ized (e.g. git_* prefix) so we wouldn't want to
just offer this library up in its current form.

Some of those symbols would get name changes (as you suggest above),
but others might not (e.g. the active_cache that I suggest further
above).  These modules might need to be moved out of libgit.a and
moved into say a new libgitprivate.a, that our own code can link
against, but that isn't offered to the public as a stable API.

      o Public header definition

Whatever we expose, we will need to draft a public "git.h"
(or somesuch) that callers can rely upon.  It will need to be
fairly stable, and handle revisions as new features get added.
E.g. version testing support like the zlib and cURL library have,
and that we rely upon in Git to do feature checks.  ;-)

>  2. What's the minimum amount of work that need to be done for
> the SoC project to be considered successful?

I'd like to see enough API support that gitweb.cgi could:

 * get the most recent commit date of all refs in all projects
   (the toplevel project index page);
 * get a shortlog for the main summary page of a project;
 * get the full content of a single commit;
 * get the "raw" diff (paths that changed) for two commits;

There's a thousand other things that gitweb.cgi would still need to
fully avoid forking Git processes.  But that's a really good start,
and is probably going to be a decent chunk of work.  Especially to
create high-quality patches that pass our standards review.  ;-)

In some cases much of the above is already "internally public";
meaning we already treat parts of that code as a library and invoke
them from within processes to get work done.  Much of this project
is about improving the interfaces and behavior enough to make those
existing APIs truely public.

See refs.h, diff.h, revision.h, commit.h...
 
>  3. I don't code in Perl, is it a problem? I mean, the project's
> goal is to have a Perl binding but I think it goes far from
> that: we could have a python module, a C program, or anything
> that shows the libgit is useful.

No, I don't see that as a problem at all.  We have some Perl
experts on the mailing list who would like to see Perl bindings.
Some of the Perl binding is pure C code, and some if it is this
weird Perl macro language...  so I expect those Perl experts to come
out of the woodwork and help the community to create a prototype
set of bindings.  There's also Ruby and Python interests around,
so we may see bindings for those too.  ;-)

>From a goal perspective of this SoC project, any functioning binding
that can support a gitweb type of application would be great.
It shows the library works as intended, is useful, and can be
continued to be built upon.  That's a pretty successful project in
my mind.

-- 
Shawn.
