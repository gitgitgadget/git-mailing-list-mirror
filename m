Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,PLING_QUERY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE2A71FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 18:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752491AbdCaSma (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 14:42:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:55051 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751644AbdCaSm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 14:42:29 -0400
Received: (qmail 13715 invoked by uid 109); 31 Mar 2017 18:42:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 31 Mar 2017 18:42:26 +0000
Received: (qmail 12362 invoked by uid 111); 31 Mar 2017 18:42:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 31 Mar 2017 14:42:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 31 Mar 2017 14:42:23 -0400
Date:   Fri, 31 Mar 2017 14:42:23 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: SHA1 collision in production repo?! (probably not)
Message-ID: <20170331184223.4im6sollr3vfahxw@sigill.intra.peff.net>
References: <4D74C1D4-9EA7-4A17-AFC5-0B54B4A6DD0E@gmail.com>
 <xmqqh929z6wl.fsf@gitster.mtv.corp.google.com>
 <20170331174515.j2ruifuigskyvucc@sigill.intra.peff.net>
 <20170331174827.zheqstwtlsqtxa6e@sigill.intra.peff.net>
 <xmqq4ly9z4tx.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4ly9z4tx.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2017 at 11:19:54AM -0700, Junio C Hamano wrote:

> > Er, no, that's totally wrong. "status' may be holding the type. It
> > should really be:
> >
> >   return status < 0 ? status : 0;
> 
> Sounds more like it.  The only caller will say "ah, that object is
> not available to us---let's try packs again", which is exactly what
> we want to happen.

Right. Callers cannot distinguish between "did not have it" and
"corrupted", but that is no different than the rest of the sha1-file
interface.

> There is another bug in the codepath: the assignment to *oi->typep
> in the pre-context must guard against negative status value.  By
> returning an error correctly like you do above, that bug becomes
> more or less irrelevant, though.

I think that is intentional. OBJ_BAD is -1 (though the callers are
assuming that error() == OBJ_BAD). And that type gets relayed through
sha1_object_info() as the combined type/status return value.

-Peff
