From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge: handle --ff/--no-ff/--ff-only as a tri-state option
Date: Tue, 02 Jul 2013 11:46:55 -0700
Message-ID: <7vfvvw94v4.fsf@alter.siamese.dyndns.org>
References: <20130701070143.GB17269@suse.cz> <51D197AD.1070502@alum.mit.edu>
	<20130701195407.GK17269@suse.cz> <51D2927F.3040207@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@suse.cz>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 02 20:47:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu5bT-00049Q-49
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 20:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754312Ab3GBSq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 14:46:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64137 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754222Ab3GBSq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 14:46:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B28EC2A8C7;
	Tue,  2 Jul 2013 18:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XiDO/rXsKiJ8/nCeONWi4xfGDhc=; b=rHrnkD
	glu5/DuRFqljj0SmI2zDXgr8AteNgQvI1PBt9RPJ/b0t6rKDCeI75P6C10ZdWMNM
	U0o4ka0lzLxKZt63TUMMM0pfKSgDK9PpsN7irHLbgqF9VF9aWgHgBw8tfBqLQfa/
	72wqDFxWon20MnW/VUBC9978zsuhDWWhzzZA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h1RHLm1niCiLe+wygzaZmLjOhAqN+OVr
	IpxjqoA+78sz6+6MbChhuq/e0DlWNZUVs1PhuHspPGPYmwpWX04tlrd7OQrtoEan
	aPH8RKh7nrmW1p+qi53OMJesS25U/YlKTXxtNkGu/WqbyqJyyE+xTQ+5uey08FEs
	iFnLxyHc/Zc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A793A2A8C6;
	Tue,  2 Jul 2013 18:46:57 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 111662A8C4;
	Tue,  2 Jul 2013 18:46:56 +0000 (UTC)
In-Reply-To: <51D2927F.3040207@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 02 Jul 2013 10:42:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C588D9D2-E347-11E2-B193-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229415>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> You allow --no-ff-only but ignore it, which I think is incorrect.  In
>
>     git merge --ff-only --no-ff-only [...]
>
> , the --no-ff-only should presumably cancel the effect of the previous
> --ff-only (i.e., be equivalent to "--ff").

Ideally, if we were starting from scratch and living in the "you
pick one out of three" world, we should forbid "--no-ff-only".  The
"--no-ff" option is spelled as if it is a negation of "--ff", and it
did start as such before "--ff-only" was introduced, but "--no-ff"
would have been better named "--always-create-merge", which is what
the option really means.

And in the tristate world, with mutually exclusive "--A", "--B", and
"--C" options, "--no-C" does not mean "I want to do A" at all.

If the existing code had allowed with "--no-ff-only" to defeat
configured merge.ff=only from the command line, then there may have
been users who are used to that behaviour, and we cannot break them,
but luckily or unluckily it does not work, so...

>> @@ -1157,14 +1181,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>>  		show_diffstat = 0;
>>  
>>  	if (squash) {
>> -		if (!allow_fast_forward)
>> +		if (fast_forward == FF_NO)
>>  			die(_("You cannot combine --squash with --no-ff."));
>>  		option_commit = 0;
>>  	}
>>  
>
> So there is still a problem with setting merge.ff=false, namely that it
> prevents the use of --squash.  That's not good.  (I realize that you are
> not to blame for this pre-existing behavior.)
>
> How should --squash and the ff-related options interact?

Interesting point.

>     git merge --ff --squash
>     git merge --no-ff --squash
>
> I think these should just squash.
>
>     git merge --ff-only --squash
>
> I think this should definitely squash.  But perhaps it should require
> that HEAD be an ancestor of the branch to be merged?
>
>     git merge --squash --ff
>     git merge --squash --no-ff
>     git merge --squash --ff-only
>
> Should these do the same as the versions with the option order reversed?

As "--squash" is about _not_ moving the head but only updating the
working tree and the index, I personally think it should be treated
as an error if any of these "ff" options is explicitly given from
the command line.
