From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse --parseopt: fix handling of optional arguments
Date: Tue, 15 Oct 2013 16:33:27 -0700
Message-ID: <xmqqfvs29kjc.fsf@gitster.dls.corp.google.com>
References: <1381838425-18244-1-git-send-email-boklm@mars-attacks.org>
	<20131015231427.GF9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Vigier <boklm@mars-attacks.org>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 01:33:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWE7M-0006Mu-O9
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 01:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933858Ab3JOXdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 19:33:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63524 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933634Ab3JOXdc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 19:33:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9F8D4BA0B;
	Tue, 15 Oct 2013 23:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kr+r+nKPIdPiZty1cguP0JPiNTM=; b=IQRiLJ
	cBMuyj3hfmiY1D9vQtmwbwSHt/i9DF5Z71zWMxdGETJ5raOVDyWDUkLAB9jX7Ug3
	Dx9rH16BHNDOgE/gMb4gpNVQDSPcQCMEAfLBVL38a7y5ssov6xIM+rb/PGx8b/ZJ
	F7izvewWvt+10xxyer1CzAEN9JDGDIfkqoho8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iEi6twi5jgPXHOJm9I/wnbjyl5x0USmd
	UO18nhMy+z5eTdBw9TBXhyMcjs0YYlXB8f5EF90gCD1Xj1MdccOlbrPP4HBX58JE
	8oCVnNLJWEhbXkw/QKqKLMB/bODIZXwMFlKHV8C3sw2UQFNhTfKr52642/DqqmtN
	LvoXygDtlRQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCC024BA0A;
	Tue, 15 Oct 2013 23:33:31 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1DBAF4BA06;
	Tue, 15 Oct 2013 23:33:31 +0000 (UTC)
In-Reply-To: <20131015231427.GF9464@google.com> (Jonathan Nieder's message of
	"Tue, 15 Oct 2013 16:14:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 335CAB30-35F2-11E3-9929-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236219>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Nicolas Vigier wrote:
>
>>   $ cat /tmp/opt.sh
>>   #!/bin/sh
>>   OPTIONS_SPEC="\
>>   git [options]
>>   --
>>   q,quiet         be quiet
>>   S,gpg-sign?     GPG-sign commit"
>>   echo "$OPTIONS_SPEC" | git rev-parse --parseopt $parseopt_extra -- "$@"
>>
>> Then the following two commands give us the same result :
>>
>>   $ /tmp/opt.sh -S -q
>>   set -- -S -q --
>>   $ /tmp/opt.sh -S-q
>>   set -- -S '-q' --
>>
>> We cannot know if '-q' is an argument to '-S' or a new option.
>
> Hmph.
>
> As Junio mentioned, inserting '' would be a backward-incompatible
> change.  I don't think it's worth breaking existing scripts.  Probably
> what is needed is a new parseopt special character with the new
> semantics (e.g.,
>
> 	Use ?? to mean the option has an optional argument.  If the
> 	option is supplied without its argument, the argument is taken
> 	to be ''.
>
> or something like
>
> 	Use ?<default> to mean the option has an optional argument.  If
> 	the option is supplied without its argument and <default> is
> 	nonempty, the argument is taken to be <default>.
>
> ).
>
> Sensible?

You just made these two that the user clearly meant to express two
different things indistinguishable.

	opt.sh -S
        opt.sh -S ''

So I do not think it is sensible. In fact, I do not think there is
any sensible way to handle a shortopt with optional parameter that
is not at the end of the command line.

And that is exactly why gitcli.txt tells users to use the 'sticked'
form, and ends the bullet point with:

   An option that takes optional option-argument must be written in
   the 'sticked' form.

That still does not give the command line a way to express an option
that could take an optional argument without the optional argument
in the middle of the command line, though.
