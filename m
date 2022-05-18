Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18FAC433EF
	for <git@archiver.kernel.org>; Wed, 18 May 2022 17:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240963AbiERRrl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 13:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240955AbiERRrk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 13:47:40 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E8221604E
        for <git@vger.kernel.org>; Wed, 18 May 2022 10:47:38 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 24IHlWtx056358
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 18 May 2022 13:47:33 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Plato Kiorpelidis'" <kioplato@gmail.com>,
        <phillip.wood@dunelm.org.uk>
Cc:     <git@vger.kernel.org>, <avarab@gmail.com>
References: <20220509175159.2948802-1-kioplato@gmail.com> <20220509175159.2948802-14-kioplato@gmail.com> <88421b18-0fa0-236a-b74b-c5ee3ef53279@gmail.com> <20220518173947.4qabalu6mjmzumen@compass>
In-Reply-To: <20220518173947.4qabalu6mjmzumen@compass>
Subject: RE: [PATCH v2 13/15] dir-iterator: option to iterate dirs in pre-order
Date:   Wed, 18 May 2022 13:47:27 -0400
Organization: Nexbridge Inc.
Message-ID: <016201d86adf$5a4e1eb0$0eea5c10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQEtoa9KICtof6G0d82GO44tkWkaaAFac/2+AdFePPMCFShFE65QcyMA
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 18, 2022 1:41 PM, Plato Kiorpelidis wrote:
>On 22/05/10 02:07PM, Phillip Wood wrote:
>> Hi Plato
>>
>> On 09/05/2022 18:51, Plato Kiorpelidis wrote:
>> > Introduce a new option to dir-iterator, using dir_iterator_begin()
>> > flags parameter, allowing to control whether or not directories will
>> > be exposed before their contents. In essence, pre-order traversal
>> > over file system entries that are directories.
>> >
>> > This changes the default behavior of the dir-iterator API. Instead
>> > of iterating directories before doing so over their contents, the
>> > new default behavior does not expose directories at all. Iteration
>> > is still performed, however, within directories, iterating over any
other entry.
>> > Only directory paths are ignored.
>> >
>> > To iterate over directories in pre-order, reproducing the previous
>> > default behavior, enable the new flag DIR_ITERATOR_DIRS_BEFORE in
>> > the flags parameter of dir_iterator_begin():
>> >    * ignore directories by not setting DIR_ITERATOR_DIRS_BEFORE
>> >    * iterate directories pre-order by enabling
>> > DIR_ITERATOR_DIRS_BEFORE
>> >
>> > Adjust existing callers, in refs/files-backend.c and builtin/clone.c
>> > to enable DIR_ITERATOR_DIRS_BEFORE since these callers require
>> > iteration over directories before doing so over their contents.
>> >
>> > Update t/t0066-dir-iterator.sh and t/helper/test-dir-iterator.c to
>> > test the new iteration scheme, which is the new default behavior,
>> > and the new flag DIR_ITERATOR_DIRS_BEFORE which reproduces the old
>default behavior.
>>
>> It's great that you've split this change out from the next patch. I
>> had not realized when I looked at the last round that all the existing
>> callers require pre-order traversal. Given that is the case I'm
>> finding it hard to see how changing the default behavior to one that
>> no caller is using is an improvement.
>
>Changing the default behavior is required to simplify entry.c
remove_subtree().
>I would have kept dir-iterator's default iteration scheme as is, but how
are we
>going to deal with remove_subtree()? remove_subtree() requires iterating
dirs
>after their contents. We need to find a flag encoding that is a good design
choice
>and serves both existing and remove_subtree(), without limiting future dir-
>iterator customers.
>
>This encoding of flags was heavily discussed in the patch series that my
work is
>based on[1], most notably here[2].
>
>[1]: https://lore.kernel.org/git/1493226219-33423-1-git-send-email-
>bnmvco@gmail.com/
>[2]: https://public-inbox.org/git/1751d788-d1f1-1c97-b33b-
>f53dab78ef86@alum.mit.edu/

Could this be a fallback position where nftw() is not available? I am not
how broadly nftw() is supported but it appears to do what you are looking
for.
--Randall

