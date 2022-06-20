Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6DAC433EF
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 18:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244329AbiFTS7Y convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 20 Jun 2022 14:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbiFTS7X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 14:59:23 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8400D63AD
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 11:59:22 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 25KIxJMj059870
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 20 Jun 2022 14:59:19 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Derrick Stolee'" <derrickstolee@github.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, <avarab@gmail.com>
References: <00a401d884d0$32885890$979909b0$@nexbridge.com> <8d2a0a36-1d2f-c723-db1e-8978e5d03d1d@github.com>
In-Reply-To: <8d2a0a36-1d2f-c723-db1e-8978e5d03d1d@github.com>
Subject: RE: Test Failure t5510,t5562 - was RE: [ANNOUNCE] Git v2.37.0-rc1
Date:   Mon, 20 Jun 2022 14:59:14 -0400
Organization: Nexbridge Inc.
Message-ID: <00b501d884d7$d8ed1200$8ac73600$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGbty4YZi8TaCT7HXBORJwwZ7F75wEiX5VOrckuJaA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 20, 2022 2:46 PM, Derrick Stolee wrote:
>On 6/20/22 2:04 PM, rsbecker@nexbridge.com wrote:
>> Subtests t5510.69, 71, 97, 99, 125, 127, 147, 149, 151, 153, 155, 157, 159, 161, 163,
>165, 167, 170 failed in rc1 on the NonStop ia64 platform. These were working in rc0,
>but after analysis, I do not think that is relevant. Here is what we see for subtest
>69:
>>
>> expecting success of 5510.69 'link prune fetch.prune=unset
>remote.origin.prune=unset fetch.pruneTags=unset
>remote.origin.pruneTags=unset --prune origin refs/tags/*:refs/tags/*;
>branch:kept tag:pruned':
>> ...
>>                         git fetch
>> "file:///home/jenkins/.jenkins/workspace/Git_Pipeline@2/t/trash
>directory.t5510-fetch/." "+refs/heads/*:refs/remotes/origin/*" && ...
>>                         git$git_fetch_c fetch --prune
>> "file:///home/jenkins/.jenkins/workspace/Git_Pipeline/t/trash
>> directory.t5510-fetch/." refs/tags/*:refs/tags/* &&
>>
>> What seems to be happening is that the test script is computing the wrong
>parent directory in the second case, cutting the @2. We use Jenkins for our builds
>and occasional multiple builds run. The @2 is Jenkins way of running in another
>place. This seems to be confusing the script parsing of the parent, causing the
>issue. When I rebuilt and test in the primary directory, the failures disappeared
>because no @2.
>
>Yes, the script is incorrectly computing the remote URL. This is not a bug in Git, but
>a bug in the test script.
>
>The issue is this line (some tabs removed):
>
>  new_cmdline=$(printf "%s" "$cmdline" | perl -pe
>'s[origin(?!/)]["'"$remote_url"'"]g')
>
>At this point, $remote_url contains the file path including the @ symbol. However,
>this perl invocation is dropping everything starting at the @ to the next slash.
>
>I'm not sure of a better way to accomplish what is trying to be done here (replace
>'origin' with that specific url) without maybe causing other issues.
>
>This line was introduced by e1790f9245f (fetch tests: fetch <url> <spec> as well as
>fetch [<remote>], 2018-02-09).

How about using sed instead of perl for this?

