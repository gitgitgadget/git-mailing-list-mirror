Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02A7D1F404
	for <e@80x24.org>; Tue, 27 Mar 2018 16:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752967AbeC0QLP (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 12:11:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:44826 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752945AbeC0QLN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 12:11:13 -0400
Received: (qmail 10617 invoked by uid 109); 27 Mar 2018 16:11:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 27 Mar 2018 16:11:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31029 invoked by uid 111); 27 Mar 2018 16:12:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 27 Mar 2018 12:12:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Mar 2018 12:11:11 -0400
Date:   Tue, 27 Mar 2018 12:11:11 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        sbeller@google.com, stolee@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCH v6 07/35] connect: convert get_remote_heads to use struct
 packet_reader
Message-ID: <20180327161110.GA24747@sigill.intra.peff.net>
References: <20180314183213.223440-1-bmwill@google.com>
 <20180315173142.176023-1-bmwill@google.com>
 <20180315173142.176023-8-bmwill@google.com>
 <20180327152714.GA27050@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180327152714.GA27050@duynguyen.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 27, 2018 at 05:27:14PM +0200, Duy Nguyen wrote:

> On Thu, Mar 15, 2018 at 10:31:14AM -0700, Brandon Williams wrote:
> > In order to allow for better control flow when protocol_v2 is introduced
> > +static enum protocol_version discover_version(struct packet_reader *reader)
> > +{
> > +	enum protocol_version version = protocol_unknown_version;
> > +
> > +	/*
> > +	 * Peek the first line of the server's response to
> > +	 * determine the protocol version the server is speaking.
> > +	 */
> > +	switch (packet_reader_peek(reader)) {
> > +	case PACKET_READ_EOF:
> > +		die_initial_contact(0);
> > +	case PACKET_READ_FLUSH:
> 
> gcc is dumb. When -Werror and -Wimplicit-fallthrough are enabled (on
> at least gcc 7.x), it fails to realize that this die_initial_contact()
> will not fall through (even though we do tell it about die() not
> returning, but I guess that involves more flow analysis to realize
> die_initial_contact is in the same boat).
> [...]
> @@ -124,6 +124,7 @@ enum protocol_version discover_version(struct packet_reader *reader)
>  	switch (packet_reader_peek(reader)) {
>  	case PACKET_READ_EOF:
>  		die_initial_contact(0);
> +		break;

Would it make sense just to annotate that function to help the flow
analysis? Like:

diff --git a/connect.c b/connect.c
index c3a014c5ba..49eca46462 100644
--- a/connect.c
+++ b/connect.c
@@ -46,7 +46,7 @@ int check_ref_type(const struct ref *ref, int flags)
 	return check_ref(ref->name, flags);
 }
 
-static void die_initial_contact(int unexpected)
+static NORETURN void die_initial_contact(int unexpected)
 {
 	if (unexpected)
 		die(_("The remote end hung up upon initial contact"));

That should let the callers know what's going on, and inside the
function itself, the compiler should confirm that all code paths hit
another NORETURN function.

-Peff
