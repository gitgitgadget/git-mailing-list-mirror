Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED3981F403
	for <e@80x24.org>; Sun,  3 Jun 2018 06:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750846AbeFCGKP (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 02:10:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:56789 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750791AbeFCGKO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 02:10:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jun 2018 23:10:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,472,1520924400"; 
   d="scan'208";a="53179135"
Received: from yexl-desktop.sh.intel.com (HELO localhost) ([10.239.159.124])
  by fmsmga002.fm.intel.com with ESMTP; 02 Jun 2018 23:10:13 -0700
Date:   Sun, 3 Jun 2018 14:07:02 +0800
From:   Ye Xiaolong <xiaolong.ye@intel.com>
To:     Eduardo Habkost <ehabkost@redhat.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: format-patch: no 'prerequisite-patch-id' info when specifying
 commit range
Message-ID: <20180603060702.GA1306@yexl-desktop>
Mail-Followup-To: Eduardo Habkost <ehabkost@redhat.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
References: <20180529184651.GB14525@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529184651.GB14525@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Junio

On 05/29, Eduardo Habkost wrote:
>Hi,
>
>I'm trying to use git-format-patch --base to generate the list of
>prerequisite patches for a series, but the behavior of git
>doesn't seem to match the documentation:
>
>When using a commit count (e.g.: "-2"), git-format-patch generates the
>prerequisite-patch-id lines as expected.  But when using a commit range like
>"Z..C", the prerequisite-patch-id lines are missing.
>

I narrowed down the problem to revision walk, if users specify the commit range
via "Z..C" pattern, the first prepare_revision_walk function called in
cmd_format_patch would mark all parents (ancestors) of Z to be uninteresting,
thus the next revision walk in prepare_bases wouldn't be able to reach
prerequisite patches, one quick solution I can think of is to clear
UNINTERESTING flag in reset_revision_walk, like below:

void reset_revision_walk(void)
{
	clear_object_flags(SEEN | ADDED | SHOWN| UNINTERESTING);
}

Though I'm not sure whether it has some side effects, or whether it would impact
behavior of other reference of reset_revision_walk. If you think it's a sensible
solution, I'll submit a patch.

Thanks,
Xiaolong


>Is this intentional, or it is a bug?
>
>Example using git.git commits:
>
>  $ git format-patch --stdout --cover-letter --stdout --base b7b1fca17~5 -2 b7b1fca17 | egrep 'base-commit|prereq'
>  base-commit: 2738744426c161a98c2ec494d41241a4c5eef9ef
>  prerequisite-patch-id: 080ac2faf21a6a7f9b23cb68286866d026a92930
>  prerequisite-patch-id: e3ee77500c9aa70248e7ee814662d01f79d0dcdb
>  prerequisite-patch-id: 6d831e23e33075681e6b74553151a32b73092013
>  (ehabkost@localhost:~/rh/proj/git (ok) 1j)
>  $ git format-patch --stdout --cover-letter --stdout --base b7b1fca17~5 b7b1fca17~2..b7b1fca17 | egrep 'base-commit|prereq'
>  base-commit: 2738744426c161a98c2ec494d41241a4c5eef9ef
>  $ git --version
>  git version 2.17.1
>  $ git log --graph --pretty=oneline -6 b7b1fca17
>  * b7b1fca175f1ed7933f361028c631b9ac86d868d fsck: complain when .gitmodules is a symlink
>  * 73c3f0f704a91b6792e0199a3f3ab6e3a1971675 index-pack: check .gitmodules files with --strict
>  * 6e328d6caef218db320978e3e251009135d87d0e unpack-objects: call fsck_finish() after fscking objects
>  * 1995b5e03e1cc97116be58cdc0502d4a23547856 fsck: call fsck_finish() after fscking objects
>  * ed8b10f631c9a71df3351d46187bf7f3fa4f9b7e fsck: check .gitmodules content
>  * 2738744426c161a98c2ec494d41241a4c5eef9ef fsck: handle promisor objects in .gitmodules check
>  $ 
>
>If I understand the documentation correctly, both "-3 C" or "Z..C" were
>supposed to be equivalent:
>
>> With `git format-patch --base=P -3 C` (or variants thereof, e.g. with
>> `--cover-letter` or using `Z..C` instead of `-3 C` to specify the
>> range), the base tree information block is shown at the end of the
>> first message the command outputs (either the first patch, or the
>> cover letter), like this:
>> 
>> ------------
>> base-commit: P
>> prerequisite-patch-id: X
>> prerequisite-patch-id: Y
>> prerequisite-patch-id: Z
>> ------------
>
>-- 
>Eduardo
