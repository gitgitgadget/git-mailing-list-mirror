From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH] pack-objects: don't use too many threads with few objects
Date: Mon, 15 Dec 2008 18:38:18 +0000
Message-ID: <e2b179460812151038y5a39b33cv1d7b41faf10563e@mail.gmail.com>
References: <alpine.LFD.2.00.0812111524370.14328@xanadu.home>
	 <20081213133238.GA6718@sigill.intra.peff.net>
	 <alpine.LFD.2.00.0812131456040.30035@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Dec 15 19:39:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCIM0-0007xo-9y
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 19:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbYLOSiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 13:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754062AbYLOSiV
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 13:38:21 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:27773 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbYLOSiU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 13:38:20 -0500
Received: by qw-out-2122.google.com with SMTP id 3so624602qwe.37
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 10:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=JzMsOm8JajGXUpIYYhKERuci3a0Zr7PvmBqXf05Sa28=;
        b=wH98VFHdIWVr5b6x802XgNJPzGF8ELGz0sOja7O/zoZsqH18/r9IEmF7qfCQrOyy/5
         RgWNxqiBWYvqrP5HQWmlmtdOHlrIgiZT4Q2q7ivQRhi07wlrMz0pLzGg5UlSKNhuOT2w
         OHUs+GtPEbv0woP4F/iPrI6UWM6o8J6zEydx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=n4o3tvzcZcXCIfLP6SWSy3vpMT7wudI2IVhEWuHghlJHqNhwlzRJacdN86xjej2LuO
         GRVp+WT3yD4fjCzVc7JY0Wc3IXqLbfTJ0/QH2N+2VLjjklsYV4ATbJEcfn/ZNAqP6Tos
         /y5RUPeVikQr7/I8R7KgtSvR5sCGT3fIbIU2g=
Received: by 10.215.100.13 with SMTP id c13mr8018416qam.353.1229366298931;
        Mon, 15 Dec 2008 10:38:18 -0800 (PST)
Received: by 10.214.150.9 with HTTP; Mon, 15 Dec 2008 10:38:18 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0812131456040.30035@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103195>

2008/12/13 Nicolas Pitre <nico@cam.org>
>
> If there are few objects to deltify, they might be split amongst threads
> so that there is simply no other objects left to delta against within
> the same thread.  Let's use the same 2*window treshold as used for the
> final load balancing to allow extra threads to be created.
>
> This fixes the benign t5300 test failure.

Even with this I'm seeing failures in t5302 which I think are probably
related to 43cc2b42

I was trying to bisect it (test runs take forever on this platform -
AIX 5.3) but I hit the t5300 failure, which I hadn't seen on the last
automatic build.

Please shout if I've snipped the vital lines (...)

Initialized empty Git repository in /usr/local/src/gitbuild/t/trash
directory.t5302-pack-index/.git/
* expecting success: rm -rf .git
     git init &&
     i=1 &&
     while test $i -le 100
     do
         iii=`printf %03i $i`
         test-genrandom "bar" 200 > wide_delta_$iii &&
         test-genrandom "baz $iii" 50 >> wide_delta_$iii &&
         test-genrandom "foo"$i 100 > deep_delta_$iii &&
         test-genrandom "foo"`expr $i + 1` 100 >> deep_delta_$iii &&
         test-genrandom "foo"`expr $i + 2` 100 >> deep_delta_$iii &&
         echo $iii >file_$iii &&
         test-genrandom "$iii" 8192 >>file_$iii &&
         git update-index --add file_$iii deep_delta_$iii wide_delta_$iii &&
         i=`expr $i + 1` || return 1
     done &&
     { echo 101 && test-genrandom 100 8192; } >file_101 &&
     git update-index --add file_101 &&
     tree=`git write-tree` &&
     commit=`git commit-tree $tree </dev/null` && {
	 echo $tree &&
	 git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
     } >obj-list &&
     git update-ref HEAD $commit
Initialized empty Git repository in /usr/local/src/gitbuild/t/trash
directory.t5302-pack-index/.git/
*   ok 1: setup

* expecting success: pack1=$(git pack-objects --index-version=1 test-1
<obj-list) &&
     git verify-pack -v "test-1-${pack1}.pack"
0106e17481932f5c223fafadc1d26abc6adf40d6 blob   57 90 850703 1
69e0b8ef8cda369575b6801c6ed47daf09aa3c62
...
fff3a3a92d2268a464dbdcd00fc055885ee3cba9 blob   8196 8210 187576
chain length = 1: 110 objects
chain length = 2: 11 objects
chain length = 3: 11 objects
chain length = 4: 10 objects
chain length = 5: 9 objects
chain length = 6: 9 objects
chain length = 7: 9 objects
chain length = 8: 9 objects
chain length = 9: 9 objects
test-1-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.pack: ok
*   ok 2: pack-objects with index version 1

* expecting success: pack2=$(git pack-objects --index-version=2 test-2
<obj-list) &&
     git verify-pack -v "test-2-${pack2}.pack"
0106e17481932f5c223fafadc1d26abc6adf40d6 blob   57 90 850531 1
69e0b8ef8cda369575b6801c6ed47daf09aa3c62
...
fff3a3a92d2268a464dbdcd00fc055885ee3cba9 blob   8196 8210 187404
chain length = 1: 109 objects
chain length = 2: 10 objects
chain length = 3: 10 objects
chain length = 4: 10 objects
chain length = 5: 10 objects
chain length = 6: 10 objects
chain length = 7: 10 objects
chain length = 8: 10 objects
chain length = 9: 9 objects
test-2-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.pack: ok
*   ok 3: pack-objects with index version 2

* expecting success: cmp "test-1-${pack1}.pack" "test-2-${pack2}.pack"
test-1-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.pack
test-2-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.pack differ: char
10236, line 32
* FAIL 4: both packs should be identical
	cmp "test-1-${pack1}.pack" "test-2-${pack2}.pack"

* expecting success: ! cmp "test-1-${pack1}.idx" "test-2-${pack2}.idx"
test-1-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.idx
test-2-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.idx differ: char 1,
line 1
*   ok 5: index v1 and index v2 should be different

* expecting success: git index-pack --index-version=1 -o 1.idx
"test-1-${pack1}.pack"
9108b6dfd43bf36ccbfc2839fe62d1503bf84292
*   ok 6: index-pack with index version 1

* expecting success: git index-pack --index-version=2 -o 2.idx
"test-1-${pack1}.pack"
9108b6dfd43bf36ccbfc2839fe62d1503bf84292
*   ok 7: index-pack with index version 2

* expecting success: cmp "test-1-${pack1}.idx" "1.idx" &&
     cmp "test-2-${pack2}.idx" "2.idx"
test-2-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.idx 2.idx differ: char
7273, line 23
* FAIL 8: index-pack results should match pack-objects ones
	cmp "test-1-${pack1}.idx" "1.idx" &&
	     cmp "test-2-${pack2}.idx" "2.idx"

* expecting success: pack3=$(git pack-objects
--index-version=2,0x40000 test-3 <obj-list)
*   ok 9: index v2: force some 64-bit offsets with pack-objects

* expecting success: git verify-pack -v "test-3-${pack3}.pack"
0106e17481932f5c223fafadc1d26abc6adf40d6 blob   57 90 850531 1
69e0b8ef8cda369575b6801c6ed47daf09aa3c62
...
fff3a3a92d2268a464dbdcd00fc055885ee3cba9 blob   8196 8210 187404
chain length = 1: 109 objects
chain length = 2: 10 objects
chain length = 3: 10 objects
chain length = 4: 10 objects
chain length = 5: 10 objects
chain length = 6: 10 objects
chain length = 7: 10 objects
chain length = 8: 10 objects
chain length = 9: 9 objects
test-3-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.pack: ok
*   ok 10: index v2: verify a pack with some 64-bit offsets

* expecting success: ! cmp "test-2-${pack2}.idx" "test-3-${pack3}.idx"
test-2-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.idx
test-3-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.idx differ: char 8281,
line 24
*   ok 11: 64-bit offsets: should be different from previous index v2 results

* expecting success: git index-pack --index-version=2,0x40000 -o 3.idx
"test-1-${pack1}.pack"
9108b6dfd43bf36ccbfc2839fe62d1503bf84292
*   ok 12: index v2: force some 64-bit offsets with index-pack

* expecting success: cmp "test-3-${pack3}.idx" "3.idx"
test-3-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.idx 3.idx differ: char
7273, line 23
* FAIL 13: 64-bit offsets: index-pack result should match pack-objects one
	cmp "test-3-${pack3}.idx" "3.idx"

* expecting success: git index-pack --index-version=1 --stdin <
"test-1-${pack1}.pack" &&
     git prune-packed &&
     git count-objects | ( read nr rest && test "$nr" -eq 1 ) &&
     cmp "test-1-${pack1}.pack" ".git/objects/pack/pack-${pack1}.pack" &&
     cmp "test-1-${pack1}.idx"  ".git/objects/pack/pack-${pack1}.idx"
pack	9108b6dfd43bf36ccbfc2839fe62d1503bf84292
Removing duplicate objects:  25% (65/256)
Removing duplicate objects:  26% (68/256)
Removing duplicate objects:  27% (71/256)
Removing duplicate objects:  28% (74/256)
Removing duplicate objects:  30% (79/256)
Removing duplicate objects:  31% (81/256)
Removing duplicate objects:  32% (83/256)
Removing duplicate objects:  33% (85/256)
Removing duplicate objects:  34% (88/256)
Removing duplicate objects:  35% (90/256)
Removing duplicate objects:  36% (93/256)
Removing duplicate objects:  37% (95/256)
Removing duplicate objects:  38% (98/256)
Removing duplicate objects:  39% (100/256)
Removing duplicate objects:  40% (103/256)
Removing duplicate objects:  41% (106/256)
Removing duplicate objects:  42% (108/256)
Removing duplicate objects:  43% (112/256)
Removing duplicate objects:  44% (114/256)
Removing duplicate objects:  45% (116/256)
Removing duplicate objects:  46% (118/256)
Removing duplicate objects:  47% (121/256)
Removing duplicate objects:  48% (124/256)
Removing duplicate objects:  50% (130/256)
Removing duplicate objects:  51% (132/256)
Removing duplicate objects:  52% (134/256)
Removing duplicate objects:  53% (136/256)
Removing duplicate objects:  54% (140/256)
Removing duplicate objects:  55% (141/256)
Removing duplicate objects:  56% (144/256)
Removing duplicate objects:  57% (146/256)
Removing duplicate objects:  57% (147/256)
Removing duplicate objects:  58% (149/256)
Removing duplicate objects:  60% (154/256)
Removing duplicate objects:  61% (157/256)
Removing duplicate objects:  62% (159/256)
Removing duplicate objects:  63% (163/256)
Removing duplicate objects:  64% (164/256)
Removing duplicate objects:  65% (167/256)
Removing duplicate objects:  66% (169/256)
Removing duplicate objects:  67% (172/256)
Removing duplicate objects:  68% (175/256)
Removing duplicate objects:  69% (177/256)
Removing duplicate objects:  70% (180/256)
Removing duplicate objects:  71% (182/256)
Removing duplicate objects:  72% (185/256)
Removing duplicate objects:  73% (187/256)
Removing duplicate objects:  74% (190/256)
Removing duplicate objects:  75% (192/256)
Removing duplicate objects:  76% (195/256)
Removing duplicate objects:  77% (198/256)
Removing duplicate objects:  78% (201/256)
Removing duplicate objects:  79% (204/256)
Removing duplicate objects:  80% (206/256)
Removing duplicate objects:  81% (208/256)
Removing duplicate objects:  82% (210/256)
Removing duplicate objects:  83% (215/256)
Removing duplicate objects:  84% (217/256)
Removing duplicate objects:  85% (218/256)
Removing duplicate objects:  86% (222/256)
Removing duplicate objects:  87% (223/256)
Removing duplicate objects:  88% (226/256)
Removing duplicate objects:  89% (228/256)
Removing duplicate objects:  90% (231/256)
Removing duplicate objects:  91% (233/256)
Removing duplicate objects:  92% (236/256)
Removing duplicate objects:  93% (240/256)
Removing duplicate objects:  94% (241/256)
Removing duplicate objects:  95% (245/256)
Removing duplicate objects:  96% (246/256)
Removing duplicate objects:  97% (249/256)
Removing duplicate objects:  98% (251/256)
Removing duplicate objects:  99% (254/256)
Removing duplicate objects: 100% (256/256)
Removing duplicate objects: 100% (256/256), done.
*   ok 14: [index v1] 1) stream pack to repository

* expecting success: # This test assumes file_101 is a delta smaller
than 16 bytes.
     # It should be against file_100 but we substitute its base for file_099
     sha1_101=`git hash-object file_101` &&
     sha1_099=`git hash-object file_099` &&
     offs_101=`index_obj_offset 1.idx $sha1_101` &&
     nr_099=`index_obj_nr 1.idx $sha1_099` &&
     chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
     dd of=".git/objects/pack/pack-${pack1}.pack" seek=$(($offs_101 + 1)) \
        if=".git/objects/pack/pack-${pack1}.idx" \
        skip=$((4 + 256 * 4 + $nr_099 * 24)) \
        bs=1 count=20 conv=notrunc &&
     git cat-file blob $sha1_101 > file_101_foo1
20+0 records in
20+0 records out
*   ok 15: [index v1] 2) create a stealth corruption in a delta base reference

* expecting success: test -f file_101_foo1 && ! cmp file_101 file_101_foo1
file_101 file_101_foo1 differ: char 5, line 2
*   ok 16: [index v1] 3) corrupted delta happily returned wrong data

* expecting success: test_must_fail git fsck --full $commit
error: .git/objects/pack/pack-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.pack
SHA1 checksum mismatch
error: packed 0b968294884af115eb5a1b941b3dabd48470c3bb from
.git/objects/pack/pack-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.pack
is corrupt
error: sha1 mismatch 0b968294884af115eb5a1b941b3dabd48470c3bb

error: 0b968294884af115eb5a1b941b3dabd48470c3bb: object corrupt or missing
*   ok 17: [index v1] 4) confirm that the pack is actually corrupted

* expecting success: pack4=$(git pack-objects test-4 <obj-list) &&
     test -f "test-4-${pack1}.pack"
*   ok 18: [index v1] 5) pack-objects happily reuses corrupted data

* expecting success: test_must_fail git verify-pack -v "test-4-${pack1}.pack"
error: packed 0b968294884af115eb5a1b941b3dabd48470c3bb from
test-4-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.pack is corrupt
test-4-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.pack: bad
*   ok 19: [index v1] 6) newly created pack is BAD !

* expecting success: rm -f .git/objects/pack/* &&
     git index-pack --index-version=2 --stdin < "test-1-${pack1}.pack" &&
     git prune-packed &&
     git count-objects | ( read nr rest && test "$nr" -eq 1 ) &&
     cmp "test-1-${pack1}.pack" ".git/objects/pack/pack-${pack1}.pack" &&
     cmp "test-2-${pack1}.idx"  ".git/objects/pack/pack-${pack1}.idx"
pack	9108b6dfd43bf36ccbfc2839fe62d1503bf84292
test-2-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.idx
.git/objects/pack/pack-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.idx
differ: char 7273, line 23
* FAIL 20: [index v2] 1) stream pack to repository
	rm -f .git/objects/pack/* &&
	     git index-pack --index-version=2 --stdin < "test-1-${pack1}.pack" &&
	     git prune-packed &&
	     git count-objects | ( read nr rest && test "$nr" -eq 1 ) &&
	     cmp "test-1-${pack1}.pack" ".git/objects/pack/pack-${pack1}.pack" &&
	     cmp "test-2-${pack1}.idx"  ".git/objects/pack/pack-${pack1}.idx"

* expecting success: # This test assumes file_101 is a delta smaller
than 16 bytes.
     # It should be against file_100 but we substitute its base for file_099
     sha1_101=`git hash-object file_101` &&
     sha1_099=`git hash-object file_099` &&
     offs_101=`index_obj_offset 1.idx $sha1_101` &&
     nr_099=`index_obj_nr 1.idx $sha1_099` &&
     chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
     dd of=".git/objects/pack/pack-${pack1}.pack" seek=$(($offs_101 + 1)) \
        if=".git/objects/pack/pack-${pack1}.idx" \
        skip=$((8 + 256 * 4 + $nr_099 * 20)) \
        bs=1 count=20 conv=notrunc &&
     git cat-file blob $sha1_101 > file_101_foo2
20+0 records in
20+0 records out
*   ok 21: [index v2] 2) create a stealth corruption in a delta base reference

* expecting success: test -f file_101_foo2 && ! cmp file_101 file_101_foo2
file_101 file_101_foo2 differ: char 5, line 2
*   ok 22: [index v2] 3) corrupted delta happily returned wrong data

* expecting success: test_must_fail git fsck --full $commit
error: .git/objects/pack/pack-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.pack
SHA1 checksum mismatch
error: index CRC mismatch for object
0b968294884af115eb5a1b941b3dabd48470c3bb from
.git/objects/pack/pack-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.pack
at offset 844376
error: packed 0b968294884af115eb5a1b941b3dabd48470c3bb from
.git/objects/pack/pack-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.pack
is corrupt
error: sha1 mismatch 0b968294884af115eb5a1b941b3dabd48470c3bb

error: 0b968294884af115eb5a1b941b3dabd48470c3bb: object corrupt or missing
*   ok 23: [index v2] 4) confirm that the pack is actually corrupted

* expecting success: test_must_fail git pack-objects test-5 <obj-list &&
     test_must_fail git pack-objects --no-reuse-object test-6 <obj-list
error: bad packed object CRC for 0b968294884af115eb5a1b941b3dabd48470c3bb
error: bad packed object CRC for 0b968294884af115eb5a1b941b3dabd48470c3bb
error: failed to read object 0b968294884af115eb5a1b941b3dabd48470c3bb
at offset 844376 from
.git/objects/pack/pack-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.pack
fatal: object 0b968294884af115eb5a1b941b3dabd48470c3bb is corrupted
error: bad packed object CRC for 0b968294884af115eb5a1b941b3dabd48470c3bb
error: failed to read object 0b968294884af115eb5a1b941b3dabd48470c3bb
at offset 844376 from
.git/objects/pack/pack-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.pack
fatal: object 0b968294884af115eb5a1b941b3dabd48470c3bb is corrupted
*   ok 24: [index v2] 5) pack-objects refuses to reuse corrupted data

* expecting success: rm -f .git/objects/pack/* &&
     git index-pack --index-version=2 --stdin < "test-1-${pack1}.pack" &&
     git verify-pack ".git/objects/pack/pack-${pack1}.pack" &&
     obj=`git hash-object file_001` &&
     nr=`index_obj_nr ".git/objects/pack/pack-${pack1}.idx" $obj` &&
     chmod +w ".git/objects/pack/pack-${pack1}.idx" &&
     dd if=/dev/zero of=".git/objects/pack/pack-${pack1}.idx" conv=notrunc \
        bs=1 count=4 seek=$((8 + 256 * 4 + `wc -l <obj-list` * 20 + $nr * 4)) &&
     ( while read obj
       do git cat-file -p $obj >/dev/null || exit 1
       done <obj-list ) &&
     err=$(test_must_fail git verify-pack \
       ".git/objects/pack/pack-${pack1}.pack" 2>&1) &&
     echo "$err" | grep "CRC mismatch"
pack	9108b6dfd43bf36ccbfc2839fe62d1503bf84292
4+0 records in
4+0 records out
error: index CRC mismatch for object
1297547aab30f952af805d38f6f1c1930cb3117b from
.git/objects/pack/pack-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.pack
at offset 23376
*   ok 25: [index v2] 6) verify-pack detects CRC mismatch

* expecting success:
    rm -f .git/objects/pack/* &&
    cp test-1-${pack1}.pack .git/objects/pack/pack-${pack1}.pack &&
    (
	cd .git/objects/pack
	git index-pack pack-${pack1}.pack
    ) &&
    test -f .git/objects/pack/pack-${pack1}.idx

9108b6dfd43bf36ccbfc2839fe62d1503bf84292
*   ok 26: running index-pack in the object store

* failed 4 among 26 test(s)
