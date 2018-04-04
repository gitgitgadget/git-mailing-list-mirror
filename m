Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 594511F424
	for <e@80x24.org>; Wed,  4 Apr 2018 07:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750826AbeDDHrB (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 03:47:01 -0400
Received: from mout.gmx.net ([212.227.17.21]:39885 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750772AbeDDHrA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 03:47:00 -0400
Received: from localhost ([188.192.2.98]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mchyv-1emNMU3mN7-00HxXd; Wed, 04
 Apr 2018 09:46:56 +0200
Date:   Wed, 4 Apr 2018 09:46:58 +0200
From:   Clemens Buchacher <drizzd@gmx.net>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, manlio.perillo@gmail.com,
        johannes.schindelin@gmx.de, gitster@pobox.com
Subject: [PATCH] completion: improve ls-files filter performance
Message-ID: <20180404074658.GA5833@Sonnenschein.localdomain>
References: <1521274624-1370-1-git-send-email-drizzd@gmx.net>
 <1521274624-1370-2-git-send-email-drizzd@gmx.net>
 <20180318012618.32691-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180318012618.32691-1-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Provags-ID: V03:K1:wuTD3ZH/aBXVwi4gC5K9dszCuMn9NyycALm3XGrbkmP4FjfgCoE
 oqVTg1k0cxa3PXgyAbNEh+T+OjjWWL/O90x/ROh+q6cy793J1XCMVeiv6/Zer91p1Acujcw
 bL5L/F+bH9MI5dR53/ut7VS3nclkkg2GnMVNsQrIcTU+IaXZXoTZbyJ7RdrmZvZHsag87aa
 CSg6Ln4mXhJSCk9FlE6VA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sgRCc6n+wgs=:tH4BvM5leuuyyElPdMtjNT
 bnJW63rv1LkuCNy4UQVP3e80C+ylaQuOXD+w6D8REYSf5IHoU0SyRBqhmD1NXZ1fTfhcAZZcL
 liNWiUF2YDRmfY8FlbOMu28zUEhmAVID2p6SNlN165bhA7J0x0f086KGAncYg1fE0HGFfdi5W
 jz08Vss0Mm+2U3/ohTIeLr+5k3wES31gb+VtCdIufqpAgBIqAkZuz8w3kNu3pw2hCCN6giXEW
 HaPY+612ZQvc3DSKKqSRBrxXhEw6s5r++XB8330g3Rq3jYewRg93CYHkaIy3cyQE1mrIEhZDr
 1pbAsU5t01U0U5jIqoTcWXtszoR9CepBeec/NyZh9sL2TpGBSXtzwR2UfXDAUVQZre0VrQh+G
 XHDBeghBx6LQ+tl4wakliH6I04gO/OWDV45xHY0HZUK97IP1C5neniGKOAEY8V0Z7iaYFjPbp
 dD0HgbZSsaenIrwmRv/f6jkz7aVIrZlBtJ3LCRVMKAtEDFhKcsVg+XRbKVke2AsBf9SHIGr8v
 SeA1v8rzk3Yml7ubJa+RmgD9roh0Qaw2xZ4npCLWiybDDq8I+ByzZZjzoYuDxFrz52nu4v6Q2
 vtZjSOIVqbOFzYguIxS/Qki01KjT3UzbCm4qp4O1WYXavjmHf+DMbRhGmYJsaVyWbllB0XQ7X
 1c8tJbUzkPwtPByk3t13WKEJZyZ49TblbcgDBmAeE8ue1nEESsq6EUh23fkil/IaYgt4qmgFM
 U92xz2S8cl9iAVkA+6jt37uxThB38OGodmCZWEy94juRKK8YndYEdwa5GqhnyU+ng7CCvzwQN
 wMoiryBJoyMPBI7IsfsFhERFCzmCw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From the output of ls-files, we remove all but the leftmost path
component and then we eliminate duplicates. We do this in a while loop,
which is a performance bottleneck when the number of iterations is large
(e.g. for 60000 files in linux.git).

$ COMP_WORDS=(git status -- ar) COMP_CWORD=3; time _git

real    0m11.876s
user    0m4.685s
sys     0m6.808s

Replacing the loop with the cut command improves performance
significantly:

$ COMP_WORDS=(git status -- ar) COMP_CWORD=3; time _git

real    0m1.372s
user    0m0.263s
sys     0m0.167s

The measurements were done with Msys2 bash, which is used by Git for
Windows.

When filtering the ls-files output we take care not to touch absolute
paths. This is redundant, because ls-files will never output absolute
paths. Remove the unnecessary operations.

The issue was reported here:
https://github.com/git-for-windows/git/issues/1533

Signed-off-by: Clemens Buchacher <drizzd@gmx.net>
---

On Sun, Mar 18, 2018 at 02:26:18AM +0100, SZEDER Gábor wrote:
> 
> You didn't run the test suite, did you? ;)

My bad. I put the sort back in. Test t9902 is now pass. I did not run
the other tests. I think the completion script is not used there.

I also considered Junio's and Johannes' comments.

> I have a short patch series collecting dust somewhere for a long
> while, [...]
> Will try to dig up those patches.

Cool. Bash completion can certainly use more performance improvements.

 contrib/completion/git-completion.bash | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6da95b8..69a2d41 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -384,12 +384,7 @@ __git_index_files ()
 	local root="${2-.}" file
 
 	__git_ls_files_helper "$root" "$1" |
-	while read -r file; do
-		case "$file" in
-		?*/*) echo "${file%%/*}" ;;
-		*) echo "$file" ;;
-		esac
-	done | sort | uniq
+	cut -f1 -d/ | sort | uniq
 }
 
 # Lists branches from the local repository.
-- 
2.7.4

