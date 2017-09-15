Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC75420286
	for <e@80x24.org>; Fri, 15 Sep 2017 06:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbdIOGyV (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 02:54:21 -0400
Received: from ikke.info ([178.21.113.177]:51550 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751152AbdIOGyU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 02:54:20 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 725CB44012D; Fri, 15 Sep 2017 08:37:40 +0200 (CEST)
Date:   Fri, 15 Sep 2017 08:37:40 +0200
From:   Kevin Daudt <me@ikke.info>
To:     "A. Wilcox" <awilfox@adelielinux.org>
Cc:     git@vger.kernel.org
Subject: Re: Git 2.14.1: t6500: error during test on musl libc
Message-ID: <20170915063740.GB21499@alpha.vpn.ikke.info>
References: <59BB3E40.7020804@adelielinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59BB3E40.7020804@adelielinux.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 14, 2017 at 09:43:12PM -0500, A. Wilcox wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
> 
> Hi there,
> 
> While bumping Git's version for our Linux distribution to 2.14.1, I've
> run in to a new test failure in t6500-gc.sh.  This is the output of
> the failing test with debug=t verbose=t:

This is a new test introduced by c45af94db 
(gc: run pre-detach operations under lock, 2017-07-11) which was
included in v2.14.0.

So it might be that this was already a problem for a longer time, only
just recently uncovered.

> 
> 
> expecting success:
>         # make sure we run a background auto-gc
>         test_commit make-pack &&
>         git repack &&
>         test_config gc.autopacklimit 1 &&
>         test_config gc.autodetach true &&
> 
>         # create a ref whose loose presence we can use to detect a
> pack-refs run
>         git update-ref refs/heads/should-be-loose HEAD &&
>         test_path_is_file .git/refs/heads/should-be-loose &&
> 
>         # now fake a concurrent gc that holds the lock; we can use our
>         # shell pid so that it looks valid.
>         hostname=$(hostname || echo unknown) &&
>         printf "$$ %s" "$hostname" >.git/gc.pid &&
> 
>         # our gc should exit zero without doing anything
>         run_and_wait_for_auto_gc &&
>         test_path_is_file .git/refs/heads/should-be-loose
> 
> [master 28ecdda] make-pack
>  Author: A U Thor <author@example.com>
>  1 file changed, 1 insertion(+)
>  create mode 100644 make-pack.t
> Counting objects: 3, done.
> Delta compression using up to 8 threads.
> Compressing objects: 100% (2/2), done.
> Writing objects: 100% (3/3), done.
> Total 3 (delta 0), reused 0 (delta 0)
> Auto packing the repository in background for optimum performance.
> See "git help gc" for manual housekeeping.
> File .git/refs/heads/should-be-loose doesn't exist.
> not ok 8 - background auto gc respects lock for all operations
> #
> #               # make sure we run a background auto-gc
> #               test_commit make-pack &&
> #               git repack &&
> #               test_config gc.autopacklimit 1 &&
> #               test_config gc.autodetach true &&
> #
> #               # create a ref whose loose presence we can use to
> detect a pack-refs run
> #               git update-ref refs/heads/should-be-loose HEAD &&
> #               test_path_is_file .git/refs/heads/should-be-loose &&
> #
> #               # now fake a concurrent gc that holds the lock; we can
> use our
> #               # shell pid so that it looks valid.
> #               hostname=$(hostname || echo unknown) &&
> #               printf "$$ %s" "$hostname" >.git/gc.pid &&
> #
> #               # our gc should exit zero without doing anything
> #               run_and_wait_for_auto_gc &&
> #               test_path_is_file .git/refs/heads/should-be-loose
> #
> 
> # failed 1 among 8 test(s)
> 1..8
> 
> 
> I admit I am mostly blind with the Git gc system.  Should I use strace
> on the git-gc process at the end?  How would I accomplish that?  Is
> there a better way of debugging this error further?
> 
> Core system stats:
> 
> Intel x86_64 E3-1280 v3 @ 3.60 GHz
> musl libc 1.1.16+20
> git 2.14.1, vanilla except for a patch to an earlier test due to
> musl's inability to cope with EUC-JP
> bash 4.3.48(1)-release
> 
> Thank you very much.
> 
> All the best,
> - --arw
> 
> - -- 
> A. Wilcox (awilfox)
> Project Lead, Adélie Linux
> http://adelielinux.org
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2
> 
> iQIcBAEBCAAGBQJZuz4yAAoJEMspy1GSK50UORwP/0Jxfp3xzexh27tSJlXYWS/g
> g9QK8Xmid+3A0R696Vb2GguKg2roCcTmM2anR7iD1B2f2W31sgf+8M5mnJRHyJ1p
> geEeqwrTdpCk6jQ/1Pj03L0NOftb1ftR6hcoVujBFAOph4jRlRdZDPA87fe6snrh
> q99C3LoDXQcyK6WWJwzX+t2wOplKgpGJP8wTAaZ0AHoUwVS5CLPl8tP2XaY4kLfD
> ZPPcvtp9wisVzzZ2ssE/CLGd38EbenNNZ6OJCBFJIHmlwey4G2isZ9kk6fVIHXi2
> unBJ8yVqI7hQKmQFSVQMMSFSd9azhHnDjTBO5mzWeRK9HNVMda3LZsXTtVeswnRs
> lN/ASMdt5KdfpNy/plFB7yDWLlQSQY7j1mxBMR8lL3AdVVQUbJppDM795tt+rn6a
> NCE2ESZMWd/QEULmT92AbkNJTj5ibBEoubnVTka05KMjaBLwIauhpqU5XxLFq2UH
> y3JYQU9hm0E7dQE0CLXxIm5/574T6bBUgp1cXH3CjxkeUYKR1USVKtDfBV6t/Qmt
> xlDZKPEfjKbTvL3KUF33G+eAp55wTwrJTaWlOp8A/JqooXavYghcsuFhYtCPJ8qo
> fFUa8kBZP70E/O7JkycUu8wi7p42+j1a8gR6/AnPG2u2wyoiosLCxHX+nll4gKmN
> b6BuiRn0Z9ie5xw4xcMR
> =Vf8Z
> -----END PGP SIGNATURE-----
