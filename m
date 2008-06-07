From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH v3 0/23] Implementation of a file tree iteration using ignore rules.
Date: Sat, 7 Jun 2008 04:43:52 -0400
Message-ID: <20080607084352.GA14120@spearce.org>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: Florian Koeberle <florianskarten@web.de>
X-From: git-owner@vger.kernel.org Sat Jun 07 10:45:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4u38-0002Zx-2d
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 10:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbYFGIn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 04:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753999AbYFGIn6
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 04:43:58 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50257 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbYFGIn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 04:43:56 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K4u1f-0003M1-HO; Sat, 07 Jun 2008 04:43:51 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6E52020FBAE; Sat,  7 Jun 2008 04:43:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1211574872-23676-1-git-send-email-florianskarten@web.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84185>

Florian Koeberle <florianskarten@web.de> wrote:
>  .../org/spearce/jgit/lib/FileNameMatcherTest.java  |  311 +++++++++++++
>  .../jgit/treewalk/LightFileTreeIteratorTest.java   |  114 +++++
>  .../treewalk/rules/AddCommandIterationTest.java    |  321 +++++++++++++
>  .../treewalk/rules/OverallIgnoreRulesTest.java     |  375 +++++++++++++++
>  .../jgit/errors/InvalidPatternException.java       |   44 ++
>  .../jgit/errors/NoGitRepositoryFoundException.java |   28 ++
>  .../errors/PathNotInProjectDirectoryException.java |   25 +
>  .../src/org/spearce/jgit/lib/Constants.java        |   30 +-
>  .../src/org/spearce/jgit/lib/FileNameMatcher.java  |  376 +++++++++++++++
>  .../src/org/spearce/jgit/lib/Repository.java       |  482 +++++++++++++-------
>  .../src/org/spearce/jgit/lib/WorkTree.java         |   67 +++
>  .../jgit/treewalk/LightFileTreeIterable.java       |   59 +++
>  .../jgit/treewalk/LightFileTreeIterator.java       |  112 +++++
>  .../jgit/treewalk/rules/AddRuleListFactory.java    |   75 +++
>  .../jgit/treewalk/rules/AddRulesFactory.java       |   90 ++++
>  .../jgit/treewalk/rules/FileNamePattern.java       |   58 +++
>  .../jgit/treewalk/rules/FilePathPattern.java       |   76 +++
>  .../spearce/jgit/treewalk/rules/FilePattern.java   |  107 +++++
>  .../jgit/treewalk/rules/IgnoreRuleListFactory.java |   94 ++++
>  .../src/org/spearce/jgit/treewalk/rules/Rule.java  |   61 +++
>  .../treewalk/rules/RuleListToObjectConverter.java  |  130 ++++++
>  .../src/org/spearce/jgit/treewalk/rules/Rules.java |   99 ++++
>  .../jgit/treewalk/rules/RulesImplementation.java   |   73 +++

I finally found time while travelling around on planes this past
week to review this series.  Since I didn't have access to my email
client I didn't organize my thoughts per-patch very well, if it all.

I agree with all of Robin's comments.  He noticed a few things I
didn't, but they all made sense once I read them.

Without further ado, here are my remarks on this current series:

----
Please consider using a cleanup commit to:

- Rename FileNameMatcher.extendStringToMatch to just append().
  The action used here is generally called "append" in Java, see
  StringBuffer for example.

- Rename FileNameMatcher.resetStringToMatch to just reset().  It
  is cleaning up the state and the only state it can cleanup is
  the string we are matching against.

- Rename FileNameMatcher.willExtendResultInNoMatch() to say
  canAppendMatch() with the negation in the callers of the
  current willExtendResultInNoMatch() method.  I think its
  easier to read as "!canAppendMatch()".

Ecipse can easily handle the refactoring and its probably easier
to just do at the end of the series rather than fixing every commit
along the way.

----
I'm not sure I see why we have FilePattern.isSameForSubdirectories(),
or Rule.isSameForSubDirectories().  By the end of the series you do
not call either method.  These should be removed from the abstract
definition and from all implementing classes.  Again a cleanup commit
to remove this would be OK.

----
Class Rule should not be public; none of its members are public.

FileNameMatcher's Head.getNextHeads and AbstractHead.setNewHeads
should not be public either; the interfaces are visible only to
this package.

In general please make method access reflect the access of the
class the method is declared within.  If the class is not a public
class then the method isn't visible, even if it is marked public,
so instead mark it package-level.

----
Since FilePattern is not public none of its members should be public;
use default package access for the MATCH_ALWAYS and MATCH_NEVER
constants and private access for the static inner classes that
supply those two implementations.

----
In FileNameMatcher the symbol name invalidWildgetCharacter is used as
a parameter to a number of methods/constructors.  Its name does not
mean anything to me as I don't know what "Wildget" means.  In many
cases this long name is causing Eclipse to wrap the code poorly.
Rename it to notInWild perhaps?

In FileNameMatcher.extendStringToMatchByOneCharacter you don't need
to use an int index into the List<Head> called "heads".  Instead
use the Java 5 syntax of "for (final Head head : heads)" and let
the compiler generate the loop.  If the memory allocation of the
Iterator is too costly here then you probably need to rethink your
storage anyway.  You could have getNextHeads return you an Head[]
instead of List<Head>.  The compiler can loop over the array and
an array takes up less memory than an ArrayList of the same size.

In FileNameMatcher.extractGroupPatternWithoutBrackets your string
literals for the pattern argument of String.format() are way too
long and cause them to overflow the line.  Break the string into
multiple literals and use + to append them together.  Any decent
Java compiler will combine them back into a single string in the
class string pool.  Even if the compiler sucks, this is for an
error condition only.  Who cares how long the StringBuilder is
going to take at that point, the operation has failed.

----
Don't create a local variable just to return it.  You do this
at least in FileNameMatcher.extractGroupPatternWithoutBrackets:

	final String groupPatternWithOutBrackets = patternString.substring(
		start + 1, closingBracketIndex);
	return groupPatternWithOutBrackets;

and it looks more complex than is really needed here:

	return patternString.substring(start + 1, closingBracketIndex);

This is also true in createMatcherForSuffix.  You can reduce
that entire method to just:

	return new FileNameMatcher(new ArrayList<Head>(heads));

which is much easier to read than the 3 lines you have to
create the copyOfHeads.

----
Please use a for loop where it makes sense.  In the case of
FileNameMatcher.extractGroupPatternWithoutBrackets you use a
while loop with a variable called "start", with a post condition
to decrement the variable.  That's why we have the for(;;) loop
construct in the language.

But this entire method is 30 lines of code to say this:

	final int ob = pattern.lastIndexOf('[', closingBracket - 1);
	final int cb = pattern.lastIndexOf(']', closingBracket - 1);
	if (ob < 0 || cb > ob)
		throw new InvalidPatternException("Unbalanced []", pattern);
	return pattern.substring(ob + 1, closingBracket);

----
In FileNameMatcher the isMatch method is _way_ more complex than
it needs to be.  Just use:

	public boolean isMatch() {
		return heads.contains(LastHead.INSTANCE);
	}

contains works perfectly well.  From what I can tell of the
implementation the size of heads should be fairly small, usually
only 1 or 2 items at most.  Testing via contains without using a
backward traversing ListIterator is just fine here.

----
Please don't initialize fields to null.  For example in the
AbstractHead class of FileNameMatcher you set newHeads = null;
the JVM does this for you automatically and that makes your
own statement redundant.

----
I'm not sure I see the value in the Head interface within
FileNameMatcher.  Only two implementations exist; the one for
AbstractHead and the one for LastHead.  Since LastHead is already
just a singleton you might as well just have it extend from the
AbstractHead base class and "waste" the couple of words of static
memory for an empty head list.

----
In FilePathPattern you use "new Character('/')".  Instead use the
flyweight one that comes with the JRE by "Character.valueOf('/')".

----
In general the implementation still feels overly complex to me.
Lots of interfaces, factories and delegation for what should be a
relatively simple thing of pruning names that should be skipped.

It also seems to be somewhat special cased around git-add sort
of behavior.  We also need to process ignore lists for merge, to
make sure we can safely overwrite something or not if there is an
untracked file in the working tree that conflicts with what we are
merging the working directory to.

-- 
Shawn.
