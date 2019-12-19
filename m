Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822DEC2D0D2
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 00:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8FA24650
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 00:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="xuanjonZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLSA5o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 19:57:44 -0500
Received: from mr85p00im-hyfv06011301.me.com ([17.58.23.184]:54861 "EHLO
        mr85p00im-hyfv06011301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726536AbfLSA5o (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 18 Dec 2019 19:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1576717062;
        bh=9Gv3T7x+2uP8c6nVo2PP9pw1fdyXIgaLtrTvq466Eus=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=xuanjonZudMwh7AqXwWg0zgfA4s6UsgVpnx4Mym//tWT8W5bO4qs4qZnFKUPwg1rU
         Kfia+2jlHBmBCfjg9QBypMzJjusX5/Hbi6EmlMQ78ulwaXFi5BOJWp+gLImcK8Vrbf
         1BxiWT26++g95+wVBOGuFXinqc0l3Jkgmgnt54WOHoxn0/blBW3dKz9jgqJFeS6nFW
         hL1IzkX640RX8u3xgPW2LHumUVbKiuIOGcW+c5VN0g0dabSIugyf0VwI114FeRmkGA
         VLuG2MCvMdyFitzneMnhaz0adCt2YU+G7kkEiGp4vwALaAGIHLyKdnastq0BaLnaAO
         ER5WAFa1PKMNA==
Received: from [10.100.5.107] (unknown [49.255.65.138])
        by mr85p00im-hyfv06011301.me.com (Postfix) with ESMTPSA id 122CB5815CA;
        Thu, 19 Dec 2019 00:57:41 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: git-subtree split misbehaviour with a commit having empty ls-tree
 for the specified subdir
From:   Tom Clarkson <tqclarkson@icloud.com>
In-Reply-To: <CAPyFy2AKSVQJtSY0RNgJDJ5k1P=-gjNXVjDgPh+CdghhZtJXDw@mail.gmail.com>
Date:   Thu, 19 Dec 2019 11:57:38 +1100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F0FBE3B6-0DF5-40A4-B1A3-18EF65D48FF3@icloud.com>
References: <CAPyFy2AKSVQJtSY0RNgJDJ5k1P=-gjNXVjDgPh+CdghhZtJXDw@mail.gmail.com>
To:     Ed Maste <emaste@freebsd.org>
X-Mailer: Apple Mail (2.3601.0.10)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-18_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912190005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On 19 Dec 2019, at 4:58 am, Ed Maste <emaste@freebsd.org> wrote:
>=20
> =EF=BB=BFOn Tue, 17 Dec 2019 at 19:17, Tom Clarkson =
<tqclarkson@icloud.com> wrote:
>>=20
>> The algorithm I am looking at to replace the file based mainline =
detection is
>>=20
>> - If subtree root is unknown (as on the initial split), everything is =
mainline.
>>=20
>> - If subtree root is reachable and mainline root is not, it=E2=80=99s =
a subtree commit
>>=20
>> - Otherwise, treat as mainline. This will also pick up commits from =
other subtrees but they hopefully won=E2=80=99t contain the subtree =
folder. I don=E2=80=99t think there is an unambiguous way to distinguish =
a subtree merge from a regular merge - the message produced is pretty =
generic. It may be possible to check reachability of all known subtrees, =
but that adds a fair bit of complexity.
>>=20
>> That leaves us with the question of how to record the empty mainline =
commits. The most correct result for your repro is probably four commits =
(add/delete everything/restore/modify), but I can see that falling over =
in a scenario where deleting a subtree is more like unlinking a library =
than editing that library to do nothing.
>>=20
>> Is it sufficiently correct for your scenario to treat =E2=80=98restore =
file1=E2=80=99 as the initial subtree commit?
>=20
> My reproduction scenario is really a demonstration of the real issue I
> encountered. Running the initial "subtree split" on the real repo
> takes about 40 minutes so I wanted something trivial that shows the
> same issue. In the demonstration case (i.e., actually removing and
> readding the subtree) I think it's reasonable to start with the commit
> that added it back.
>=20
> Overall I think your proposed algorithm is reasonable (even though I
> think it won't address some of the cases in our repo). Will your
> algorithm allow us to pass $dir to git rev-list, for the initial
> split?

Is this just for performance reasons? As I understand it that was left =
out because it would exclude relevant commits on an existing subtree, =
but it could make sense as an optimization for the first split of a =
large repo.

> My actual issue stems from the way svn2git converted some odd svn
> history, and is described in more detail on the freebsd-git mailing
> list at =
https://lists.freebsd.org/pipermail/freebsd-git/2019-November/000218.html.=

>=20
> Perhaps we can have some command-line options to provide metadata for
> cases that cannot be inferred? The cases in our repo come from svn2git
> creating subtree merges to represent updates from vendor code. AFAIK
> these should be basically identical to what subtree creates, except
> that we don't have any of the metadata it adds.

The existing --onto option comes pretty close - it marks everything in =
the rev-list of $onto as a subtree commit to be used as-is

For more flexibility, I think allowing more manipulation of the cache is =
the way to go - $cachedir is currently based on process id, but I =
don=E2=80=99t see any reason it can=E2=80=99t be based on prefix =
instead. So the process becomes something like

 # clear the cache - shouldn't usually be necessary, but it's a =
universal debugging step.
git subtree clear-cache --prefix=3Ddir

# ref and all its parents are before subtree add. Treat any children as =
inital commits.
git subtree ignore --prefix=3Ddir ref

# ref and all its parents are known subtree commits to be included =
without transformation.
git subtree existing --prefix=3Ddir ref

# Override an arbitrary mapping, either for performance or because that =
commit is problematic=20
git subtree map --prefix=3Ddir mainline-ref subtree-ref

# Run the existing algorithm, but skipping anything defined manually
git subtree split --prefix=3Ddir


> For a concrete example (from the repo at
> https://github.com/freebsd/freebsd), 7f3a50b3b9f8 is a mainline commit
> that added a new subtree, from 9ee787636908. I think that if I could
> inform subtree split that 9ee787636908 is the root it would work for
> me.

Aside from the metadata, that one is a bit different from a standard =
subtree add in that it copies three folders from the subtree repo rather =
than the root - so the contents of contrib/elftoolchain will never =
exactly match the actual elftoolchain repo, and 9ee787636908 is neither =
mainline nor subtree as subtree split understands it.

If you ignore 9ee787636908, the resulting subtree will be fairly clean, =
but won=E2=80=99t have much of a relationship to the external repo.

If you treat 9ee787636908 as an existing subtree, the second commit on =
your subtree will be based on 7f3a50b3b9f8, which deletes most of the =
contents of the subtree. You should still be able to merge in updates =
from the external repo, but if you try to push changes upstream the =
deletion will break things.


