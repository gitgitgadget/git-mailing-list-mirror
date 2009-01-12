From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC PATCH 2/3] Add specification of git-vcs helpers
Date: Sun, 11 Jan 2009 21:03:45 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901112033070.19665@iabervon.org>
References: <alpine.LNX.1.00.0901110334350.19665@iabervon.org> <7vk591mhwj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 03:05:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMCAy-0004XE-Sg
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 03:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbZALCDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 21:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752308AbZALCDr
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 21:03:47 -0500
Received: from iabervon.org ([66.92.72.58]:46381 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752151AbZALCDr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 21:03:47 -0500
Received: (qmail 13503 invoked by uid 1000); 12 Jan 2009 02:03:45 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jan 2009 02:03:45 -0000
In-Reply-To: <7vk591mhwj.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105277>

On Sun, 11 Jan 2009, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > So far, I've actually used list and import; I've also implemented an 
> > export, but haven't figured out exactly how the user should cause it to be 
> > used.
> > ...
> > +'capabilities'::
> > +	Prints the capabilities of the helper, one per line. These are:
> > +	 - import: the basic import command
> > +	 - marks: import should be done with a saved marks file
> > +	 - find-new-branches: detect new branches
> > +	 - export: the general export command
> > +	 - fork: create a new branch and export to it
> > +	 - anonymous-fork: make commits on a branch without an inherent name
> > +	 - merge: merge branches (of whatever type the system supports)
> > +
> > +	If the helper doesn't support "merge", the default for pull is
> > +	to rebase instead of merging.
> 
> Have you tried formatting this to both html and man?  I think you need to
> dedent the second paragraph, and have '+' as the sole character on a line
> immediately before, without any blank lines.  The formatted output of the
> description of 'export' is probably more troublesome as it is much longer.

Nope, I've just been referring to it in the original text, so I've been 
careless with markup.

> This list feels like overengineered yet without enough thinking behind it.

Yeah, I haven't really nailed this one down; it's hard to get really right 
without having a bunch of different helpers which can do different amounts 
of stuff and need different git-side help.

> Your 'list' allows to list what can become branches on the git end, so as
> long as you have tracking information on the git side, find-new-branches
> seems unnecessary, for examle.

I was unclear about what that one meant, I guess. It's supposed to handle 
systems where it's possible to create things that work like branches but 
are hard to find. If a helper doesn't report the capability, then the user 
may need to say, "I also want some/branch/location", or the helper 
wouldn't know that's a branch.

For example, in order to find all of the branches in Perforce, you have 
to figure out both directions of integration, in order to find branches 
that haven't been integrated back into the location you know about, and 
that's kind of expensive to determine and a bit tricky to parse.

It's not intended to indicate that the helper will tell you which ones are 
new or not, just that, if the helper doesn't have it, it will only tell 
you about branches that it's been told about.

> What does 'merge' mean?  It cannot mean to fetch their changes from
> foreign vcs and create a merge locally (you only need import from the
> backend, and merge will be a usual git merge).  Perhaps you meant if you
> can export a merge back?  Some foreign systems may support importing
> merges but not octopus, so it may not be just a black-or-white boolean.

If the helper supports "merge", it means that it is able to create a merge 
in the foreign vcs. You're right about needing to separately list an 
"octopus" capability, and maybe further refinements.

> Also "the default is to rebase instead of merge" is probably too weak.
> You would want to error out if the user tried to merge, wouldn't you?

I think users should be able to create merges in git if they want to, but 
they'd have to linearize the history in order to push it back. Hopefully, 
at some point, we'll have a tool to help with this (which would be helpful 
for generating patch series, anyway).

> > +'list'::
> > +	Takes the remote name, and outputs the names of refs. These
> > +	may be followed, after a single space, by "changed" or
> > +	"unchanged", indicating whether the foreign repository has
> > +	changed from the state in the ref. If the helper doesn't know,
> > +	it doesn't have to provide a value. (In particular, it
> > +	shouldn't do expensive operations, such as importing the
> > +	content, to see whether it matches.)
> 
> I am guessing by 'a value' you mean 'changed/unchanged', iow you are not
> saying if the helper does not know it can omit such refs from the list,
> but it is unclear.

Yeah, that's what I meant.

	-Daniel
*This .sig left intentionally blank*
