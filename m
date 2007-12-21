From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: Add --suppress-all-from option.
Date: Fri, 21 Dec 2007 09:43:48 -0800
Message-ID: <7vfxxw7xkb.fsf@gitster.siamese.dyndns.org>
References: <1198216860-487-1-git-send-email-git@davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Fri Dec 21 18:44:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5lv8-0002bN-KO
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 18:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbXLURoC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 12:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753264AbXLURoC
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 12:44:02 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38335 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900AbXLURoA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 12:44:00 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C47D04B82;
	Fri, 21 Dec 2007 12:43:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F19C24B81;
	Fri, 21 Dec 2007 12:43:49 -0500 (EST)
In-Reply-To: <1198216860-487-1-git-send-email-git@davidb.org> (David Brown's
	message of "Thu, 20 Dec 2007 22:01:00 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69078>

David Brown <git@davidb.org> writes:

> Sometimes, it is useful to be able to send a patch to a third party
> without the author of the patch being copied on the message.

I would agree with the cause, but not necessarily with the
execution.

> +--suppress-all-from, --no-suppress-all-from::
> +        If this is set, do not add the From: address to the cc: list,
> +        even if it is different than the person sending the email.
> +        Default is the value of the 'sendemail.suppressallfrom'
> +        configuration value; if that is unspecified, default to
> +        -no-suppress-all-from.

The option name feels as if it is somehow affecting From: but
this is all about recipients.  It needs to be named better.

Even more importantly, git-send-email has too many places that
pick up additional recipients.  I doubt --suppress-foo to
suppress one such source "foo" is sustainable.  We should try to
clean up the mess, not adding to it.

So let's analyze the current situation first.  It seems that we
currently pick up the list of recipients from the following
places:

 * obviously, --to command line;
 * mbox Cc: header lines;
 * mbox From: header lines;
 * lots-of-email first line
 * $cc_cmd output;
 * Signed-off-by: lines in body;
 * Cc: lines in body;

The --no-signed-off-cc option is about omitting the last two
from the recipients.  We do not have a way to squelch other
sources of extra recipients, hence the need for your patch.

The --suppress-from option is about not giving an extra copy to
the sender.  It is "suppress from-address from the recipient
list", so the option name makes sense.

Your --suppress-all-from, from a cursory read of your patch,
omits only mbox Cc: and From: line recipients -- it is far from
"all", isn't it?  --signed-off-cc defaults to true so you would
need to suppress that at least to call it "all".

A cleaner approach might be:

 - introduce a helper function add_to_recipients that take \@cc,
   $recipient and the "source class".  Make this function
   responsible for not adding the sender to the list
   (i.e. --suppress-from, which is currently checked
   everywhere), and for not adding recipients from specified
   classes of sources, like this:

        sub add_to_recipients {
                my ($cc, $source, $recipient) = @_;
                return 0 if ($suppress_from and $sender eq $recipient);
                return 0 if ($suppressed_recipient_source{$source});
                push @$cc, $recipient;
                return 1;
        }

   Instead of returning 1 unconditionally, it might make sense
   to omit pushing duplicate here and to return 0 when
   $recipient was already in @$cc.

 - adjust the places where "push @cc" happens to use the above
   helper; the existing suppress logic in the callers can and
   should be removed as the add_to_recipients will be
   responsible for it, like this (an example for cc-cmd part):

        if (defined $cc_cmd) {
        open(F, "$cc_cmd $t |")
                or die "(cc-cmd) Could not execute '$cc_cmd'";
        while(<F>) {
                my $c = $_;
                $c =~ s/^\s*//g;
                $c =~ s/\n$//g;
-               next if ($c eq $sender and $suppress_from);
-               push @cc, $c;
+               next if (!add_to_recipients(\@cc, 'cccmd', $c));
                printf("(cc-cmd) Adding cc: %s from: '%s'\n",
                        $c, $cc_cmd) unless $quiet;
        }

 - define a global %suppressed_recipient_source hash to be used
   in add_to_recipients().  The existing --no-signed-off-cc is
   about adding two sources to this hash.

 - make the %suppressed_recipient_source configurable from the
   command line and repository configuration.

As to the "recipient source" classes, I think they can be
categorized as:

 * 'cc', to cover mbox Cc: header, lots-of-email first line, and
    Cc: lines in body;

 * 'sob', to cover Signed-off-by: lines in body;

 * 'cccmd', to cover $cc_cmd output;

Hmm?
