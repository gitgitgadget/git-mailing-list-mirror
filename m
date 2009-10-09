From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 1/2] t/test-lib.sh: support Korn shell by converting 
	GIT_EXIT_OK to GIT_EXIT_CODE
Date: Fri, 9 Oct 2009 17:37:23 -0500
Message-ID: <ee63ef30910091537i40a8cc68y2513f07c91fb35b@mail.gmail.com>
References: <1eweIwf5YoFwmLPWwEFN69a2f-EUnj_kgiagVJoVQYfNQeLjlpm12U84RKxhzjh0NJv36SqO12lAX2c_x0WSgA@cipher.nrlssc.navy.mil>
	 <7vhbu8s151.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	drizzd@aon.at, peff@peff.net
X-From: git-owner@vger.kernel.org Sat Oct 10 00:47:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwOFd-0003it-QQ
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 00:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761521AbZJIWo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 18:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756535AbZJIWo6
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 18:44:58 -0400
Received: from mail-vw0-f203.google.com ([209.85.212.203]:34263 "EHLO
	mail-vw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934533AbZJIWo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 18:44:57 -0400
Received: by vws41 with SMTP id 41so4007996vws.4
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 15:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=FWGcVRNl2QJr04A+qfBzk1Sin1nUqnkE+HQuKZwEip0=;
        b=gAewKOKLxOHKZSJ+R5nwAXxjhBV1zDWOwYumskOT3P6bM8LcknK+/wRADUK1aMW5pp
         93EjhQ4lLHrxIN8RClySbXIXo2Rvbf3UZaEkehkPQtZgvI0g+0nNE85PBx9YWR0FRC58
         14dUqKDdivQnvJq7vawC3a40hzqrwOujgwYqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=p0WoqN927rEHbdh6vvYowpraVkeevoVTpdYp67oxzsRY79xxyS9fuNYlwUva8xko8r
         P5dKcSBQHKJhh1tygpxIlo2OVgmknFLytwl6qTrQfB0kjkBOpQ1cyGwximCB8P63W92e
         3UDTtqG6keSLE5kiatZN7FwBwTBSo66SBGIUU=
Received: by 10.220.15.71 with SMTP id j7mr4924148vca.79.1255127843974; Fri, 
	09 Oct 2009 15:37:23 -0700 (PDT)
In-Reply-To: <7vhbu8s151.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129855>

I'm away from a computer right now. Junio, if gmail is showing me the
entirety of your workaround, then no, I don't think that will work.
Your code will always exit non-zero, but there are cases where 'exit
0' is called and a '0' exit status is desired. e.g. when test_done is
called.

I'll look more closely at the suggestions when I get back to a computer.

-brandon

On 10/9/09, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
>
>> From: Brandon Casey <drafnel@gmail.com>
>>
>> Commit 6e7b5aaf introduced the concept of GIT_EXIT_OK as a way to indicate
>> to die(), the exit handler, whether the exit was initiated by the test
>> harness, or whether it was unexpected.  die() expects $? to contain the
>> value passed to exit(), and when GIT_EXIT_OK is set, die() calls exit with
>> the value in $?.  This works as expected when using the Bash shell.  For
>> the Korn shell, $? has the value of the last executed statement _before_
>> the call to exit.  If that statement completed successfully, then die()
>> would incorrectly exit with a successful status when GIT_EXIT_OK is set.
>
> That's somewhat unexpected, as I did not think this was an anomaly in
> bash.  FWIW, dash seems to behave the same way.
>
>     The environment in which the shell executes a trap on EXIT shall be
>     identical to the environment immediately after the last command executed
>     before the trap on EXIT was taken.
>
> If the trap action was triggered because somebody called "exit 13", $? is
> expected to contain that value, because that is the last command executed
> before the trap on EXIT was taken, no?
>
>> So, rather than relying on the behavior of Bash in order to get the exit
>> code from $? inside die(), change GIT_EXIT_OK into GIT_EXIT_CODE, and set
>> it to the code that we want to exit with.  This allows the test suite to
>> be run with the Korn shell.
>
> I wonder if the attached is a more clear and contained workaround for this
> issue.
>
> ---
>  t/test-lib.sh |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index f2ca536..c47a295 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -185,7 +185,14 @@ die () {
>  	code=$?
>  	if test -n "$GIT_EXIT_OK"
>  	then
> -		exit $code
> +		# Korn does not update $? when "exit 47" triggers
> +		# the EXIT trap.
> +		if test $code = 0
> +		then
> +			exit 1
> +		else
> +			exit $code
> +		fi
>  	else
>  		echo >&5 "FATAL: Unexpected exit with code $code"
>  		exit 1
>

-- 
Sent from my mobile device
