From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] unpack-trees: do not abort when overwriting an
 existing file with the same content
Date: Mon, 21 Jan 2013 18:15:15 -0500
Message-ID: <20130121231515.GD17156@sigill.intra.peff.net>
References: <1358594648-26851-1-git-send-email-pclouds@gmail.com>
 <1358768433-26096-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 00:15:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxQab-0000py-RW
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 00:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240Ab3AUXPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 18:15:18 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41804 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620Ab3AUXPR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 18:15:17 -0500
Received: (qmail 20546 invoked by uid 107); 21 Jan 2013 23:16:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 Jan 2013 18:16:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Jan 2013 18:15:15 -0500
Content-Disposition: inline
In-Reply-To: <1358768433-26096-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214173>

On Mon, Jan 21, 2013 at 06:40:33PM +0700, Nguyen Thai Ngoc Duy wrote:

> +	/*
> +	 * If it has the same content that we are going to overwrite,
> +	 * there's no point in complaining. We still overwrite it in
> +	 * the end though.
> +	 */
> +	if (ce &&
> +	    S_ISREG(st->st_mode) && S_ISREG(ce->ce_mode) &&
> +	    (!trust_executable_bit ||
> +	     (0100 & (ce->ce_mode ^ st->st_mode)) == 0) &&
> +	    st->st_size < SAME_CONTENT_SIZE_LIMIT &&
> +	    sha1_object_info(ce->sha1, &ce_size) == OBJ_BLOB &&
> +	    ce_size == st->st_size) {
> +		void *buffer = NULL;
> +		unsigned long size;
> +		enum object_type type;
> +		struct strbuf sb = STRBUF_INIT;
> +		int matched =
> +			strbuf_read_file(&sb, ce->name, ce_size) == ce_size &&
> +			(buffer = read_sha1_file(ce->sha1, &type, &size)) != NULL &&
> +			type == OBJ_BLOB &&
> +			size == ce_size &&
> +			!memcmp(buffer, sb.buf, size);
> +		free(buffer);
> +		strbuf_release(&sb);
> +		if (matched)
> +			return 0;
> +	}

Can you elaborate on when this code is triggered?

In the general case, shouldn't we already know the sha1 of what's on
disk in the index, and be able to just compare the hashes? And if we
don't, because the entry is start-dirty, should we be updating it
(possibly earlier, so we do not even get into the "need to write" code
path) instead of doing this ad-hoc byte comparison?

Confused...

-Peff
