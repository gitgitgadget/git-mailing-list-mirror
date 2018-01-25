Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9105D1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 04:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933420AbeAYEfx (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 23:35:53 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:45436 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933369AbeAYEfw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 23:35:52 -0500
Received: from c-76-24-253-1.hsd1.nh.comcast.net ([76.24.253.1] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1eeZGQ-0003cj-FA
        for git@vger.kernel.org; Wed, 24 Jan 2018 23:35:51 -0500
Date:   Wed, 24 Jan 2018 23:35:44 -0500
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <20180125043544.GY3296@hopa.kiewit.dartmouth.edu>
References: <20170925000213.rilmsczdbi3jqkta@hopa.kiewit.dartmouth.edu>
 <xmqqwp4nfuv1.fsf@gitster.mtv.corp.google.com>
 <20170925031751.lg7zk6krt65dxwas@hopa.kiewit.dartmouth.edu>
 <xmqqmv5je412.fsf_-_@gitster.mtv.corp.google.com>
 <20170925143040.4qgofxcdahal46r7@hopa.kiewit.dartmouth.edu>
 <xmqqing6cje7.fsf@gitster.mtv.corp.google.com>
 <xmqqefqucigh.fsf@gitster.mtv.corp.google.com>
 <xmqqa81ichdu.fsf@gitster.mtv.corp.google.com>
 <20170926133703.7gtk5ztkhqvfxszh@hopa.kiewit.dartmouth.edu>
 <xmqqtvyzslcz.fsf_-_@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtvyzslcz.fsf_-_@gitster.mtv.corp.google.com>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SA-Exim-Connect-IP: 76.24.253.1
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: external diff driver is not used for diff --stat?
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git Peoples,

I am torturing git and git-annex here trying to compare some logs from a
run of a software recorded in two different branches.  As many other
tools, software often logs its version, elapsed times etc, so diff becomes not of interest to me:

	$> PATH=~/proj/misc/git/INSTALL-2.16.1/bin:$PATH git diff test-18.0.09 test-18.0.05+git24-gb25b21054_dfsg.1-1_nd90+1 -- AFNI_data6/FT_analysis/FT.results/out.allcostX.txt-git
	diff --git a/AFNI_data6/FT_analysis/FT.results/out.allcostX.txt-git b/AFNI_data6/FT_analysis/FT.results/out.allcostX.txt-git
	index db85c9be..5f4a704d 100644
	--- a/AFNI_data6/FT_analysis/FT.results/out.allcostX.txt-git
	+++ b/AFNI_data6/FT_analysis/FT.results/out.allcostX.txt-git
	@@ -1,4 +1,4 @@
	-++ 3dAllineate: AFNI version=AFNI_18.0.09 (Jan 19 2018) [64-bit]
	+++ 3dAllineate: AFNI version=Debian-18.0.05+git24-gb25b21054~dfsg.1-1~nd90+1 (Jan 23 2018) [64-bit]
	 ++ Authored by: Zhark the Registrator
	 ++ Source dataset: ./anat_final.FT+tlrc.HEAD
	 ++ Base dataset:   ./final_epi_vr_base_min_outlier+tlrc.HEAD
	@@ -28,5 +28,5 @@ volume 0
		lpa  = 0.921773
		lpc+ = 0.310739
		ncd  = 0.967007
	-++ 3dAllineate: total CPU time = 0.0 sec  Elapsed = 1.5
	+++ 3dAllineate: total CPU time = 0.0 sec  Elapsed = 1.3


so I came up with a simple differ to exclude those:

	$> cat ~/bin/git-annex-diff-wrapper
	#!/usr/bin/env bash                                                             
	LANG=C diff --color=always --ignore-matching-lines="\(AFNI version=\|time.*Elapsed\)" -u "$2" "$5"  

which works as it should (sorry for long lines, just wanted to not cut out
anything which might be of relevance)

	$> PATH=~/proj/misc/git/INSTALL-2.16.1/bin:$PATH GIT_EXTERNAL_DIFF='git-annex diffdriver  -- ~/bin/git-annex-diff-wrapper --' git diff --ext-diff test-18.0.09 test-18.0.05+git24-gb25b21054_dfsg.1-1_nd90+1 -- AFNI_data6/FT_analysis/FT.results/out.allcostX.txt-git     
	# no output received

(and even on annexed files -- whoohoo).

The problem comes that --stat seems to be not using the external diff (it is
line the same as above just with --stat):

	$> PATH=~/proj/misc/git/INSTALL-2.16.1/bin:$PATH GIT_EXTERNAL_DIFF='git-annex diffdriver  -- ~/bin/git-annex-diff-wrapper --' git diff --ext-diff test-18.0.09 test-18.0.05+git24-gb25b21054_dfsg.1-1_nd90+1 --stat -- AFNI_data6/FT_analysis/FT.results/out.allcostX.txt-git
	 AFNI_data6/FT_analysis/FT.results/out.allcostX.txt-git | 4 ++--
	 1 file changed, 2 insertions(+), 2 deletions(-)


A shortcoming or somehow "by design"? ;)

PS Please CC me in replies

Cheers!

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
