Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BB981F42D
	for <e@80x24.org>; Tue, 29 May 2018 18:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965752AbeE2Sqy (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 14:46:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964848AbeE2Sqx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 14:46:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F7537C0A7;
        Tue, 29 May 2018 18:46:53 +0000 (UTC)
Received: from localhost (ovpn-116-54.gru2.redhat.com [10.97.116.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E899A6148;
        Tue, 29 May 2018 18:46:52 +0000 (UTC)
Date:   Tue, 29 May 2018 15:46:51 -0300
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Xiaolong Ye <xiaolong.ye@intel.com>
Cc:     Fengguang Wu <fengguang.wu@intel.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Xiaolong Ye <xiaolong.ye@intel.com>
Subject: format-patch: no 'prerequisite-patch-id' info when specifying commit
 range
Message-ID: <20180529184651.GB14525@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Fnord: you can see the fnord
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 29 May 2018 18:46:53 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm trying to use git-format-patch --base to generate the list of
prerequisite patches for a series, but the behavior of git
doesn't seem to match the documentation:

When using a commit count (e.g.: "-2"), git-format-patch generates the
prerequisite-patch-id lines as expected.  But when using a commit range like
"Z..C", the prerequisite-patch-id lines are missing.

Is this intentional, or it is a bug?

Example using git.git commits:

  $ git format-patch --stdout --cover-letter --stdout --base b7b1fca17~5 -2 b7b1fca17 | egrep 'base-commit|prereq'
  base-commit: 2738744426c161a98c2ec494d41241a4c5eef9ef
  prerequisite-patch-id: 080ac2faf21a6a7f9b23cb68286866d026a92930
  prerequisite-patch-id: e3ee77500c9aa70248e7ee814662d01f79d0dcdb
  prerequisite-patch-id: 6d831e23e33075681e6b74553151a32b73092013
  (ehabkost@localhost:~/rh/proj/git (ok) 1j)
  $ git format-patch --stdout --cover-letter --stdout --base b7b1fca17~5 b7b1fca17~2..b7b1fca17 | egrep 'base-commit|prereq'
  base-commit: 2738744426c161a98c2ec494d41241a4c5eef9ef
  $ git --version
  git version 2.17.1
  $ git log --graph --pretty=oneline -6 b7b1fca17
  * b7b1fca175f1ed7933f361028c631b9ac86d868d fsck: complain when .gitmodules is a symlink
  * 73c3f0f704a91b6792e0199a3f3ab6e3a1971675 index-pack: check .gitmodules files with --strict
  * 6e328d6caef218db320978e3e251009135d87d0e unpack-objects: call fsck_finish() after fscking objects
  * 1995b5e03e1cc97116be58cdc0502d4a23547856 fsck: call fsck_finish() after fscking objects
  * ed8b10f631c9a71df3351d46187bf7f3fa4f9b7e fsck: check .gitmodules content
  * 2738744426c161a98c2ec494d41241a4c5eef9ef fsck: handle promisor objects in .gitmodules check
  $ 

If I understand the documentation correctly, both "-3 C" or "Z..C" were
supposed to be equivalent:

> With `git format-patch --base=P -3 C` (or variants thereof, e.g. with
> `--cover-letter` or using `Z..C` instead of `-3 C` to specify the
> range), the base tree information block is shown at the end of the
> first message the command outputs (either the first patch, or the
> cover letter), like this:
> 
> ------------
> base-commit: P
> prerequisite-patch-id: X
> prerequisite-patch-id: Y
> prerequisite-patch-id: Z
> ------------

-- 
Eduardo
