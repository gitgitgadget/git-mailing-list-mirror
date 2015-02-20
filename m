From: Stephen Morton <stephen.c.morton@gmail.com>
Subject: Re: Git Scaling: What factors most affect Git performance for a large repo?
Date: Fri, 20 Feb 2015 11:06:44 -0500
Message-ID: <CAH8BJxEWDb0SDHPS_ZnPzz0QEbryw2GCv2RtJm2u_6rPH566hg@mail.gmail.com>
References: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
	<20150220000320.GD5021@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 17:06:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOq6T-0003x7-Jk
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 17:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755191AbbBTQGs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Feb 2015 11:06:48 -0500
Received: from mail-we0-f179.google.com ([74.125.82.179]:44391 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165AbbBTQGq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2015 11:06:46 -0500
Received: by wesk11 with SMTP id k11so6399454wes.11
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 08:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=J+os5fdpzogPAV+htPDYq4zG+G29XktD5U7phC6lE2g=;
        b=uBuXLYFTjgZ4S5WRtmz4uk3wcbILO62W+5DqFvPuEXkVV74hf7kx+t/DN5Xj1Szupo
         SIeyLOBaw+PTJrCYsfyrn/xJNe/AfxzSqeeLaygeA0s4nnR94o98vIm7Dx/avVGvy5vk
         wdA6fI8N9XMG1npXrXJ4+W03TxtJLHjk+8YoJMAIK+F2yZy+z4Snep4ORJf0xly1afKS
         u5+z/hU9rb/5+PnPVtvcRPmSK6avby6rIbKWmuqhDK+QsLaILttmrN4PZ6gYLevq8+h6
         DhFLIVOEjozmXs1Y3IdYaPFFdlK0w9F4NiexSfvd2QbWn3ZjIC+1UQ0QoJ+VipRrlBFI
         z7fA==
X-Received: by 10.180.87.33 with SMTP id u1mr6793476wiz.20.1424448404862; Fri,
 20 Feb 2015 08:06:44 -0800 (PST)
Received: by 10.194.239.228 with HTTP; Fri, 20 Feb 2015 08:06:44 -0800 (PST)
In-Reply-To: <20150220000320.GD5021@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264170>

This is fantastic. I really appreciate all the answers. And it's great
that I think I've sparked some general discussion that could lead
somewhere too.

Notes:

I'm currently using 2.1.3. I'll move to 2.3.x

I'm experimenting with git-annex to reduce repo size on disk. We'll see=
=2E

I could remove all tags older than /n/ years old in the active repo
and just maintain them in the historical repo. (We have quite a lot of
CI-generated tags.) It sounds like that might improve performance.

Questions:

1. =C3=86var : I'm a bit concerned by your statement that git rebases t=
ake
about 1-2 s per commit. Does that mean that a "git pull --rebase", if
it is picking up say 120 commits (not at all unrealistic), could
potentially take 4 minutes to complete? Or have I misinterpreted your
comment.

2. I'd not heard about bitmap indexes before this thread but it sounds
like they should help me. In limited searching I can't find much
useful documentation about them. It is also not clear to me if I have
to explicitly run "git repack --write-bitmap-indexes" or if git will
automatically detect when they're needed; first experiments seem to
indicate that I need to explicitly generate them. I assume that once
the index is there, git will just use it automatically.


Steve


On Thu, Feb 19, 2015 at 7:03 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Thu, Feb 19, 2015 at 04:26:58PM -0500, Stephen Morton wrote:
>> I posted this to comp.version-control.git.user and didn't get any re=
sponse. I
>> think the question is plumbing-related enough that I can ask it here=
=2E
>>
>> I'm evaluating the feasibility of moving my team from SVN to git. We=
 have a very
>> large repo. [1] We will have a central repo using GitLab (or similar=
) that
>> everybody works with. Forks, code sharing, pull requests etc. will b=
e done
>> through this central server.
>>
>> By 'performance', I guess I mean speed of day to day operations for =
devs.
>>
>>    * (Obviously, trivially, a (non-local) clone will be slow with a =
large repo.)
>>    * Will a few simultaneous clones from the central server also slo=
w down
>>      other concurrent operations for other users?
>
> This hasn't been a problem for us at $DAYJOB.  Git doesn't lock anyth=
ing
> on fetches, so each process is independent.  We probably have about
> sixty developers (and maybe twenty other occasional users) that manag=
e
> to interact with our Git server all day long.  We also have probably
> twenty smoker (CI) systems pulling at two hour intervals, or, when
> there's nothing to do, every two minutes, plus probably fifteen to
> twenty build systems pulling hourly.
>
> I assume you will provide adequate resources for your server.
>
>>    * Will 'git pull' be slow?
>>    * 'git push'?
>
> The most pathological case I've seen for git push is a branch with a
> single commit merged into the main development branch.  As of Git 2.3=
=2E0,
> the performance regression here is fixed.
>
> Obviously, the speed of your network connection will affect this.  Ev=
en
> at 30 MB/s, cloning several gigabytes of data takes time.  Git tries
> hard to eliminate sending a lot of data, so if your developers keep
> reasonably up-to-date, the cost of establishing the connection will t=
end
> to dominate.
>
> I see pull and push times that are less than 2 seconds in most cases.
>
>>    * 'git commit'? (It is listed as slow in reference [3].)
>>    * 'git stautus'? (Slow again in reference 3 though I don't see it=
=2E)
>
> These can be slow with slow disks or over remote file systems.  I
> recommend not doing that.  I've heard rumbles that disk performance i=
s
> better on Unix, but I don't use Windows so I can't say.
>
> You should keep your .gitignore files up-to-date to avoid enumerating
> untracked files.  There's some work towards making this less of an
> issue.
>
> git blame can be somewhat slow, but it's not something I use more tha=
n
> about once a day, so it doesn't bother me that much.
>
>> Assuming I can put lots of resources into a central server with lots=
 of CPU,
>> RAM, fast SSD, fast networking, what aspects of the repo are most li=
kely to
>> affect devs' experience?
>>    * Number of commits
>>    * Sheer disk space occupied by the repo
>
> The number of files can impact performance due to the number of stat(=
)s
> required.
>
>>    * Number of tags.
>>    * Number of branches.
>
> The number of tags and branches individually is really less relevant
> than the total number of refs (tags, branches, remote branches, etc).
> Very large numbers of refs can impact performance on pushes and pulls
> due to the need to enumerate them all.
>
>>    * Binary objects in the repo that cause it to bloat in size [1]
>>    * Other factors?
>
> If you want good performance, I'd recommend the latest version of Git
> both client- and server-side.  Newer versions of Git provide pack
> bitmaps, which can dramatically speed up clones and fetches, and Git
> 2.3.0 fixes a performance regression with large numbers of refs in
> non-shallow repositories.
>
> It is totally worth it to roll your own packages of git if your vendo=
r
> provides old versions.
>
>> Of the various HW items listed above --CPU speed, number of cores, R=
AM, SSD,
>> networking-- which is most critical here?
>
> I generally find that having a good disk cache is important with larg=
e
> repositories.  It may be advantageous to make sure the developer
> machines have adequate memory.  Performance is notably better on
> development machines (VMs) with 2 GB or 4 GB of memory instead of 1 G=
B.
>
> I can't speak to the server side, as I'm not directly involved with i=
ts
> deployment.
>
>> Assume ridiculous numbers. Let me exaggerate: say 1 million commits,=
 15 GB repo,
>> 50k tags, 1,000 branches. (Due to historical code fixups, another 5,=
000 "fix-up
>> branches" which are just one little dangling commit required to chan=
ge the code
>> a little bit between a commit a tag that was not quite made from it.=
)
>
> I routinely work on a repo that's 1.9 GB packed, with 25k (and rapidl=
y
> growing) refs.  Other developers work on a repo that's 9 GB packed, w=
ith
> somewhat fewer refs.  We don't tend to have problems with this.
>
> Obviously, performance is better on some of our smaller repos, but it=
's
> not unacceptable on the larger ones.  I generally find that the 940 K=
B
> repo with huge numbers of files performs worse than the 1.9 GB repo w=
ith
> somewhat fewer.  If you can split your repository into multiple logic=
al
> repositories, that will certainly improve performance.
>
> If you end up having pain points, we're certainly interested in
> working through those.  I've brought up performance problems and peop=
le
> are generally responsive.
> --
> brian m. carlson / brian with sandals: Houston, Texas, US
> +1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion o=
nly
> OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B=
187
