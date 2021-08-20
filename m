Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA9FC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 06:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C1256108F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 06:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbhHTGQC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 02:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238196AbhHTGQB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 02:16:01 -0400
Received: from tilde.club (unknown [IPv6:2607:5300:61:c67::196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE57C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 23:15:24 -0700 (PDT)
Received: from tilde.club (unknown [89.163.252.12])
        by tilde.club (Postfix) with ESMTPSA id E7B8422047799;
        Fri, 20 Aug 2021 06:15:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 tilde.club E7B8422047799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tilde.club; s=mail;
        t=1629440120; bh=ekK5OQxWsFlcVWNtEvXywNKxpCGBxqjtigWB5p3Nw9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DUyR1uB4C0gOT1UzNXrJUMASfJSgmciQduoQKfPIjYfScf2YdMifjHcCkB0c8F7dA
         LD4A8p293+oGSm0SNz35bauqQjRbLTWVVprZ/0Je9YPr5YW4I76FNTunm1MeEqZ8kV
         pE3RrocKZd44skYfmOfAe9IWfml+oZYTPgF8veOE=
Date:   Fri, 20 Aug 2021 06:15:06 +0000
From:   Gwyneth Morgan <gwymor@tilde.club>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Adam Williamson <awilliam@redhat.com>, git@vger.kernel.org
Subject: Re: git format-patch produces invalid patch if the commit adds an
 empty file?
Message-ID: <YR9Iaj/FqAyCMade@tilde.club>
References: <02be6a48411fa100e7d1292fc312f7fcf571f334.camel@redhat.com>
 <xmqq5yw1ywdk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5yw1ywdk.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-08-19 14:09:43-0700, Junio C Hamano wrote:
> I do not think our patch injestion machinery in "git apply" minds if
> we added the "--- /dev/null" + "+++ b/<path>" headers (and the
> reverse for removal of an empty file) to the current output, and I
> am not fundamentally opposed to such a change.
> 
> But because it is such a rare event (and a discouraged practice) to
> record a completely empty file, I wouldn't place a high priority on
> doing so myself.

GNU patch chokes in this case with an unquoted filename with spaces.
However if we output

	diff --git "a/test cases/common/56 array methods/a.txt" "b/test cases/common/56 array methods/a.txt"

instead of

	diff --git a/test cases/common/56 array methods/a.txt b/test cases/common/56 array methods/a.txt

GNU patch (and Git) will read it correctly. Rather than adding the "---"
"+++" lines, could we instead quote filenames in the "diff --git" line
when they contain spaces?
