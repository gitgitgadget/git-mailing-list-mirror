Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23D54205C9
	for <e@80x24.org>; Tue,  3 Jan 2017 01:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757236AbdACBcW (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 20:32:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:34465 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756288AbdACBcV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 20:32:21 -0500
Received: (qmail 21897 invoked by uid 109); 3 Jan 2017 01:32:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Jan 2017 01:32:20 +0000
Received: (qmail 21675 invoked by uid 111); 3 Jan 2017 01:33:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Jan 2017 20:33:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jan 2017 20:32:18 -0500
Date:   Mon, 2 Jan 2017 20:32:18 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git discussion list <git@vger.kernel.org>
Subject: Re: [PATCH 13/17] refs: convert each_reflog_ent_fn to struct
 object_id
Message-ID: <20170103013217.vctawyhpsd73frjc@sigill.intra.peff.net>
References: <20170101191847.564741-1-sandals@crustytoothpaste.net>
 <20170101191847.564741-14-sandals@crustytoothpaste.net>
 <49fcccfa-df28-c01b-0e51-1451ecf8e784@alum.mit.edu>
 <20170102191256.fjqsns3rgjyehzgp@genre.crustytoothpaste.net>
 <d5fc2830-37c2-9274-77b7-97ecc5f9b763@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d5fc2830-37c2-9274-77b7-97ecc5f9b763@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 03, 2017 at 12:30:40AM +0100, Michael Haggerty wrote:

> > I think
> > my next series is going to include a small sscanf-style parser to parse
> > these.  Right now, using constants here is going to leave it extremely
> > difficult to read.  Something like the following for the OIDs:
> > 
> >   strbuf_git_scanf(sb, "%h %h ", &ooid, &noid);
> > 
> > and then following up parsing the remainder.
> 
> Maybe something with an interface like skip_prefix wouldn't be too
> obnoxious:
> 
>     const char *p = sb.buf;
>     if (oid_prefix(p, &ooid, &p) &&
>         *p++ == ' ' &&
>         oid_prefix(p, &noid, &p) && ...

Yeah, I've used C code before that had a very similar interface for
parsing, and when used consistently it's pretty pleasant. Something
like:

  if (parse_oid(p, &oid, &p) &&
      skip_whitespace(p, &p) &&
      parse_refname(p, &refname, &p))

etc is nicer than some of the magic numbers we end up using in the
various parsers (I don't think anybody needs to mass-convert, I just
mean that something like parse_oid() seems like a step in a good
direction).

-Peff
