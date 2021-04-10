Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4ABC433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 00:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD4C461108
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 00:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbhDJA5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 20:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbhDJA5r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 20:57:47 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810A1C061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 17:57:33 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1618016251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vzEJ9JeJIHP8ORyRCsiUmh3EZfUUJzFdU+gmihz9fgI=;
        b=AYmcvvJFkCJy4ppVlAo3728nhz84eWog4ATp7vMPniPNjFLWlYC5+Q8imwoYmV0k7xbwEK
        pI3yXk9tWY+AOKeESj5MyhKR20qI+yognrGgN9v7gYnBQivoj/YWI2h65LCyyHh6qcwwHD
        uCvucC/kgmMndxIOo9T1axz75fJ1qH3BfETbpYusYGAE9dU5vFdzrjVCpSS7VjpCTg41lM
        s9EKS2x31ebLuhHaYc78qdW2KA96MMpGqexrI0B/wXp2jcS+DbhlbZiKct8QA+zhtS3BLQ
        5RATZPhZeqhj1CjEujQa3RFT8pqLfx8FUagOkKdR//WYOo9pLOfifkjSflDFxQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 09 Apr 2021 20:57:30 -0400
Message-Id: <CAJMW3X0O81L.8TNFDEFUNML1@taiga>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: clarify SMTP encryption settings
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Junio C Hamano" <gitster@pobox.com>
References: <20210409211812.3869-1-sir@cmpwn.com>
 <xmqqlf9rklkb.fsf@gitster.g>
In-Reply-To: <xmqqlf9rklkb.fsf@gitster.g>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri Apr 9, 2021 at 8:52 PM EDT, Junio C Hamano wrote:
> Hmph.
>
> Isn't SMTPS (running SMTP over SSL encrypted connection) the one
> that was once deprecated until it got resurrected)?

Kind of, back in the 90's, but that's water under the bridge now. SMTP
over SSL/TLS is the de-facto standard.

> STARTTLS is not all that SMTP specific---POP and IMAP can also start
> in cleartext and upgrade with STARTTLS the same way, no?

Well, email-specific, at least. Sorry for the confusion.

> I couldn't find a justification for our log message to call
> STARTTLS-style explicit TLS "deprecated". When you send an updated
> version, please give a reference.

The main concern with STARTTLS is downgrade attacks. I'll note this in
the commit message for v2.

> I think it is a vast improvement to describe what existing 'ssl' and
> 'tls' does, like the above does. It is a documentation update that
> deserves its own commit (i.e. [PATCH 1/3]), and it should be done
> before adding the new ssl/tls and starttls synonyms.
>
> Making it an error to give unrecognised string (i.e. other than
> 'ssl' and 'tls'), or at least warning, would be a good follow-up
> change (i.e. [PATCH 2/3]), but that is optional.
>
> And then, it may make sense to introduce the synonyms, but please
> make it a separate patch that builds on top of the other two steps
> (i.e. [PATCH 3/3]).

Ack, can do.

> In the ideal world, it would have been nice if we could make 'tls'
> as the name of the choice that has been known as 'ssl' (i.e. the
> underlying transport protocol to run SMTP or any other higher layer
> protocol on top, there used to be SSL but these days TLS is used as
> an improved alternative---SSL 2.0/3.0 have been deprecated for some
> time), but because we used 'tls' to mean the STARTTLS-style "start
> SMTP as plain and then upgrade to encrypted channel", we can't reuse
> the 'tls' for that purpose.
>
> I do not have any qualm about the fully spelled out "starttls"
> synonym for the latter. In fact, if we can go back in time and redo
> the history with hindsight, that is the name we should have used
> from the beginning. But I find it unfortunate that we need to say
> 'ssl/tls', i.e. prefixing the name of the choice with the name of a
> deprecated thing, for the former. Another reason I am hesitant
> about 'ssl/tls' is because the description of it in documentation
> naturally invites errors. I.e. "You can set it to 'ssl/tls'..."
> sounds as if the manual is telling me to use one of 'ssl' or 'tls',
> which is not what it is sayng---it literally wants me to say
> 'ssl/tls' with a slash in it.

If I may propose a bold alternative: what I added as "ssl/tls", i.e.
"modern" SSL, should be "yes", no encryption should be "no", and if you
specifically need starttls: "starttls".
