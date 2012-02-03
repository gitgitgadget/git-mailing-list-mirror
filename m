From: Sam Vilain <sam@vilain.net>
Subject: Re: Git performance results on a large repository
Date: Fri, 03 Feb 2012 14:40:54 -0800
Message-ID: <4F2C6276.1070100@vilain.net>
References: <CB5179E9.3B751%joshua.redstone@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Redstone <joshua.redstone@fb.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 23:51:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtRyd-0007cz-Sl
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 23:51:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069Ab2BCWv0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 17:51:26 -0500
Received: from uk.vilain.net ([92.48.122.123]:55007 "EHLO uk.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604Ab2BCWvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 17:51:25 -0500
X-Greylist: delayed 626 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Feb 2012 17:51:24 EST
Received: by uk.vilain.net (Postfix, from userid 1001)
	id B3A4C8275; Fri,  3 Feb 2012 22:40:57 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on uk.vilain.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [IPv6:::1] (localhost [127.0.0.1])
	by uk.vilain.net (Postfix) with ESMTP id 1D17B8075;
	Fri,  3 Feb 2012 22:40:54 +0000 (GMT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <CB5179E9.3B751%joshua.redstone@fb.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189818>

Joshua,

You have an interesting use case.

If I were you I'd consider investigating the git fast-import protocol.=20
It has become bi=E2=80=93directional, and is essentially socket access =
to a git=20
repository with read and transactional update capability.  With a few=20
more commands implemented, it may even be capable of providing all=20
functionality required for command=E2=80=93line git use.

It is already possible that the ".git" directory can be a file: this=20
case is used for submodules in git 1.7.8 and higher.  For this use case=
,=20
there would be an extra field to the ".git" file which is created.  It=20
would indicate the hostname (and port) to connect its internal=20
'fast-import' stream to.  'clone' would consist of creating this file,=20
and then getting the server to stream the objects from its pack to the=20
client.

With the hard=E2=80=93working part of git on the other end of a network=
 service,=20
you could back it by a re=E2=80=93implementation of git which is writte=
n to be=20
distributed in Hadoop.  There are at least two similar implementations=20
of git that are like this: one for cassandra which was written by githu=
b=20
as a research project, and Google's implementation on top of their=20
BigTable/GFS/whatever.  As the git object storage model is write=E2=80=93=
only=20
and content=E2=80=93addressed, it should git this kind of scaling well.

There have also been designs at various times for sparse check=E2=80=93=
outs; ie=20
check=E2=80=93outs where you don't check out the root of the repository=
 but a=20
sub=E2=80=93tree.

With both of these features, clients could easily check out a small par=
t=20
of the repository very quickly.  This is probably the only case which=20
SVN still does better than git at, which is a particular blocker for us=
e=20
cases like repositories with large binaries in them and for projects=20
such as the one you have (another one with a similar problem was KDE,=20
where their projects moved around the repository a lot, and refactoring=
=20
touched many projects simultaneously at times).

It's a large undertaking, alright.

Sam,
just another git community propeller=E2=80=93head.


On 2/3/12 9:00 AM, Joshua Redstone wrote:
> Hi =C3=86var,
>
>
> Thanks for the comments.  I've included a bunch more info on the test=
 repo
> below.  It is based on a growth model of two of our current repositor=
ies
> (I.e., it's not a perforce import). We already have some of the easil=
y
> separable projects in separate repositories, like HPHP.   If we could
> split our largest repos into multiple ones, that would help the scali=
ng
> issue.  However, the code in those repos is rather interdependent and=
 we
> believe it'd hurt more than help to split it up, at least for the
> medium-term future.  We derive a fair amount of benefit from the code
> sharing and keeping things together in a single repo, so it's not cle=
ar
> when it'd make sense to get more aggressive splitting things up.
>
> Some more information on the test repository:   The working directory=
 is
> 9.5 GB, the median file size is 2 KB.  The average depth of a directo=
ry
> (counting the number of '/'s) is 3.6 levels and the average depth of =
a
> file is 4.6.  More detailed histograms of the repository composition =
is
> below:
>
> ------------------------
>
> Histogram of depth of every directory in the repo (dirs=3D`find . -ty=
pe d` ;
> (for dir in $dirs; do t=3D${dir//[^\/]/}; echo ${#t} ; done) |
> ~/tmp/histo.py)
> * The .git directory itself has only 161 files, so although included,
> doesn't affect the numbers significantly)
>
> [0.0 - 1.3): 271
> [1.3 - 2.6): 9966
> [2.6 - 3.9): 56595
> [3.9 - 5.2): 230239
> [5.2 - 6.5): 67394
> [6.5 - 7.8): 22868
> [7.8 - 9.1): 6568
> [9.1 - 10.4): 420
> [10.4 - 11.7): 45
> [11.7 - 13.0]: 21
> n=3D394387 mean=3D4.671830, median=3D5.000000, stddev=3D1.272658
>
>
> Histogram of depth of every file in the repo (files=3D`git ls-files` =
; (for
> file in $files; do t=3D${file//[^\/]/}; echo ${#t} ; done) | ~/tmp/hi=
sto.py)
> * 'git ls-files' does not prefix entries with ./, like the 'find' com=
mand
> above, does, hence why the average appears to be the same as the dire=
ctory
> stats
>
> [0.0 - 1.3]: 1274
> [1.3 - 2.6]: 35353
> [2.6 - 3.9]: 196747
> [3.9 - 5.2]: 786647
> [5.2 - 6.5]: 225913
> [6.5 - 7.8]: 77667
> [7.8 - 9.1]: 22130
> [9.1 - 10.4]: 1599
> [10.4 - 11.7]: 164
> [11.7 - 13.0]: 118
> n=3D1347612 mean=3D4.655750, median=3D5.000000, stddev=3D1.278399
>
>
> Histogram of file sizes (for first 50k files - this command takes a
> while):  files=3D`git ls-files` ; (for file in $files; do stat -c%s $=
file ;
> done) | ~/tmp/histo.py
>
> [ 0.0 - 4.7): 0
> [ 4.7 - 22.5): 2
> [ 22.5 - 106.8): 0
> [ 106.8 - 506.8): 0
> [ 506.8 - 2404.7): 31142
> [ 2404.7 - 11409.9): 17837
> [ 11409.9 - 54137.1): 942
> [ 54137.1 - 256866.9): 53
> [ 256866.9 - 1218769.7): 18
> [ 1218769.7 - 5782760.0]: 5
> n=3D49999 mean=3D3590.953239, median=3D1772.000000, stddev=3D42835.33=
0259
>
> Cheers,
> Josh
>
>
>
>
>
>
> On 2/3/12 9:56 AM, "=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason"<avarab@gm=
ail.com>  wrote:
>
>> On Fri, Feb 3, 2012 at 15:20, Joshua Redstone<joshua.redstone@fb.com=
>
>> wrote:
>>
>>> We (Facebook) have been investigating source control systems to mee=
t our
>>> growing needs.  We already use git fairly widely, but have noticed =
it
>>> getting slower as we grow, and we want to make sure we have a good =
story
>>> going forward.  We're debating how to proceed and would like to sol=
icit
>>> people's thoughts.
>>
>> Where I work we also have a relatively large Git repository. Around
>> 30k files, a couple of hundred thousand commits, clone size around
>> half a GB.
>>
>> You haven't supplied background info on this but it really seems to =
me
>> like your testcase is converting something like a humongous Perforce
>> repository directly to Git.
>>
>> While you /can/ do this it's not a good idea, you should split up
>> repositories at the boundaries code or data doesn't directly cross
>> over, e.g. there's no reason why you need HipHop PHP in the same
>> repository as Cassandra or the Facebook chat system, is there?
>>
>> While Git could better with large repositories (in particular applyi=
ng
>> commits in interactive rebase seems to be to slow down on bigger
>> repositories) there's only so much you can do about stat-ing 1.3
>> million files.
>>
>> A structure that would make more sense would be to split up that gia=
nt
>> repository into a lot of other repositories, most of them probably
>> have no direct dependencies on other components, but even those that
>> do can sometimes just use some other repository as a submodule.
>>
>> Even if you have the requirement that you'd like to roll out
>> *everything* at a certain point in time you can still solve that wit=
h
>> a super-repository that has all the other ones as submodules, and
>> creates a tag for every rollout or something like that.
>
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=D8=A7=EF=
=BF=BD=17=EF=BF=BD=EF=BF=BD=DC=A8}=EF=BF=BD=EF=BF=BD=EF=BF=BD=C6=A0z=EF=
=BF=BD&j:+v=EF=BF=BD=EF=BF=BD=EF=BF=BD=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BDzZ+=EF=BF=BD=EF=BF=BD+zf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=
=BD=EF=BF=BD~=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDi=EF=BF=BD=EF=BF=BD=EF=
=BF=BDz=EF=BF=BD=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD?=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD&=EF=BF=BD)=DF=A2=1Bfl=3D=3D=3D
