From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/3] connect: improve check for plink to reduce false
 positives
Date: Fri, 26 Jun 2015 09:15:24 -0400
Message-ID: <20150626131524.GA2626@peff.net>
References: <1429914505-325708-1-git-send-email-sandals@crustytoothpaste.net>
 <1430080212-396370-1-git-send-email-sandals@crustytoothpaste.net>
 <1430080212-396370-4-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri Jun 26 15:15:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8TTh-0006XC-NK
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 15:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbbFZNP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 09:15:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:52221 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752115AbbFZNP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 09:15:26 -0400
Received: (qmail 5981 invoked by uid 102); 26 Jun 2015 13:15:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Jun 2015 08:15:26 -0500
Received: (qmail 16066 invoked by uid 107); 26 Jun 2015 13:15:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Jun 2015 09:15:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jun 2015 09:15:24 -0400
Content-Disposition: inline
In-Reply-To: <1430080212-396370-4-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272778>

On Sun, Apr 26, 2015 at 08:30:12PM +0000, brian m. carlson wrote:

> The git_connect function has code to handle plink and tortoiseplink
> specially, as they require different command line arguments from
> OpenSSH (-P instead of -p for ports; tortoiseplink additionally requires
> -batch).  However, the match was done by checking for "plink" anywhere
> in the string, which led to a GIT_SSH value containing "uplink" being
> treated as an invocation of putty's plink.
> 
> Improve the check by looking for "plink" or "tortoiseplink" (or those
> names suffixed with ".exe") only in the final component of the path.
> This has the downside that a program such as "plink-0.63" would no
> longer be recognized, but the increased robustness is likely worth it.
> Add tests to cover these cases to avoid regressions.

FYI, this ended up biting me today. We have some integration tests that
make sure we can clone over putty, and we wrap plink in a
"plink-wrapper.sh" script that tweaks a few extra options. That used to
match under the old scheme, but not the new. It would also match if we
looked for "plink" anywhere in the basename (but not in leading
directories).

I was able to work around it pretty easily by changing our test setup,
but I thought I would include it here as a data point. It's probably not
that representative of real-world users.

-Peff
