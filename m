From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Sun, 22 Jun 2008 19:30:36 -0700
Message-ID: <7vd4m8khmb.fsf@gitster.siamese.dyndns.org>
References: <1214181904-30265-1-git-send-email-LeWiemann@gmail.com>
 <1214183688-8544-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 04:32:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAbqZ-0003sY-98
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 04:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015AbYFWCau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 22:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752831AbYFWCau
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 22:30:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37437 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753298AbYFWCat (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 22:30:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 18A911F850;
	Sun, 22 Jun 2008 22:30:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1C1A11F84D; Sun, 22 Jun 2008 22:30:40 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 63162CF0-40CC-11DD-9E4F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85830>

Lea Wiemann <lewiemann@gmail.com> writes:

> Changed since v5: honor $ENV{GITPERL} for gitweb.cgi execution, not
> just test execution:
>
>     diff --git a/t/t9503/test.pl b/t/t9503/test.pl
>     index 28894c5..947e2e8 100755
>     --- a/t/t9503/test.pl
>     +++ b/t/t9503/test.pl
>     @@ -54,5 +54,5 @@ my $gitweb = abs_path(File::Spec->catfile('..', '..', 'gitweb', 'gitweb.cgi'));
>      my $cgi = sub {
>             # Use exec, not the shell, to support blanks in the path.
>     -	my $status = system $gitweb $gitweb;
>     +	my $status = system { $ENV{GITPERL} } $ENV{GITPERL}, $gitweb;
>             my $value  = $status >> 8;

My Perl must be getting rusty.  I had to look up this tricky syntax in
perlfunc.pod, under "=item exec", with examples like:

            $shell = '/bin/csh';
            exec $shell '-sh';		# pretend it's a login shell

        or, more directly,

            exec {'/bin/csh'} '-sh';	# pretend it's a login shell

>  t/t9503-gitweb-Mechanize.sh |  132 ++++++++++++++++
>  t/t9503/test.pl             |  354 +++++++++++++++++++++++++++++++++++++++++++
>  t/test-lib.sh               |    2 +
>  3 files changed, 488 insertions(+), 0 deletions(-)
>  create mode 100755 t/t9503-gitweb-Mechanize.sh
>  create mode 100755 t/t9503/test.pl
>
> diff --git a/t/t9503-gitweb-Mechanize.sh b/t/t9503-gitweb-Mechanize.sh
> new file mode 100755
> index 0000000..3fe6d8b
> --- /dev/null
> +++ b/t/t9503-gitweb-Mechanize.sh
> @@ -0,0 +1,132 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2008 Jakub Narebski
> +# Copyright (c) 2008 Lea Wiemann

If you mean by this that originally Jakub started and then Lea continued
extending the work, probably the order of Sign-off should match that order
to express the patch flow trail better.

> +# check if test can be run
> +"$GITPERL" -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1 || {
> +	test_expect_success \
> +		'skipping gitweb tests, perl version is too old' :
> +	test_done
> +	exit
> +}
> +
> +"$GITPERL" -MTest::WWW::Mechanize::CGI -e '' >/dev/null 2>&1 || {
> +	test_expect_success \
> +		'skipping gitweb tests, Test::WWW::Mechanize::CGI not found' :
> +	test_done
> +	exit
> +}

Nice touch.
