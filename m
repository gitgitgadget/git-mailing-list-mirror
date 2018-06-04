Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E238F1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 02:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751482AbeFDCoQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 22:44:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:43959 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751373AbeFDCoP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 22:44:15 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2018 19:44:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,473,1520924400"; 
   d="scan'208";a="229644060"
Received: from yexl-desktop.sh.intel.com (HELO localhost) ([10.239.159.124])
  by orsmga005.jf.intel.com with ESMTP; 03 Jun 2018 19:44:13 -0700
Date:   Mon, 4 Jun 2018 10:41:01 +0800
From:   Ye Xiaolong <xiaolong.ye@intel.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eduardo Habkost <ehabkost@redhat.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: Re: format-patch: no 'prerequisite-patch-id' info when specifying
 commit range
Message-ID: <20180604024101.GO27396@yexl-desktop>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
        Eduardo Habkost <ehabkost@redhat.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
References: <20180529184651.GB14525@localhost.localdomain>
 <20180603060702.GA1306@yexl-desktop>
 <xmqqh8mj70w6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh8mj70w6.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/04, Junio C Hamano wrote:
>Ye Xiaolong <xiaolong.ye@intel.com> writes:
>
>> I narrowed down the problem to revision walk, if users specify the commit range
>> via "Z..C" pattern, the first prepare_revision_walk function called in
>> cmd_format_patch would mark all parents (ancestors) of Z to be uninteresting,
>> thus the next revision walk in prepare_bases wouldn't be able to reach
>> prerequisite patches, one quick solution I can think of is to clear
>> UNINTERESTING flag in reset_revision_walk, like below:
>>
>> void reset_revision_walk(void)
>> {
>> 	clear_object_flags(SEEN | ADDED | SHOWN| UNINTERESTING);
>> }
>
>When you are done with objects that are UNINTERESTING in your
>application (i.e. only when "format-patch" is told to compute list
>of prereq patches by doing an extra revision walk), your application
>can call clear_object_flags() on the flags you are done with, I
>would think.
>
>But the current callers of reset_revision_walk() do not expect any
>flags other than the ones that are used to keep track of the
>traversal state, so it is likely you will break them if you suddenly
>started to clear flags randomly.

Got it, I'll try to call clear_object_flags in format-patch related codepatch
only, not to touch the global reset_revision_walk.

Thanks,
Xiaolong
