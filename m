Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F26C433E0
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 13:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDDED2081A
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 13:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hX/ucCPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgFZNj6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:39:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29615 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726169AbgFZNj6 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jun 2020 09:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593178797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e5GPYUh5mptmP+w8eMv9rtH4WHfju8Vbea/19ikUXPM=;
        b=hX/ucCPF5FjrZhPU9xgO7Ofuuxw1wGwZRJ1Gt5WybsLcyNSNzr/ZAr6co/0V+Jrm7fXe4I
        uSBkP5iQM91Z3Wp+ycQdimrk882BO4klzbl31ViOj5nGIRnR/xAb+XOpdQYMrmPs3xarBn
        oZAxe30xGKWPoRGPdfdISEAhHXdU8eA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-eiFsY1UKMTmuYYpXbpWcgQ-1; Fri, 26 Jun 2020 09:39:52 -0400
X-MC-Unique: eiFsY1UKMTmuYYpXbpWcgQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FD9F100CCC1;
        Fri, 26 Jun 2020 13:39:51 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3850D60CD1;
        Fri, 26 Jun 2020 13:39:49 +0000 (UTC)
Date:   Fri, 26 Jun 2020 09:39:47 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] send-email: restore --in-reply-to superseding behavior
Message-ID: <20200626133947.GB2235017@optiplex-lnx>
References: <20200624195520.2062298-1-aquini@redhat.com>
 <xmqqo8p85eud.fsf@gitster.c.googlers.com>
 <20200624234539.GH1987277@optiplex-lnx>
 <20200625184715.GC2117795@optiplex-lnx>
 <CAPUEspgoDUGUmFqoKkmKDpRzSB5dQNb+PasaPjbPwb04SBz=Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPUEspgoDUGUmFqoKkmKDpRzSB5dQNb+PasaPjbPwb04SBz=Ww@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 25, 2020 at 06:08:24PM -0700, Carlo Arenas wrote:
> a test case in t/t9001-send-email.sh will also help, as I am not sure
> this might be "expected behaviour" as hinted in the man page for
> git-send-email (under --thread):
> 
> "It is up to the user to ensure that no In-Reply-To header already exists
>   exists when git send-email is asked to add it (especially note that
>   git format-patch can be configured to do the threading itself).
>   Failure to do so may not produce the expected result in the
>   recipient's MUA."
>

A quick note: this change does not break that assumption, as well.
The "ensure it exists" part means the header must either be in the
messages, as populated by format-patch, or it is provided by the
--in-reply-to switch option. send-email --thread is not orthogonal, 
but complementar with --in-reply-to, AFAICS.

The problem we have, right now, is that "send-email --in-reply-to" input gets 
dropped on the floor if you don't explicitly do "format-patch --no-thread" (or
extract a single patch), and this is a behavior regression introduced after v2.17.2


I took a glance in the test-cases, an it seems this is already covered:

test_expect_success $PREREQ 'in-reply-to but no threading' '
        git send-email \
                --dry-run \
                --from="Example <nobody@example.com>" \
                --to=nobody@example.com \
                --in-reply-to="<in-reply-id@example.com>" \
                --no-thread \
                $patches >out &&
        grep "In-Reply-To: <in-reply-id@example.com>" out
'

Cheers,
-- Rafael

