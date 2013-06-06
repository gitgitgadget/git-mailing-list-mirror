From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 17/18] Place the open() call inside the do{} struct and prevent failing close
Date: Thu, 06 Jun 2013 14:13:32 -0700
Message-ID: <7vhahbx7r7.fsf@alter.siamese.dyndns.org>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
	<1370547263-13558-18-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, benoit.person@ensimag.fr,
	matthieu.moy@grenoble-inp.fr
To: =?utf-8?Q?C=C3=A9lestin?= Matte <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 06 23:13:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkhV6-0007wo-6E
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 23:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754379Ab3FFVNg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jun 2013 17:13:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54534 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753117Ab3FFVNf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jun 2013 17:13:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89B9025A05;
	Thu,  6 Jun 2013 21:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=m/MExmy2x25y
	ejoDHpyob6o66NI=; b=S8zbJgzfvg/ptHpoDI917k0g4lDBXiYJ3bDbyid4xGHg
	z3udgplsflr02HKNuB+Davnbgd0SWjktVS08Uo4BKxJM2vGwlpVBJPGlaRFcOLoa
	/OFrMwjPWN2dAs4yoraU1SksAkbSvHdWuiAhHImTidsdJf08CnzWXdQRgfq1fQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=L/D5sV
	HUpX6CEyNHXml+TE6zQ4a2D9HxaketUpbU79ZOtnLx1kPBd8NrSgHHJIu0ysEk1h
	6sgfzQBxbO3DQdDID9UPyUzQwI6zActkvSzqkzTUiu+sMjJ3RHaEhyDxFdJ4SLwG
	3JAzTk/kcabqzXtXH6UlYltUui8wLZeCmp7pU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C5A125A04;
	Thu,  6 Jun 2013 21:13:34 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D4E6025A02;
	Thu,  6 Jun 2013 21:13:33 +0000 (UTC)
In-Reply-To: <1370547263-13558-18-git-send-email-celestin.matte@ensimag.fr>
	(=?utf-8?Q?=22C=C3=A9lestin?= Matte"'s message of "Thu, 6 Jun 2013 21:34:22
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F218E80C-CEED-11E2-90BC-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226560>

C=C3=A9lestin Matte <celestin.matte@ensimag.fr> writes:

> Placing the open() call inside the do{} struct will automatically clo=
se the
> filehandle if possible.
> Placing the close() call outside the do{} struct is useless and will =
make it
> fail systematically
> Change the error message to state that what fails is a fork(), not a =
file
> opening.
> Use autodie to properly exit when a print or open call fails.
>
> Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> ---
>  contrib/mw-to-git/git-remote-mediawiki.perl |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw=
-to-git/git-remote-mediawiki.perl
> index 952ddcc..20ddccb 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -23,6 +23,7 @@ binmode STDOUT, ':encoding(UTF-8)';
> =20
>  use URI::Escape;
>  use Readonly;
> +use autodie;
> =20
>  # Mediawiki filenames can contain forward slashes. This variable dec=
ides by which pattern they should be replaced
>  Readonly my $SLASH_REPLACEMENT =3D> '%2F';
> @@ -363,8 +364,6 @@ sub run_git {
>  		local $/ =3D undef;
>  		<$git>
>  	};
> -	close($git);
> -
>  	return $res;
>  }

Confused.  Which part of this patch moves open inside a do{} block?
This was last touched by [9/18] but it doesn't do any such thing,
either.

Upon leaving this subroutine, $git filehandle will go out of scope,
so in that sense, close may not be necessary, but that does not
match what the proposed log message claims what the patch does.

Also, this patch does not remove "or die" 9/18 added, even though
the proposed log message claims that with autodie it is no longer
necessary.

I am not convinced that using autodie globally, without vetting the
calls the original code make, is a good idea in the first place.
How does this change interact with existing calls to open, close,
etc. that check the return value from them, now these calls throw
exception and will not give a chance for the existing error handling
codepath to intervene?
