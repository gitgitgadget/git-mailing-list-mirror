Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3D0C433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 15:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D21806124C
	for <git@archiver.kernel.org>; Wed, 19 May 2021 15:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346928AbhESPyR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 11:54:17 -0400
Received: from elephants.elehost.com ([216.66.27.132]:31412 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346899AbhESPyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 11:54:16 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 14JFqrXI098651
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Wed, 19 May 2021 11:52:54 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [Broken] t5300 fails at 2.32.0-rc0
Date:   Wed, 19 May 2021 11:52:48 -0400
Message-ID: <018201d74cc7$079ad730$16d08590$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AddMtyn7ITRCoXUPQpWFpv+Gl4iUHw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Much of the t5300 tests fail on 2.32.0-rc0 on NonStop.

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

ok 1 - setup

expecting success of 5300.2 'pack without delta':
        packname_1=$(git pack-objects --progress --window=0 test-1 \
                        <obj-list 2>stderr) &&
        check_deltas stderr = 0

not ok 2 - pack without delta
#
#               packname_1=$(git pack-objects --progress --window=0 test-1 \
#                               <obj-list 2>stderr) &&
#               check_deltas stderr = 0
#

expecting success of 5300.3 'pack-objects with bogus arguments':
        test_must_fail git pack-objects --window=0 test-1 blah blah <obj-list

usage: git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]
   or: git pack-objects [<options>...] <base-name> [< <ref-list> | < <object-list>]

    -q, --quiet           do not show progress meter
    --progress            show progress meter
    --all-progress        show progress meter during object writing phase
    --all-progress-implied
                          similar to --all-progress when progress meter is shown
    --index-version <version>[,<offset>]
                          write the pack index file in the specified idx format version
    --max-pack-size <n>   maximum size of each output pack file
    --local               ignore borrowed objects from alternate object store
    --incremental         ignore packed objects
    --window <n>          limit pack window by objects
    --window-memory <n>   limit pack window by memory in addition to object limit
    --depth <n>           maximum length of delta chain allowed in the resulting pack
    --reuse-delta         reuse existing deltas
    --reuse-object        reuse existing objects
    --delta-base-offset   use OFS_DELTA objects
    --threads <n>         use threads when searching for best delta matches
    --non-empty           do not create an empty pack output
    --revs                read revision arguments from standard input
    --unpacked            limit the objects to those that are not yet packed
    --all                 include objects reachable from any reference
    --reflog              include objects referred by reflog entries
    --indexed-objects     include objects referred to by the index
    --stdin-packs         read packs from stdin
    --stdout              output pack to stdout
    --include-tag         include tag objects that refer to objects to be packed
    --keep-unreachable    keep unreachable objects
    --pack-loose-unreachable
                          pack loose unreachable objects
    --unpack-unreachable[=<time>]
                          unpack unreachable objects newer than <time>
    --sparse              use the sparse reachability algorithm
    --thin                create thin packs
    --shallow             create packs suitable for shallow fetches
    --honor-pack-keep     ignore packs that have companion .keep file
    --keep-pack <name>    ignore this pack
    --compression <n>     pack compression level
    --keep-true-parents   do not hide commits by grafts
    --use-bitmap-index    use a bitmap index if available to speed up counting objects
    --write-bitmap-index  write a bitmap index together with the pack index
    --filter <args>       object filtering
    --missing <action>    handling for missing objects
    --exclude-promisor-objects
                          do not pack objects in promisor packfiles
    --delta-islands       respect islands during delta compression
    --uri-protocol <protocol>
                          exclude any configured uploadpack.blobpackfileuri with this protocol

ok 3 - pack-objects with bogus arguments

-- Brief whoami:
NonStop developer since approximately 211288444200000000
UNIX developer since approximately 421664400
-- In my real life, I talk too much.


