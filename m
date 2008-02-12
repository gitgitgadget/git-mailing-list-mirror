From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add compat/fopen.c which returns NULL on attempt to open directory
Date: Mon, 11 Feb 2008 16:20:05 -0800
Message-ID: <7v8x1r6n62.fsf@gitster.siamese.dyndns.org>
References: <47ACFFD9.2030705@nrlssc.navy.mil>
	<47AD10CF.1040207@nrlssc.navy.mil>
	<20080211102950.122ba93d@pc09.procura.nl>
	<20080211111537.2bf47448@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Morten Welinder <mwelinder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Feb 12 01:21:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOitQ-0002GV-UE
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 01:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322AbYBLAU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 19:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752315AbYBLAU0
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 19:20:26 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60413 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbYBLAUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 19:20:25 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 68CFF2995;
	Mon, 11 Feb 2008 19:20:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CEC9F2992;
	Mon, 11 Feb 2008 19:20:12 -0500 (EST)
In-Reply-To: <20080211111537.2bf47448@pc09.procura.nl> (H. Merijn Brand's
	message of "Mon, 11 Feb 2008 11:15:37 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73611>

"H.Merijn Brand" <h.m.brand@xs4all.nl> writes:

> No, it is not. Some shell weirdness. This fixes it. Don't know off-hand
> if it is portable enough
>
> diff -pur a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
> --- a/t/t5701-clone-local.sh  2008-02-02 05:09:01 +0100
> +++ b/t/t5701-clone-local.sh  2008-02-11 11:13:26 +0100
> @@ -37,8 +37,8 @@ test_expect_success 'local clone from x'
>
>  test_expect_success 'local clone from x.git that does not exist' '
>         cd "$D" &&
> -       if git clone -l -s x.git z
> -       then
> +       git clone -l -s x.git z
> +       if $? ; then
>                 echo "Oops, should have failed"
>                 false
>         else

I think your "git clone" is broken and I strongly suspect it is
not your shell (at least the "if" construct in the test).

What's 

	if $?; then

In sane shells, I think this tries to execute 0 or perhaps 124
or whatever the error code from clone as if it was the name of a
command, which would most likely fail and would not take "then"
part (which reports the error).  It did not fix, but just made
it ignore the error from "git clone".

If it were

	if test $? != 0
        then

it would have made a bit more sense.

And if (this is a big "if" as I doubt any shell is so broken)
these two are equivalent to your shell, then I do not think it
is portable at all.
