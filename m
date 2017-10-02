Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ED2320281
	for <e@80x24.org>; Mon,  2 Oct 2017 19:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751266AbdJBTlo (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 15:41:44 -0400
Received: from outbound1.eu.mailhop.org ([52.28.251.132]:55678 "EHLO
        outbound1.eu.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbdJBTln (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 15:41:43 -0400
X-MHO-User: b00e122a-a7a9-11e7-a893-25625093991c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 74.98.178.3
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [74.98.178.3])
        by outbound1.eu.mailhop.org (Halon) with ESMTPSA
        id b00e122a-a7a9-11e7-a893-25625093991c;
        Mon, 02 Oct 2017 19:41:31 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id E411880053;
        Mon,  2 Oct 2017 19:41:27 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io E411880053
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1506973288;
        bh=WYWprBI0Qp+OfITV4J77GXydUs/1G9uqmtZR4GpDkBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=g6q2rZJdAJRedf1aHaWQAPVgTEo73+vVXOg7erHfBmnuiQpi+gJ6oUVvyY7UBXHWH
         W5MtS/0K5s8BDHGNMt6iKdmegTK2LosTiT+KNcCSNDnm14vcTEF4S//yVgzNf7LFd9
         WNh6EBJeeaqPH2gic24a8fSg7OQ6qaV/bPooiiIiYCeJvpOaGRD3fo/jW+ytEubWLh
         VF/68N6GepDVMLToh5hFRwDS5NTnFXe/UEXch3fVZKBz1xLWXd3Cu9rfO1eEr2Nw5y
         mxcV3jGN3lZX26iP6ZUZYGvmFijok/9MJleb+ld1Ji3eaGSVu3n1R540ByDgj6ebky
         cLy5eA2GDP2qw==
Date:   Mon, 2 Oct 2017 19:41:27 +0000
From:   Jason Cooper <jason@lakedaemon.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shawn Pearce <spearce@spearce.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Masaya Suzuki <masayasuzuki@google.com>, demerphq@gmail.com,
        The Keccak Team <keccak@noekeon.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] technical doc: add a design doc for hash function
 transition
Message-ID: <20171002194127.GI31762@io.lakedaemon.net>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170307001709.GC26789@aiede.mtv.corp.google.com>
 <CAJo=hJtoX9=AyLHHpUJS7fueV9ciZ_MNpnEPHUz8Whui6g9F0A@mail.gmail.com>
 <20170928044320.GA84719@aiede.mtv.corp.google.com>
 <xmqqo9puvy1w.fsf@gitster.mtv.corp.google.com>
 <20170929173413.GI19555@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170929173413.GI19555@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 29, 2017 at 10:34:13AM -0700, Jonathan Nieder wrote:
> Junio C Hamano wrote:
> > Jonathan Nieder <jrnieder@gmail.com> writes:
...
> > If it is a goal to eventually be able to lose SHA-1 compatibility
> > metadata from the objects, then we might want to remove SHA-1 based
> > signature bits (e.g. PGP trailer in signed tag, gpgsig header in the
> > commit object) from NewHash contents, and instead have them stored
> > in a side "metadata" table, only to be used while converting back.
> > I dunno if that is desirable.
> 
> I don't consider that desirable.
> 
> A SHA-1 based signature is still of historical interest even if my
> centuries-newer version of Git is not able to verify it.

Agreed, even a signature made by a now exposed and revoked key still has
validity.  Especially in a commit or merge.  We know it was made prior
to the key being compromised / revoked.

This is assuming that the keyholder can definitively say "Don't trust
signatures from this key after this date/time+0000".  And the signature
in question is in the git history prior to that cut off.

Tags are a different animal because they can be added at any time and
aren't directly incorporated into the history.

thx,

Jason.
