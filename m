From: Eric Raymond <esr@snark.thyrsus.com>
Subject: git status --porcelain is a mess that needs fixing
Date: Fri,  9 Apr 2010 14:46:08 -0400 (EDT)
Message-ID: <20100409184608.C7C61475FEF@snark.thyrsus.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 09 20:46:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0JDd-0002LN-87
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 20:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375Ab0DISqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 14:46:12 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:48518
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570Ab0DISqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 14:46:09 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id C7C61475FEF; Fri,  9 Apr 2010 14:46:08 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144455>

I'm going to gripe a lot in this mail, possibly verging on flaming.
Therefore I want to start by making clear that I am not here to
complain without pitching in to help fix the problems.  If I can get
responsive answers to my questions, I will take responsibility for
editing them into the relevant git documentation,

Short version: "git status --porcelain" is horribly badly documented
and appears to be seriously maldesigned.  Both these problems need to
be fixed before git causes a lot of unnecessary grief for people
trying to use it.

Here is the entire documentation on this feature in HEAD:

=============================================================================

In short-format, the status of each path is shown as

	XY PATH1 -> PATH2

where `PATH1` is the path in the `HEAD`, and ` -> PATH2` part is
shown only when `PATH1` corresponds to a different path in the
index/worktree (i.e. renamed).

For unmerged entries, `X` shows the status of stage #2 (i.e. ours) and `Y`
shows the status of stage #3 (i.e. theirs).

For entries that do not have conflicts, `X` shows the status of the index,
and `Y` shows the status of the work tree.  For untracked paths, `XY` are
`??`.

    X          Y     Meaning
    -------------------------------------------------
              [MD]   not updated
    M        [ MD]   updated in index
    A        [ MD]   added to index
    D        [ MD]   deleted from index
    R        [ MD]   renamed in index
    C        [ MD]   copied in index
    [MARC]           index and work tree matches
    [ MARC]     M    work tree changed since index
    [ MARC]     D    deleted in work tree
    -------------------------------------------------
    D           D    unmerged, both deleted
    A           U    unmerged, added by us
    U           D    unmerged, deleted by them
    U           A    unmerged, added by them
    D           U    unmerged, deleted by us
    A           A    unmerged, both added
    U           U    unmerged, both modified
    -------------------------------------------------
    ?           ?    untracked
    -------------------------------------------------

=============================================================================

This was clearly written as an aide-memoire by someone intimately
familiar with the system, but I have to tell you it is so confusing
to me as to be nearly worse than useless.  

In addition, some of the design choices it appears to imply are quite
bad - so I hope I am wrong about those implications.  If I am not, you
have specified a misdesigned format that will frustrate and annoy your
customers (script and front-end writers). And that would be a problem.

As I criticize, bear in mind that (a) none of my issues are VC
specific, and (b) I am the author of several version-control front
ends - *I have done this before.* My objections are *not*
theoretical!

First, the documentation issues, in roughly increasing order of severity:

1. What separates the XY column from the first path?

I'd assume a tab, but it's not documented. It needs to be documented.

2. What separates the '->' on either side from the path columns?

Not documented.  Needs to be documented.  

3. What do the status codes M A D R C mean?

I can guess, but I should not have to guess.  They should be documented.

4. Some columns in the table have sets of codes enclosed by [].  Is
this indicating alternation?

My guess is yes, but I should not have to guess.  This should be documented.

5. What is 'us' versus 'them'? What are "stage #2" and "stage #3"?

It makes my brain hurt just trying to list all the things "us"
and "them" could mean.

Remember that because you're advertising a format for script use, your
audience for this page is not git hackers.  It's not git power
users. It's not even ordinary git users. It's people whose main
expertise is is *other tools*.  They want to get in, write their
script and get out, having learned as little about git as they can get
away with.

If 'us'/'them'/'stage #2'/'stage #3' are git terms of art that are well
defined elsewhere, you must reference that elsewhere.  If they are
not, you need to define them here.  And because of the special
audience for this page, it needs to be more self-contained and make
fewer assumptions about the reader's knowledge than usual.

Note: I, personally, read very fast and don't mind the mental effort
of skimming 50-100 pages of other documentation.  But you must *not*
assume I am anything but an exception.  This *particular* section on
this *particular* page needs (more than others) to be written so it
would be comprehensible to a lazy idiot who vaguely knows about
otther version-control systems and can't be bothered to read 
about this one, either.  


Now to the functional problems, again in roughly increasing order of
severity:

A. The '->' separator considered harmful

The '->' was superfluous and thus a poor design choice; the
distinction between two columns and three columns is easy enough to
make in any scripting language.  As it is, it's meaningless and
scripts will actually have to go to some extra effort to throw it
away.

I think the underlying problem here is that whoever designed this
never got past the idea that it needed to have cues for human
eyeballs in it.  That was a mistake.  If you're serious about it
being easily parseable, design it that way.

B. Does "untracked" include "ignored"?  

If so, that is a problem -- front ends care about the difference, for
example when C-x v v is trying to compute the logical next action.
For an unregistered file, it's to register it.  For an ignored file,
it's to throw a user-visible error.

C. If "untracked" does not include "ignored", how is an ignored file tagged?

If ignored files are not listed, that's another problem. Even more
serious, actually.

D. How do I tell the conflict/no-conflict cases apart?

You have three divisions in the table.  The first two are supposed
to pertain to "entries that do not have conflicts" and "unmerged
entries".  

They share code letters.  *How do I tell them apart?* 

Illustrative case: I see the status code "DD". How do I distinguish
between case 4 ("deleted from index") and case 10 ("unmerged, both
deleted")?

If the distinction is meaningless, then why are they listed
separately?

E. Are you *really* using a space as a status character?

It certainly appears so from the first and seventh rows of the table.
If so, this was a major blunder. It complicates parsing code
unnecessarily, because the easiest way to separate columns is with the
equivalent of a Python or Perl split() operation that will eat that
space.  Then we have to special-case depending on the field width.

The correct way to design a format like this for script parseability
is to (a) never make the difference between space and tab significant,
and (b) never use whitespace as anything but a field separator.  If
you want the equivalent of "blank" you use '-', as in Unix ls -l
output.

This may sound like a nitpick, but it's actually a crash landing, or
close to it.  Front-end writers look at things like this and think
"Idiots.  Can't trust them an inch...".  And git already has a bad
reputation for interface spikiness to live down.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

A right is not what someone gives you; it's what no one can take from you. 
	-- Ramsey Clark
