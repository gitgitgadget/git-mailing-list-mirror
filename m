Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17687C433F5
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 23:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbhLEXRK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 18:17:10 -0500
Received: from tram.compute.dc.uq.edu.au ([130.102.189.36]:44679 "EHLO
        tram.compute.dc.uq.edu.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhLEXRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 18:17:09 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Dec 2021 18:17:09 EST
Received: from smtp1.compute.dc.uq.edu.au (smtp1.compute.dc.uq.edu.au [10.208.11.2])
        by tram.compute.dc.uq.edu.au (8.14.5/8.14.5) with ESMTP id 1B5N6WWQ117467;
        Mon, 6 Dec 2021 09:06:33 +1000
Received: from mailhub.eait.uq.edu.au (hazel.eait.uq.edu.au [130.102.60.17])
        by smtp1.compute.dc.uq.edu.au (8.14.5/8.14.5) with ESMTP id 1B5N6WJS040158
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Dec 2021 09:06:32 +1000
Received: from haru.mindrot.org (haru.mindrot.org [130.102.96.5])
        by mailhub.eait.uq.edu.au (8.15.1/8.15.1) with ESMTP id 1B5N6RcB020548;
        Mon, 6 Dec 2021 09:06:28 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
        by haru.mindrot.org (OpenSMTPD) with ESMTP id ce28f2a6;
        Mon, 6 Dec 2021 10:06:27 +1100 (AEDT)
Date:   Mon, 6 Dec 2021 10:06:27 +1100 (AEDT)
From:   Damien Miller <djm@mindrot.org>
To:     Fabian Stelzer <fs@gigacodes.de>
cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        pedro martelletto <pedro@yubico.com>
Subject: Re: [PATCH] gpg-interface: trim CR from ssh-keygen -Y
 find-principals
In-Reply-To: <20211204131149.cvyu7dvf6p66dotq@fs>
Message-ID: <70cee773-9547-e3cf-9327-ac0213d327e@mindrot.org>
References: <pull.1090.git.1638538276608.gitgitgadget@gmail.com> <Yao+l0ckDWZNf4AE@coredump.intra.peff.net> <20211204131149.cvyu7dvf6p66dotq@fs>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.73 on UQ Mailhub on 130.102.189.36
X-Scanned-By: MIMEDefang 2.75 on 130.102.60.17
X-UQ-FilterTime: 1638745594
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 4 Dec 2021, Fabian Stelzer wrote:

> > I'm guessing probably not, but when it comes to something with security
> > implications like this, it pays to be extra careful. I'm hoping somebody
> > familiar with the ssh-keygen side and how the rest of the parsing works
> > (like Fabian) can verify that this is OK.
> > 
> 
> A good point. I just tested this and CR is a valid character to use in a
> principal name in the allowed signers file and as of now the principal will be
> passed to the verify call `as is` and everything works just fine. When we
> introduce the patch above a principal with a CR in it will fail to verify.

Are you sure? I thought that we split principals in allowed_signers on
most whitespace, including \r. Follow:

https://github.com/openssh/openssh-portable/blob/e9c7149/sshsig.c#L742
https://github.com/openssh/openssh-portable/blob/e9c7149/misc.c#L452
https://github.com/openssh/openssh-portable/blob/e9c7149/misc.c#L408

> I've added Damien Miller to this thread. He knows more about what the expected
> behaviour for the principal would/should be. I think at the moment almost
> everything except \n or \0 goes. Maybe restricting \r as well would make life
> easier for other uses too?

IMO sensible content for the principals section would be printable, non-
whitespace characters, excluding wildcards ('*', '?'). ssh-keygen mostly
assumes that the file is in good order, but maybe it could be stricter.

> If we add `trust on first use` in a future series I would assume we use the
> email address from the commit/tag author ident when adding a new principal to
> the file. Can the ident contain a CR?
> Even if it did, I would only allow a list of allowed alphanumeric chars to be
> added anyway since a principal can contain wildcards which we obviously don't
> want to trust on first use ;).

Yeah. my mental model for the allowed_signers file is that it's similar
to ~/.ssh/authorized_keys in that it directly controls authn/authz
decisions, and if you put bad stuff in there then you're going to have
a bad day...

-d
