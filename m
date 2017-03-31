Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,PLING_QUERY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8353D1FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 17:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933451AbdCaRpU (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 13:45:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:55008 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933313AbdCaRpT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 13:45:19 -0400
Received: (qmail 10276 invoked by uid 109); 31 Mar 2017 17:45:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 31 Mar 2017 17:45:17 +0000
Received: (qmail 11804 invoked by uid 111); 31 Mar 2017 17:45:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 31 Mar 2017 13:45:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 31 Mar 2017 13:45:15 -0400
Date:   Fri, 31 Mar 2017 13:45:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: SHA1 collision in production repo?! (probably not)
Message-ID: <20170331174515.j2ruifuigskyvucc@sigill.intra.peff.net>
References: <4D74C1D4-9EA7-4A17-AFC5-0B54B4A6DD0E@gmail.com>
 <xmqqh929z6wl.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh929z6wl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2017 at 10:35:06AM -0700, Junio C Hamano wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
> 
> > Hi,
> >
> > I just got a report with the following output after a "git fetch" operation
> > using Git 2.11.0.windows.3 [1]:
> >
> > remote: Counting objects: 5922, done.
> > remote: Compressing objects: 100% (14/14), done.
> > error: inflate: data stream error (unknown compression method)
> > error: unable to unpack 6acd8f279a8b20311665f41134579b7380970446 header
> > fatal: SHA1 COLLISION FOUND WITH 6acd8f279a8b20311665f41134579b7380970446 !
> > fatal: index-pack failed
> >
> > I would be really surprised if we discovered a SHA1 collision in a production
> > repo. My guess is that this is somehow triggered by a network issue (see data
> > stream error). Any tips how to debug this?
> 
> Perhaps the first thing to do is to tweak the messages in builtin/index-pack.c
> to help you identify which one of identical 5 messages is firing.
> 
> My guess would be that the code saw an object that came over the
> wire, hashed it to learn that its object name is
> 6acd8f279a8b20311665f41134579b7380970446, noticed that it locally
> already has the object with the same name, and tried to make sure
> they have identical contents (otherwise, what came over the wire is
> a successful second preimage attack).  But your loose object on disk
> you already had was corrupt and didn't inflate correctly when
> builtin/index-pack.c::compare_objects() or check_collision() tried
> to.  The code saw no data, or truncated data, or
> whatever---something different from what the other data that hashed
> down to 6acd8..., and reported a collision when there is no
> collision.

My guess is the one in compare_objects(). The "unable to unpack" error
comes from sha1_loose_object_info(). We'd normally then follow up with
read_sha1_file(), which would generate its own set of errors.

But if open_istream() got a bogus value for the object size (but didn't
correctly report an error), then it would probably quietly return 0
bytes from read_istream() later.

I suspect this may improve things, but I haven't dug deeper to see if
there are unwanted side effects, or if there are other spots that need
similar treatment.

diff --git a/sha1_file.c b/sha1_file.c
index 43990dec7..38411f90b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2952,7 +2952,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	if (status && oi->typep)
 		*oi->typep = status;
 	strbuf_release(&hdrbuf);
-	return 0;
+	return status;
 }
 
 int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)

-Peff
