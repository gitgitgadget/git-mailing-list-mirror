From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3 v2] send-email: --suppress-cc improvements
Date: Fri, 13 Feb 2009 22:36:21 -0800
Message-ID: <7vzlgpzfru.fsf@gitster.siamese.dyndns.org>
References: <1234583491-61260-4-git-send-email-jaysoffian@gmail.com>
 <1234589823-67610-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 07:38:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYEAR-0004T4-51
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 07:38:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbZBNGge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 01:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbZBNGgd
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 01:36:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbZBNGgc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 01:36:32 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C45C02B180;
	Sat, 14 Feb 2009 01:36:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 479182B181; Sat,
 14 Feb 2009 01:36:23 -0500 (EST)
In-Reply-To: <1234589823-67610-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Sat, 14 Feb 2009 00:37:03 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D0812DB8-FA61-11DD-A1FF-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109830>

Jay Soffian <jaysoffian@gmail.com> writes:

> From: Jay Soffian <jaysoffian@gmail.com>
>
> Commit 656482830ddc4a4e2af132fabb118a25190439c2 added the --suppress-cc
> option. However, it made --suppress-cc=sob suppress both SOB lines and
> body Cc lines (but not header Cc lines), which seems contrary to how
> it is named.
>
> After this commit, 'sob' suppresses only SOB lines and --suppress-cc
> takes two additional values:

I know it's just wording, but it always makes my skin tingle when I see
"Before this commit, blah, after this commit bah."  Maybe it's just me?
The logic flows more naturally if you say "X does Y.  It is not good for
such and such reasons.  This patch changes it to do Z.", at least to me.

>  * 'body' suppresses both SOB and body Cc lines (i.e. what 'sob'
>     used to do).
>
>  * 'bodycc' suppresses body Cc lines, but not header Cc lines.
>
> For backwards compatibility, --no-signed-off-by-cc, acts like 'body'.

I had to read this sentence three time.  Giving --no-signed-off-by-cc is
the same as giving --suppress-cc=body, meaning it suppresses both S-o-b
and in-body Cc addresses?

It looks very weird to say "For backwards compatibility," immediately
after you said "screw backward compatibility" by changing the meaning of
"sob" without even justifying why it is a good idea in the commit log
message.

You are changing the semantics of "sob" because you believe the new
definition is much saner (and I happen to agree with you but that is
besides the point).  When the user says --no-signed-off-by-cc, the user
asks not to Cc: people who have sign-offs in the log message; I'd say it
would be more natural to screw the backward compatibility here as well and
give it a saner and more natural semantics of suppressing S-o-b but not
in-body Cc.  No?

> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index ff4aeff..d6af035 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -166,12 +166,14 @@ Automating
>  	Specify an additional category of recipients to suppress the
>  	auto-cc of.  'self' will avoid including the sender, 'author' will
>  	avoid including the patch author, 'cc' will avoid including anyone
> +	mentioned in Cc lines in the patch header, 'ccbody' will avoid
> +	including anyone mentioned in Cc lines in the patch body (commit
> +	message), 'sob' will avoid including anyone mentioned in Signed-off-by
> +	lines, and 'cccmd' will avoid running the --cc-cmd. 'body' is
> +	equivalent to 'sob' + 'ccbody'. 'all' will suppress all auto cc
> +	values.  Default is the value of 'sendemail.suppresscc' configuration
> +	value; if that is unspecified, default to 'self' if --suppress-from is
> +	specified, as well as 'body' if --no-signed-off-cc is specified.

Perhaps with this many choices, it would be better to rewrite this into a
list form.

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 2a3e3e8..23a55e2 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -319,21 +319,28 @@ my(%suppress_cc);
>  if (@suppress_cc) {
>  	foreach my $entry (@suppress_cc) {
>  		die "Unknown --suppress-cc field: '$entry'\n"
> -			unless $entry =~ /^(all|cccmd|cc|author|self|sob)$/;
> +			unless $entry =~ /^(all|cccmd|cc|author|self|sob|body|bodycc)$/;
>  		$suppress_cc{$entry} = 1;
>  	}
>  }
>  
>  if ($suppress_cc{'all'}) {
> -	foreach my $entry (qw (ccmd cc author self sob)) {
> +	foreach my $entry (qw (ccmd cc author self sob body bodycc)) {
>  		$suppress_cc{$entry} = 1;
>  	}
>  	delete $suppress_cc{'all'};
>  }
>  
> +if ($suppress_cc{'sob'} && $suppress_cc{'bodycc'}) {
> +	$suppress_cc{'body'} = 1;
> +}

Hmmm.

I wonder if doing this the other way around, and treat 'body' as a mere
shorthand of setting 'sob' and 'bodycc', just like we do to 'all' (which
is just a shorthand to set all of them), and delete $suppress_cc{'body'},
would make the program much less error prone in the longer term, because
then each test needs to check the independent flags and do not have to
worry about a synthetic flag 'body'.

It's just a common sense futureproofing.  More of your code will resist
possible changes to the meaning of 'body' in the future that way..

>  # Debugging, print out the suppressions.
>  if (0) {
> @@ -1007,14 +1014,16 @@ foreach my $t (@files) {
>  	# Now parse the message body
>  	while(<F>) {
>  		$message .=  $_;
> +		next if $suppress_cc{'body'};
>  		if (/^(Signed-off-by|Cc): (.*)$/i) {
>  			chomp;
> +			my ($what, $c) = ($1, $2);
>  			chomp $c;
> +			next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
> +			next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
>  			next if ($c eq $sender and $suppress_cc{'self'});
>  			push @cc, $c;
> +			printf("(body) Adding cc: %s from line '%s'\n",
>  				$c, $_) unless $quiet;

Looks sane.

> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index da54835..d7766f9 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -32,11 +32,11 @@ clean_fake_sendmail() {
>  }
>  
>  test_expect_success 'Extract patches' '
> -    patches=`git format-patch --cc="One <one@example.com>" --cc=two@example.com -n HEAD^1`
> +    patches=`git format-patch -s --cc="One <one@example.com>" --cc=two@example.com -n HEAD^1`
>  '
>  
>  test_expect_success 'Send patches' '
> -     git send-email --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" $patches 2>errors
> +     git send-email --suppress-cc=sob --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" $patches 2>errors
>  '

Looks sane.

> @@ -74,6 +74,7 @@ EOF
>  test_expect_success 'Show all headers' '
>  	git send-email \
>  		--dry-run \
> +		--suppress-cc=sob \
>  		--from="Example <from@example.com>" \
>  		--to=to@example.com \
>  		--cc=cc@example.com \

It is somewhat troublesome that only sob suppression is tested, output
from messages that do have in-body S-o-b/Cc without any --suppress-cc is
not tested anymore, and none of the new ones you added is tested.  You can
build confidence in the working of the suppression that way, but you would
also want to test that your new code is not over-suppressing things by
mistake.

When writing new tests, people tend to concentrate so much on showing the
new feature works in writing positive tests to forget that negative tests
are equally important.
