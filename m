Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9E951F461
	for <e@80x24.org>; Mon,  9 Sep 2019 14:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfIIOZN (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 10:25:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:44122 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725294AbfIIOZN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 10:25:13 -0400
Received: (qmail 19342 invoked by uid 109); 9 Sep 2019 14:25:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Sep 2019 14:25:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9034 invoked by uid 111); 9 Sep 2019 14:27:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Sep 2019 10:27:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Sep 2019 10:25:12 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Blake <eblake@redhat.com>
Cc:     Christian Schoenebeck <qemu_oss@crudebyte.com>,
        qemu-devel@nongnu.org, git@vger.kernel.org, berrange@redhat.com,
        stefanha@gmail.com, Greg Kurz <groug@kaod.org>,
        dgilbert@redhat.com, antonios.motakis@huawei.com
Subject: Re: [Qemu-devel] [PATCH v6 0/4] 9p: Fix file ID collisions
Message-ID: <20190909142511.GA20726@sigill.intra.peff.net>
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <46fe6c73-961f-d72a-77de-88491b6f223c@redhat.com>
 <4642438.ai5u8AxThJ@silver>
 <1897173.eDCz7oYxVq@silver>
 <305577c2-709a-b632-4056-6582771176ac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <305577c2-709a-b632-4056-6582771176ac@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 09, 2019 at 09:05:45AM -0500, Eric Blake wrote:

> > But as you can already read from the manual, the overall behaviour of git 
> > regarding a separate "From:" line in the email body was intended solely for 
> > the use case sender != author. So in practice (at least in my git version) git 
> > always makes a raw string comparison between sender (name and email) string 
> > and author string and only adds the separate From: line to the body if they 
> > differ.
> > 
> > Hence also "git format-patch --from=" only works here if you use a different 
> > author string (name and email) there, otherwise on a perfect string match it 
> > is simply ignored and you end up with only one "From:" in the email header.
> 
> git folks:
> 
> How hard would it be to improve 'git format-patch'/'git send-email' to
> have an option to ALWAYS output a From: line in the body, even when the
> sender is the author, for the case of a mailing list that munges the
> mail headers due to DMARC/DKIM reasons?

It wouldn't be very hard to ask format-patch to just handle this
unconditionally. Something like:

diff --git a/pretty.c b/pretty.c
index e4ed14effe..9cf79d7874 100644
--- a/pretty.c
+++ b/pretty.c
@@ -451,7 +451,8 @@ void pp_user_info(struct pretty_print_context *pp,
 		map_user(pp->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
 
 	if (cmit_fmt_is_mail(pp->fmt)) {
-		if (pp->from_ident && ident_cmp(pp->from_ident, &ident)) {
+		if (pp->always_use_in_body_from ||
+		    (pp->from_ident && ident_cmp(pp->from_ident, &ident))) {
 			struct strbuf buf = STRBUF_INIT;
 
 			strbuf_addstr(&buf, "From: ");

but most of the work would be ferrying that option from the command line
down to the pretty-print code.

That would work in conjunction with "--from" to avoid a duplicate. It
might require send-email learning about the option to avoid doing its
own in-body-from management. If you only care about send-email, it might
be easier to just add the option there.

-Peff
