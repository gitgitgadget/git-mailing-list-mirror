Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA41C433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 16:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC7EF61244
	for <git@archiver.kernel.org>; Wed, 19 May 2021 16:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355393AbhESQsH convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 19 May 2021 12:48:07 -0400
Received: from elephants.elehost.com ([216.66.27.132]:64026 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbhESQsH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 12:48:07 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 14JGkg9o001375
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 19 May 2021 12:46:42 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     <git@vger.kernel.org>
References: <018201d74cc7$079ad730$16d08590$@nexbridge.com> <YKU7sj9MvF/hu/Lc@coredump.intra.peff.net>
In-Reply-To: <YKU7sj9MvF/hu/Lc@coredump.intra.peff.net>
Subject: RE: [Broken] t5300 fails at 2.32.0-rc0
Date:   Wed, 19 May 2021 12:46:36 -0400
Message-ID: <018401d74cce$8c0300e0$a40902a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQEfAsP8A9SkuzERWVBkOfx4zLThSAF6vDNArE/BQ9A=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 19, 2021 12:24 PM. Jeff King wrote:
>To: Randall S. Becker <rsbecker@nexbridge.com>
>Cc: git@vger.kernel.org
>Subject: Re: [Broken] t5300 fails at 2.32.0-rc0
>
>On Wed, May 19, 2021 at 11:52:48AM -0400, Randall S. Becker wrote:
>
>> expecting success of 5300.2 'pack without delta':
>>         packname_1=$(git pack-objects --progress --window=0 test-1 \
>>                         <obj-list 2>stderr) &&
>>         check_deltas stderr = 0
>>
>> not ok 2 - pack without delta
>> #
>> #               packname_1=$(git pack-objects --progress --window=0 test-1 \
>> #                               <obj-list 2>stderr) &&
>> #               check_deltas stderr = 0
>> #
>
>That was one I touched recently (to add the check_deltas stuff). Can you run with "-x"? And/or run with "-i", and show the contents of the
>"stderr" file?
>
>The check_deltas helper is supposed to complain to stderr when it fails.
>So I'm guessing perhaps pack-objects itself failed, and the reason is hidden in the stderr file.
>
>Also, of course, bisecting the failure would be helpful (I can't reproduce here; I tried building with NO_PTHREADS, given our recent
>discussion, but it doesn't seem to matter).

*** t5300-pack-object.sh ***
Initialized empty Git repository in /home/git/git/t/trash directory.t5300-pack-object/.git/
expecting success of 5300.1 'setup':
        rm -f .git/index* &&
        perl -e "print \"a\" x 4096;" >a &&
        perl -e "print \"b\" x 4096;" >b &&
        perl -e "print \"c\" x 4096;" >c &&
        test-tool genrandom "seed a" 2097152 >a_big &&
        test-tool genrandom "seed b" 2097152 >b_big &&
        git update-index --add a a_big b b_big c &&
        cat c >d && echo foo >>d && git update-index --add d &&
        tree=$(git write-tree) &&
        commit=$(git commit-tree $tree </dev/null) &&
        {
                echo $tree &&
                echo $commit &&
                git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)        .*/\\1/"
        } >obj-list &&
        {
                git diff-tree --root -p $commit &&
                while read object
                do
                        t=$(git cat-file -t $object) &&
                        git cat-file $t $object || return 1
                done <obj-list
        } >expect

++ rm -f '.git/index*'
++ perl -e 'print "a" x 4096;'
++ command /usr/bin/perl -e 'print "a" x 4096;'
++ /usr/bin/perl -e 'print "a" x 4096;'
++ perl -e 'print "b" x 4096;'
++ command /usr/bin/perl -e 'print "b" x 4096;'
++ /usr/bin/perl -e 'print "b" x 4096;'
++ perl -e 'print "c" x 4096;'
++ command /usr/bin/perl -e 'print "c" x 4096;'
++ /usr/bin/perl -e 'print "c" x 4096;'
++ test-tool genrandom 'seed a' 2097152
++ test-tool genrandom 'seed b' 2097152
++ git update-index --add a a_big b b_big c
++ cat c
++ echo foo
++ git update-index --add d
+++ git write-tree
++ tree=3c5699c72c7dae4ca3b3ca9de37d68a592b50a45
+++ git commit-tree 3c5699c72c7dae4ca3b3ca9de37d68a592b50a45
++ commit=ee88dc8f46b17a7cf0af1141d84677fff4ba1cfe
++ echo 3c5699c72c7dae4ca3b3ca9de37d68a592b50a45
++ echo ee88dc8f46b17a7cf0af1141d84677fff4ba1cfe
++ git ls-tree 3c5699c72c7dae4ca3b3ca9de37d68a592b50a45
++ sed -e 's/.* \([0-9a-f]*\)   .*/\1/'
++ git diff-tree --root -p ee88dc8f46b17a7cf0af1141d84677fff4ba1cfe
++ read object
+++ git cat-file -t 3c5699c72c7dae4ca3b3ca9de37d68a592b50a45
++ t=tree
++ git cat-file tree 3c5699c72c7dae4ca3b3ca9de37d68a592b50a45
++ read object
+++ git cat-file -t ee88dc8f46b17a7cf0af1141d84677fff4ba1cfe
++ t=commit
++ git cat-file commit ee88dc8f46b17a7cf0af1141d84677fff4ba1cfe
++ read object
+++ git cat-file -t 9d235ed07cd19811a6ceb342de82f190e49c9f68
++ t=blob
++ git cat-file blob 9d235ed07cd19811a6ceb342de82f190e49c9f68
++ read object
+++ git cat-file -t 012b05d476b4ffc9e62d036156b99467206f1efa
++ t=blob
++ git cat-file blob 012b05d476b4ffc9e62d036156b99467206f1efa
++ read object
+++ git cat-file -t c82de19312b6c3695c0c18f70709a6c535682a67
++ t=blob
++ git cat-file blob c82de19312b6c3695c0c18f70709a6c535682a67
++ read object
+++ git cat-file -t 6a9aaa62f091ea4b20590414e8b58c1b0b32b5bf
++ t=blob
++ git cat-file blob 6a9aaa62f091ea4b20590414e8b58c1b0b32b5bf
++ read object
+++ git cat-file -t 0be779221aca65277fd447c8207e1b3c2706ae20
++ t=blob
++ git cat-file blob 0be779221aca65277fd447c8207e1b3c2706ae20
++ read object
+++ git cat-file -t b010fe5253f7dc59c6605dacb92fcea00d199d4e
++ t=blob
++ git cat-file blob b010fe5253f7dc59c6605dacb92fcea00d199d4e
++ read object
ok 1 - setup

expecting success of 5300.2 'pack without delta':
        packname_1=$(git pack-objects --progress --window=0 test-1 \
                        <obj-list 2>stderr) &&
        check_deltas stderr = 0

+++ git pack-objects --progress --window=0 test-1
++ packname_1=
error: last command exited with $?=128
not ok 2 - pack without delta
#
#               packname_1=$(git pack-objects --progress --window=0 test-1 \
#                               <obj-list 2>stderr) &&
#               check_deltas stderr = 0
#

