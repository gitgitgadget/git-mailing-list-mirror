From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/8] lock_ref_sha1_basic(): do not set force_write for
 missing references
Date: Tue, 10 Feb 2015 19:05:20 -0500
Message-ID: <20150211000520.GA30561@peff.net>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
 <1423473164-6011-4-git-send-email-mhagger@alum.mit.edu>
 <CAGZ79kbrFpgF6_dLYdgT2D0JjWggu8edjV2sgXER5btpmyjDNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 01:05:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLKo3-0001ht-KE
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 01:05:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbbBKAFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 19:05:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:47506 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750905AbbBKAFX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 19:05:23 -0500
Received: (qmail 13886 invoked by uid 102); 11 Feb 2015 00:05:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 Feb 2015 18:05:22 -0600
Received: (qmail 11327 invoked by uid 107); 11 Feb 2015 00:05:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 Feb 2015 19:05:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Feb 2015 19:05:20 -0500
Content-Disposition: inline
In-Reply-To: <CAGZ79kbrFpgF6_dLYdgT2D0JjWggu8edjV2sgXER5btpmyjDNw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263662>

On Tue, Feb 10, 2015 at 03:24:47PM -0800, Stefan Beller wrote:

> On Mon, Feb 9, 2015 at 1:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> > If a reference is missing, its SHA-1 will be null_sha1, which can't
> > possibly match a new value that ref_transaction_commit() is trying to
> > update it to. So there is no need to set force_write in this scenario.
> >
> 
> This commit reverts half the lines of 5bdd8d4a3062a (2008-11, do not
> force write of packed refs). And reading both commit messages, they
> seem to contradict each other. (Both agree on  "If a reference is
> missing, its SHA-1 will be null_sha1 as provided by resolve_ref", but
> the conclusion seems to be different.)

Most of the lines of 5bdd8d4a3062a that are being reverted here are
caching the is_null_sha1() check in the "missing" variable. And that's
a cleanup in this patch that is not strictly necessary ("missing" would
only be used once, so it becomes noise).

The interesting thing in the earlier commit was to use the null sha1 to
cause a force-write, rather than lstat()ing the filesystem. And here we
are saying the force-write is not necessary at all, no matter what
storage scheme is used. So I don't think there is any contradiction
between the two.

Is this patch correct that the force-write is not necessary? I think so.
The force-write flag comes from:

commit 732232a123e1e61e38babb1c572722bb8a189ba3
Author: Shawn Pearce <spearce@spearce.org>
Date:   Fri May 19 03:29:05 2006 -0400

    Force writing ref if it doesn't exist.
    
    Normally we try to skip writing a ref if its value hasn't changed
    but in the special case that the ref doesn't exist but the new
    value is going to be 0{40} then force writing the ref anyway.

but I am not sure that logic still holds (if it ever did). We do not ever write
0{40} into a ref value.

-Peff
