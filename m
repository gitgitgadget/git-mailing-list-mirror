From: Joshua Redstone <joshua.redstone@fb.com>
Subject: RE: Git performance results on a large repository
Date: Sat, 4 Feb 2012 18:05:08 +0000
Message-ID: <243C23AF01622E49BEA3F28617DBF0AD5912CA85@SC-MBX02-5.TheFacebook.com>
References: <CB5074CF.3AD7A%joshua.redstone@fb.com>,<CACsJy8DkLCK0ZUKNz_PJazsxjsRbWVVZwjAU5n2EAjJfCYtpoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 19:05:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtjzJ-0008KZ-8C
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 19:05:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069Ab2BDSFS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Feb 2012 13:05:18 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37143 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753559Ab2BDSFQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Feb 2012 13:05:16 -0500
Received: from pps.filterd (m0004077 [127.0.0.1])
	by mx0b-00082601.pphosted.com (8.14.4/8.14.4) with SMTP id q14I5Dri032533;
	Sat, 4 Feb 2012 10:05:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=from : to : cc : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=KdWo5pVLh3K0OxvpUxKj0iHTpSfpTXXOyRFf+QfjFD0=;
 b=MDwRVGozB6tT8EGNE7HoL/IK0vrTu6PflykLDHMMAs68fk9BCwPSlUDt86rdG/v3Nqrr
 47ZVABndR+4y8NJSHyV54CNTHI7TWhzApXboTCY7lagFeMefq7nT+x+34aq1PlGvYd4O
 HLDpXsyPYLxhKvZUaDyWN30YjbUeSxrzknQ= 
Received: from mail.thefacebook.com (corpout1.snc1.tfbnw.net [66.220.144.38])
	by mx0b-00082601.pphosted.com with ESMTP id 12rutkrq65-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 04 Feb 2012 10:05:13 -0800
Received: from SC-MBX02-5.TheFacebook.com ([fe80::9dc2:cfe6:2745:44cc]) by
 sc-hub03.TheFacebook.com ([192.168.18.198]) with mapi id 14.01.0355.002; Sat,
 4 Feb 2012 10:05:08 -0800
Thread-Topic: Git performance results on a large repository
Thread-Index: AQHM4n7tcAztB0vzgUq1FZmN2PdUJJYs1JqA///3O7E=
In-Reply-To: <CACsJy8DkLCK0ZUKNz_PJazsxjsRbWVVZwjAU5n2EAjJfCYtpoQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.18.252]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.6.7361,1.0.260,0.0.0000
 definitions=2012-02-04_05:2012-02-03,2012-02-04,1970-01-01 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189890>

[ wanted to reply to my initial msg, but wasn't subscribed to the list =
at time of mailing, so replying to most recent post instead ]

Thanks to everyone for the questions and suggestions.  I'll try to resp=
ond here.  One high-level clarification - this synthetic repo for which=
 I've reported perf times is representative of where we think we'll be =
in the future.  Git is slow but marginally acceptable for today.  We wa=
nt to start planning now for any big changes we need to make going forw=
ard.

Evgeny Sazhin, Slinky and =C6var Arnfj=F6r=F0 Bjarmason suggested split=
ting up the repo into multiple, smaller repos.  I indicated before that=
 we have a lot of cross-dependencies.  Our largest repo by number of fi=
les and commits is the repo containing the front-end server.  It is a l=
arge code base in which the tight integration of various components res=
ults in many of the cross dependencies.  We are working slowly to split=
 things up more, for example into services, but that is a long-term pro=
cess.

To get a bit abstract for a moment, in an ideal world, it doesn't seem =
like performance constraints of a source-control-system should dictate =
how we choose to structure our code.  Ideally, seems like we should be =
able to choose to structure our code in whatever way we feel maximizes =
developer productivity.  If development and code/release management see=
m easier in a single repo, than why not make an SCM that can handle it?=
  This is one reason I've been leaning towards figuring out an SCM appr=
oach that can work well with our current practices rather than changing=
 them as a prerequisite for good SCM performance.

Sam Vilain:  Thanks for the pointer, i didn't realize that fast-import =
was bi-directional.  I used it for generating the synthetic repo.  Will=
 look into using it the other way around.  Though that still won't spee=
d up things like git-blame, presumably?  The sparse-checkout issue you =
mention is a good one.  There is a good question of how to support quic=
k checkout, branch switching, clone, push and so forth.  I'll look into=
 the approaches you suggest.  One consideration is coming up with a hig=
h-leverage approach - i.e. not doing heavy dev work if we can avoid it.=
  On the other hand, it would be nice if we (including the entire commu=
nity :) ) improve git in areas that others that share similar issues be=
nefit from as well.

Matt Graham:  I don't have file stats at the moment.  It's mostly code =
files, with a few larger data files here and there.    We also don't do=
 sparse checkouts, primarily because most people use git (whether on to=
p of SVN or not), which doesn't support it.

Chris Lee:  When I was building up the repo (e.g., doing lots of commit=
s, before I started using fast-import), i noticed that flash was not mu=
ch faster - stat'ing the whole repo takes a lot of kernel time, even wi=
th flash.  My hunch is that we'd see similar issues with other operatio=
ns, like git-blame.

Zeki Mokhtarzada:  Dumping history I think would speed up operations fo=
r which we don't care about old history, like git-blame in which we onl=
y want to see recent modifications.  We'd also need a good story for ot=
her kinds of operations.  In my mental model of git scalability, I cate=
gorize git structures into three kinds:  those for reasoning about hist=
ory, those for the index and those for the working directory  (yeah, I =
know these don't map precisely to actual on-disk things like the object=
 store, including trees, etc.).  One scaling approach we've been thinki=
ng of is to focus on each individually:  develop a specialized thing to=
 handle history commands efficiently (git-blame, git-log, git-diff, etc=
=2E), something to speed up or bypass the index, and something to make =
large changes to the working directly quickly.

Joey Hess:  Separating the factors is a good suggestion.  My hunch is t=
hat the various git operations test the performance issues in isolation=
=2E  For example, git-status performance depends just on the number of =
files, not on the depth of history.  On the other hand, my guess is tha=
t git-blame performance is more a function of the length of history rat=
her than the number of files.  Though, certainly with compression and i=
ndexing in pack files, I could imagine there being cross-effects betwee=
n length of history and number of files.   The git-status suggestion de=
finitely helps when you know which directory you are concerned about.  =
Often I'm lazy and stat the repo root so I trade-off slowness for being=
 more sure I'm not missing anything.

@Joey, I think you're also touching on a good meta point which is that,=
 there's probably no silver bullet here.  If we want git to efficiently=
 handle repos that are large across a number of dimensions (size, # com=
mits, # files, etc.), there's multiple parts of git that would need enh=
ancement of some form.

Nguyen Thai Ngoc Duy:  At which point in the test flow should I insert =
git-update-index?  I'm happy to try it out.  Will compress index when I=
 next get to a terminal.  My guess is it'll compress a bunch.  It's als=
o conceivable that, if there were an external interface in git to attac=
h other systems to efficiently report which files have changed (e.g., v=
ia file-system integration), it's possible that we could omit managing =
the index in many cases.   I know that would be a big change, but the b=
enefits are intriguing.

Cheers,
Josh




________________________________________
=46rom: Nguyen Thai Ngoc Duy [pclouds@gmail.com]
Sent: Friday, February 03, 2012 10:53 PM
To: Joshua Redstone
Cc: git@vger.kernel.org
Subject: Re: Git performance results on a large repository

On Fri, Feb 3, 2012 at 9:20 PM, Joshua Redstone <joshua.redstone@fb.com=
> wrote:
> I timed a few common operations with both a warm OS file cache and a =
cold
> cache.  i.e., I did a 'echo 3 | tee /proc/sys/vm/drop_caches' and the=
n did
> the operation in question a few times (first timing is the cold timin=
g,
> the next few are the warm timings).  The following results are on a s=
erver
> with average hard drive (I.e., not flash)  and > 10GB of ram.
>
> 'git status' :   39 minutes cold, and 24 seconds warm.
>
> 'git blame':   44 minutes cold, 11 minutes warm.
>
> 'git add' (appending a few chars to the end of a file and adding it):=
   7
> seconds cold and 5 seconds warm.
>
> 'git commit -m "foo bar3" --no-verify --untracked-files=3Dno --quiet
> --no-status':  41 minutes cold, 20 seconds warm.  I also hacked a ver=
sion
> of git to remove the three or four places where 'git commit' stats ev=
ery
> file in the repo, and this dropped the times to 30 minutes cold and 8
> seconds warm.

Have you tried "git update-index --assume-unchaged"? That should
reduce mass lstat() and hopefully improve the above numbers. The
interface is not exactly easy-to-use, but if it has significant gain,
then we can try to improve UI.

On the index size issue, ideally we should make minimum writes to
index instead of rewriting 191 MB index. An improvement we could do
now is to compress it, reduce disk footprint, thus disk I/O. If you
compress the index with gzip, how big is it?
--
Duy
