From: Bernie Innocenti <bernie@codewiz.org>
Subject: Re: [Foundation-l] Wikipedia meets git
Date: Wed, 21 Oct 2009 15:49:27 -0400
Organization: Sugar Labs - http://www.sugarlabs.org/
Message-ID: <1256154567.1477.87.camel@giskard>
References: <ee9cc730910151155w307a87f0w7bba5c4039bb1ef9@mail.gmail.com>
	 <e692861c0910170118n6cabcc0bt3a4028cbbb54da86@mail.gmail.com>
	 <ee9cc730910170140m5a7f2949h80afce7398d9e503@mail.gmail.com>
	 <71cd4dd90910170705o7c61e06fuacba41f447571b45@mail.gmail.com>
	 <deea21830910170804s61786d8ewae0bc9390baaed71@mail.gmail.com>
	 <71cd4dd90910170823o3f58b8c2x1d39040e7582634@mail.gmail.com>
	 <ee9cc730910170939m6e83ad2fy5f22a541c3679638@mail.gmail.com>
	 <deea21830910170953o33823dd3rd7a9305f9ea794d@mail.gmail.com>
	 <ee9cc730910171011l1b68a1a0q7096a93c36362959@mail.gmail.com>
	 <e405c96a0910190830y51009225lc72942a703575042@mail.gmail.com>
	 <5396c0d10910210543i4c0a3350je5bee4c6389a2292@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wikimedia Foundation Mailing List 
	<foundation-l@lists.wikimedia.org>, git <git@vger.kernel.org>
To: Samuel Klein <meta.sj@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 21:56:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0hIE-00016u-8v
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 21:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827AbZJUT4M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Oct 2009 15:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754113AbZJUT4L
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 15:56:11 -0400
Received: from trinity.develer.com ([83.149.158.210]:51530 "EHLO
	trinity.develer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668AbZJUT4K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 15:56:10 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Oct 2009 15:56:10 EDT
Received: (qmail 10857 invoked from network); 21 Oct 2009 19:49:32 -0000
Received: from terminus-est.gnu.org (HELO ?101.117.138.19?) (bernie@66.92.78.210)
  by trinity.develer.com with ESMTPA; 21 Oct 2009 19:49:32 -0000
In-Reply-To: <5396c0d10910210543i4c0a3350je5bee4c6389a2292@mail.gmail.com>
X-Mailer: Evolution 2.28.0 (2.28.0-2.fc12) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130954>

[cc+=3Dgit@vger.kernel.org]

El Wed, 21-10-2009 a las 08:43 -0400, Samuel Klein escribi=F3:
> That sounds like a great idea.  I know a few other people who have
> worked on git-based wikis and toyed with making them compatible with
> mediawiki (copying bernie innocenti, one of the most eloquent :).

Then I'll do my best to sound as eloquent as expected :)

While I think git's internal structure is wonderfully simple and
elegant, I'm a little worried about its scalability in the wiki usecase=
=2E

The scenario for which git's repository format was designed is "patch
oriented" revision control of a filesystem tree. The central object of =
a
git tree is the "commit", which represents a set of changes on multiple
files. I'll disregard all the juicy details on how the changes are
actually packed together to save disk space, making git's repository
format amazingly compact.

Commits are linked to each other in order to represent the history. Git
can efficiently represent a highly non-linear history with thousands of
branches, each containing hundreds of thousands revisions. Branching an=
d
merging huge trees is so fast that one is left wondering if anything ha=
s
happened at all.

So far, so good. This commit-oriented design is great if you want to
track the history *the whole tree* at once, applying related changes to
multiple files atomically. In Git, as well as most other version contro=
l
systems, there's no such thing as a *file* revision! Git manages entire
trees. Trees are assigned unique revision numbers (in fact, ugly sha-1
hashes), and can optionally by tagged or branched at will.

And here's the the catch: the history of individual files is not
directly represented in a git repository. It is typically scattered
across thousands of commit objects, with no direct links to help find
them. If you want to retrieve the log of a file that was changed only 6
times in the entire history of the Linux kernel, you'd have to dig
through *all* of the 170K revisions in the "master" branch.

And it takes some time even if git is blazingly fast:

 bernie@giskard:~/src/kernel/linux-2.6$ time git log  --pretty=3Donelin=
e REPORTING-BUGS  | wc -l=20
 6

 real	0m1.668s
 user	0m1.416s
 sys	0m0.210s

(my laptop has a low-power CPU. A fast server would be 8-10x faster).


Now, the English Wikipedia seems to have slightly more than 3M articles=
,
with--how many? tenths of millions of revisions for sure. Going through
them *every time* one needs to consult the history of a file would be
100x slower. Tens of seconds. Not acceptable, uh?

It seems to me that the typical usage pattern of an encyclopedia is to
change each article individually. Perhaps I'm underestimating the role
of bots here. Anyway, there's no consistency *requirement* for mass
changes to be applied atomically throughout all the encyclopedia, right=
?

In conclusion, the "tree at a time" design is going to be a performance
bottleneck for a large wiki, with no useful application. Unless of
course the concept of changesets was exposed in the UI, which would be
an interesting idea to explore.

Mercurial (Hg) seems to have a better repository layout for the "one
file at a time" access pattern... Unfortunately, it's also much slower
than git for almost any other purpose, sometimes by an order of
magnitude. I'm not even sure how well Hg would cope with a repository
containing 3M files and some 30M revisions. The largest Hg tree I've
dealt with is the "mozilla central" repo, which is already unbearably
slow to work with.

It would be interesting to compare notes with the other DSCM hackers,
too.

--=20
   // Bernie Innocenti - http://codewiz.org/
 \X/  Sugar Labs       - http://sugarlabs.org/
