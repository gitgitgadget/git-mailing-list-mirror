Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C413B201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 23:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbdBXXn6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 18:43:58 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:39850 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751212AbdBXXn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 18:43:57 -0500
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1chPW1-0007YV-Go; Fri, 24 Feb 2017 23:43:09 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <22704.50445.435156.883001@chiark.greenend.org.uk>
Date:   Fri, 24 Feb 2017 23:43:09 +0000
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Joey Hess <id@joeyh.name>, git@vger.kernel.org
Subject: Re: SHA1 collisions found
In-Reply-To: <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
        <22704.19873.860148.22472@chiark.greenend.org.uk>
        <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano writes ("Re: SHA1 collisions found"):
> Ian Jackson <ijackson@chiark.greenend.org.uk> writes:
> >  * Therefore the transition needs to be done by giving every object
> >    two names (old and new hash function).  Objects may refer to each
> >    other by either name, but must pick one.  The usual shape of
> 
> I do not think it is necessrily so.

Indeed.  And my latest thoughts involve instead having two parallel
systems of old and new objects.

> *1* In the above toy example, length being 40 vs 64 is used as a
>     sign between SHA-1 and the new hash, and careful readers may
>     wonder if we should use sha-3,20769079d22... or something like
>     that that more explicity identifies what hash is used, so that
>     we can pick a hash whose length is 64 when we transition again.

I have an idea for this.  I think we should prefix new hashes with a
single uppercase letter, probably H.

Uppercase because: case-only-distinguished ref names are already
discouraged because they do not work properly on case-insensitive
filesystems; convention is that ref names are lowercase; so an
uppercase letter probably won't appear at the start of a ref name
component even though almost all existing software will treat it as
legal.  So the result is that the new object names are unlikely to
collide with ref names.

(There is of course no need to store the H as a literal in filenames,
so the case-insensitive filesystem problem does not apply to ref
names.)

We should definitely not introduce new punctuation into object names.
That will cause a great deal of grief for existing software which has
to handle git object names and may thy to store them in
representations which assume that they match \w+.

The idea of using the length is a neat trick, but it cannot support
the dcurrent object name abbreviation approach unworkable.

Ian.
