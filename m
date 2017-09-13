Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 932E3209B8
	for <e@80x24.org>; Wed, 13 Sep 2017 11:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbdIMLPE (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 07:15:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:36484 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751645AbdIMLPD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 07:15:03 -0400
Received: (qmail 32093 invoked by uid 109); 13 Sep 2017 11:15:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 11:15:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12852 invoked by uid 111); 13 Sep 2017 11:15:38 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 07:15:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2017 07:15:01 -0400
Date:   Wed, 13 Sep 2017 07:15:01 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/4] replace-objects: evaluate replacement refs without
 using the object store
Message-ID: <20170913111501.cosukqzf76oy65ow@sigill.intra.peff.net>
References: <20170912172330.GA144745@aiede.mtv.corp.google.com>
 <20170912173140.GD144745@aiede.mtv.corp.google.com>
 <fe956802-41ab-783f-62b3-f7c4b8292e8c@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe956802-41ab-783f-62b3-f7c4b8292e8c@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2017 at 10:03:58AM +0200, Michael Haggerty wrote:

> On 09/12/2017 07:31 PM, Jonathan Nieder wrote:
> > From: Stefan Beller <sbeller@google.com>
> > 
> > Pass DO_FOR_EACH_INCLUDE_BROKEN when iterating over replacement refs
> > so that the iteration does not require opening the named objects from
> > the object store. This avoids a dependency cycle between object access
> > and replace ref iteration.
> > 
> > Moreover the ref subsystem has not been migrated yet to access the
> > object store via passed in repository objects.  As a result, without
> > this patch, iterating over replace refs in a repository other than
> > the_repository it produces errors:
> > 
> >    error: refs/replace/3afabef75c627b894cccc3bcae86837abc7c32fe does not point to a valid object!
> > 
> > Noticed while adapting the object store (and in particular its
> > evaluation of replace refs) to handle arbitrary repositories.
> 
> Have you checked that consumers of this API can handle broken
> references? Aside from missing values, broken references can have
> illegal names (though hopefully not unsafe in the sense of causing
> filesystem traversal outside of `$GITDIR`).

It looks like there are only two callers. One complains about
names that aren't 40-hex. The other ("git replace -l") parses the 40-hex
in "long" mode, but will print anything in short mode (not that printing
is very dangerous).

I do have to wonder if for_each_replace_ref() should just do the 40-hex
syntactic check itself (and issue a warning for other refs). It seems
like that would be the point of calling for_each_replace_ref() instead
of just for_each_ref_in("refs/replace") yourself, and both of the
callers would benefit.

-Peff
