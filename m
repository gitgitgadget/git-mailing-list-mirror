Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA6E32027C
	for <e@80x24.org>; Tue, 30 May 2017 12:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751435AbdE3M2y (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 08:28:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751412AbdE3M2x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 08:28:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 867E580F6D;
        Tue, 30 May 2017 12:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 867E580F6D
Authentication-Results: ext-mx03.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx03.extmail.prod.ext.phx2.redhat.com; spf=pass smtp.mailfrom=lersek@redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com 867E580F6D
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-87.phx2.redhat.com [10.3.116.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B91DC5C542;
        Tue, 30 May 2017 12:28:47 +0000 (UTC)
Subject: Re: FORMAT_PATCH_NAME_MAX increase
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <99ac8ee7-67b5-5ae7-51cf-6be38de6217f@redhat.com>
 <CACBZZX5U=U1bpiFuuxH2t8ZWnmQQAjWm1ji8XYq_6-SJPGL1sw@mail.gmail.com>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <c2453701-979b-ebc7-dcc3-483a27d4c157@redhat.com>
Date:   Tue, 30 May 2017 14:28:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CACBZZX5U=U1bpiFuuxH2t8ZWnmQQAjWm1ji8XYq_6-SJPGL1sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 30 May 2017 12:28:48 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/30/17 13:36, Ævar Arnfjörð Bjarmason wrote:
> On Mon, May 29, 2017 at 10:49 AM, Laszlo Ersek <lersek@redhat.com> wrote:
>> Hi,
>>
>> would it be possible to
>>
>> - increase the FORMAT_PATCH_NAME_MAX macro from 64 to, say, 128?
>>
>> - Or else to introduce a new git-config knob for it?
>>
>> I have a small review-helper / interdiff script that matches patches
>> from adjacent versions of a series against each other, based on subject
>> line. (Using the formatted file name with the patch number stripped.)
>> The project in question uses long common prefixes in subjects, and the
>> current limit of 64 does not always ensure unicity (again, with the
>> number stripped).
> 
> I don't see why this shouldn't be made configurable, but more
> generally if you have a script like this it seems like a futile effort
> in general to just make the subject longer to solve the general case,
> consider:
> 
>     (cd /tmp/; rm -rf test; git init test; cd test && for i in {1..3};
> do touch $i && git add $i && git commit -m"test"; done && git
> format-patch -2 && git reset --hard HEAD~2 && git am *patch)
> 
> Which now yields:
> 
>     0001-test.patch
>     0002-test.patch
> 
> Git projects in general will have plenty of patches like this, e.g.
> "fix build" or "update tests" or whatever. Isn't a better solution for
> your script to e.g. key on git-patch-id?
> 
>     $ grep "^From " *patch
>     0001-test.patch:From 870e37afa1a5aeb7eef76e607345adcfd4a9022d Mon
> Sep 17 00:00:00 2001
>     0002-test.patch:From de8c37a1532a4f6ae71ffa65400479ba77438f3b Mon
> Sep 17 00:00:00 2001
>     $ cat *patch | git patch-id
>     c71eb8f2c8c461ba6040668e9d79f996f5a04a61
> 870e37afa1a5aeb7eef76e607345adcfd4a9022d
>     735aff6fb601d7ce99506dc7701be3e8a9b5d38c
> de8c37a1532a4f6ae71ffa65400479ba77438f3b
> 
> Other potential heuristics could be keying not just on the subject but
> on the subject + subject of the last N commits for each commit, which
> should give more of a unique key, or key on the whole commit message
> etc.
> 

My use case is the following:

- Contributor posts version 1 of his/her patch series to the mailing
list, and also pushes the series to his/her publicly accessible git repo
on some branch. I review it and suggest a number of improvements.

- Contributor posts version 2 of his/her patch series to the mailing
list, and pushes the series to another branch in his/her repo too. I
want to review the v2 series incrementally; that is, I'd like to diff
each individual v2 patch against its v1 counterpart.

While patches may be dropped, added, replaced between patch set
versions, the general case is that most patches remain in the series,
and they preserve their original subjects. Thus, finding the v1
counterpart for a v2 patch, based on the subject, as formatted by
git-format-patch into filenames, works reliably most of the time.

Note that in such an incremental review, I specifically wish to compare
patches against each other (i.e., I'd like to see diffs of diffs, AKA
interdiffs), and not the source tree at two, v1<->v2, commits into the
two series. The latter would only give me the difference between the v1
and v2 patch application results, and while that is valuable as well,
I'd really like to diff the actual patches.

Of course I could technically parse the Subject: header of the formatted
patch files, and rename the files for interdiffing using full-length
filenames. But then I'd have to care about filesystem safety and such,
and that's already handled perfectly by git-format-patch itself. The
only bit I'm missing is the arbitrary length in the formatted file
names. (I had patched git earlier to use 128 for FORMAT_PATCH_NAME_MAX,
but I'd like to stop carrying that change.)

"git-patch-id" doesn't look applicable here, as I'd like to assign
patches (across v1 and v2) to each other based on "purpose". I.e., the
assignment should occur regardless of even functional changes between
corresponding v1 and v2 patches. I need the coupling exactly so I can
review those differences.

I use the "join" utility on the number-stripped patch filenames to find
the pairs of patches between v1 and v2 that should be compared.

Thanks!
Laszlo
