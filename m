From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] ewah: fix building with gcc < 3.4.0
Date: Tue, 3 Feb 2015 11:35:45 -0500
Message-ID: <20150203163545.GB9325@peff.net>
References: <1422959227-3046-1-git-send-email-tgc@statsbiblioteket.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
X-From: git-owner@vger.kernel.org Tue Feb 03 17:35:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIgS8-0007LF-IK
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 17:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbbBCQfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 11:35:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:44592 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755984AbbBCQfr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 11:35:47 -0500
Received: (qmail 3675 invoked by uid 102); 3 Feb 2015 16:35:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Feb 2015 10:35:47 -0600
Received: (qmail 10797 invoked by uid 107); 3 Feb 2015 16:35:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Feb 2015 11:35:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Feb 2015 11:35:45 -0500
Content-Disposition: inline
In-Reply-To: <1422959227-3046-1-git-send-email-tgc@statsbiblioteket.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263325>

On Tue, Feb 03, 2015 at 11:27:07AM +0100, Tom G. Christensen wrote:

> The __builtin_ctzll function was added in gcc 3.4.0.
> This extends the check for gcc so that use of __builtin_ctzll is only
> enabled if gcc >= 3.4.0.
> ---
> 
> I noticed this on RHEL3 during 2.0.0rc phase but I see that the same
> issue was noticed on Debian Sarge:
> http://article.gmane.org/gmane.comp.version-control.git/255190
> RHEL3 ships with gcc 3.2.3.
> 
> With this patch git can build on RHEL3 provided cURL support is disabled.

Thanks. I built with some older gcc's at the time this was developed,
but I don't think I went past what was in Debian stable, which was
probably 4.something.

> -#ifdef __GNUC__
> +/* __builtin_ctzll was not available until 3.4.0 */
> +#if defined(__GNUC__) && (__GNUC__ > 3 || (__GNUC__ == 3  && __GNUC_MINOR > 3))
>  #define ewah_bit_ctz64(x) __builtin_ctzll(x)
>  #else
>  static inline int ewah_bit_ctz64(uint64_t x)

We could turn this into a HAS_CTZLL Makefile knob (and auto-set it as
above), but I don't think it is worth it. I don't expect anybody to need
to tweak it. I double-checked that clang sets the value of __GNUC__
appropriately.

-Peff
