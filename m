Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4FDC3DA78
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 23:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjAOXR5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 18:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjAOXR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 18:17:56 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A9E18179
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 15:17:55 -0800 (PST)
Received: (qmail 9248 invoked by uid 109); 15 Jan 2023 23:17:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Jan 2023 23:17:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25081 invoked by uid 111); 15 Jan 2023 23:17:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 15 Jan 2023 18:17:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 15 Jan 2023 18:17:54 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 2/3] http: prefer CURLOPT_SEEKFUNCTION to
 CURLOPT_IOCTLFUNCTION
Message-ID: <Y8SJoulYtKnfRgrO@coredump.intra.peff.net>
References: <Y8RddcM9Vr71ljp4@coredump.intra.peff.net>
 <Y8Rd0KXYcHKykvjq@coredump.intra.peff.net>
 <xmqqilh7fp4s.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqilh7fp4s.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 15, 2023 at 01:45:39PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The IOCTLFUNCTION option has been deprecated, and generates a compiler
> > warning in recent versions of curl. We can switch to using SEEKFUNCTION
> > instead. It was added in 2008 via curl 7.18.0; our INSTALL file already
> > indicates we require at least curl 7.19.4.
> > ...
> > +	if (offset < 0 || offset >= buffer->buf.len) {
> > +		error("curl seek would be outside of buffer");
> > +		return CURL_SEEKFUNC_FAIL;
> >  	}
> > +
> > +	buffer->posn = offset;
> > +	return CURL_SEEKFUNC_OK;
> >  }
> 
> Now we depend on having at least cURL 7.19.5 because
> CURL_SEEKFUNC_{FAIL,OK} are not available before that version.
> 
> cf.  https://github.com/curl/curl/blob/master/docs/libcurl/symbols-in-versions#L127

Ugh. I did not even check that, because why would anyone introduce the
return values in a separate version! ;)

> Which is fine, as 7.19.5 is from May 2009 that is old enough.  We
> just need to update the place where you got the 7.19.4 above from.

OK, if we are all right with bumping the version, I can squash that in.
The other option is to fall back to the obvious 0/1 for OK/FAIL, which
is what curl does. But that feels awfully hacky, and it would only be
used if you were at _exactly_ 7.19.4. So I prefer the bump if it's
acceptable.

diff --git a/INSTALL b/INSTALL
index 3344788397..d5694f8c47 100644
--- a/INSTALL
+++ b/INSTALL
@@ -139,7 +139,7 @@ Issues of note:
 	  not need that functionality, use NO_CURL to build without
 	  it.
 
-	  Git requires version "7.19.4" or later of "libcurl" to build
+	  Git requires version "7.19.5" or later of "libcurl" to build
 	  without NO_CURL. This version requirement may be bumped in
 	  the future.
 

-Peff
