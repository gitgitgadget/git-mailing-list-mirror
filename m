Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBBEC19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 16:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbiHDQWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 12:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbiHDQVz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 12:21:55 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4054667148
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 09:21:51 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-49-209-117.bstnma.fios.verizon.net [108.49.209.117])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 274GLlDL004456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 Aug 2022 12:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1659630109; bh=MuyFohwLHefqqZAftNa3QVva8B2GBWEi8Hsri2lV/18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=LGrZL9DVlanNdgmQbtxJCKzIFpG76GoLP5gWuL2KjdrAeDfY9V8I1WI47QXAHGYgk
         QCkM8iHMHw5+EhiblHTEhHY76Yqfw9eez04y/JJU1/Y6VncrAtNcGBe/83DzQvVLb6
         P6u22oRCpwcdZgX7sClrn3d3JeK1en7509rqrNGQjNrQ8hMJf58HB35gIwoAZRoh7a
         t2wJPbBJRDb58GjVCXliEqIhBYiB2tnzy6T3tWi0wmplt1YJiEECjV19Jsc2oTsHDA
         YshErsOHkYc10mi7PdxYIbvp9+AQa00CPKw2FFXWlKjueHzxt3KlhuM5Jly9JKkFeB
         z38sNX8aO2wWw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B758F15C00E4; Thu,  4 Aug 2022 12:21:47 -0400 (EDT)
Date:   Thu, 4 Aug 2022 12:21:47 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric D <eric.decosta@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: mail from mathworks.com domain is rejected
Message-ID: <YuvyGzevAMWyd0K5@mit.edu>
References: <CAMxJVdH6_CAhe1ToJnFB55dQAJd81HD0vUDgZ_1Ub=9QKJbHjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMxJVdH6_CAhe1ToJnFB55dQAJd81HD0vUDgZ_1Ub=9QKJbHjg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 04, 2022 at 11:57:40AM -0400, Eric D wrote:
> I and a colleague of mine have been unable to send email to this list
> from our work accounts; the mail server always responds with the
> following:
> 
> git@vger.kernel.org
> 23.128.96.18
> Remote Server returned '554 5.7.1 <23.128.96.18 #5.7.1 smtp; 553 5.7.1
> Hello [23.128.96.19], for your MAIL FROM address
> <edecosta@mathworks.com> policy analysis reported: Your address is not
> liked source for email>'
> 
> Can this be corrected? Is there any additional information that I can provide?

Mathworks.com has the following SPF settings (found by running "dig -t
TXT mathworks.com"):

mathworks.com.          900     IN      TXT     "v=spf1 ip4:144.212.130.25 ip4:144.212.244.25 include:spf-misc.mathworks.com include:spf.protection.outlook.com include:us._netblocks.mimecast.com include:_spf.salesforce.com ?exists:%{i}._spf.mathworks.com ~all"

The ip address 23.128.96.19 reverse resolves to lindbergh.monkeyblade.net.

At a guess, after expanding the indlude: fields for the SPF record for
mathworks.com, it looks like individual IP addresses that are manually
added by the mathworks.com postmaster are stored in
spf-misc.mathworks.com and spf-misc1.mathworks.com.  For example:

% dig -t TXT spf-misc.mathworks.com
	...
spf-misc.mathworks.com. 900     IN      TXT     "v=spf1 ip4:144.212.128.24/29 ip4:142.0.160.0/20 ip4:144.212.100.42/32 ip4:208.185.229.0/24 ip4:208.185.235.0/24 ip4:12.130.57.0/24 include:spf-misc1.mathworks.com ~all"
	...

So it looks like you and your colleague need to ask your work's mail
admins to add the IP addresses of the hosts from which you send e-mail
to mathworks.com's SPF allow list.  Alternatively, they may tell you
to reconfigure your mailers to use one of mathworks.com's mail
submission servers.

Cheers,

					- Ted
