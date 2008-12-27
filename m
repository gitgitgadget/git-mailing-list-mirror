From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse-opt: migrate builtin-apply.
Date: Fri, 26 Dec 2008 23:29:42 -0800
Message-ID: <7vtz8qgjo9.fsf@gitster.siamese.dyndns.org>
References: <1230351727-20116-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Dec 27 08:35:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGTiB-0000GW-2A
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 08:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbYL0H3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2008 02:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbYL0H3v
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 02:29:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51923 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbYL0H3u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 02:29:50 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 685BF1B2C1;
	Sat, 27 Dec 2008 02:29:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2BC591B2B9; Sat,
 27 Dec 2008 02:29:43 -0500 (EST)
In-Reply-To: <1230351727-20116-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Sat, 27 Dec 2008 05:22:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2399F8AE-D3E8-11DD-BADC-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103986>

Miklos Vajna <vmiklos@frugalware.org> writes:

> The only notable user-visible/incompatible change is that the
> --build-fake-ancestor option now conforms to gitcli(7).
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>
> I know that we do care about incompatible changes a lot, though I think
> this is the right direction and probably --build-fake-ancestor is not a
> heavily used switch, so I hope that part is OK.

An acceptable justification for such a plumbing change is if (1) the old
syntax is still supported the same way as the original implementation,
*and* if (2) the new syntax is something that could not possibly have been
a valid input to the original implementation with a different meaning.

I think the condition (1) holds but (2) does not hold for your patch; even
though I think the latter breakage is excusable in this particular case,
it is not for the reason you cited.

That is,

 (1) The parseopt parser allows both of these forms:

	$ git apply --build-fake-ancestor file <input
        $ git apply --build-fake-ancestor=file <input

     The former has been how existing scripts that use the plumbing have
     been feeding the file, and it is still supported.

 (2) A script that used "git apply" and relied on the behaviour of 
     the original implementation could have fed a patch from a file
     whose name is "--build-fake-ancestor=some-string", with this command
     line:

        $ git apply --build-fake-ancestor=file

     Now such a script would break with the new parser.

The reason you are excused to break such an insane script is definitely
not because --build-fake-ancestor is a rarely used option.  The whole
defence depends on the fact that --build-fake-ancestor=something is a very
unlikely name for any sane script to be using for its temporary file.  It
could still be an end user input, but at that point you could simply doubt
the sanity of the end user and dismiss the issue away.

I am not fundamentally opposed to using parseopt in git-apply, and I think
the change to add a new and saner meaning to "--build-fake-ancestor=file"
on the command line is a good thing in the longer term.  But your
justification for such a change should be given in such a way to show
clearly that you have thought things through.  It has to be much better
than "it is not a heavily used switch anyway".

The saddest part of the story that pisses me off about this patch is that
you did not seem to have even run the test suite before sending it.  t4105
and t4252 fail for me, at least.

I did not look at the patch very closely, but do you really need that many
option callbacks?  My gut feeling is that many of them should be just
setting a boolean flag, and you can postprocess to get the correct "apply"
behaviour.

For example, you start with "apply" set to true, and let parseopt set
"diffstat" upon seeing "--stat", and set "cmdline_apply" upon seeing
"--apply".  After parseopt returns, you determine the final value of
"apply" by using "diffstat" (and friends that would normally drop "apply")
and "cmdline_apply" (which would override such droppages).  That way I
think you can lose many callback functions whose sole purpose is to drop
"apply" option, no?
