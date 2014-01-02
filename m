From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] completion: introduce __gitcomp_2 ()
Date: Thu, 02 Jan 2014 15:47:59 -0800
Message-ID: <xmqqeh4qndxs.fsf@gitster.dls.corp.google.com>
References: <1388415138-11011-1-git-send-email-artagnon@gmail.com>
	<1388415138-11011-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 03 00:48:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vyrzr-0005F2-7I
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 00:48:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbaABXsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 18:48:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45097 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbaABXsK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 18:48:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 912776023D;
	Thu,  2 Jan 2014 18:48:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ukAt9DXXwBz4L/0xmm4rZnBCm+4=; b=TjmNKn
	sZVDGQMsmyOgGqbt1+2/nLH0O3BmibNyhSGNLSjXKbgmlpNWl8R/PV9oGLfeM7f2
	jNhBFr85XwBZ2XJEHzFCih4dhgdbQYMZraz2sP1Q/s+2gcI86M9XEAE80hB2vwH0
	TyHmT0yotAc4bGFqVGT6qw2wwWJ1NglE43I6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZduNUsGhpPaBZ1cPkV0Q77cXbrm1H/JJ
	jTaTZrOnfdld8gHuV/OOZRBTi8EELGgP0ARlnhxy8lLl9kSixal0yXf7lKupwiqT
	o478fAC6hzCm3aqJDxmtbJK3TrCEGkDjd9ky+HnESy7aoFKi6UxO+aqdI5qoVVbB
	vIYFR4ic4pc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C1D96023C;
	Thu,  2 Jan 2014 18:48:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B04A60238;
	Thu,  2 Jan 2014 18:48:05 -0500 (EST)
In-Reply-To: <1388415138-11011-3-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Mon, 30 Dec 2013 20:22:16 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 53351D1C-7408-11E3-8142-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239895>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> There are situations where two classes of completions possible. For
> example
>
>   branch.<TAB>
>
> should try to complete
>
>   branch.master.
>   branch.autosetupmerge
>   branch.autosetuprebase
>
> The first candidate has the suffix ".", and the second/ third candidates
> have the suffix " ". To facilitate completions of this kind, create a
> variation of __gitcomp_nl () that accepts two sets of arguments and two
> independent suffixes.

That sounds like a reasonable issue to address, but I do not quite
get why you need a new helper to do this.

If the original only knows to throw "branch." + branch names +
trailing dot into COMPREPLY[] and does so by calling gitcomp_nl,
isn't it the matter of making another call to gitcomp_nl just after
the existing call to stuff branch.autosetup* with trailing SP to
append them to COMPREPLY[]?

Ahh, is that because the eventual call to __gitcompadd() starts the
iteration starting from zero, essentially forbidding you to
incrementally adding to COMPREPLY[] from multiple callers, even
though it is called comp "add" not "replace with this single thing"?

What I am wondering is if a cleaner solution that can be reused by
later needs that may have more than two data sources (or more than
two suffixes) might be to create a variant of __gitcomp_nl that does
not clear existing entries in COMPREPLY[] array, add a helper to
clear the array, which would make the existing one to:

	__gitcomp_nl () {
        	__gitcomp_clear
                __gitcomp_nl_append "$@"
	}

and then complete branch.* using two calls to __gitcomp_*, letting
the first one clear and later one(s) accumulate:

	__gitcomp_nl "$(__git_heads)" "$pfx" "$cur_" "."
	__gitcomp_nl_append $"autosetupmerge\nautosetuprebase\n" "$pfx" "$cur_" " "

Will queue as-is.

Thanks.
