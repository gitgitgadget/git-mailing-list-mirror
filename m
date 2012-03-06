From: Sam Vilain <sam@vilain.net>
Subject: Re: [spf:guess] Re: Approaches to SVN to Git conversion (was: Re:
 [RFC] "Remote helper for Subversion" project)
Date: Tue, 06 Mar 2012 15:59:27 -0800
Message-ID: <4F56A4DF.8060807@vilain.net>
References: <ab5eb5a7-a446-4dc3-b8e8-e3f7ec306452@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nathan Gray <n8gray@n8gray.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 00:59:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S54I8-0002dY-81
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 00:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031513Ab2CFX7f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Mar 2012 18:59:35 -0500
Received: from uk.vilain.net ([92.48.122.123]:51581 "EHLO uk.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031468Ab2CFX7e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 18:59:34 -0500
Received: by uk.vilain.net (Postfix, from userid 1001)
	id 09BCF8277; Tue,  6 Mar 2012 23:59:33 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on uk.vilain.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [IPv6:::1] (localhost [127.0.0.1])
	by uk.vilain.net (Postfix) with ESMTP id 12BA98209;
	Tue,  6 Mar 2012 23:59:27 +0000 (GMT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <ab5eb5a7-a446-4dc3-b8e8-e3f7ec306452@mail>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192418>

On 3/6/12 12:35 PM, Stephen Bash wrote:
>> The problem of specifying and detecting branches is a major problem =
in
>> my upcoming conversion.  We've got toplevel trunk/branches/tags
>> directories but underneath "branches" it's a free-for-all:
>>
>> /branches/codenameA/{projectA,projectB,projectC}
>> /branches/codenameB   (actually a branch of projectA)
>> /branches/developers/joe/frobnicator-experiment (also a branch of
>> projectA)
>>
>> Clearly there's no simple regex that's going to capture this, so I'm
>> reduced to listing every branch of projectA, which is tedious and
>> error-prone.  However, what *would* work fabulously well for me is
>> "marker file" detection.  Every copy of projectA has a certain file =
at
>> it's root.  Let's call it "markerFile.txt".  What I'd really love is=
 a
>> way to say:
>>
>> my %branch_markers =3D {'/branches/**/markerFile.txt' =3D>
>>                        '/refs/heads/**'}
>
> Ooo...  I like it.  I hadn't hit on this idea yet, but it certainly i=
s a very helpful heuristic.  I doubt I'd have any sort of demo code for=
 you in the near future, but it's definitely an idea to roll into the m=
ix.

What I did for the Perl Perforce conversion is make this a multi=E2=80=93=
step=20
process; first, the heuristic goes through and detects branches and=20
merge parents.  Then you do the actual export.  If, however, the=20
heuristic gets it wrong, then you can manually override the branch=20
detection for a particular revision, which invalidates all of the=20
_automatic_ decisions made for later revisions the next time you run it=
=2E

Even with all of the information in Postgres, and much of the hard work=
=20
pushed into the Postgres engine, and Postgres tuned for OLAP, this was=20
the slowest part of the operation.  For a 30,000=E2=80=93odd revision P=
erforce=20
repository.

The manual input is extremely useful for bespoke conversions; there wil=
l=20
always be warts in the history and no heuristic is perfect (even if you=
=20
can supply your own set of expressions, a way to override it for just=20
one revision is handy).

Just to revise, the steps in git-p4raw, are:

* load metadata (git-p4raw load ; git-p4raw check)
* load blobs (git-p4raw export-blobs)
* find project roots (git-p4raw find-branches)

   Project root decisions can be overridden, in git-p4raw this was=20
through a DB insert, but all this consisted of was inserting (revision,=
=20
branch) tuples into the appropriate table so a front=E2=80=93end would =
be=20
trivial.  As you suggest, a custom heuristic is also an option but the=20
most flexible solution is just being able to override the decisions mad=
e=20
for a particular revision.

* detect project merges (also done by git-p4raw find-branches)

Detecting merge parents used a heuristic based on the per=E2=80=93file=20
integration records and a computation based on an internal diff-tree=20
which produced a list of files that would have needed resolving.  This=20
one I actually used enough to bother implementing a front=E2=80=93end f=
or:

   git-p4raw graft REV PARENT PARENT

Where 'PARENT' could be another project root (revision/branch location)=
,=20
or it could be a git commit ID (for the inevitable occasion where you=20
need to manually graft on some history).  This interface allows you to=20
do several things:

   1. mark a merge which was not recorded correctly in history
   2. un=E2=80=93mark a merge which was detected/recorded incorrectly
   3. skip bad sections of history, for instance squash merging merges=20
which happened over several commits (SVN and Perforce, of course,=20
support insane piecemeal merging prohibited by git)

* the actual fast-import exporter.

   git-p4raw export-commits 1..5000

There was also an important reverse operation:

   git-p4raw unexport-commits 2500

Which moved all of the exported refs backwards, deleted ones which=20
didn't exist at revision 2500.

Once the data has been mined, the actual exporting can proceed very=20
fast.  Eg, on my laptop I could easily be topping 300 commits per secon=
d=20
which makes for a nice export/examine/rewind/adjust cycle.

=46or more information,

   git clone git://github.com/samv/git-p4raw
   cd git-p4raw
   perldoc git-p4raw

The "Game plan." section of the POD is particularly relevant.  Remember=
=20
that SVN is very similar to Perforce in virtually all of its design=20
details so this tool, its database schema, and implementation are all=20
very relevant to the design of the new svn-fe importer.

Sam
