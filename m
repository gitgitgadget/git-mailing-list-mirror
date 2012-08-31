From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: warn users if action is taken in ambiguous
 situation
Date: Fri, 31 Aug 2012 11:27:42 -0700
Message-ID: <7vd326or1d.fsf@alter.siamese.dyndns.org>
References: <1346423934-7003-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 20:27:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7Vwe-000863-Kl
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 20:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551Ab2HaS1q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Aug 2012 14:27:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53675 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754440Ab2HaS1p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Aug 2012 14:27:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 023CB9FD2;
	Fri, 31 Aug 2012 14:27:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tGy2uLx9C39h
	YN3/kC9tfTknKU0=; b=Fuw0JWN2gB8CJpOJTerWrzv1XEmmE87oHtddsuSOM6MF
	rO1EZZC4YWwvfqwlud4mwGusxJCwfM/+y+QI+mhjDErJDuB1EzmfPRgDHuxlVtpw
	gEKqYIAz2cI2RZhoUFFTe8i35G2p9iD75uFrkRnkp8rJWTFyZzKKUzs0Q5/kMZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BWuq4x
	YmtTTGdpjhX0bifQHNzWOs+MvxGJY52i2Kbl9P9YIvq0FC6777c0rjkkdZSDZTLd
	EFP/lGOH3sN/HK5C3eQSiiyCFQBW5pGn5QtqsJ70jfxM/tzYm6rrUw03ncDaYFzQ
	hQVHtvYwLyJRGtnlc/JJxcGDfpJk4bzjOAe50=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E32A09FD1;
	Fri, 31 Aug 2012 14:27:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 202689FCE; Fri, 31 Aug 2012
 14:27:44 -0400 (EDT)
In-Reply-To: <1346423934-7003-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 31 Aug
 2012 21:38:54 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E568D36-F399-11E1-A480-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204602>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> "git checkout foo" (no more arguments) always checks out existing
> branch "foo" even if "foo" exists on working directory. To avoid
> confusion to users who do not know this exception, say something alon=
g
> the action.

I do not think the extra noise "Checked out the new branch." your
patch adds is necessary:

    $ git checkout master
    Already on 'master'
    $ >next
    $ git checkout next
    Switched to branch 'next'

If the user wanted to grab the contents from the index for path
'next' and deposit it to the file 'next' in the working tree, we are
already telling the user that that is not what happened.

Even though I agree with you that it is a good goal to help users
who want to disambiguate between branch and path differently from
what the annoyance avoidance does, I do not think butchering the
annoyance avoidance in parse_branchname_arg() is the right way to do
so.

I wouldn't mind if the above interaction went like this:

    $ git checkout next
    Switched to branch 'next'
    hint: if you meant to check out the contents of 'next' out of
    hint: the index to the file 'next' in your working tree, say
    hint: "git checkout -- next" instead.  To squelch this advice,
    hint: "git config set advice.checkoutWarnFileAndBranchName false".

This should trigger only when the advice is not set (or set to
true), and only when you have 'next' in the index.  Presense or
absense of 'next' in the working tree should not make a difference.

And doing it that way covers anoter valid case in which the user
would want the exact same help from Git that your patch would not
cover:

    $ git branch Makefile
    $ git checkout master
    Already on 'master'
    $ rm Makefile
    $ git checkout Makefile
    D	Makefile
    Switched to branch 'Makefile'

Another thing to look out for is this case:

    $ git branch Makefile master
    $ git checkout next
    Already on 'next'
    $ rm Makefile
    $ echo >>archive.c ;# different between master and next
    $ git checkout Makefile
    error: Your local changes to the following files would be overwritt=
en by checkout:
        archive.c
    Please, commit your changes or stash them before you can switch bra=
nches.
    Aborting

We would want the exact same hint (with the obvious s/next/Makefile/) a=
fter
the above output.

Just for a reference, with your patch, I think the output would like
this (I didn't apply nor run it):

    $ git checkout Makefile
    warning: ambiguous argument 'Makefile': both revision and filename
    Use '--' to separate paths from revisions, like this:
    'git <command> [<reviosion>....] -- [<file>...]'
    warning: checked out the new branch.
    error: Your local changes...
        archive.c
    Please, commit your ...
    Aborting

which would be far worse and confusing.
