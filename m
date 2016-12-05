Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 705C71FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 13:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbcLENXl (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 08:23:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:51741 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751223AbcLENXj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 08:23:39 -0500
Received: (qmail 23829 invoked by uid 109); 5 Dec 2016 13:23:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Dec 2016 13:23:36 +0000
Received: (qmail 4954 invoked by uid 111); 5 Dec 2016 13:24:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Dec 2016 08:24:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Dec 2016 08:23:34 -0500
Date:   Mon, 5 Dec 2016 08:23:34 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>, Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH v3 00/16] Add initial experimental external ODB
 support
Message-ID: <20161205132334.vlojtzecfhvhedew@sigill.intra.peff.net>
References: <20161130210420.15982-1-chriscool@tuxfamily.org>
 <A5ABBF3E-BED9-4FF3-9DE5-B529DEF0B8E8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A5ABBF3E-BED9-4FF3-9DE5-B529DEF0B8E8@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 03, 2016 at 07:47:51PM +0100, Lars Schneider wrote:

> >  - "<command> have": the command should output the sha1, size and
> > type of all the objects the external ODB contains, one object per
> > line.
> 
> This looks impractical. If a repo has 10k external files with
> 100 versions each then you need to read/transfer 1m hashes (this is
> not made up - I am working with Git repos than contain >>10k files
> in GitLFS).

Are you worried about the client-to-server communication, or the pipe
between git and the helper? I had imagined that the client-to-server
communication happen infrequently and be cached.

But 1m hashes is 20MB, which is still a lot to dump over the pipe.
Another option is that Git defines a simple on-disk data structure
(e.g., a flat file of sorted 20-byte binary sha1s), and occasionally
asks the filter "please update your on-disk index".

That still leaves open the question of how the external odb script
efficiently gets updates from the server. It can use an ETag or similar
to avoid downloading an identical copy, but if one hash is added, we'd
want to know that efficiently. That is technically outside the scope of
the git<->external-odb interface, but obviously it's related. The design
of the on-disk format might be make that problem easier or harder on the
external-odb script.

> Wouldn't it be better if Git collects all hashes that it currently 
> needs and then asks the external ODBs if they have them?

I think you're going to run into latency problems when git wants to ask
"do we have this object" and expects the answer to be no. You wouldn't
want a network request for each.

And I think it would be quite complex to teach all operations to work on
a promise-like system where the answer to "do we have it" might be
"maybe; check back after you've figured out the whole batch of hashes
you're interested in".

> >  - "<command> get <sha1>": the command should then read from the
> > external ODB the content of the object corresponding to <sha1> and
> > output it on stdout.
> > 
> >  - "<command> put <sha1> <size> <type>": the command should then read
> > from stdin an object and store it in the external ODB.
> 
> Based on my experience with Git clean/smudge filters I think this kind 
> of single shot protocol will be a performance bottleneck as soon as 
> people store more than >1000 files in the external ODB.
> Maybe you can reuse my "filter process protocol" (edcc858) here?

Yeah. This interface comes from my original proposal, which used the
rationale "well, the files are big, so process startup shouldn't be a
big deal". And I don't think I wrote it down, but an implicit rationale
was "it seems to work for LFS, so it should work here too". But of
course LFS hit scaling problems, and so would this. It was one of the
reasons I was interested in making sure your filter protocol could be
used as a generic template, and I think we would want to do something
similar here.

> > * Transfer
> > 
> > To tranfer information about the blobs stored in external ODB, some
> > special refs, called "odb ref", similar as replace refs, are used.
> > 
> > For now there should be one odb ref per blob. Each ref name should be
> > refs/odbs/<odbname>/<sha1> where <sha1> is the sha1 of the blob stored
> > in the external odb named <odbname>.
> > 
> > These odb refs should all point to a blob that should be stored in the
> > Git repository and contain information about the blob stored in the
> > external odb. This information can be specific to the external odb.
> > The repos can then share this information using commands like:
> > 
> > `git fetch origin "refs/odbs/<odbname>/*:refs/odbs/<odbname>/*"`

I'd worry about scaling this part. Traditionally our refs storage does
not scale very well.

-Peff
