From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 7/8] update-ref: support multiple simultaneous updates
Date: Thu, 05 Sep 2013 14:23:52 -0700
Message-ID: <xmqqk3ivgdxz.fsf@gitster.dls.corp.google.com>
References: <cover.1378142795.git.brad.king@kitware.com>
	<cover.1378307529.git.brad.king@kitware.com>
	<ad27a96b70198e837ac61995a1328960e10072bc.1378307529.git.brad.king@kitware.com>
	<xmqqsixkmonq.fsf@gitster.dls.corp.google.com>
	<52279107.2070205@kitware.com>
	<xmqqd2ool1ks.fsf@gitster.dls.corp.google.com>
	<5228EA62.7030606@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 23:24:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHh2M-0003uk-6S
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 23:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720Ab3IEVYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 17:24:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39139 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752124Ab3IEVYB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 17:24:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B564A3F831;
	Thu,  5 Sep 2013 21:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HWuyHiraS7a5KXRinZFezyoUSHw=; b=qQBIn8
	yGzxIRwF9TgnIgV0TUi8w2bZHRWvSgmNFlBEJ+Gf11/6Y7vOQxB1IFSUhacpFk41
	N4pg8gVXL6rJsVVTaVpNE264Ixm1UTl3PsswdPOW8eMlSY+tPuBH3exdESm3fjtN
	7iJF0L5o41G+NUJQ0kHfHE0lAlKbatyUITl2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r9nvD8cwRcKxz4rSzsZl0g9Sz/smzxrL
	/VDpfRs2nnYAeHTvV45ptj//K6E0nz79t8WDFX9RHtlqyEWcBS7+P59f4/MkPPRk
	BEluYiJeCnEIn3PiFfAKKNv4IkmXDt4xLWsg8VjJ4BGRV2tACciMX1Hq7Jj5AZJ3
	BTR6/wPyKEk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 922F93F830;
	Thu,  5 Sep 2013 21:24:00 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 537B63F82A;
	Thu,  5 Sep 2013 21:23:58 +0000 (UTC)
In-Reply-To: <5228EA62.7030606@kitware.com> (Brad King's message of "Thu, 05
	Sep 2013 16:32:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7A47C728-1671-11E3-91AF-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233993>

Brad King <brad.king@kitware.com> writes:

> On 09/04/2013 05:27 PM, Junio C Hamano wrote:
>> I am not saying the above is the best format, but the point is that
>> the mode of the operation defines the structure
>
> Great, thanks for your comments.  Based on that I've prototyped a
> new format.  Rather than jumping straight to the patch, here is my
> proposed format documentation for review:
>
> -------------------------------------------------------------------------
> With `--stdin`, update-ref reads instructions from standard input and
> performs all modifications together.  Specify commands of the form:
>
> 	create SP <ref> SP <newvalue> LF
> 	update SP <ref> SP <newvalue> [SP <oldvalue>] LF
> 	delete SP <ref> [SP <oldvalue>] LF
> 	verify SP <ref> [SP <oldvalue>] LF
> 	option SP <opt> LF
>
> Quote fields containing whitespace as if they were strings in C source
> code.  Alternatively, use `-z` to specify commands without quoting:
>
> 	create SP <ref> NUL <newvalue> NUL
> 	update SP <ref> NUL <newvalue> NUL [<oldvalue>] NUL
> 	delete SP <ref> NUL [<oldvalue>] NUL
> 	verify SP <ref> NUL [<oldvalue>] NUL
> 	option SP <opt> NUL

That SP in '-z' format looks strange.  Was there a reason why NUL
was inappropriate?

> Lines of any other format or a repeated <ref> produce an error.
> Command meanings are:
>
> create::
> 	Create <ref> with <newvalue> only if it does not exist.
>
> update::
> 	Update <ref> to be <newvalue>, verifying <oldvalue> if given.
> 	Specify a zero <newvalue> to delete a ref and/or a zero
> 	<oldvalue> to make sure that a ref does not exist.
>
> delete::
> 	Delete <ref>, verifying <oldvalue> if given.
>
> verify::
> 	Verify <ref> against <oldvalue> but do not change it.  If
> 	<oldvalue> zero or missing, the ref must not exist.
>
> option::
> 	Specify an option to take effect for following commands.
> 	Valid options are `deref` and `no-deref` to specify whether
> 	to dereference symbolic refs.

This last one is somewhat peculiar, especially because it says
"following command*s*".

How would I request to update refs HEAD and next in an all-or-none
fashion, while applying 'no-deref' only to HEAD but not next?

	update refs/heads/next <newvalue>
	option --no-deref
        update HEAD <newvalue>

sounds somewhat convoluted.

When I said "create or update" in the message you are responding to,
I did not mean that we should have two separate commands.  The
regular command line does create-or-update; if it exists already, it
is an update, and if it does not, it is a create.

If we were to have two, I would say we should have:

	create-or-update <ref> <newvalue> [<oldvalue>]
	create-or-update-no-deref <ref> <newvalue> [<oldvalue>]
        
An old value of 0{40} would mean "I should be the one creating; if
somebody else created it while I was preparing this request, please
fail".

Similarly for delete:

	delete <ref> [<oldvalue>]
        delete-no-deref <ref> [<oldvalue>]

Also how would one set the reflog message for the proposed update?
