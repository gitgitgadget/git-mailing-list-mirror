From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] allow hooks to ignore their standard input stream
Date: Fri, 13 Nov 2015 18:23:20 -0500
Message-ID: <20151113232320.GB16173@sigill.intra.peff.net>
References: <20151111143920.GA30409@musxeris015.imu.intel.com>
 <20151111144222.GA24717@musxeris015.imu.intel.com>
 <20151113061729.GC32157@sigill.intra.peff.net>
 <20151113093303.GA4111@musxeris015.imu.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, junio@pobox.com
To: Clemens Buchacher <clemens.buchacher@intel.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 00:23:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxNgl-0003mb-RZ
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 00:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbbKMXXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 18:23:24 -0500
Received: from cloud.peff.net ([50.56.180.127]:57318 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751085AbbKMXXX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 18:23:23 -0500
Received: (qmail 16596 invoked by uid 102); 13 Nov 2015 23:23:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 17:23:23 -0600
Received: (qmail 29642 invoked by uid 107); 13 Nov 2015 23:23:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 18:23:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Nov 2015 18:23:20 -0500
Content-Disposition: inline
In-Reply-To: <20151113093303.GA4111@musxeris015.imu.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281272>

On Fri, Nov 13, 2015 at 10:33:03AM +0100, Clemens Buchacher wrote:

> Since ec7dbd145 (receive-pack: allow hooks to ignore its standard input stream)
> the pre-receive and post-receive hooks ignore SIGPIPE. Do the same for the
> remaining hooks pre-push and post-rewrite, which read from standard input. The
> same arguments for ignoring SIGPIPE apply.
> 
> Performance improvements which allow us to enable the test by
> default by Jeff King.

I actually did add a new test. The existing one was basically this:

> +test_expect_success 'filling pipe buffer does not cause failure' '
> +	git push parent1 "refs/heads/b/*:refs/heads/b/*" &&
> +	test_cmp expected actual
> +'

It actually _does_ read all of the input, but I guess is making sure we
call write() in a loop. I don't know if this is even worth keeping.

Can you think of a good reason that it is checking something
interesting?

> +test_expect_success 'sigpipe does not cause pre-push hook failure' '
> +	echo "exit 0" | write_script "$HOOK" &&
> +	git push parent1 "refs/heads/b/*:refs/heads/c/*"
> +'

This is the new one which checks your code.

-Peff
