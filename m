From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 5/5] git-send-email: use git credential to obtain
 password
Date: Mon, 11 Feb 2013 12:01:34 -0500
Message-ID: <20130211170134.GE16402@sigill.intra.peff.net>
References: <cover.1360599057.git.mina86@mina86.com>
 <fd7997960cad569d57f5330f2416f702db414169.1360599712.git.mina86@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Michal Nazarewicz <mina86@mina86.com>
To: Michal Nazarewicz <mpn@google.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 18:02:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4wlU-0003oX-7l
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 18:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758132Ab3BKRBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 12:01:37 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44355 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758036Ab3BKRBg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 12:01:36 -0500
Received: (qmail 23854 invoked by uid 107); 11 Feb 2013 17:03:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Feb 2013 12:03:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2013 12:01:34 -0500
Content-Disposition: inline
In-Reply-To: <fd7997960cad569d57f5330f2416f702db414169.1360599712.git.mina86@mina86.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216053>

On Mon, Feb 11, 2013 at 05:23:39PM +0100, Michal Nazarewicz wrote:

> +	# TODO: Authentication may fail not because credentials were
> +	# invalid but due to other reasons, in which we should not
> +	# reject credentials.
> +	$auth = Git::credential({
> +		'protocol' => 'smtp',
> +		'host' => join(':', $smtp_server, $smtp_server_port),
> +		'username' => $smtp_authuser,
> +		# if there's no password, "git credential fill" will
> +		# give us one, otherwise it'll just pass this one.
> +		'password' => $smtp_authpass
> +	}, sub {
> +		my $cred = shift;
> +		return !!$smtp->auth($cred->{'username'}, $cred->{'password'});
> +	});

What do we want to do about this TODO?

I am happy to put it off until it becomes a problem, but I wonder if the
Git::credential() interface is sufficient to express what we would want.
It only allows two return values: true for approve, false for reject.
But we would want a tri-state: approve, reject, indeterminate.

Reading the Net::SMTP code, it doesn't look like the information is even
available to us (it really just passes out success or failure), so I
don't think we can even make it work now. But it may be better to
prepare the public Git::credential interface for it now, so we do not
have to deal with breaking compatibility later.

-Peff
