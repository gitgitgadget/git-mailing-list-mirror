Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826B2C2BA19
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 13:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593BA23107
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 13:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgDFNal (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:30:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:34240 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728319AbgDFNal (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 09:30:41 -0400
Received: (qmail 23536 invoked by uid 109); 6 Apr 2020 13:30:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Apr 2020 13:30:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9888 invoked by uid 111); 6 Apr 2020 13:41:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Apr 2020 09:41:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 6 Apr 2020 09:30:40 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Emma Brooks <me@pluvano.com>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] format-patch: teach --no-encode-headers
Message-ID: <20200406133040.GB1276@coredump.intra.peff.net>
References: <20200405231109.8249-1-me@pluvano.com>
 <20200406030444.GG6369@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200406030444.GG6369@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 06, 2020 at 03:04:44AM +0000, brian m. carlson wrote:

> On 2020-04-05 at 23:11:09, Emma Brooks wrote:
> > When commit subjects or authors have non-ASCII characters, git
> > format-patch Q-encodes them so they can be safely sent over email.
> > However, if the patch transfer method is something other than email (web
> > review tools, sneakernet), this only serves to make the patch metadata
> > harder to read without first applying it (unless you can decode RFC 2047
> > in your head). git am as well as some email software supports
> > non-Q-encoded mail as described in RFC 6531.
> 
> Do we always output UTF-8 in this case, or do we sometimes output other
> encodings if the user has specified one for the commit message?

That was my first question, too. But I think even without this option,
we always respect i18n.logOutputEncoding before we even hit the email
pretty-printing code. So by default it would always be utf8 (and
otherwise whatever the user has asked us to output).

That would obviously be disastrous for an output encoding that isn't an
ASCII superset, but that's already true for any of our output formats.

> Do we know how git send-email handles such a message if it receives
> one?
> 
> I know it isn't your intention to work with git send-email in this
> patch, but it would be nice to know whether there's additional value in
> someone sending a followup patch to make git send-email use SMTPUTF8 if
> that's necessary.

I suspect this is mostly orthogonal, as that deals only with the
SMTP-level addresses, which include only the actual email part (not the
name) and aren't RFC2047-encoded anyway. It looks like we already leave
characters in addresses untouched (I'm not even 100% sure that RFC2047
allows modifying within the local part of an addr):

  $echo foo >file
  $ git add file
  $ git -c user.email=péff@peff.net commit -m foo
  $ git format-patch -1 --stdout | grep From:
  From: Jeff King <péff@peff.net>

I did wonder if there are any standards around 8bit headers. Certainly
the de facto standard for local tools (e.g., mutt reading a message
you've edited in vim) is that they can be treated like a stream of
ASCII-compatible bytes, and that works pretty well in practice. But if
there's an IETF-endorsed method for 8bit headers, it would be nice to
use it. For 8bit bodies, we're able to give a content-transfer-encoding
and a content-type with the charset. But I don't know of an equivalent
for headers.

-Peff
