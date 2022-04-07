Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5246BC433FE
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 22:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbiDGWmn convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 7 Apr 2022 18:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiDGWmi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 18:42:38 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D49E1104
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 15:40:33 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.251.39] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 237MeNTP036236
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Apr 2022 18:40:23 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Justin Steven'" <justin@justinsteven.com>
Cc:     "'Glen Choo'" <chooglen@google.com>, <git@vger.kernel.org>,
        "'Emily Shaffer'" <emilyshaffer@google.com>,
        "'Taylor Blau'" <me@ttaylorr.com>
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com> <Yk9Wcr74gvhtyOi7@camp.crustytoothpaste.net> <CAHZU0ySHqc7f9qB0+ZrMWHHJiWsS-_hsUzomwNrGNMTF6qwcOw@mail.gmail.com> <Yk9hONuCIVIq6ieV@camp.crustytoothpaste.net>
In-Reply-To: <Yk9hONuCIVIq6ieV@camp.crustytoothpaste.net>
Subject: RE: Bare repositories in the working tree are a security risk
Date:   Thu, 7 Apr 2022 18:40:18 -0400
Organization: Nexbridge Inc.
Message-ID: <005d01d84ad0$782e8fc0$688baf40$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG01znzod2GH02gC8Rr2yDfyYoUKAGz53C7AbAKRRUCK/yt0Kz/cVpQ
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 7, 2022 6:10 PM, brian m. carlson wrote:
>On 2022-04-07 at 21:53:26, Justin Steven wrote:
>> Hi all,
>>
>> I'm the author of one of the articles linked in Glen's mail. Thank you
>> Glen for summarising the problem beautifully and pushing this forward.
>>
>> Brian said:
>> > As mentioned elsewhere, git status doesn't work without a working tree.
>>
>> This is correct. However, it is possible to embed a bare repo that has
>> its own core.worktree which points to a directory within the
>> containing repo, satisfying the requirement of having a working tree.
>> This is covered in the article [1] and looks to be accounted for in
>> Taylor's reproducer script which admittedly I haven't run.
>>
>> > Instead, I'd rather see us avoid executing any program from the
>> > config or any hooks in a bare repository without a working tree
>> > (except for pushes).  I think that would avoid breaking things while
>> > still improving security.
>>
>> Due to the fact that the embedded bare repo can be made to have a
>> working tree, this won't be an effective fix.
>
>Then we'd probably be better off just walking up the entire hierarchy and
>excluding worktrees from embedded bare repositories, or otherwise restricting
>the config we read.  That will probably mean we'll need to walk the entire
>directory hierarchy to see if it's embedded (or at least to the root of the device) in
>such a case, but that should be relatively uncommon.
>
>I'd definitely like to see us make a security improvement here, but I also would like
>to avoid us breaking a lot of repositories, especially since we lack alternatives.
>
>If git fast-import could 100% correctly round-trip all commits and repositories, I
>would be much more open to blocking this in fsck after a deprecation period, but
>as it stands that's not possible.  Perhaps improving that would be a suitable way
>forward.

One option relating to enable/disable this is to set up a config option that, by default is false, to allow embedded bare repositories. At least with enough warning that this option is required, it might be acceptable. I would prefer never to receive a bare repo through any means (including through a more worrying submodule). From an attack vector standpoint, I would be more concerned about this in an automation setting, say GitHub workflows or Jenkins GitSCM. At least with GitHub workflows, this is "somewhat" contained within VMs under GitHub's control - although not entirely. Jenkins is probably more vulnerable as the clones done through that path do not get the same scrutiny, although in my world, I use a dedicated non-root UID and sandbox the whole thing. This topic makes me nervous and wonder whether we should be self-reporting a CVE.

Shuddering,
Randall

