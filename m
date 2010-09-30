From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 13/16] send-email: extract_valid_address use qr//
 regexes and /o
Date: Thu, 30 Sep 2010 12:19:12 -0400
Message-ID: <20100930161912.GA8707@sigill.intra.peff.net>
References: <1285854189-10240-1-git-send-email-avarab@gmail.com>
 <1285854189-10240-14-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ryan Anderson <rda@google.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 18:19:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1Lqy-0004UT-M3
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 18:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756680Ab0I3QTO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 12:19:14 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:32865 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753531Ab0I3QTN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 12:19:13 -0400
Received: (qmail 23088 invoked by uid 111); 30 Sep 2010 16:19:12 -0000
Received: from 129-79-255-204.dhcp-bl.indiana.edu (HELO sigill.intra.peff.net) (129.79.255.204)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 30 Sep 2010 16:19:12 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Sep 2010 12:19:12 -0400
Content-Disposition: inline
In-Reply-To: <1285854189-10240-14-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157686>

On Thu, Sep 30, 2010 at 01:43:06PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> Change the regex fragment in extract_valid_address to use the qr//
> syntax for compiled regexes, and when they're used add a /o flag so
> they're only compiled once for the lifetime of the program.
> [...]
>  sub extract_valid_address {
>  	my $address =3D shift;
> -	my $local_part_regexp =3D '[^<>"\s@]+';
> -	my $domain_regexp =3D '[^.<>"\s@]+(?:\.[^.<>"\s@]+)+';
> +	my $local_part_regexp =3D qr/[^<>"\s@]+/;
> +	my $domain_regexp =3D qr/[^.<>"\s@]+(?:\.[^.<>"\s@]+)+/;
> =20

Hmm. But these are lexical variables, so won't we recompile them each
time we enter the subroutine? I don't think it affects correctness, as
this "/o":

> +	return $address if ($address =3D~ /^($local_part_regexp)$/o);

means that we will compile and use the value from the first time we run
the function.

But we are unnecessarily compiling the sub-regexes each time. Not that
this is probably a performance critical piece of code, but your "/o" is
doing very little, and this is exactly the sort perl wankery that I fin=
d
interesting.

Sadly, there is no real perl equivalent of C static local variables,
which is what you really want.  Usually I would do:

  {
    my $local_part_regexp =3D qr/.../;
    sub extract_valid_address {
      ...
    }
  }

but beware of the execution order. That works well in a module, where
the module code is executed before anybody calls the function. But it
breaks in something like this:

  foo();
  {
    my $foo_static_local =3D 5;
    sub foo {
      print "$foo_static_local\n";
    }
  }

I think you could get by with:

  {
    my $local_part_regexp;
    sub extract_valid_address {
      $local_part_regexp ||=3D qr/.../;
      ...
    }
  }

-Peff
