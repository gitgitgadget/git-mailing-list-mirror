Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F26F21FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 17:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933075AbcLNRai (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 12:30:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:56501 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932694AbcLNRah (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 12:30:37 -0500
Received: (qmail 9890 invoked by uid 109); 14 Dec 2016 17:30:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 17:30:36 +0000
Received: (qmail 26984 invoked by uid 111); 14 Dec 2016 17:31:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 12:31:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2016 12:30:34 -0500
Date:   Wed, 14 Dec 2016 12:30:34 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] fix pushing to //server/share/dir paths on Windows
Message-ID: <20161214173034.inbyakdykjv5j7ua@sigill.intra.peff.net>
References: <2ff2613c-47da-a780-5d38-93e16cb16328@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ff2613c-47da-a780-5d38-93e16cb16328@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2016 at 10:32:01PM +0100, Johannes Sixt wrote:

> normalize_path_copy() is not prepared to keep the double-slash of a
> //server/share/dir kind of path, but treats it like a regular POSIX
> style path and transforms it to /server/share/dir.
> 
> The bug manifests when 'git push //server/share/dir master' is run,
> because tmp_objdir_add_as_alternate() uses the path in normalized
> form when it registers the quarantine object database via
> link_alt_odb_entries(). Needless to say that the directory cannot be
> accessed using the wrongly normalized path.

Thanks for digging this up! I had a feeling that the problem was going
to be in the underlying path code, but I didn't want to just pass the
buck without evidence. :)

> -	if (is_dir_sep(*src)) {
> +	/*
> +	 * Handle initial part of absolute path: "/", "C:/", "\\server\share/".
> +	 */
> +	offset = offset_1st_component(src);
> +	if (offset) {
> +		/* Convert the trailing separator to '/' on Windows. */
> +		memcpy(dst, src, offset - 1);
> +		dst += offset - 1;
>  		*dst++ = '/';

Hmm. So this is the "change-of-behavior" bit. Would it be reasonable to
write:

  /* Copy initial part of absolute path, converting separators on Windows */
  const char *end = src + offset_1st_component(src);
  while (src < end) {
	  char c = *src++;
	  if (c == '\\')
		  c = '/';
	  *dst++ = c;
  }

? I'm not sure if it's wrong to convert backslashes in that first
component or not (but certainly we were before). I don't think we'd need
is_dir_sep() in that "if()", because we can leave slashes as-is. But
maybe it would make the code easier to read.

-Peff
