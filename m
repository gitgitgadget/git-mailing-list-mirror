From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] test-lib.sh: set PERL5LIB instead of GITPERLLIB
Date: Mon, 02 Jun 2008 13:01:40 -0700
Message-ID: <7v4p8b7gij.fsf@gitster.siamese.dyndns.org>
References: <4843FEE2.1070708@gmail.com>
 <1212415996-32130-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lea Wiemann <LeWiemann@gmail.com>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 22:03:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3GFQ-0004Zs-HZ
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 22:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754538AbYFBUB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 16:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754530AbYFBUB5
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 16:01:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54894 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754330AbYFBUBy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 16:01:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 973D234D3;
	Mon,  2 Jun 2008 16:01:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A265C34CD; Mon,  2 Jun 2008 16:01:46 -0400 (EDT)
In-Reply-To: <1212415996-32130-1-git-send-email-LeWiemann@gmail.com> (Lea
 Wiemann's message of "Mon, 2 Jun 2008 16:13:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BD32A676-30DE-11DD-8941-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83561>

Lea Wiemann <lewiemann@gmail.com> writes:

> From: Lea Wiemann <lewiemann@gmail.com>
>
> By setting PERL5LIB for the tests, we enable Perl test scripts to just
> say "use Git;" without adding the GITPERLLIB paths to @INC beforehand.
>
> Also, unset GITPERLLIB so that user-set paths in GETPERLLIB don't
> cause the wrong module to be loaded.
>
> Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
> ---
> Added since v1: Unset GITPERLLIB.

This goes even further in the opposite direction from the original.  It
looks cleaner, and I'd prefer the approach _if_ it worked.

But I do not think it does.

I think the reason we did not do this long time ago in 6fcca93 (Use
$GITPERLLIB instead of $RUNNING_GIT_TESTS and centralize @INC munging,
2006-07-03) was because of the precedence between "use lib @these_paths"
and $PERL5LIB does not work the way you seem to think it does.

If you say in your script:

	use lib '/usr/local/git/perl'
        use Git;

(and we do want to say so in our script to make sure that people can
install Git.pm outside of system install paths), running the script with
PERL5LIB set to elsewhere that has Git.pm would not help.

I just tried:

	$ pwd
        /net/knick/home/junio/junk/
	$ cat j.perl
        #!/usr/bin/perl -w
        use lib '/net/knick/home/junio/junk/1dir';
        use G;
        print $G::it;
        $ cat 1dir/G.pm
        package G;
        our $it = 1;
        1;
        $ cat 2dir/G.pm
        package G;
        our $it = 2;
        1;
        $ perl -w j.perl
        1
        $ PERL5LIB=/net/knick/home/junio/junk/2dir perl -w j.perl
        1

Because "t/t9700/<many>.perl" will _not_ be installed anyway, I do not
think they need to be "built" like the scripted Porcelain commands.  If
they unconditionally do "use lib $ENV{GITPERLLIB};" upfront, wouldn't that
be enough to guarantee that you would use the freshly built one during the
test, not the instsalled one?
