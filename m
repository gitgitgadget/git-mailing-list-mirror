Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5A54202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 18:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932302AbdCISpK (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 13:45:10 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39072 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932075AbdCISpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 13:45:09 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3B0EF607DF; Thu,  9 Mar 2017 18:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1489085108;
        bh=vgfuuKV6MkiFp1rpQFpJHJsppw1qAdXfCs4bYZY46d8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hPGeHp+boOLLPq7xtLbA2RHX0sRxNIk02kyK8hOkGH0k+6CEybliWOxYP6CIi+6+4
         ODSqv2xZxIUwgkFqky4uSH4tPL0a7lBK2NmdiY5zQDgZOMGmJGXdCJmZrjqHWnhUXk
         7NAcwzF+USuhp6EQLWi1GQ2sX+jwIPgBXF20MdAg=
Received: from mfick1-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6574660341;
        Thu,  9 Mar 2017 18:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1489085107;
        bh=vgfuuKV6MkiFp1rpQFpJHJsppw1qAdXfCs4bYZY46d8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NctA65nhT2rYfIS/ql0SHEAAc/gIaYRrqLOO8icx4II8VvTFI0RcN9W/W3yMBCWWC
         pZb5aZyiS+xD94k5XaOt4XR0OPOKjJkb/IUq7gL5EWgDSzUuAYJtQCLq0c773UfqH6
         O6uiVw3wcKW7/j4TUsi3C03e2sDylfwqbOd2gyHE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6574660341
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     jmelvin@codeaurora.org
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        nasserg@codeaurora.org, peff@peff.net, sbeller@google.com
Subject: Re: [PATCH] repack: Add options to preserve and prune old pack files
Date:   Thu, 09 Mar 2017 11:45:06 -0700
Message-ID: <4065744.f4TKuYAukl@mfick1-lnx>
User-Agent: KMail/4.8.5 (Linux/3.2.0-106-generic; KDE/4.8.5; x86_64; ; )
In-Reply-To: <1d816bbb08b228ece9a74ffcdfb7a5b1@codeaurora.org>
References: <20170307164035.27866-1-jmelvin@codeaurora.org> <xmqq4lz4968p.fsf@gitster.mtv.corp.google.com> <1d816bbb08b228ece9a74ffcdfb7a5b1@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, March 09, 2017 10:50:21 AM 
jmelvin@codeaurora.org wrote:
> On 2017-03-07 13:33, Junio C Hamano wrote:
> > James Melvin <jmelvin@codeaurora.org> writes:
> >> These options are designed to prevent stale file handle
> >> exceptions during git operations which can happen on
> >> users of NFS repos when repacking is done on them. The
> >> strategy is to preserve old pack files around until
> >> the next repack with the hopes that they will become
> >> unreferenced by then and not cause any exceptions to
> >> running processes when they are finally deleted
> >> (pruned).
> > 
> > I find it a very sensible strategy to work around NFS,
> > but it does not explain why the directory the old ones
> > are moved to need to be configurable.  It feels to me
> > that a boolean that causes the old ones renamed
> > s/^pack-/^old-&/ in the same directory (instead of
> > pruning them right away) would risk less chances of
> > mistakes (e.g. making "preserved" subdirectory on a
> > separate device mounted there in a hope to reduce disk
> > usage of the primary repository, which may defeat the
> > whole point of moving the still-active file around
> > instead of removing them).
> 
> Moving the preserved pack files to a separate directory
> only helped make the pack directory cleaner, but I agree
> that having the old* pack files in the same directory is
> a better approach as it would ensure that it's still on
> the same mounted device. I'll update the logic to reflect
> that.
> 
> As for the naming convention of the preserved pack files,
> there is already some logic to remove "old-" files in
> repack. Currently this is the naming convention I have
> for them:
> 
> pack-<sha1>.old-<ext>
> pack-7412ee739b8a20941aa1c2fd03abcc7336b330ba.old-pack
> 
> One advantage of that is the extension is no longer an
> expected one, differentiating it from current pack files.
> 
> That said, if that is not a concern, I could prefix them
> with "preserved" instead of "old" to differentiate them
> from the other logic that cleans up "old-*". What are
> your thoughts on that?
> 
> preserved-<sha1>.<ext>
> preserved-7412ee739b8a20941aa1c2fd03abcc7336b330ba.pack

Some other proposals so that the preserved files do not get 
returned by naive finds based on their extensions,

 preserved-<sha1>.<ext>-preserved
 preserved-7412ee739b8a20941aa1c2fd03abcc7336b330ba.pack-
preserved

or:

 preserved-<sha1>.preserved-<ext>
 preserved-7412ee739b8a20941aa1c2fd03abcc7336b330ba.preserved-
pack

or maybe even just:

 preserved-<ext>-<sha1>
 preserved-pack-7412ee739b8a20941aa1c2fd03abcc7336b330ba


-Martin
-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

