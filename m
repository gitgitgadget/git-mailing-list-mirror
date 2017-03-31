Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,PLING_QUERY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 798A11FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 17:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933292AbdCaR1c (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 13:27:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:54983 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933217AbdCaR1c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 13:27:32 -0400
Received: (qmail 9254 invoked by uid 109); 31 Mar 2017 17:27:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 31 Mar 2017 17:27:29 +0000
Received: (qmail 11504 invoked by uid 111); 31 Mar 2017 17:27:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 31 Mar 2017 13:27:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 31 Mar 2017 13:27:27 -0400
Date:   Fri, 31 Mar 2017 13:27:27 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: SHA1 collision in production repo?! (probably not)
Message-ID: <20170331172726.z6w34kticc74bgec@sigill.intra.peff.net>
References: <4D74C1D4-9EA7-4A17-AFC5-0B54B4A6DD0E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4D74C1D4-9EA7-4A17-AFC5-0B54B4A6DD0E@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2017 at 06:05:17PM +0200, Lars Schneider wrote:

> I just got a report with the following output after a "git fetch" operation
> using Git 2.11.0.windows.3 [1]:
> 
> remote: Counting objects: 5922, done.
> remote: Compressing objects: 100% (14/14), done.
> error: inflate: data stream error (unknown compression method)
> error: unable to unpack 6acd8f279a8b20311665f41134579b7380970446 header
> fatal: SHA1 COLLISION FOUND WITH 6acd8f279a8b20311665f41134579b7380970446 !
> fatal: index-pack failed
> 
> I would be really surprised if we discovered a SHA1 collision in a production
> repo. My guess is that this is somehow triggered by a network issue (see data
> stream error). Any tips how to debug this?

I'd be surprised, too. :)

I'm not sure that inflate error actually comes from the network pack.
The "unable to unpack $sha1 header" message actually comes from
sha1_object_info_loose(). Which means we're failing to read our _local_
version of 6acd8f279a8b, which is an object we believe is coming in from
the network.

And that would explain the false-positive collision. We computed the
sha1 on something come from the network. We believe we have an object
with that sha1 already (but it's corrupted), and then when we compared
the real bytes to the corrupted bytes, they didn't match.

We should be able to confirm that by running "git fsck" on the local
repo, which I'd expect to complain about the loose object.

But what I find disturbing there is that we did not notice the failure
when accessing the loose object. It seems to have been lost in the call
chain. I think the problem is that sha1_loose_object_info() may report
errors in two ways: returning -1 if it did not find the object, or
putting OBJ_BAD into the type field if it found a corrupt object. But
callers are not aware of the second one.

I think it should probably return -1 for a corruption, too, and act as
if we don't have the object (because we effectively don't).

-Peff
