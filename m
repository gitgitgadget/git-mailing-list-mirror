Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E8A71FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 21:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbdBLVNy (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 16:13:54 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:34608 "EHLO
        homiemail-a14.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751348AbdBLVNx (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Feb 2017 16:13:53 -0500
Received: from homiemail-a14.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a14.g.dreamhost.com (Postfix) with ESMTP id D224A392076;
        Sun, 12 Feb 2017 13:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=
        mattmccutchen.net; bh=LN2xBJaGkxU3GbQ6x+EyZ9KpaaU=; b=MfttIS4p8J
        3oUsK2jLTrRP9LDyquoM24U7Zsl9bsh1mjbDqPeAXFaVI6WgUEKog46sG0TYh+Sq
        2S5oaKx9osjWmIXxetKQ2Coi4dOLjRVzae/V6UBhljLZe3hSYy+5PRnjW1iGXMOB
        JdnO0aNpbcZ9CA9L5meXJdTvmjEvbzfyc=
Received: from main (mdf2436d0.tmodns.net [208.54.36.223])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a14.g.dreamhost.com (Postfix) with ESMTPSA id 36ABE392075;
        Sun, 12 Feb 2017 13:13:42 -0800 (PST)
Message-ID: <1486934007.8517.10.camel@mattmccutchen.net>
Subject: Re: [PATCH] fetch: print an error when declining to request an
 unadvertised object
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Sun, 12 Feb 2017 16:13:27 -0500
In-Reply-To: <xmqqwpcxlwpv.fsf@gitster.mtv.corp.google.com>
References: <1486747828.17272.5.camel@mattmccutchen.net>
         <xmqqwpcxlwpv.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.4 (3.22.4-2.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-02-10 at 10:36 -0800, Junio C Hamano wrote:
> > 
> There is this piece of code near the end of builtin/fetch-pack.c:
> 
> [...]
> 
> that happens before the command shows the list of fetched refs, and
> this code is prepared to inspect what happend to the requests it (in
> response to the user request) made to the underlying fetch
> machinery, and issue the error message.
> If you change your command line to "git fetch-pack REMOTE SHA1", you
> do see an error from the above.

Yes, "error: no such remote ref NNNN", which at least makes clear that
the operation didn't work, though it would be nice to give a more
specific error message.

> This all happens in transport.c::fetch_refs_via_pack().
> I think that function is a much better place to error or die than
> filter_refs().

I confirmed that checking the sought refs there works.  However, in
filter_refs, it's easy to give a more specific error message that the
server doesn't allow requests for unadvertised objects, and that code
works for "git fetch-pack" too.  To do the same in fetch_refs_via_pack,
we'd have to duplicate a few lines of code from filter_refs and expose
the allow_unadvertised_object_request variable, or just set a flag on
the "struct ref" in filter_refs and check it in fetch_refs_via_pack.

What do you think?  Do you not care about having a more specific error,
in which case I can copy the code from builtin/fetch-pack.c to
fetch_refs_via_pack?  Or shall I add code to filter_refs to set a flag
and add code to builtin/fetch-pack.c and fetch_refs_via_pack to check
the flag?  Or what?

Matt
