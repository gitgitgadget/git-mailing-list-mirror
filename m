From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 08/18] git notes merge: Initial implementation handling
 trivial merges only
Date: Thu, 21 Oct 2010 04:12:54 +0200
Message-ID: <201010210412.54383.johan@herland.net>
References: <1285719811-10871-1-git-send-email-johan@herland.net>
 <201010090155.20858.johan@herland.net> <20101009172955.GB17799@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, bebarino@gmail.com, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 04:13:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8keM-00007F-FB
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 04:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757052Ab0JUCM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 22:12:57 -0400
Received: from smtp.getmail.no ([84.208.15.66]:33849 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756756Ab0JUCM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 22:12:57 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAM00IX2BHJYX70@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 21 Oct 2010 04:12:55 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 3F6D11EA5783_CBFA1A7B	for <git@vger.kernel.org>; Thu,
 21 Oct 2010 02:12:55 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id E179C1EA281B_CBFA1A6F	for <git@vger.kernel.org>; Thu,
 21 Oct 2010 02:12:54 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAM009C5BHI3500@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 21 Oct 2010 04:12:54 +0200 (MEST)
User-Agent: KMail/1.13.5 (Linux/2.6.35-ARCH; KDE/4.5.2; x86_64; ; )
In-reply-to: <20101009172955.GB17799@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159478>

On Saturday 09 October 2010, Jonathan Nieder wrote:
> Johan Herland wrote:
> > Jonathan Nieder wrote:
> >> I would find it easier to read
> >> 
> >> 	if (o->verbosity >= DEFAULT_VERBOSITY)
> >> 	
> >> 		fprintf(stderr, ...)
> >> 
> >> unless there are going to be a huge number of messages.
> > 
> > The current version is modeled on the show() and output() functions in
> > merge-recursive.c. I think that works better in this situation.
> > Or maybe you have a better solution for merge-recursive.c as well?
> 
> Hmm --- isn't the point of output() that it indents to the appropriate
> level to portray a recursive merge?
> 
> Similarly, show() prevents those confusing messages from the internal
> merge between ancestors from being printed when the user is not
> interested.
> 
> But if you think they are important abstractions to maintain, I won't
> stop you. :)

I see. I still find the OUTPUT() macro more readable, but I've amended
the patch to eliminate the extraneous show() function. Hence, you'll
find this in the next iteration:

#define OUTPUT(o, v, ...) \
	do { \
		if ((o)->verbosity >= (v)) { \
			printf(__VA_ARGS__); \
			puts(""); \
		} \
	} while (0)

> >>> +
> >>> +	if (!o->local_ref || get_sha1(o->local_ref, local_sha1)) {
> >>> +		/* empty notes ref => assume empty notes tree */
> 
> [...]
> 
> > I'm not sure when you think we should (or shouldn't) error out.
> 
> get_sha1() can return -1 in the following cases:
> 
>  - starts with :/, regex does not match.
>  - starts with :, entry not present in index
>  - in form <rev>:<path>, <path> does not exist in <rev>
>  - in form <rev>^, <rev> does not exist or that parent does not
>    exist
>  - tag being used as commit points to a tree instead
>  - et c.

I see. I didn't take these into account when I wrote the code.

> Especially if the caller tries
> 
> 	git notes merge 'afjkdlsa^{gobbledeegook'
> 
> I would not like the merge to succeed.

Agreed, but I believe that command currently returns:

  fatal: Could not parse commit 'refs/notes/afjkdlsa^{gobbledeegook'.

(or using afjkdlsa^{gobbledeegook as "our" side of the merge):

  fatal: Cannot lock the ref 'refs/notes/afjkdlsa^{gobbledeegook'.

> So as I see it, there are four cases:
> 
>  - get_sha1() succeeds and returns a commit ==> merge that rev
>  - get_sha1() succeeds and returns a non-commit ==> fail
>  - get_sha1() fails, but resolve_ref() indicates a ref valid
>    for writing ==> merge empty tree
>  - get_sha1() fails, invalid refname ==> fail
> 
> The current code does not notice case 4, does it?

My tests indicate that case 4 does fail (correctly). However I also
agree that this is not at all clear from the current code, so I've
rewritten this code to something that is hopefully more straightforward
(this is the next iteration):

	/* Dereference o->local_ref into local_sha1 */
	if (!resolve_ref(o->local_ref, local_sha1, 0, NULL))
		die("Failed to resolve local notes ref '%s'", o->local_ref);
	else if (!check_ref_format(o->local_ref) && is_null_sha1(local_sha1))
		local = NULL; /* local_sha1 == null_sha1 indicates unborn ref */
	else if (!(local = lookup_commit_reference(local_sha1)))
		die("Could not parse local commit %s (%s)",
		    sha1_to_hex(local_sha1), o->local_ref);
	trace_printf("\tlocal commit: %.7s\n", sha1_to_hex(local_sha1));

	/* Dereference o->remote_ref into remote_sha1 */
	if (get_sha1(o->remote_ref, remote_sha1)) {
		/*
		 * Failed to get remote_sha1. If o->remote_ref looks like an
		 * unborn ref, perform the merge using an empty notes tree.
		 */
		if (!check_ref_format(o->remote_ref)) {
			hashclr(remote_sha1);
			remote = NULL;
		}
		else
			die("Failed to resolve remote notes ref '%s'",
			    o->remote_ref);
	}
	else if (!(remote = lookup_commit_reference(remote_sha1)))
		die("Could not parse remote commit %s (%s)",
		    sha1_to_hex(remote_sha1), o->remote_ref);
	trace_printf("\tremote commit: %.7s\n", sha1_to_hex(remote_sha1));

I've also added more testcases for expected failures.

> > I guess this becomes a discussion of whether we should model notes
> > merges on the 'resolve' merge strategy or the 'recursive' merge
> > strategy. Without having studied each strategy in-depth, I don't know
> > how much "better" 'recursive' is than 'resolve', especially not from
> > the POV of notes merges.
> 
> I think 'resolve' should be good enough for now.  We can always add
> 'recursive' later.

My thoughts exactly.

> > If you look at the notes_merge() docs in notes-merge.h by the
> > end of this series, you'll see the following return values:
> > 
> > 0: Merge trivially succeeded in an existing commit (e.g. fast-forward).
> > 
> > 1: Merge successfully completes a merge commit (i.e. no conflicts).
> > 
> > -1: Merge results is conflicts.
> 
> What kind of caller would care about the distinction between 1 and -1
> here (just curious)?

Any caller who cares about the merge at all, I'd imagine

If 1 (or 0) the merge is complete, and there's nothing more to be done
(expect updating the notes ref, of course).

If -1, there are conflicts checked out in .git/NOTES_MERGE_WORKTREE,
and the user must be told to fix them and commit the conflict
resolution.

See the last part of builtin/notes.c:merge() at the end of this series
for an example.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
