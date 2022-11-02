Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDADC4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 14:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiKBOQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 10:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKBOQT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 10:16:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812B024F38
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 07:16:16 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A2CRLxg013587;
        Wed, 2 Nov 2022 14:16:13 GMT
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kkqc70fa0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 14:16:13 +0000
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-mathbern-lv.qualcomm.com [10.47.235.147])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A2EGCFb028653
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Nov 2022 14:16:12 GMT
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 4229910)
        id 959905395; Wed,  2 Nov 2022 11:16:12 -0300 (-03)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, mark@xwax.org, matheus.bernardino@usp.br
Subject: Re: Consist timestamps within a checkout/clone
Date:   Wed,  2 Nov 2022 11:16:09 -0300
Message-Id: <20221102141609.1603860-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <221101.86bkpq4jan.gmgdl@evledraar.gmail.com>
References: <221101.86bkpq4jan.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MXyWtP11sKE1K3ytV3Aa7JQMbnXBbKaO
X-Proofpoint-ORIG-GUID: MXyWtP11sKE1K3ytV3Aa7JQMbnXBbKaO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_10,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211020091
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Mon, Oct 31 2022, Mark Hills wrote:
>
> > On Mon, 31 Oct 2022, Ævar Arnfjörð Bjarmason wrote:
> >
> >>
> >> On Mon, Oct 31 2022, Mark Hills wrote:
> >>
> >> > Our use case: we commit some compiled objects to the repo, where compiling
> >> > is either slow or requires software which is not always available.
> >> >
> >> > Since upgrading Git 2.26.3 -> 2.32.4 (as part of Alpine Linux OS upgrade)
> >> > we are noticing a change in build behaviour.
> >> >
> >> > Now, after a "git clone" we find the Makefile intermittently attempting
> >> > (and failing) some builds that are not intended.
> >> >
> >> > Indeed, Make is acting reasonably as the source file is sometimes
> >> > marginally newer than the destination (both checked out by Git), example
> >> > below.
> >> >
> >> > I've never had to consider consistency timestamps within a Git checkout
> >> > until now.
> >> >
> >> > It's entirely possible there's _never_ a guarantee of consistency here.
> >> >
> >> > But then something has certainly changed in practice, as this fault has
> >> > gone from never happening to now every couple of days.
> >> >
> >> > Imaginging I can't be the first person to encounter this, I searched for
> >> > existing threads or docs, but overwhemingly the results were question of
> >> > Git tracking the timestamps (as part of the commit) which this is not;
> >> > it's consistency within one checkout.
> >> >
> >> > $ git clone --depth 1 file:///path/to/repo.git
> >> >
> >> > $ stat winner.jpeg
> >> >   File: winner.jpeg
> >> >   Size: 258243          Blocks: 520        IO Block: 4096   regular file
> >> > Device: fd07h/64775d    Inode: 33696       Links: 1
> >> > Access: (0644/-rw-r--r--)  Uid: (  106/ luthier)   Gid: (  106/ luthier)
> >> > Access: 2022-10-31 16:05:17.756858496 +0000
> >> > Modify: 2022-10-31 16:05:17.756858496 +0000
> >> > Change: 2022-10-31 16:05:17.756858496 +0000
> >> >  Birth: -
> >> >
> >> > $ stat winner.svg
> >> >   File: winner.svg
> >> >   Size: 52685           Blocks: 112        IO Block: 4096   regular file
> >> > Device: fd07h/64775d    Inode: 33697       Links: 1
> >> > Access: (0644/-rw-r--r--)  Uid: (  106/ luthier)   Gid: (  106/ luthier)
> >> > Access: 2022-10-31 16:05:17.766859030 +0000
> >> > Modify: 2022-10-31 16:05:17.766859030 +0000
> >> > Change: 2022-10-31 16:05:17.766859030 +0000
> >> >  Birth: -
> >> >
> >> > Elsewhere in the repository, it's clear the timestamps are not consistent:
> >> >
> >> > $ stat Makefile
> >> >   File: Makefile
> >> >   Size: 8369            Blocks: 24         IO Block: 4096   regular file
> >> > Device: fd07h/64775d    Inode: 33655       Links: 1
> >> > Access: (0644/-rw-r--r--)  Uid: (  106/ luthier)   Gid: (  106/ luthier)
> >> > Access: 2022-10-31 16:05:51.628660212 +0000
> >> > Modify: 2022-10-31 16:05:17.746857963 +0000
> >> > Change: 2022-10-31 16:05:17.746857963 +0000
> >> >  Birth: -
> >>
> >> I think you're almost certainly running into the parallel checkout,
> >> which is new in that revision range. Try tweaking checkout.workers and
> >> checkout.thresholdForParallelism (see "man git-config").

This does look like something you would see with parallel checkout, yes.
But...

> > Thanks, it will be interesting to try this and I'll report back.
>
> FWIW I was under the impression that we'd made it the default, so unless
> you opted-in it's probably not that.

... it indeed should be disabled by default. It seems Mark didn't
manually enable parallel checkout, as the original message only mentions
the git upgrade as a changing factor. And Alpine's git installation
script for 2.32.4 [1] doesn't seem to change our defaults either.

Perhaps, it just happens that 2.32.4 changed the checkout processing
time slightly so that each entry is finished a bit slower (or the system
was overloaded at that moment?). Anyways, the creation order (based on
the mtimes) looks correct to me from a sequential-checkout point of
view: first Makefile, than winner.jpeg, and finally winner.svg. That's
the order in which these files would appear in the index, which is the
order followed by sequential checkout.

[1]: https://git.alpinelinux.org/aports/tree/main/git/APKBUILD?h=3.14-stable&id=0f3285f2cfcb8362460002c27e219fadbf18c885
