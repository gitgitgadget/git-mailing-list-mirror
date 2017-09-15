Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A29E20A25
	for <e@80x24.org>; Fri, 15 Sep 2017 02:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbdIOCt7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 22:49:59 -0400
Received: from mail.wilcox-tech.com ([45.32.83.9]:54606 "EHLO
        mail.wilcox-tech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751703AbdIOCt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 22:49:58 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Sep 2017 22:49:58 EDT
Received: (qmail 22928 invoked from network); 15 Sep 2017 02:43:15 -0000
Received: from 107-131-85-42.lightspeed.tulsok.sbcglobal.net (HELO ?192.168.1.157?) (awilcox@wilcox-tech.com@107.131.85.42)
  by mail.wilcox-tech.com with ESMTPA; 15 Sep 2017 02:43:15 -0000
To:     git@vger.kernel.org
From:   "A. Wilcox" <awilfox@adelielinux.org>
Subject: Git 2.14.1: t6500: error during test on musl libc
X-Enigmail-Draft-Status: N1110
Organization: =?UTF-8?Q?Ad=c3=a9lie_Linux?=
Message-ID: <59BB3E40.7020804@adelielinux.org>
Date:   Thu, 14 Sep 2017 21:43:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi there,

While bumping Git's version for our Linux distribution to 2.14.1, I've
run in to a new test failure in t6500-gc.sh.  This is the output of
the failing test with debug=t verbose=t:


expecting success:
        # make sure we run a background auto-gc
        test_commit make-pack &&
        git repack &&
        test_config gc.autopacklimit 1 &&
        test_config gc.autodetach true &&

        # create a ref whose loose presence we can use to detect a
pack-refs run
        git update-ref refs/heads/should-be-loose HEAD &&
        test_path_is_file .git/refs/heads/should-be-loose &&

        # now fake a concurrent gc that holds the lock; we can use our
        # shell pid so that it looks valid.
        hostname=$(hostname || echo unknown) &&
        printf "$$ %s" "$hostname" >.git/gc.pid &&

        # our gc should exit zero without doing anything
        run_and_wait_for_auto_gc &&
        test_path_is_file .git/refs/heads/should-be-loose

[master 28ecdda] make-pack
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 make-pack.t
Counting objects: 3, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), done.
Total 3 (delta 0), reused 0 (delta 0)
Auto packing the repository in background for optimum performance.
See "git help gc" for manual housekeeping.
File .git/refs/heads/should-be-loose doesn't exist.
not ok 8 - background auto gc respects lock for all operations
#
#               # make sure we run a background auto-gc
#               test_commit make-pack &&
#               git repack &&
#               test_config gc.autopacklimit 1 &&
#               test_config gc.autodetach true &&
#
#               # create a ref whose loose presence we can use to
detect a pack-refs run
#               git update-ref refs/heads/should-be-loose HEAD &&
#               test_path_is_file .git/refs/heads/should-be-loose &&
#
#               # now fake a concurrent gc that holds the lock; we can
use our
#               # shell pid so that it looks valid.
#               hostname=$(hostname || echo unknown) &&
#               printf "$$ %s" "$hostname" >.git/gc.pid &&
#
#               # our gc should exit zero without doing anything
#               run_and_wait_for_auto_gc &&
#               test_path_is_file .git/refs/heads/should-be-loose
#

# failed 1 among 8 test(s)
1..8


I admit I am mostly blind with the Git gc system.  Should I use strace
on the git-gc process at the end?  How would I accomplish that?  Is
there a better way of debugging this error further?

Core system stats:

Intel x86_64 E3-1280 v3 @ 3.60 GHz
musl libc 1.1.16+20
git 2.14.1, vanilla except for a patch to an earlier test due to
musl's inability to cope with EUC-JP
bash 4.3.48(1)-release

Thank you very much.

All the best,
- --arw

- -- 
A. Wilcox (awilfox)
Project Lead, Adélie Linux
http://adelielinux.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZuz4yAAoJEMspy1GSK50UORwP/0Jxfp3xzexh27tSJlXYWS/g
g9QK8Xmid+3A0R696Vb2GguKg2roCcTmM2anR7iD1B2f2W31sgf+8M5mnJRHyJ1p
geEeqwrTdpCk6jQ/1Pj03L0NOftb1ftR6hcoVujBFAOph4jRlRdZDPA87fe6snrh
q99C3LoDXQcyK6WWJwzX+t2wOplKgpGJP8wTAaZ0AHoUwVS5CLPl8tP2XaY4kLfD
ZPPcvtp9wisVzzZ2ssE/CLGd38EbenNNZ6OJCBFJIHmlwey4G2isZ9kk6fVIHXi2
unBJ8yVqI7hQKmQFSVQMMSFSd9azhHnDjTBO5mzWeRK9HNVMda3LZsXTtVeswnRs
lN/ASMdt5KdfpNy/plFB7yDWLlQSQY7j1mxBMR8lL3AdVVQUbJppDM795tt+rn6a
NCE2ESZMWd/QEULmT92AbkNJTj5ibBEoubnVTka05KMjaBLwIauhpqU5XxLFq2UH
y3JYQU9hm0E7dQE0CLXxIm5/574T6bBUgp1cXH3CjxkeUYKR1USVKtDfBV6t/Qmt
xlDZKPEfjKbTvL3KUF33G+eAp55wTwrJTaWlOp8A/JqooXavYghcsuFhYtCPJ8qo
fFUa8kBZP70E/O7JkycUu8wi7p42+j1a8gR6/AnPG2u2wyoiosLCxHX+nll4gKmN
b6BuiRn0Z9ie5xw4xcMR
=Vf8Z
-----END PGP SIGNATURE-----
