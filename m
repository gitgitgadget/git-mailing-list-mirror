From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] autodetect number of CPUs by default when using threads
Date: Sat, 13 Dec 2008 08:32:39 -0500
Message-ID: <20081213133238.GA6718@sigill.intra.peff.net>
References: <alpine.LFD.2.00.0812111524370.14328@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Dec 13 14:34:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBUd7-0000rt-R2
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 14:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755398AbYLMNco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 08:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754226AbYLMNco
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 08:32:44 -0500
Received: from peff.net ([208.65.91.99]:3784 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752601AbYLMNcm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 08:32:42 -0500
Received: (qmail 21462 invoked by uid 111); 13 Dec 2008 13:32:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 13 Dec 2008 08:32:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Dec 2008 08:32:39 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0812111524370.14328@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102999>

On Thu, Dec 11, 2008 at 03:36:47PM -0500, Nicolas Pitre wrote:

> ... and display the actual number of threads used when locally 
> repacking.  A remote server still won't tell you how many threads it 
> uses during a fetch though.

Hrm. I have no idea how, but this patch reliably causes t5300 to fail on
my FreeBSD test box ("next" is broken, bisection pointed to 43cc2b42).
Sample verbose output is below.

-- >8 --
Initialized empty Git repository in /home/peff/compile/gitbuild/jk/freebsd/project/t/trash directory.t5300-pack-object/.git/
* expecting success: rm -f .git/index*
     for i in a b c
     do
	     dd if=/dev/zero bs=4k count=1 | perl -pe "y/\\000/$i/" >$i &&
	     git update-index --add $i || return 1
     done &&
     cat c >d && echo foo >>d && git update-index --add d &&
     tree=`git write-tree` &&
     commit=`git commit-tree $tree </dev/null` && {
	 echo $tree &&
	 echo $commit &&
	 git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
     } >obj-list && {
	 git diff-tree --root -p $commit &&
	 while read object
	 do
	    t=`git cat-file -t $object` &&
	    git cat-file $t $object || return 1
	 done <obj-list
     } >expect
1+0 records in
1+0 records out
4096 bytes transferred in 0.000059 secs (69273666 bytes/sec)
1+0 records in
1+0 records out
4096 bytes transferred in 0.000053 secs (77386798 bytes/sec)
1+0 records in
1+0 records out
4096 bytes transferred in 0.000055 secs (74695083 bytes/sec)
*   ok 1: setup

* expecting success: packname_1=$(git pack-objects --window=0 test-1 <obj-list)
*   ok 2: pack without delta

* expecting success: GIT_OBJECT_DIRECTORY=.git2/objects &&
     export GIT_OBJECT_DIRECTORY &&
     git init &&
     git unpack-objects -n <test-1-20f53d0edce6980dfa341c034ae365aef2616e8d.pack &&
     git unpack-objects <test-1-20f53d0edce6980dfa341c034ae365aef2616e8d.pack
Reinitialized existing Git repository in /home/peff/compile/gitbuild/jk/freebsd/project/t/trash directory.t5300-pack-object/.git/
*   ok 3: unpack without delta

* expecting success: (cd ../.git && find objects -type f -print) |
     while read path
     do
         cmp $path ../.git/$path || {
	     echo $path differs.
	     return 1
	 }
     done
*   ok 4: check unpack without delta

* expecting success: pwd &&
     packname_2=$(git pack-objects test-2 <obj-list)
/home/peff/compile/gitbuild/jk/freebsd/project/t/trash directory.t5300-pack-object
*   ok 5: pack with REF_DELTA

* expecting success: GIT_OBJECT_DIRECTORY=.git2/objects &&
     export GIT_OBJECT_DIRECTORY &&
     git init &&
     git unpack-objects -n <test-2-${packname_2}.pack &&
     git unpack-objects <test-2-${packname_2}.pack
Reinitialized existing Git repository in /home/peff/compile/gitbuild/jk/freebsd/project/t/trash directory.t5300-pack-object/.git/
*   ok 6: unpack with REF_DELTA

* expecting success: (cd ../.git && find objects -type f -print) |
     while read path
     do
         cmp $path ../.git/$path || {
	     echo $path differs.
	     return 1
	 }
     done
*   ok 7: check unpack with REF_DELTA

* expecting success: pwd &&
     packname_3=$(git pack-objects --delta-base-offset test-3 <obj-list)
/home/peff/compile/gitbuild/jk/freebsd/project/t/trash directory.t5300-pack-object
*   ok 8: pack with OFS_DELTA

* expecting success: GIT_OBJECT_DIRECTORY=.git2/objects &&
     export GIT_OBJECT_DIRECTORY &&
     git init &&
     git unpack-objects -n <test-3-${packname_3}.pack &&
     git unpack-objects <test-3-${packname_3}.pack
Reinitialized existing Git repository in /home/peff/compile/gitbuild/jk/freebsd/project/t/trash directory.t5300-pack-object/.git/
*   ok 9: unpack with OFS_DELTA

* expecting success: (cd ../.git && find objects -type f -print) |
     while read path
     do
         cmp $path ../.git/$path || {
	     echo $path differs.
	     return 1
	 }
     done
*   ok 10: check unpack with OFS_DELTA

* expecting success: 
	perl -e '
		defined($_ = -s $_) or die for @ARGV;
		exit 1 if $ARGV[0] <= $ARGV[1];
	' test-2-$packname_2.pack test-3-$packname_3.pack

* FAIL 11: compare delta flavors
	
		perl -e '
			defined($_ = -s $_) or die for @ARGV;
			exit 1 if $ARGV[0] <= $ARGV[1];
		' test-2-$packname_2.pack test-3-$packname_3.pack
	

* expecting success: GIT_OBJECT_DIRECTORY=.git2/objects &&
     export GIT_OBJECT_DIRECTORY &&
     git init &&
     cp test-1-${packname_1}.pack test-1-${packname_1}.idx .git2/objects/pack && {
	 git diff-tree --root -p $commit &&
	 while read object
	 do
	    t=`git cat-file -t $object` &&
	    git cat-file $t $object || return 1
	 done <obj-list
    } >current &&
    diff expect current
Reinitialized existing Git repository in /home/peff/compile/gitbuild/jk/freebsd/project/t/trash directory.t5300-pack-object/.git/
*   ok 12: use packed objects

* expecting success: GIT_OBJECT_DIRECTORY=.git2/objects &&
     export GIT_OBJECT_DIRECTORY &&
     rm -f .git2/objects/pack/test-* &&
     cp test-2-${packname_2}.pack test-2-${packname_2}.idx .git2/objects/pack && {
	 git diff-tree --root -p $commit &&
	 while read object
	 do
	    t=`git cat-file -t $object` &&
	    git cat-file $t $object || return 1
	 done <obj-list
    } >current &&
    diff expect current
*   ok 13: use packed deltified (REF_DELTA) objects

* expecting success: GIT_OBJECT_DIRECTORY=.git2/objects &&
     export GIT_OBJECT_DIRECTORY &&
     rm -f .git2/objects/pack/test-* &&
     cp test-3-${packname_3}.pack test-3-${packname_3}.idx .git2/objects/pack && {
	 git diff-tree --root -p $commit &&
	 while read object
	 do
	    t=`git cat-file -t $object` &&
	    git cat-file $t $object || return 1
	 done <obj-list
    } >current &&
    diff expect current
*   ok 14: use packed deltified (OFS_DELTA) objects

* expecting success: git verify-pack	test-1-${packname_1}.idx \
			test-2-${packname_2}.idx \
			test-3-${packname_3}.idx
*   ok 15: verify pack

* expecting success: git verify-pack -v	test-1-${packname_1}.idx \
			test-2-${packname_2}.idx \
			test-3-${packname_3}.idx
0be779221aca65277fd447c8207e1b3c2706ae20 blob   4096 31 311
2f22df7b2a002e7e84bd7c124483f0df7f7bc1ef commit 163 121 128
890b180ae96f7abd6a1917dee506bceb188003b6 tree   116 116 12
9d235ed07cd19811a6ceb342de82f190e49c9f68 blob   4096 31 249
b010fe5253f7dc59c6605dacb92fcea00d199d4e blob   4100 36 342
c82de19312b6c3695c0c18f70709a6c535682a67 blob   4096 31 280
test-1-20f53d0edce6980dfa341c034ae365aef2616e8d.pack: ok
0be779221aca65277fd447c8207e1b3c2706ae20 blob   4096 31 311
2f22df7b2a002e7e84bd7c124483f0df7f7bc1ef commit 163 121 128
890b180ae96f7abd6a1917dee506bceb188003b6 tree   116 116 12
9d235ed07cd19811a6ceb342de82f190e49c9f68 blob   4096 31 249
b010fe5253f7dc59c6605dacb92fcea00d199d4e blob   4100 36 342
c82de19312b6c3695c0c18f70709a6c535682a67 blob   4096 31 280
test-2-20f53d0edce6980dfa341c034ae365aef2616e8d.pack: ok
0be779221aca65277fd447c8207e1b3c2706ae20 blob   4096 31 311
2f22df7b2a002e7e84bd7c124483f0df7f7bc1ef commit 163 121 128
890b180ae96f7abd6a1917dee506bceb188003b6 tree   116 116 12
9d235ed07cd19811a6ceb342de82f190e49c9f68 blob   4096 31 249
b010fe5253f7dc59c6605dacb92fcea00d199d4e blob   4100 36 342
c82de19312b6c3695c0c18f70709a6c535682a67 blob   4096 31 280
test-3-20f53d0edce6980dfa341c034ae365aef2616e8d.pack: ok
*   ok 16: verify pack -v

* expecting success: cat test-1-${packname_1}.idx >test-3.idx &&
     cat test-2-${packname_2}.pack >test-3.pack &&
     if git verify-pack test-3.idx
     then false
     else :;
     fi
* FAIL 17: verify-pack catches mismatched .idx and .pack files
	cat test-1-${packname_1}.idx >test-3.idx &&
	     cat test-2-${packname_2}.pack >test-3.pack &&
	     if git verify-pack test-3.idx
	     then false
	     else :;
	     fi

* expecting success: cat test-1-${packname_1}.pack >test-3.pack &&
     dd if=/dev/zero of=test-3.pack count=1 bs=1 conv=notrunc seek=2 &&
     if git verify-pack test-3.idx
     then false
     else :;
     fi
1+0 records in
1+0 records out
1 bytes transferred in 0.000042 secs (23831 bytes/sec)
error: file test-3.pack is not a GIT packfile
fatal: packfile test-3.pack cannot be accessed
*   ok 18: verify-pack catches a corrupted pack signature

* expecting success: cat test-1-${packname_1}.pack >test-3.pack &&
     dd if=/dev/zero of=test-3.pack count=1 bs=1 conv=notrunc seek=7 &&
     if git verify-pack test-3.idx
     then false
     else :;
     fi
1+0 records in
1+0 records out
1 bytes transferred in 0.000042 secs (23831 bytes/sec)
error: packfile test-3.pack is version 0 and not supported (try upgrading GIT to a newer version)
fatal: packfile test-3.pack cannot be accessed
*   ok 19: verify-pack catches a corrupted pack version

* expecting success: cat test-1-${packname_1}.pack >test-3.pack &&
     dd if=/dev/zero of=test-3.pack count=1 bs=1 conv=notrunc seek=12 &&
     if git verify-pack test-3.idx
     then false
     else :;
     fi
1+0 records in
1+0 records out
1 bytes transferred in 0.000046 secs (21732 bytes/sec)
error: test-3.pack SHA1 checksum mismatch
error: index CRC mismatch for object 890b180ae96f7abd6a1917dee506bceb188003b6 from test-3.pack at offset 12
error: unknown object type 0 at offset 12 in test-3.pack
error: cannot unpack 890b180ae96f7abd6a1917dee506bceb188003b6 from test-3.pack at offset 12
*   ok 20: verify-pack catches a corrupted type/size of the 1st packed object data

* expecting success: l=`wc -c <test-3.idx` &&
     l=`expr $l - 20` &&
     cat test-1-${packname_1}.pack >test-3.pack &&
     dd if=/dev/zero of=test-3.idx count=20 bs=1 conv=notrunc seek=$l &&
     if git verify-pack test-3.pack
     then false
     else :;
     fi
20+0 records in
20+0 records out
20 bytes transferred in 0.000123 secs (162570 bytes/sec)
error: Packfile index for test-3.pack SHA1 mismatch
*   ok 21: verify-pack catches a corrupted sum of the index file itself

* expecting success: cat test-1-${packname_1}.pack >test-3.pack &&
     git index-pack -o tmp.idx test-3.pack &&
     cmp tmp.idx test-1-${packname_1}.idx &&

     git index-pack test-3.pack &&
     cmp test-3.idx test-1-${packname_1}.idx &&

     cat test-2-${packname_2}.pack >test-3.pack &&
     git index-pack -o tmp.idx test-2-${packname_2}.pack &&
     cmp tmp.idx test-2-${packname_2}.idx &&

     git index-pack test-3.pack &&
     cmp test-3.idx test-2-${packname_2}.idx &&

     cat test-3-${packname_3}.pack >test-3.pack &&
     git index-pack -o tmp.idx test-3-${packname_3}.pack &&
     cmp tmp.idx test-3-${packname_3}.idx &&

     git index-pack test-3.pack &&
     cmp test-3.idx test-3-${packname_3}.idx &&

     :
20f53d0edce6980dfa341c034ae365aef2616e8d
20f53d0edce6980dfa341c034ae365aef2616e8d
20f53d0edce6980dfa341c034ae365aef2616e8d
20f53d0edce6980dfa341c034ae365aef2616e8d
20f53d0edce6980dfa341c034ae365aef2616e8d
20f53d0edce6980dfa341c034ae365aef2616e8d
*   ok 22: build pack index for an existing pack

* expecting success: test -f	.git/objects/c8/2de19312b6c3695c0c18f70709a6c535682a67 &&
     cp -f	.git/objects/9d/235ed07cd19811a6ceb342de82f190e49c9f68 \
		.git/objects/c8/2de19312b6c3695c0c18f70709a6c535682a67
*   ok 23: fake a SHA1 hash collision

* expecting success: test_must_fail git index-pack -o bad.idx test-3.pack 2>msg &&
     grep "SHA1 COLLISION FOUND" msg
fatal: SHA1 COLLISION FOUND WITH c82de19312b6c3695c0c18f70709a6c535682a67 !
*   ok 24: make sure index-pack detects the SHA1 collision

* expecting success: git config pack.packSizeLimit 200 &&
     packname_4=$(git pack-objects test-4 <obj-list) &&
     test 3 = $(ls test-4-*.pack | wc -l)
*   ok 25: honor pack.packSizeLimit

* expecting success: 

	git config --unset pack.packsizelimit &&
	for j in a b c d e f g
	do
		for i in 0 1 2 3 4 5 6 7 8 9
		do
			o=$(echo $j$i | git hash-object -w --stdin) &&
			echo "100644 $o	0 $j$i"
		done
	done >LIST &&
	rm -f .git/index &&
	git update-index --index-info <LIST &&
	LIST=$(git write-tree) &&
	rm -f .git/index &&
	head -n 10 LIST | git update-index --index-info &&
	LI=$(git write-tree) &&
	rm -f .git/index &&
	tail -n 10 LIST | git update-index --index-info &&
	ST=$(git write-tree) &&
	PACK5=$( git rev-list --objects "$LIST" "$LI" "$ST" | \
		git pack-objects test-5 ) &&
	PACK6=$( (
			echo "$LIST"
			echo "$LI"
			echo "$ST"
		 ) | git pack-objects test-6 ) &&
	test_create_repo test-5 &&
	(
		cd test-5 &&
		git unpack-objects --strict <../test-5-$PACK5.pack &&
		git ls-tree -r $LIST &&
		git ls-tree -r $LI &&
		git ls-tree -r $ST
	) &&
	test_create_repo test-6 &&
	(
		# tree-only into empty repo -- many unreachables
		cd test-6 &&
		test_must_fail git unpack-objects --strict <../test-6-$PACK6.pack
	) &&
	(
		# already populated -- no unreachables
		cd test-5 &&
		git unpack-objects --strict <../test-6-$PACK6.pack
	)

Initialized empty Git repository in /home/peff/compile/gitbuild/jk/freebsd/project/t/trash directory.t5300-pack-object/test-5/.git/
100644 blob 0042f6c56d8fc1896f3efc2cdc5060e5b5e44e02	0 a0
100644 blob da0f8ed91a8f2f0f067b3bdf26265d5ca48cf82c	0 a1
100644 blob c1827f07e114c20547dc6a7296588870a4b5b62c	0 a2
100644 blob d616f7380ad325123fed6f628d02fa76e1ce77c3	0 a3
100644 blob 88ba23dca8c8529f8165539c369925a99391a4d1	0 a4
100644 blob fafec68b313bde633804c37b46810f136ee12ea6	0 a5
100644 blob 5b521d0587015867ac1a23fa00be3f3fce080b9f	0 a6
100644 blob 6bac181dd20780870c30d69308f5a90b59a15102	0 a7
100644 blob f1914bb68f8515ba7d1ab0f0cddcdf960731773d	0 a8
100644 blob dbe2bc1151e5d5d469644f20189f923f006ed0cc	0 a9
100644 blob 2270a80fbb71d7109b85e7489f3f307d0141a559	0 b0
100644 blob c9c6af7f78bc47490dbf3e822cf2f3c24d4b9061	0 b1
100644 blob e6bfff5c1d0f0ecd501552b43a1e13d8008abc31	0 b2
100644 blob 6d0875c82a99774922eab07fbc08510fc85d9e0a	0 b3
100644 blob 8e953e84d803f13fd06416a1bd8161dcd93cfd00	0 b4
100644 blob 90a5159bf020296276ea5ca1bcd292a9b1de9947	0 b5
100644 blob 07eb61d36f49569a2b0649af299f9f00013d0969	0 b6
100644 blob 6e6d33cfc7b1581413a88ae0759202b25ac4cad1	0 b7
100644 blob 5d453c66b522d8de5d99c03bd2bf8b65ca0bcf33	0 b8
100644 blob 9a16e0d1a643983973291127012d2694a0b17fe8	0 b9
100644 blob caecf05cdbb03e144f113ecab2b99e5ee74df706	0 c0
100644 blob ae9304576a6ec3419b231b2b9c8e33a06f97f9fb	0 c1
100644 blob 16f9ec009e5568c435f473ba3a1df732d49ce8c3	0 c2
100644 blob 0771aea884dd394a7b12783d049f05b5599f41a4	0 c3
100644 blob a103f673dd1b7c5727aa0ae0100419adc50e1b76	0 c4
100644 blob c36357109ce20af8f90df3c0dd0784e89408d707	0 c5
100644 blob 86a716504cbdc40a135faa5ab199d15e364c416d	0 c6
100644 blob 20be68787e59f4cb8983b641d170c4baf8ea25dd	0 c7
100644 blob bb420bc8fb9e91530fdc25e363f6b822d5195309	0 c8
100644 blob f899bd1761a5ca5978799bc3189a04d3c52d8435	0 c9
100644 blob 79a5e858be4a3a969e3b71406fef0d3d36e1d387	0 d0
100644 blob 6f1852975b9306ae5d8dfdf0d4cb1f5cb36ac229	0 d1
100644 blob fd3671590780b645e1bef030d550191f6cdf1c95	0 d2
100644 blob 69c77a9ea746edd27b46107142fc2c5288c1daf5	0 d3
100644 blob d7b30ee07d4b9819a77a3b122282b4c04528ec21	0 d4
100644 blob fa590f3f8bfbef6095cf6525e8497b2b2b46445c	0 d5
100644 blob fef4390d19cb98fa97efd44c09d4e2eb7b084b40	0 d6
100644 blob a5adf29249757619b8890c86f2cfcfeee611b5d8	0 d7
100644 blob 1859919d049c078ba63fcecbce60e697c6da8e01	0 d8
100644 blob b6148c82443a60d1d5ce07872a85e3c544b5f4b0	0 d9
100644 blob 4fe4106b50b257f3d6ffd23b750d2d1945c2608b	0 e0
100644 blob 5ff91639494693b1f238b5dc9baf8be95142c3ab	0 e1
100644 blob 3811af3ca744c2fb44077a8025c23b4d4166a449	0 e2
100644 blob 9338c3fa1f74d202651154257572d32aed57cc16	0 e3
100644 blob c5195815f83aa9ef1ebac9e11f14d62b26406c99	0 e4
100644 blob 0c44c89ef9c29077cceebc6dd9ca0b3a950c95ee	0 e5
100644 blob f17172bc54cfa55a9e531cc845dff39855cd8df0	0 e6
100644 blob 29870e9ccff84f86938ee588a47b39cf3a802e6b	0 e7
100644 blob e8d01d007452cede5c6eafc3343fc80675b1e2f9	0 e8
100644 blob 0c1945ad576ffc445ad69a3fafd1d3c04cc0bd40	0 e9
100644 blob 844dc808a1d3d769ddcf5430eac933d4d87ff606	0 f0
100644 blob 8e1e71d5ce34c01b6fe83bc5051545f2918c8c2b	0 f1
100644 blob 9de77c18733ab8009a956c25e28c85fe203a17d7	0 f2
100644 blob 45d9e0e9fc8859787c33081dffdf12f41b54fcf3	0 f3
100644 blob c48ac4847d3abae8e5899dcc5cf490a98df55755	0 f4
100644 blob 14c61ecf25961ce674048103c5fa5ea3c535a5cd	0 f5
100644 blob 59ce90029dfd9e224701a040a26153e9f2feb74c	0 f6
100644 blob 0a7bd52ffb819609cf65f40eb91be62000db47e5	0 f7
100644 blob c7e617f6b429a1f3b462df6add2b4ea2cf702faf	0 f8
100644 blob a720d8c8d277ad31ee5b180bef57379b5f62517c	0 f9
100644 blob 2e7d2f0b106eb8823e449a020497e26b86dc3eb1	0 g0
100644 blob d8a17fff13638d804e8bf7f9f357c174db98f126	0 g1
100644 blob 247c4abd244a429297a4c4b091592ae13bbf4677	0 g2
100644 blob affaa5ba8c43cfc71469226e0d57cb6823c843da	0 g3
100644 blob 51bc00f93e60aeef7dccfcf646e3f615056112bd	0 g4
100644 blob 02b4fdd23d495769852f1550c10eb015f0fe0039	0 g5
100644 blob e65aa9d64b596da2ba61e0662b1173f1e16dcbcf	0 g6
100644 blob e19089689a05907b359f52c972ee7d2294fa96ab	0 g7
100644 blob 30c2af9542d38e1f248390632612e0fb944fd27d	0 g8
100644 blob 09827d7e43d81089e868e9f0f06502b865939c05	0 g9
100644 blob 0042f6c56d8fc1896f3efc2cdc5060e5b5e44e02	0 a0
100644 blob da0f8ed91a8f2f0f067b3bdf26265d5ca48cf82c	0 a1
100644 blob c1827f07e114c20547dc6a7296588870a4b5b62c	0 a2
100644 blob d616f7380ad325123fed6f628d02fa76e1ce77c3	0 a3
100644 blob 88ba23dca8c8529f8165539c369925a99391a4d1	0 a4
100644 blob fafec68b313bde633804c37b46810f136ee12ea6	0 a5
100644 blob 5b521d0587015867ac1a23fa00be3f3fce080b9f	0 a6
100644 blob 6bac181dd20780870c30d69308f5a90b59a15102	0 a7
100644 blob f1914bb68f8515ba7d1ab0f0cddcdf960731773d	0 a8
100644 blob dbe2bc1151e5d5d469644f20189f923f006ed0cc	0 a9
100644 blob 2e7d2f0b106eb8823e449a020497e26b86dc3eb1	0 g0
100644 blob d8a17fff13638d804e8bf7f9f357c174db98f126	0 g1
100644 blob 247c4abd244a429297a4c4b091592ae13bbf4677	0 g2
100644 blob affaa5ba8c43cfc71469226e0d57cb6823c843da	0 g3
100644 blob 51bc00f93e60aeef7dccfcf646e3f615056112bd	0 g4
100644 blob 02b4fdd23d495769852f1550c10eb015f0fe0039	0 g5
100644 blob e65aa9d64b596da2ba61e0662b1173f1e16dcbcf	0 g6
100644 blob e19089689a05907b359f52c972ee7d2294fa96ab	0 g7
100644 blob 30c2af9542d38e1f248390632612e0fb944fd27d	0 g8
100644 blob 09827d7e43d81089e868e9f0f06502b865939c05	0 g9
Initialized empty Git repository in /home/peff/compile/gitbuild/jk/freebsd/project/t/trash directory.t5300-pack-object/test-6/.git/
error: unable to find 0042f6c56d8fc1896f3efc2cdc5060e5b5e44e02
fatal: object of unexpected type
*   ok 26: unpacking with --strict

* expecting success: 

	for j in a b c d e f g
	do
		for i in 0 1 2 3 4 5 6 7 8 9
		do
			o=$(echo $j$i | git hash-object -w --stdin) &&
			echo "100644 $o	0 $j$i"
		done
	done >LIST &&
	rm -f .git/index &&
	git update-index --index-info <LIST &&
	LIST=$(git write-tree) &&
	rm -f .git/index &&
	head -n 10 LIST | git update-index --index-info &&
	LI=$(git write-tree) &&
	rm -f .git/index &&
	tail -n 10 LIST | git update-index --index-info &&
	ST=$(git write-tree) &&
	PACK5=$( git rev-list --objects "$LIST" "$LI" "$ST" | \
		git pack-objects test-5 ) &&
	PACK6=$( (
			echo "$LIST"
			echo "$LI"
			echo "$ST"
		 ) | git pack-objects test-6 ) &&
	test_create_repo test-7 &&
	(
		cd test-7 &&
		git index-pack --strict --stdin <../test-5-$PACK5.pack &&
		git ls-tree -r $LIST &&
		git ls-tree -r $LI &&
		git ls-tree -r $ST
	) &&
	test_create_repo test-8 &&
	(
		# tree-only into empty repo -- many unreachables
		cd test-8 &&
		test_must_fail git index-pack --strict --stdin <../test-6-$PACK6.pack
	) &&
	(
		# already populated -- no unreachables
		cd test-7 &&
		git index-pack --strict --stdin <../test-6-$PACK6.pack
	)

Initialized empty Git repository in /home/peff/compile/gitbuild/jk/freebsd/project/t/trash directory.t5300-pack-object/test-7/.git/
pack	df7e2e394127cb487b2a6904a9a3fa45be4d4199
100644 blob 0042f6c56d8fc1896f3efc2cdc5060e5b5e44e02	0 a0
100644 blob da0f8ed91a8f2f0f067b3bdf26265d5ca48cf82c	0 a1
100644 blob c1827f07e114c20547dc6a7296588870a4b5b62c	0 a2
100644 blob d616f7380ad325123fed6f628d02fa76e1ce77c3	0 a3
100644 blob 88ba23dca8c8529f8165539c369925a99391a4d1	0 a4
100644 blob fafec68b313bde633804c37b46810f136ee12ea6	0 a5
100644 blob 5b521d0587015867ac1a23fa00be3f3fce080b9f	0 a6
100644 blob 6bac181dd20780870c30d69308f5a90b59a15102	0 a7
100644 blob f1914bb68f8515ba7d1ab0f0cddcdf960731773d	0 a8
100644 blob dbe2bc1151e5d5d469644f20189f923f006ed0cc	0 a9
100644 blob 2270a80fbb71d7109b85e7489f3f307d0141a559	0 b0
100644 blob c9c6af7f78bc47490dbf3e822cf2f3c24d4b9061	0 b1
100644 blob e6bfff5c1d0f0ecd501552b43a1e13d8008abc31	0 b2
100644 blob 6d0875c82a99774922eab07fbc08510fc85d9e0a	0 b3
100644 blob 8e953e84d803f13fd06416a1bd8161dcd93cfd00	0 b4
100644 blob 90a5159bf020296276ea5ca1bcd292a9b1de9947	0 b5
100644 blob 07eb61d36f49569a2b0649af299f9f00013d0969	0 b6
100644 blob 6e6d33cfc7b1581413a88ae0759202b25ac4cad1	0 b7
100644 blob 5d453c66b522d8de5d99c03bd2bf8b65ca0bcf33	0 b8
100644 blob 9a16e0d1a643983973291127012d2694a0b17fe8	0 b9
100644 blob caecf05cdbb03e144f113ecab2b99e5ee74df706	0 c0
100644 blob ae9304576a6ec3419b231b2b9c8e33a06f97f9fb	0 c1
100644 blob 16f9ec009e5568c435f473ba3a1df732d49ce8c3	0 c2
100644 blob 0771aea884dd394a7b12783d049f05b5599f41a4	0 c3
100644 blob a103f673dd1b7c5727aa0ae0100419adc50e1b76	0 c4
100644 blob c36357109ce20af8f90df3c0dd0784e89408d707	0 c5
100644 blob 86a716504cbdc40a135faa5ab199d15e364c416d	0 c6
100644 blob 20be68787e59f4cb8983b641d170c4baf8ea25dd	0 c7
100644 blob bb420bc8fb9e91530fdc25e363f6b822d5195309	0 c8
100644 blob f899bd1761a5ca5978799bc3189a04d3c52d8435	0 c9
100644 blob 79a5e858be4a3a969e3b71406fef0d3d36e1d387	0 d0
100644 blob 6f1852975b9306ae5d8dfdf0d4cb1f5cb36ac229	0 d1
100644 blob fd3671590780b645e1bef030d550191f6cdf1c95	0 d2
100644 blob 69c77a9ea746edd27b46107142fc2c5288c1daf5	0 d3
100644 blob d7b30ee07d4b9819a77a3b122282b4c04528ec21	0 d4
100644 blob fa590f3f8bfbef6095cf6525e8497b2b2b46445c	0 d5
100644 blob fef4390d19cb98fa97efd44c09d4e2eb7b084b40	0 d6
100644 blob a5adf29249757619b8890c86f2cfcfeee611b5d8	0 d7
100644 blob 1859919d049c078ba63fcecbce60e697c6da8e01	0 d8
100644 blob b6148c82443a60d1d5ce07872a85e3c544b5f4b0	0 d9
100644 blob 4fe4106b50b257f3d6ffd23b750d2d1945c2608b	0 e0
100644 blob 5ff91639494693b1f238b5dc9baf8be95142c3ab	0 e1
100644 blob 3811af3ca744c2fb44077a8025c23b4d4166a449	0 e2
100644 blob 9338c3fa1f74d202651154257572d32aed57cc16	0 e3
100644 blob c5195815f83aa9ef1ebac9e11f14d62b26406c99	0 e4
100644 blob 0c44c89ef9c29077cceebc6dd9ca0b3a950c95ee	0 e5
100644 blob f17172bc54cfa55a9e531cc845dff39855cd8df0	0 e6
100644 blob 29870e9ccff84f86938ee588a47b39cf3a802e6b	0 e7
100644 blob e8d01d007452cede5c6eafc3343fc80675b1e2f9	0 e8
100644 blob 0c1945ad576ffc445ad69a3fafd1d3c04cc0bd40	0 e9
100644 blob 844dc808a1d3d769ddcf5430eac933d4d87ff606	0 f0
100644 blob 8e1e71d5ce34c01b6fe83bc5051545f2918c8c2b	0 f1
100644 blob 9de77c18733ab8009a956c25e28c85fe203a17d7	0 f2
100644 blob 45d9e0e9fc8859787c33081dffdf12f41b54fcf3	0 f3
100644 blob c48ac4847d3abae8e5899dcc5cf490a98df55755	0 f4
100644 blob 14c61ecf25961ce674048103c5fa5ea3c535a5cd	0 f5
100644 blob 59ce90029dfd9e224701a040a26153e9f2feb74c	0 f6
100644 blob 0a7bd52ffb819609cf65f40eb91be62000db47e5	0 f7
100644 blob c7e617f6b429a1f3b462df6add2b4ea2cf702faf	0 f8
100644 blob a720d8c8d277ad31ee5b180bef57379b5f62517c	0 f9
100644 blob 2e7d2f0b106eb8823e449a020497e26b86dc3eb1	0 g0
100644 blob d8a17fff13638d804e8bf7f9f357c174db98f126	0 g1
100644 blob 247c4abd244a429297a4c4b091592ae13bbf4677	0 g2
100644 blob affaa5ba8c43cfc71469226e0d57cb6823c843da	0 g3
100644 blob 51bc00f93e60aeef7dccfcf646e3f615056112bd	0 g4
100644 blob 02b4fdd23d495769852f1550c10eb015f0fe0039	0 g5
100644 blob e65aa9d64b596da2ba61e0662b1173f1e16dcbcf	0 g6
100644 blob e19089689a05907b359f52c972ee7d2294fa96ab	0 g7
100644 blob 30c2af9542d38e1f248390632612e0fb944fd27d	0 g8
100644 blob 09827d7e43d81089e868e9f0f06502b865939c05	0 g9
100644 blob 0042f6c56d8fc1896f3efc2cdc5060e5b5e44e02	0 a0
100644 blob da0f8ed91a8f2f0f067b3bdf26265d5ca48cf82c	0 a1
100644 blob c1827f07e114c20547dc6a7296588870a4b5b62c	0 a2
100644 blob d616f7380ad325123fed6f628d02fa76e1ce77c3	0 a3
100644 blob 88ba23dca8c8529f8165539c369925a99391a4d1	0 a4
100644 blob fafec68b313bde633804c37b46810f136ee12ea6	0 a5
100644 blob 5b521d0587015867ac1a23fa00be3f3fce080b9f	0 a6
100644 blob 6bac181dd20780870c30d69308f5a90b59a15102	0 a7
100644 blob f1914bb68f8515ba7d1ab0f0cddcdf960731773d	0 a8
100644 blob dbe2bc1151e5d5d469644f20189f923f006ed0cc	0 a9
100644 blob 2e7d2f0b106eb8823e449a020497e26b86dc3eb1	0 g0
100644 blob d8a17fff13638d804e8bf7f9f357c174db98f126	0 g1
100644 blob 247c4abd244a429297a4c4b091592ae13bbf4677	0 g2
100644 blob affaa5ba8c43cfc71469226e0d57cb6823c843da	0 g3
100644 blob 51bc00f93e60aeef7dccfcf646e3f615056112bd	0 g4
100644 blob 02b4fdd23d495769852f1550c10eb015f0fe0039	0 g5
100644 blob e65aa9d64b596da2ba61e0662b1173f1e16dcbcf	0 g6
100644 blob e19089689a05907b359f52c972ee7d2294fa96ab	0 g7
100644 blob 30c2af9542d38e1f248390632612e0fb944fd27d	0 g8
100644 blob 09827d7e43d81089e868e9f0f06502b865939c05	0 g9
Initialized empty Git repository in /home/peff/compile/gitbuild/jk/freebsd/project/t/trash directory.t5300-pack-object/test-8/.git/
error: unable to find 0042f6c56d8fc1896f3efc2cdc5060e5b5e44e02
fatal: object of unexpected type
pack	f67e682280757d6079b87511ea590015d0e26770
*   ok 27: index-pack with --strict

* expecting success: 
	git config pack.packSizeLimit 2 &&
	packname_9=$(git pack-objects test-9 <obj-list) &&
	test $(wc -l <obj-list) = $(ls test-9-*.pack | wc -l)

*   ok 28: tolerate absurdly small packsizelimit

* failed 2 among 28 test(s)
