From: Dennis Stosberg <dennis@stosberg.net>
Subject: Re: Running gitweb under mod_perl
Date: Thu, 24 Aug 2006 21:32:21 +0200
Message-ID: <20060824193220.G4a28fdc4@leonov.stosberg.net>
References: <eck6sq$agn$1@sea.gmane.org> <eckor9$jje$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 24 21:32:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGKwG-0002zN-5r
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 21:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbWHXTcZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 15:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbWHXTcZ
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 15:32:25 -0400
Received: from kleekamp.stosberg.net ([85.116.201.130]:4993 "EHLO
	kleekamp.stosberg.net") by vger.kernel.org with ESMTP
	id S1751600AbWHXTcY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 15:32:24 -0400
Received: by kleekamp.stosberg.net (Postfix, from userid 500)
	id 87B1511D36A; Thu, 24 Aug 2006 21:32:21 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: attachment
In-Reply-To: <eckor9$jje$1@sea.gmane.org>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25974>

Jakub Narebski wrote:

> By the way, does the "static" variables works under mod_perl? i.e.
> 
> {
>   my $private_var = "something"
> 
>   sub some_sub {
>     ...
>   }
> 
>   sub other_sub {
>     ...
>   }
> }

Depends on what you expect.  The variable will remain shared between
those subs over successive executions, but it will not be reinitialised
to "something" -- at least not visibly to the subs:

On the first invocation, $private_var is initialised and the two
subroutines are created.  Internally, they refer to the _instance_ of
$private_var.  The next time the script is run by mod_perl, $private_var
gets initialised again, but the subs are persistent and still refer to
the old instance.  _Their_ copy of the variable will still be shared
between them, but it will not be reset to "something".

So it should work, but I would avoid such a construction if possible.

Apache::Registry wraps the whole script in another function, which
is called on each request, so your piece of code really looks somewhat
like this:

#!/usr/bin/perl
sub handler {
    # do something
    {
        my $a = 'A';
	sub sub_a { $a .= 'B' }
	sub sub_b { print $a."\n" }
    }
    sub_a();
    sub_b();
}
for(1..10) { handler() }

Regards,
Dennis
