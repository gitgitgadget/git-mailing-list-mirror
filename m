From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: update hook for GPG signed submission on secured branches
Date: Fri, 16 Jan 2015 11:33:25 -0800
Message-ID: <xmqqsifa1px6.fsf@gitster.dls.corp.google.com>
References: <BBE88A3EA44D47159C483F1046AC747E@black>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: "Jason Pyeron" <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Fri Jan 16 20:33:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCCeD-0002gp-GG
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 20:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756392AbbAPTd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 14:33:29 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60699 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752608AbbAPTd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 14:33:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E6C443082E;
	Fri, 16 Jan 2015 14:33:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iV/tCQjxwD51x4599lrcgAezU7k=; b=xyi8BM
	vSoWv6rGblh/K67MvDhxSo0xu05o9V2EOR+qeNuQ/XNcmcfLPQStdQMhWorScmS5
	jVbkHF+GeetOFA8NF3V2xFNtG7UQF05IR0FrOFQz3PBplIAyZ8QYGzDnieBsy+hj
	YpHrv+S+5kXQq1ZO/rn3ofazReM4f4iMdiPCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uZ9SfndgkF0PDGAYOMYhkcF3Q2RObLTX
	T5fup87Yfm0foFDrEKXus5V8IgNsbim0zeME1KiVVGXxBpwYBUwa7fQ5721w6e6w
	P8zC51PKxav1Eprj7NtuyJFAG1yu8ja/AjuVamKvC/1bC54Px2g+HEmjI+SDVKHv
	XAnOsR/NSAM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DD0C23082D;
	Fri, 16 Jan 2015 14:33:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7B53430829;
	Fri, 16 Jan 2015 14:33:26 -0500 (EST)
In-Reply-To: <BBE88A3EA44D47159C483F1046AC747E@black> (Jason Pyeron's message
	of "Fri, 16 Jan 2015 14:03:51 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8ABBD7DE-9DB6-11E4-88BD-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262564>

"Jason Pyeron" <jpyeron@pdinc.us> writes:

> What would you change? Any bugs that you see?

> sigkey=$(\
>  git cat-file $newrev -p |\

"-p" being a command line option should come before revision, but
more importantly, because you accept pushes only to refs/heads/, you
would want to explicitly require commit objects, no?  i.e.

	git cat-file commit "$newrev" |

I am not sure if you need these unsightly backslashes.  When you
stop talking to it after saying "$(", or "$( git cat-file ... |",
the shell _knows_ that you haven't stopped what you want to tell
it.

>  sed -e '/^ /{H;$!d;}; x;/^gpgsig /!d; s/^gpgsig//;' |\
>  cut -c 2- |\

It always makes me feel nervous to see people pipe sed output to
another filter that is a mere s/.//;

Is this complex pipeline the same as this (I didn't understand the
trailing I at the end)?

	git cat-file commit "$newrev" |
        sed -ne '/^gpgsig /,/^ -----END/{
        	s/^gpgsig //
                s/^ //p
	}' |
	gpg --list-packets --textmode |
        sed -ne '/^:signature packet:/s/.*keyid \([0-9A-F]*\).*/\1/p'

>  gpg --list-packets --textmode |\
>  sed '/keyid/!d; s/.*keyid \([0-9A-F]\{16\}\).*/\1/I' \
> )

> if [ -z "$sigkey" ]; then
>         echo no GPG signature on commit $newrev
>         exit 1
> fi

I am not sure if the design of this, to require signature only on
the tip commit, is sound.  That is not a -bug- in the script,
though.

> if [[ $refname != refs/heads/* ]]; then
>         echo only heads may be pushed, illegal ref: $refname
>         exit 1;
> fi
>
> head="${refname:11}"

It is hard to tell where the magic number 11 comes from.  Perhaps

    head="${refname#refs/heads/}"

reads easier?
