From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] tag-ref and tag object binding
Date: Tue, 26 Jan 2016 14:44:46 -0800
Message-ID: <xmqq1t94arkx.fsf@gitster.mtv.corp.google.com>
References: <20160125212208.GB26169@LykOS>
	<56A73DE6.5050201@drmicha.warpmail.net> <20160126152941.GA31951@LykOS>
	<20160126202651.GA1090@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Santiago Torres <santiago@nyu.edu>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 26 23:44:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOCM2-0000P7-3p
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 23:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144AbcAZWou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 17:44:50 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50176 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752783AbcAZWot (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 17:44:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A0BFA4055E;
	Tue, 26 Jan 2016 17:44:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WncMd7e+HazJ36L4i5oIN5xykgg=; b=xbGmY/
	7VroGIpUrIEDZrZG0kBKhzsMoYVno5n3lC53HAjY/qTWKE93KRMyOf/RhVgCO51n
	e+4BPsaEkE9GF8iFZXpwBZeMiSt41yRzrRErCtCm/sXcuBcc582lgfRhfA23hMVJ
	UlsT8k+99FprWWYbFwOwuJw/IhxsU62RFFSPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vNcxwPcpIJljJBD4Tjwu0GkP6ni5itMS
	0XuJMmuhoy1mo3v4s7I0PguTS1XlTpp8xQ6OdbVsNEeTJoikXsEx4OmlwYFfF9F3
	BrYdn4jvAA01XC1bYYP3dsKXnVkFpFwzjfb4KPf6Hk2EaKTaCN9ETK7tc9Io5KiO
	+l4UOuUMfe0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 98D124055D;
	Tue, 26 Jan 2016 17:44:48 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 19B1D4055C;
	Tue, 26 Jan 2016 17:44:48 -0500 (EST)
In-Reply-To: <20160126202651.GA1090@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 26 Jan 2016 15:26:51 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 67367B62-C47E-11E5-A96D-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284864>

Jeff King <peff@peff.net> writes:

>> I don't think that an addition like this would get in the way of any
>> existing git workflow, and should be backwards-compatible right?
>
> Doesn't this already exist?
>
>   $ git cat-file tag v2.0.0
>   object e156455ea49124c140a67623f22a393db62d5d98
>   type commit
>   tag v2.0.0
>   tagger Junio C Hamano <gitster@pobox.com> 1401300269 -0700
>
>   Git 2.0
>   -----BEGIN PGP SIGNATURE-----
>   [...]
>   -----END PGP SIGNATURE-----
>
> Tag objects already have a "tag" header, which is part of the signed
> content. If you use "git verify-tag -v", you can check both that the
> signature is valid and that the tag is the one you are expecting.

Another thing worth mentioning is that "fsck" does not insist that
refs/tags/$NAME must have a "tag" line that says "tag $NAME", and
that is a very deliberate design decision.  A project may want to
allow multiple people tag the same commit with the same tagname and
publish all of them in the same ref hierarchy.  For example, while I
am away, Peff may make an emergency maintenance release and tag it
like so:

    $ git tag -s -m 'Git v2.7.1' v2.7.1 master
    $ git push $there tags/v2.7.1:tags/peff/v2.7.1 master

and announce to the list that he has cut a release, and published
his signed tag as peff/v2.7.1 in the public repository.  While
everybody in the project trusts Peff as much as they trust me, I
would still want to sign the same commit myself, endorsing what Peff
did for the project, when I come back, by doing something like:

    $ git tag -s -m 'Git v2.7.1' v2.7.1 peff/v2.7.1^0
    $ git push $there v2.7.1

In fact, I think "git describe" uses the name recorded in the
closest tag, not the refname such a tag is found at, when giveing a
name to the commit.  E.g.

    $ git tag foo v2.7.0
    $ git tag -d v2.7.0
    $ git describe master
    warning: tag 'v2.7.0' is really 'foo' here
    v2.7.0-170-ge572fef
