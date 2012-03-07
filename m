From: Sam Vilain <sam@vilain.net>
Subject: Re: [spf:guess,iffy] Re: [spf:guess] Re: Approaches to SVN to Git
 conversion (was: Re: [RFC] "Remote helper for Subversion" project)
Date: Wed, 07 Mar 2012 15:15:16 -0800
Message-ID: <4F57EC04.8060705@vilain.net>
References: <ab5eb5a7-a446-4dc3-b8e8-e3f7ec306452@mail> <4F56A4DF.8060807@vilain.net> <4F57DBF0.4060101@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Bash <bash@genarts.com>, Nathan Gray <n8gray@n8gray.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Thu Mar 08 00:15:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5Q4v-000679-Ad
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 00:15:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030560Ab2CGXPY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 18:15:24 -0500
Received: from uk.vilain.net ([92.48.122.123]:41676 "EHLO uk.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932803Ab2CGXPX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 18:15:23 -0500
Received: by uk.vilain.net (Postfix, from userid 1001)
	id 1374F8276; Wed,  7 Mar 2012 23:15:23 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on uk.vilain.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [IPv6:::1] (localhost [127.0.0.1])
	by uk.vilain.net (Postfix) with ESMTP id 0E98C8083;
	Wed,  7 Mar 2012 23:15:16 +0000 (GMT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <4F57DBF0.4060101@pileofstuff.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192501>

On 3/7/12 2:06 PM, Andrew Sayers wrote:
> It sounds like we've approached two similar problems in similar ways,=
 so
> I'm curious about the differences where they exist.  I've been readin=
g
> this message of yours from 18 months ago alongside this thread:
> http://article.gmane.org/gmane.comp.version-control.git/150007
> Unfortunately these comprise everything I know about Perforce.

Right, I went into more detail back then than I did with my more recent=
=20
message.

> I notice that git-p4raw stores all of its data in Postgres and provid=
es
> a programmatic interface for querying it, whereas I've focussed on
> providing ASCII interfaces at relevant points.  I can see how a DB st=
ore
> would help manage the amount of data you'd need to process in a big
> repository, but were there any other issues that drove you down this
> route?  Did you consider a text-based interface?

I wrote it like this mostly because the source metadata was already in =
a=20
tabular form.  It allowed me to load the data, and then convert=20
deductions I could make of the data into unique and foreign key=20
constraints.  It provided me with ACID semantics to make it so that if=20
my program ran and failed the changes would not be applied.  Despite th=
e=20
popular opinion of "web=E2=80=93scale" technologists, databases do have=
 large=20
advantages over unstructured hierarchical data :-).

I didn't really intend to provide a programmatic interface, that was a=20
set of user tools.  The SQL store is the programmatic interface :)

>> What I did for the Perl Perforce conversion is make this a multi=E2=80=
=93step
>> process; first, the heuristic goes through and detects branches and
>> merge parents.  Then you do the actual export.  If, however, the
>> heuristic gets it wrong, then you can manually override the branch
>> detection for a particular revision, which invalidates all of the
>> _automatic_ decisions made for later revisions the next time you run=
 it.
>
> Could you give an example of overriding branch/merge detection?  It
> sounds like you're saying that if there's some problem detecting merg=
e
> parents in an early revision, then all future merges are ignored by t=
he
> script.

The wrong decision can make things much worse down the line.  With the=20
Perl history, the repository was about 350MB of pack, until I got the=20
merge history correct.  Afterwards, it packed down to about 70MB.  This=
=20
is because there was a lot of criss=E2=80=93cross merging, and by marki=
ng them=20
correctly git's repack algorithm was more able to locate similar blobs=20
and compress correctly.  The pack size was not the goal, but a good=20
verification that I had brought the correct commits together in history=
=2E

The bigger problems with it range from thinking changes are merged in=20
your branch which weren't really, or depending on how branch detection=20
etc works, getting thrown off completely and emitting garbage branch=20
histories.  So, it does help to be able to "rewind" the heuristics, pok=
e=20
information in and then resume again and see if things are improved.=20
The information could be inserted into a single file which has=20
configured the entire import, and also serves as a set of notes as to=20
the amendments carried out.  I was happy with a database dump :-).

> <snip>
>> The manual input is extremely useful for bespoke conversions; there =
will
>> always be warts in the history and no heuristic is perfect (even if =
you
>> can supply your own set of expressions, a way to override it for jus=
t
>> one revision is handy).
>
> Again, would you mind providing a few examples?  It sounds like you h=
ave
> some edge cases that could be handled by extending the branch history
> format, but I'd like to pin it down a bit more before discussing solu=
tions.

There's a few,

* a branch contains a subproject and is merged into a subtree
* someone puts a "README" or similar file in a funny place, which isn't=
=20
inside a project root
* someone starts a project with no files in its root directory
* someone records a merge incorrectly (or using a young or middle=E2=80=
=93aged=20
SVN which didn't record merges).  You don't want your annotate to hit a=
=20
merge commit which isn't recorded as a merge, and then have to go=20
hunting around in history for the real origin of a line of code
* the piecemeal merge case you have seen yourself.

It's just very useful to be able to reparent during the data mining sta=
ge.

> <snip>
>>    3. skip bad sections of history, for instance squash merging merg=
es
>> which happened over several commits (SVN and Perforce, of course,
>> support insane piecemeal merging prohibited by git)
>
> This is an excellent point I've stumbled past in my experiments witho=
ut
> realising what I was seeing.  A simple SVN example might look like th=
is:
>
> 	svn add trunk branches
> 	svn add trunk/foo trunk/bar
> 	svn ci -m "Initial revision" # r1
>
> 	svn cp trunk branches/my_branch
> 	svn ci -m "Created my_branch" # r2
>
> 	# edit files in my_branch
>
> 	svn merge branches/my_branch/foo trunk/foo
> 	svn ci -m "Merge my_branch ->  trunk (1/3)" # r11
>
> 	svn merge branches/my_branch/bar trunk/bar
> 	svn ci -m "Merge my_branch ->  trunk (2/3)" # r12
>
> 	svn cp branches/my_branch/new_file trunk/new_file
> 	svn ci -m "Merge my_branch ->  trunk (3/3)" # r13
>
> This strikes me as a sensibly cautious workflow in SVN, where merge
> conflicts are common and changes are hard to revert.  The best
> representation for this in the current branch history format would be
> something like this:
>
> 	In r1, create branch "trunk"
> 	In r2, create branch "branches/my_branch" from "trunk"
> 	In r13, merge "branches/my_branch" r13 into "trunk"
>
> In other words, pretend r11 and r12 are just normal commits, and that
> r13 is a full merge.  A more useful (and arguably more accurate)
> representation would be possible if we extended the format a bit:
>
> 	In r1, create branch "trunk"
> 	In r2, create branch "branches/my_branch" from "trunk"
> 	In r12, squash changes in "branches/my_branch"
> 	In r13, squash changes in "branches/my_branch"
> 	In r13, merge "branches/my_branch" r13 into "trunk"
>
> Adding "squash" and "fixup" commands would let us represent the whole
> messy business as a single commit, which is closer to what the user w=
as
> trying to say even if it's further from what they actually had to say=
=2E

Right, you see the problem.

I think your text syntax is fine so long as it is precise enough, and=20
similar to what I mention earlier in this e=E2=80=93mail with having a =
single=20
file to drive a conversion run.  That really is the kind of input data=20
that I had, it's just that I set it up as a useful set of commands.

Sam.
