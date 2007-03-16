From: Junio C Hamano <junkio@cox.net>
Subject: Re: Libification project (SoC)
Date: Thu, 15 Mar 2007 22:30:46 -0700
Message-ID: <7vejnpycu1.fsf@assigned-by-dhcp.cox.net>
References: <20070316042406.7e750ed0@home.brethil>
	<20070316045928.GB31606@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 06:31:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS51t-000716-If
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 06:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbXCPFas (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 01:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128AbXCPFas
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 01:30:48 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:56238 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbXCPFas (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 01:30:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070316053046.EYGI321.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Fri, 16 Mar 2007 01:30:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bHWm1W00X1kojtg0000000; Fri, 16 Mar 2007 01:30:47 -0400
In-Reply-To: <20070316045928.GB31606@spearce.org> (Shawn O. Pearce's message
	of "Fri, 16 Mar 2007 00:59:28 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42326>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> On the other hand, many of the variables declared in environment.c
> are repository specific configuration variables.  These probably
> should be abstracted into some sort of wrapper, so that multiple
> repositories can be accessed from within the same process.  Why?
> a future mod_perl running gitweb.cgi accessing repositories through
> libgit.a and Perl bindings of course!

I think if you are abstracting them out, into "struct repo_state",
the index and object store related variables such as packed_git
should go there as well, so your recommendation feels very
inconsistent to me.

>>     o Avoid dying when a function call fails (eg, malloc())
>
> malloc is a huge problem in the Git code today.  Almost all
> of our malloc calls are actually through the xmalloc wrapper.
> All xmalloc callers assume xmalloc will *never* fail.  This
> makes it, uh, interesting.  ;-)

Actually they do not assume such.  What they assume is worse.
They assume that there is nothing else you can do other than
dying when allocation fails.

> But other areas die when they get given a bad SHA-1 (for example).
> If the library caller can supply that (possibly bad) SHA-1 to an
> API function, that's just mean to die out.  ;-)

That's a real problem, but on the other hand, perl or whatever
wrapped ones can do the dying (or not dying) before calling into
libgit, so it may not be such a big issue.

>>     o Documentation (eg, doxygen)
>>     o Unit-tests
>>     o Add prefix (eg, git_*) to public API functions
>
> Yes.  But which functions shall we expose?  ;-)

Before going into that topic, a bigger question is if we are
happy with the current internal API and what the goal of
libification is.  If the libification is going to say that "this
is a published API so we are not going to change it", I would
imagine that it would be very hard to accept in the mainline.
Improvements like the earlier sliding mmap() series need to be
able to change the interfaces without backward compatibility
wart.

In other words, I do not know what idiot ^W ^W who listed the
libification stuff on the SoC "ideas" page, but I think (1) it
is premature to promise stable ABI, and (2) if it does not
promise stable ABI a library is not very useful.

>       o Build system issues
>
> You missed this, but I think its an important consideration.
> Our current libgit.a is a static library that has a relatively large
> number of symbols its modules are exporting.  These symbol names
> aren't namespace-ized (e.g. git_* prefix) so we wouldn't want to
> just offer this library up in its current form.

Very true, in fact, the current libgit.a is _NOT_ a library at
all.  It is just a way to be terse in our Makefile to make the
linker do the work for us, nothing more.

And I do not think we would want to rename our "internally
public" functions such as find_pack_entry_one() and
sha1_object_info() with git_ prefix only for the purpose of this
libification.

If we can trick the linker to create gitlib.so which defines the
symbol git_sha1_object_info() that lets the caller to call our
internal sha1_object_info(), without exposing the internal name
sha1_object_info(), and strip other global names libgit.a and
plumbing internally use to communicate each other, such as
find_pack_entry_one(), from the gitlib.so library, that would be
a good solution.

>>  2. What's the minimum amount of work that need to be done for
>> the SoC project to be considered successful?
>
> I'd like to see enough API support that gitweb.cgi could:
>
>  * get the most recent commit date of all refs in all projects
>    (the toplevel project index page);
>  * get a shortlog for the main summary page of a project;
>  * get the full content of a single commit;
>  * get the "raw" diff (paths that changed) for two commits;

I would disagree with tying libification and Perl binding this
way.  If the goal is to get faster gitweb, then that does not
necessarily have to be libified git.  Let one person who does
the libification come up with a decent C binding and let others
worry about Perl bindings.

> In some cases much of the above is already "internally public";
> meaning we already treat parts of that code as a library and invoke
> them from within processes to get work done.  Much of this project
> is about improving the interfaces and behavior enough to make those
> existing APIs truely public.

One big thing you forgot to mention is that whatever form it
takes, the libification should not impact performance of
existing plumbing.  These interfaces are "internally" public
exactly because the callers still honor underlying convention
such as not having to clean-up the object flags for the last
invocation.  If you libify in a wrong way, you would end up an
implementation of the interface that always cleans up (because
you would not know if you are part of a long-living process so
you will clean-up just in case you will still be called later),
which would be unusable from the plumbing point-of-view.
