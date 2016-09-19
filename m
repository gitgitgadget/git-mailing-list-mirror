Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E8982070F
	for <e@80x24.org>; Mon, 19 Sep 2016 17:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbcISRQ0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 13:16:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54963 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752717AbcISRQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 13:16:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC0253FC15;
        Mon, 19 Sep 2016 13:16:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yPlXnCdj7DmU+lcz5aI4n3KdHw4=; b=tnV+DT
        Vj0CcxG17k3tnp4ePC66exVe7jc1IsCJpPLlNsJSc7g/oZ9xmXzLvWzARQHQytbl
        6dClGOaJyvbvmtIVeM80qtKbR1/K3in+MNciaxU0PuwodvPHn4Zi/JAniStmTu5V
        iCM6KrFUymOOFnBncVc9F/VGBc1wxpcQEX8yk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i+bK0OK/3W7nGBtmakbdecIsaI+w1IAF
        fcCUu4QJ0LZBYTcuavAC/chLzOEpmrj6MN3Iavzw/1D8FEmtj8HrUNdtEEMdKq1U
        61zEFmImhHaeRU041dNGimFCk3hBa470BiJsw+sIoBNFveeusHEF51oL23pQLoIG
        TMD5SBLC5Pc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D406C3FC14;
        Mon, 19 Sep 2016 13:16:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F0653FC13;
        Mon, 19 Sep 2016 13:16:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Kevin Wern <kevin.m.wern@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 11/11] Resumable clone: implement primer logic in git-clone
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
        <1473984742-12516-12-git-send-email-kevin.m.wern@gmail.com>
        <CACsJy8B1bbKBhg1ke4u6PV3k4FWz-bhBPyN2X=mV2Z2=8Mhy=A@mail.gmail.com>
Date:   Mon, 19 Sep 2016 10:16:21 -0700
In-Reply-To: <CACsJy8B1bbKBhg1ke4u6PV3k4FWz-bhBPyN2X=mV2Z2=8Mhy=A@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 19 Sep 2016 21:04:40 +0700")
Message-ID: <xmqqmvj3g68q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA25CCA0-7E8C-11E6-84A0-5D827B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Sep 16, 2016 at 7:12 AM, Kevin Wern <kevin.m.wern@gmail.com> wrote:
>>  builtin/clone.c             | 590 +++++++++++++++++++++++++++++++++++++-------
>
> Argh.. this is too big for my brain at this hour. It might be easier
> to follow if you separate out some code move (I think I've seen some,
> not sure). I'll try to have another look when I find time. But it's
> great to hear from you again, the pleasant surprise in my inbox today,
> as I thought we lost you ;-) There's hope for resumable clone maybe
> before 2018 again.

I had a similar thought.

What "git clone" (WITHOUT Kevin's update) should have been was to be
as close to

    * Parse command line arguments;

    * Create a new repository and go into it; this step would
      require us to have parsed the command line for --template,
      <directory>, --separate-git-dir, etc.

    * Talk to the remote and do get_remote_heads() aka ls-remote
      output;

    * Decide what fetch refspec to use, which alternate object store
      to borrow from; this step would require us to have parsed the
      command line for --reference, --mirror, --origin, etc;

    * Issue "git fetch" with the refspec determined above; this step
      would require us to have parsed the command line for --depth, etc.

    * Run "git checkout -b" to create an initial checkout; this step
      would require us to have parsed the command line for --branch,
      etc.

and the current code Kevin is basing his work on is not quite in
that shape.  This round of the patches may be RFC so it may be OK
but the ready-for-review work may need to do the refactoring to get
it close to the above shape as a preparatory step before doing
anything else.  Once that is done, Kevin's series (other than the
part that acutally does the resumable static file download) will
become a very easily understood "Ah, we know where to prime the well
from, so let's do that first" step inserted immediately before the
"Issue 'git fetch'" step.

