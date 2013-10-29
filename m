From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] remote-curl: fix large pushes with GSSAPI
Date: Mon, 28 Oct 2013 22:17:47 -0400
Message-ID: <20131029021747.GF11861@sigill.intra.peff.net>
References: <1382826882-48704-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Oct 29 03:18:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vaysa-0006ML-PH
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 03:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757199Ab3J2CRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 22:17:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:57485 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753496Ab3J2CRu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 22:17:50 -0400
Received: (qmail 31862 invoked by uid 102); 29 Oct 2013 02:17:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Oct 2013 21:17:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Oct 2013 22:17:47 -0400
Content-Disposition: inline
In-Reply-To: <1382826882-48704-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236889>

On Sat, Oct 26, 2013 at 10:34:42PM +0000, brian m. carlson wrote:

> Enable the use of the Expect: 100-continue header for large requests where the
> server offers GSSAPI authentication to avoid this issue, since the request would
> otherwise fail.  This allows git to get the authentication data right before
> sending the pack contents.  Existing cases where pushes would succeed, including
> small requests using GSSAPI, still disable the use of 100 Continue, as it causes
> problems for some remote HTTP implementations (servers and proxies).

This iteration looks very reasonable to me.

One minor nit:

> +		slot = get_active_slot();
> +		curl_easy_getinfo(slot->curl, CURLINFO_HTTPAUTH_AVAIL, &authtype);
> +		if (authtype & CURLAUTH_GSSNEGOTIATE)
> +			needs_100_continue = 1;

According to curl_easy_getinfo(3), CURLINFO_HTTPAUTH_AVAIL was
introduced in 7.10.8 (and it looks like CURLAUTH_GSSNEGOTIATE came
earlier in 7.10.6). We should probably surround it with

  #if LIBCURL_VERSION_NUM >= 0x070a08

-Peff
