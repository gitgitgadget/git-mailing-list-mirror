Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7206AC43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 00:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D96206D3
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 00:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="pNJAZIvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfLRARe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 19:17:34 -0500
Received: from mr85p00im-ztdg06011901.me.com ([17.58.23.198]:43814 "EHLO
        mr85p00im-ztdg06011901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725946AbfLRARe (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 17 Dec 2019 19:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1576628251;
        bh=WT3rKsfTyz62g2JLG09FfgrSz3+Ix8j8NeZnnFGAEFo=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=pNJAZIvsFhmQf8t0keRStmuKSkySZr22E0ypPDFJpHQ3XJSxNvMXZKMfiPQUD5bDj
         wN7UBxEyYZUWWouMubagXebBjgIJFV9/6uLuMU7m0dSs5a6UtJNBF8Tnm6SlLDbsGi
         6eyv6+RrYEpqx7ast0ChXBJMGhscfF7aRFHVYD2dO+B4igdtmVscGLfrghYpxN8LVo
         dKzC4y7bzWlJssrRoqtLe68DyaPVQwRNrZgomkvykWixc5sO7o6Gp58bDbjALl6PHZ
         vJTb7j/KezaQlxUci3QFdSegGQ4BdX7M1uR4UroEbAUxUY+tf8t6dkoiGlS1Oruoum
         IpssfLXDeZGPw==
Received: from [10.100.5.107] (unknown [49.255.65.138])
        by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id 0CB13A6131F;
        Wed, 18 Dec 2019 00:17:30 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: git-subtree split misbehaviour with a commit having empty ls-tree
 for the specified subdir
From:   Tom Clarkson <tqclarkson@icloud.com>
In-Reply-To: <CAPyFy2AsmaxU-BDf_teZJE5hiaVpTSZc8fftnuXPb_4-j7j5Fw@mail.gmail.com>
Date:   Wed, 18 Dec 2019 11:17:28 +1100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D4C58338-10C6-4E5A-BF1F-F48EC2EBDAD5@icloud.com>
References: <CAPyFy2AsmaxU-BDf_teZJE5hiaVpTSZc8fftnuXPb_4-j7j5Fw@mail.gmail.com>
To:     Ed Maste <emaste@freebsd.org>
X-Mailer: Apple Mail (2.3601.0.10)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-17_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912170193
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On 23 Nov 2019, at 3:55 am, Ed Maste <emaste@freebsd.org> wrote:
>=20
> I encountered an issue while trying to use git subtree with the
> FreeBSD svn->git mirror: I found that when "git subtree split"
> encounters a commit with an empty "git ls-tree" for the subdirectory
> being split, it ends up recording the original parent as the new
> parent in the split history that's being created. This then leads to
> unrelated history appearing in the split subtree.
>=20
> Below is a shell script that demonstrates the issue - this is not the
> precise case that I encountered in the FreeBSD repo, but the behaviour
> is identical (and it doesn't take nearly 10 minutes to run). Running
> the script and then "git log" of the commit printed by the final (git
> subtree) command includes the unrelated history in dir2/.
>=20
> It looks like this comes from the cache_set "$rev" "$rev" in
> process_split_commit() added in 39f5fff0d53. This is under the
> suspicious-looking "ugly. is there no better way to tell if this is a
> subtree vs. a mainline commit? Does it matter" comment. However, I
> don't yet understand enough of git-subtree's operation to propose a
> fix.
>=20
> --repro.sh--
> #!/bin/sh
>=20
> rm -rf subrepo-issue
> mkdir -p subrepo-issue
> cd subrepo-issue
>=20
> git init .
> mkdir -p dir1 dir2
> touch dir1/file1 dir2/file2
> git add dir1 dir2
> git commit -m 'initial commit'
> echo 'file2' > dir2/file2
> git commit -m 'file2 modified' dir2/file2
> git rm dir1/file1
> git commit -m 'remove file1'
> mkdir -p dir1
> touch dir1/file1
> git add dir1
> git commit -m 'restore file1'
> echo 'file1' > dir1/file1
> git commit -m 'file1 modified' dir1/file1
> git subtree split --prefix=3Ddir1/
>=20


The algorithm I am looking at to replace the file based mainline =
detection is

 - If subtree root is unknown (as on the initial split), everything is =
mainline.

 - If subtree root is reachable and mainline root is not, it=E2=80=99s a =
subtree commit=20

 - Otherwise, treat as mainline. This will also pick up commits from =
other subtrees but they hopefully won=E2=80=99t contain the subtree =
folder. I don=E2=80=99t think there is an unambiguous way to distinguish =
a subtree merge from a regular merge - the message produced is pretty =
generic. It may be possible to check reachability of all known subtrees, =
but that adds a fair bit of complexity.

That leaves us with the question of how to record the empty mainline =
commits. The most correct result for your repro is probably four commits =
(add/delete everything/restore/modify), but I can see that falling over =
in a scenario where deleting a subtree is more like unlinking a library =
than editing that library to do nothing.

Is it sufficiently correct for your scenario to treat =E2=80=98restore =
file1=E2=80=99 as the initial subtree commit?

