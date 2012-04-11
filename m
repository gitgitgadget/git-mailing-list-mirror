From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Thu, 12 Apr 2012 01:44:28 +0600
Message-ID: <CA+gfSn8CW_eqnd-wpyLktbJrVeZ993L9MigE7ehiUStGM15gFw@mail.gmail.com>
References: <11292500.AVmZFUUvNi@flobuntu>
	<1421035.yALBSXSHGd@flomedio>
	<20120410171707.GA3869@burratino>
	<2866164.rI5svgrW1x@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 21:44:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI3T9-0004sh-QY
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 21:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932866Ab2DKToc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 15:44:32 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44285 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756881Ab2DKToa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2012 15:44:30 -0400
Received: by lbbgm6 with SMTP id gm6so1019834lbb.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 12:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=k5Ep/kzotoJQL859LEAUgb8F+9Lu+QSsKO2ksYWIclE=;
        b=sZiaa8bWVk6DmuCKgMZpHRDyzXZ7DAlJFARx4Nv4DSxiS42JnEwHemPVJMORFUDRej
         L9I1QBAg57lJyQeVCvyVzdfJRGBxtW6SHG243Ycc2K+gRY6M+XLYWqmJ28kx+D7V8Wdr
         QPKQ0SzwKXGb+nxtUg2F6+Oxma0CWQjw+oN+uzF9VxLlZ4vtnw1xdx36DSttVZbFe5qb
         agA9mZnZY6z33+kYSpSgyxxUW3E7yEc49vtEBI5jHZ1d1KFc4AJfh3158IdaUDK3F3fZ
         S90z7TXGUgvVzEzyj485by2aPS0UlW7xHWrGt8cNgBhxFV0IBUAZ71u1kI6ia5K8C0sD
         cpMA==
Received: by 10.152.146.39 with SMTP id sz7mr19572637lab.3.1334173468298; Wed,
 11 Apr 2012 12:44:28 -0700 (PDT)
Received: by 10.152.11.231 with HTTP; Wed, 11 Apr 2012 12:44:28 -0700 (PDT)
In-Reply-To: <2866164.rI5svgrW1x@flomedio>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195244>

On Thu, Apr 12, 2012 at 1:20 AM, Florian Achleitner
<florian.achleitner2.6.31@gmail.com> wrote:
> On Tuesday 10 April 2012 12:17:07 Jonathan Nieder wrote:
>> Hi,
>>
>> Florian Achleitner wrote:
>> > Thanks for your inputs. I've now submitted a slightly updated vers=
ion of
>> > my proposal to google. Additionally it's on github [1].
>> >
>> > Summary of diffs:
>> > I'll concentrate on the fetching from svn, writing a remote helper
>> > without branch detection (like svn-fe) first, and then creating th=
e
>> > branch mapper.
>> Thanks for the update.
>>
>> If I understand correctly, the remote helper from the first half wou=
ld
>> do essentially the same thing as Dmitry's remote-svn-alpha script.
>> Since in shell script form it is very simple, I don't think it shoul=
d
>> take more than a couple of days to write such a thing in C.
>
> If the remote-svn-alpha script is really all that needs to be done, y=
ou're
> right. It just pipes through svn-fe. I thought svn-fe could only impo=
rt an svn
> repo initially, and there would be some difference between importing =
the whole
> history and fetching new revisions later, (?).
I've already forgotten the exact details, but svnrdump --incremental
from r0 to rX and then from rX+1 to Y is the same (modulo small dump
header) as from r0 to rY. And svn-fe is able to continue like this too
(maybe some bits of this are not merged, sadly I've forgotten this
too).

A side note is that svnrdump can't do the same trick for rZ, Z>1
(that's shallow clone) starting point as --incremental may produce
delta references to rX, X<Z.
So svnrdump rZ..rY is ok, but it's impossible to continue this with
svnrdump --incremental rY+1..rX. Though it probably is not too hard to
fix from inside svnrdump (disable deltas agains given"old"-threshold
revs) or if the helper becomes very smart about partial history import
it may be done from outside svnrdump, obviously via calling a new
svnrdump request for the needed data and somehow glueing it together.

>
>> Via
>> > Timeline
>> >
>> > GSoC timeline and summer holidays
>> > Summer holidays in Austria at 9th of July. So until the mid-term
>> > evaluations my git project will have co-exist with my regular
>> > university work and projects. But holidays extend until the beginn=
ing
>> > of October, so there=92s some time left to catch up after the offi=
cial
>> > end of GSoC.
>>
>> Another possibility that some people in similar situations have
>> followed is to start early. =A0That works a little better since it m=
eans
>> that by the time midterm evaluations come around we can have a
>> reasonable idea of whether a change in strategy is needed for the
>> project to finished on time.
>>
>> > I plan to split the project in two parts:
>> >
>> > Writing the remote helper using existing functions in vcs-svn to
>> > import svn history without detecting branches, like svn-fe does.
>> > Milestone: 9th of July, GSoC mid-term
>> >
>> > Writing a branch mapper for the remote helper that reads the confi=
g
>> > language (SBL) and imports branches trying to deal as good as poss=
ible
>> > with all the little pitfalls that will occur. Milestone: 20th of
>> > August, GSoC end
>>
>> Could you flesh out this timeline more? =A0Ideally it would be nice =
to
>> have a definite plan here, even to the point of listing what patches
>> would need to be written, so during the summer all that would need t=
o
>> happen is to execute and deal with bugs as they come.
>
> Listing patches and planing all details in the submitted proposal wou=
ld
> require me to know what I do and how I will do it all before last Fri=
day! As
> I'm not yet an expert on this topic, I don't know how I could have kn=
own all
> details a-priori.
> Of course the project's documentation will evolve outside the GSoC pr=
oject
> proposal, which cannot be changed anymore.
>
>>
>> Given the goal described here of an import with support for
>> automatically detecting branches, here are some rough steps I imagin=
e
>> would be involved:
>>
>> =A0. baseline: remote helper in C
>>
>> =A0. option to import starting with a particular numbered revision.
>> =A0 =A0This would be good practice for seeing how options passed to
>> =A0 =A0"git clone -c" can be read from the config file.
>>
>> =A0. option or URL schema to import a single project from a large
>> =A0 =A0Subversion repository that houses several projects. =A0This w=
ould
>> =A0 =A0already be useful in practice since importing the entire Apac=
he
>> =A0 =A0Software Foundation repository takes a while which is a waste
>> =A0 =A0when one only wants the history of the Subversion project.
>>
>> =A0 =A0How should the importer handle Subversion copy commands that
>> =A0 =A0refer to other projects in this case?
>>
>> =A0. automatically detecting trunk when importing a project with the
>> =A0 =A0standard layout. =A0The trunk usually is not branched from el=
sewhere
>> =A0 =A0so this does not require copyfrom info. =A0Some design questi=
ons
>> =A0 =A0come up here: should the remote helper import the entire proj=
ect
>> =A0 =A0tree, too? =A0(I think "yes", since copy commands that copy f=
rom
>> =A0 =A0other branches are very common and that would ensure the rele=
vant
>> =A0 =A0info is available to git.) =A0What should the mapping of git =
commit
>> =A0 =A0names to Subversion revision numbers that is stored in notes =
say
>> =A0 =A0in this case?
>>
>> =A0. detecting trunk and branches and exposing them as different rem=
ote
>> =A0 =A0branches. =A0This is a small step that just involves understa=
nding
>> =A0 =A0how remote helpers expose branches.
>>
>> =A0. storing path properties and copyfrom information in the commits
>> =A0 =A0produced by the vcs-svn/ library. =A0How should these be stor=
ed?
>> =A0 =A0For example, there could be a parallel directory structure
>> =A0 =A0in the tree:
>>
>> =A0 =A0 =A0 foo/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bar.c
>> =A0 =A0 =A0 baz/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 qux.c
>> =A0 =A0 =A0 .properties/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 foo.properties
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 foo/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bar.c.properties
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 baz/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qux.c.properties
>>
>> =A0 =A0with properites for <path> stored at .properties/<path>.prope=
rties.
>> =A0 =A0This strawman scheme doesn't work if the repository being imp=
orted
>> =A0 =A0has any paths ending with ".properties", though. =A0Ideas?
>>
>> =A0. tracing history past branch creation events, using the now-save=
d
>> =A0 =A0copyfrom information.
>>
>> =A0. tracing second-parent history using svn:mergeinfo properties.
>>
>> In other words, in the above list the strategy is:
>>
>> =A01. First convert the remote helper to C so it doesn't have to be
>> =A0 =A0 translated again later.
>>
>> =A02. Teach the remote helper to import a single project from a
>> =A0 =A0 repository that houses multiple projects (i.e., path limitin=
g).
>>
>> =A03. Teach the remote helper to split an imported project that uses
>> =A0 =A0 the standard layout into branches (an application of the cod=
e
>> =A0 =A0 from (2)). =A0This complicates the scheme for mapping betwee=
n
>> =A0 =A0 Subversion revision numbers and git commit ids.
>>
>> =A04. Teach the SVN dumpfile to fast-import stream converter not to
>> =A0 =A0 lose the information that is needed in order to get parentho=
od
>> =A0 =A0 information.
>>
>> =A05. Use the information from step (4) to get parenthood right for =
a
>> =A0 =A0 project split into branches.
>>
>> =A06. Getting the second parent right (i.e., merges). =A0I mentioned
>> =A0 =A0 this for fun but I don't expect there to be time for it.
>>
>> Does that seem right, or does it need tweaks? =A0How long would each
>> step take? =A0Can the steps be subdivided into smaller steps?
>>
>> Another question is: what is the design for this? =A0With the existi=
ng
>> remote-svn-alpha script, there are a few different components with
>> well defined interfaces:
>>
>> =A0 =A0 =A0 commands like "git fetch"
>>
>> =A0 =A0 =A0 =A0 | (1)
>>
>> =A0 =A0 =A0 transport-helper --- (2) --- git fast-import
>>
>> =A0 =A0 =A0 =A0 | (2, 3) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0|
>>
>> =A0 =A0 =A0 remote-svn-alpha =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| (3=
)
>>
>> =A0 =A0 =A0 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 ''.. =A0 =A0 =A0 =A0 =A0 =A0=
 =A0|
>> =A0 =A0 =A0 =A0 |
>> =A0 =A0 =A0 =A0 | (2) =A0 =A0 =A0 =A0 =A0 =A0 ''(2).. =A0 =A0 =A0 |
>> =A0 =A0 =A0 =A0 |
>> =A0 =A0 =A0 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0''.=
=2E =A0 |
>>
>> =A0 =A0 =A0 svnrdump --------- (3) -------- svn-fe
>>
>> =A0(1) communicates using function calls and shared data
>> =A0(2) launches
>> =A0(3) communicates over pipe
>>
>> Once remote-svn-alpha is rewritten in C, the same structure is still
>> present, though it might be less obvious because some of the (2)
>> and (3) can change into (1).
>>
>> Where does the functionality you are adding fit into this picture?
>> Are there any new components being added, and if so what do they tak=
e
>> as input and output?
>
> I planned to implement a remote-helper using the existing interface
> specification to communicate over pipes with git's transport-helper.
> Instead of invoking svn-fe as a subprocess, I want to call vcs-svn/ f=
unctions
> directly from the remote-helper and place new functions in this direc=
tory (?).
> To communicate with svn, the remote-helper launches svnrdump as a sub=
process.
> Additionally the remote-helper will read a configuration file contain=
ing
> additional information about branch-mapping, this should be closely r=
elated to
> Andrew's SBL.
>
>>
>> Hope that helps,
>> Jonathan
>>
>> > [1] https://github.com/flyingflo/git/wiki/
>
> Florian
