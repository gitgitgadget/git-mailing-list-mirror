From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: filter-branch env-filter example
Date: Thu, 14 Feb 2013 16:24:59 -0500
Message-ID: <20130214212459.GA8005@sigill.intra.peff.net>
References: <511D3C33.6070902@hell.org.pl>
 <7vy5eqy6z3.fsf@alter.siamese.dyndns.org>
 <20130214210910.GA6660@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tadeusz Andrzej =?utf-8?Q?Kad=C5=82ubowski?= <yess@hell.org.pl>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 22:25:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U66J6-0005os-DF
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 22:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210Ab3BNVZC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 16:25:02 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48956 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759032Ab3BNVZB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 16:25:01 -0500
Received: (qmail 24082 invoked by uid 107); 14 Feb 2013 21:26:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Feb 2013 16:26:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2013 16:24:59 -0500
Content-Disposition: inline
In-Reply-To: <20130214210910.GA6660@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216334>

On Thu, Feb 14, 2013 at 04:09:10PM -0500, Jeff King wrote:

> I think the advice in the documentation about re-exporting is because
> some versions of the bourne shell will not reliably pass the new version
> of the variable when you do this:
> 
>   VAR=old
>   export VAR
>   VAR=new
>   some_subprocess ;# we see $VAR=old here!
> 
> I do not recall ever running across such a shell myself, but rather
> hearing about it third-hand in a portability guide somewhere.

The closest I could find in the autoconf shell guidelines[1] is that the
automagic export marking for incoming variables is not always accurate:

	export
            The builtin export dubs a shell variable environment
            variable. Each update of exported variables corresponds to
            an update of the environment variables.  Conversely, each
            environment variable received by the shell when it is
            launched should be imported as a shell variable marked as
            exported.

            Alas, many shells, such as Solaris 2.5, IRIX 6.3, IRIX 5.2,
            AIX 4.1.5, and Digital UNIX 4.0, forget to export the
            environment variables they receive. As a result, two
            variables coexist: the environment variable and the shell
            variable. The following code demonstrates this failure:

	    #! /bin/sh
	    echo $FOO
	    FOO=bar
	    echo $FOO
	    exec /bin/sh $0

            when run with `FOO=foo' in the environment, these shells
            will print alternately `foo' and `bar', although it should
            only print `foo' and then a sequence of `bar's.

            Therefore you should export again each environment variable
            that you update.

I don't know what the behavior would be on such shells of:

	#!/bin/sh
	echo $FOO
	FOO=bar
	export FOO
	echo $FOO
	exec /bin/sh $0

I.e., would the "export" correctly reconcile the local and environment
copies of the variable, or are they forever broken? I don't have such a
system to test on. But that would more closely match what we are doing.

-Peff

[1] https://www.gnu.org/software/autoconf/manual/autoconf.html#Limitations-of-Builtins
