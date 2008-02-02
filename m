From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2][Perlers?] git-send-email: ssh/login style password requests
Date: Sat, 02 Feb 2008 13:31:17 -0800
Message-ID: <7vve5711wa.fsf@gitster.siamese.dyndns.org>
References: <7vve586tbz.fsf@gitster.siamese.dyndns.org>
	<1201925161-9864-1-git-send-email-mfwitten@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Sat Feb 02 22:32:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLPy2-0006a1-M9
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 22:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761996AbYBBVbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 16:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757323AbYBBVbe
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 16:31:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55058 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380AbYBBVbd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 16:31:33 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FF4F546A;
	Sat,  2 Feb 2008 16:31:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 752835467;
	Sat,  2 Feb 2008 16:31:29 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72303>

Michael Witten <mfwitten@MIT.EDU> writes:

>  2 files changed, 53 insertions(+), 9 deletions(-)

Documentation part looks very clear.  Thanks.

> +		if (defined $smtp_authuser) {
> +
> +			if (!defined $smtp_authpass) {
> +				
> +				system "stty -echo";
> +
> +				do {
> +					$_ = $term->readline("Password: ");
> +				} while (!defined $_);
> +
> +				system "stty echo";
> +
> +				$smtp_authpass = $_ if ($_);
> +			}
> +

Another example which appears in PerlFAQ #8 uses ReadKey with
its ReadLine, like this:

    use Term::ReadKey;
    ReadMode('noecho');
    $password = ReadLine(0);

which is different from Term::ReadLine's "ReadLine".  An earlier
example you cited from perlfunc.pod's crypt() entry does:

    system "stty -echo";
    print "Password: ";
    chomp($word = <STDIN>);
    print "\n";
    system "stty echo";

In either case, I was worried about the interaction between the
Term::ReadLine backend implementation and "stty".

Actually, I just tried this myself:

    #!/usr/bin/perl -w

    use Term::ReadLine;
    my $term = new Term::ReadLine 'foobar';

    my ($user, $password);
    while (!defined $user) {
            $user = $term->readline("User: ");
    }
    system 'stty -echo';
    while (!defined $password) {
            $password = $term->readline("Password: ");
    }
    system 'stty echo';
    print "You said <$user><$password>\n";
    print "ReadLine backend used was ", $term->ReadLine, "\n";

In my case, the backend was "Term::ReadLine::Perl".  A few
problems:

 * After typing "junio <Enter>" to "User:", an extra newline is
   left before "Password:" prompt;

 * "Password:" prompt still echoed password "abc".  There was no
   extra newline before "You said <junio><abc>".

 * In either case, typing <Enter> returns an empty string from
   $term->readline() so the "while (!defined)" loop does not buy
   us anything.


 
