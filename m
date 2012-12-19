From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] wildmatch: support "no FNM_PATHNAME" mode
Date: Wed, 19 Dec 2012 09:24:55 -0800
Message-ID: <7vlicu9cpk.fsf@alter.siamese.dyndns.org>
References: <1355922488-20976-1-git-send-email-pclouds@gmail.com>
 <1355922488-20976-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 18:25:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlNOP-0004B8-5H
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 18:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755678Ab2LSRZA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2012 12:25:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58098 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753072Ab2LSRY6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2012 12:24:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E158DBFB5;
	Wed, 19 Dec 2012 12:24:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=DvonaxSatxLTtSF88IID9BHsG
	dc=; b=fXziiVM3ndyym01ZoHVKXnYESGs6+Hwxxosx1lJVxOJeHvbWygBRuWSri
	Bd0KuKjLCuUCR6fud5ahhms/y4ciR5qY4vKYPQFJS7l3WPTPMTKLnBOfXkKG9nlF
	2Wpg96RYIKKNx2NyDtHjETuc22zxv/7XXplcbcyd6uzwCn7HzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=KbJ6FoCJf37EGITSima
	VqVKtfKMQfkn7t0wsI3Dm5BiIhJ1HDnNv9i23GIBqermLb9KOIBn8ZxJ5I3Vj2nd
	gT8zR7naBqfVxyqH8N9EtPVSK8Nu3g99P1DjlK8VpCDbRaNPJ0jVApOc7Zjw63TK
	UpyMyANGtiUQscDJV6whTRBk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD4EDBFB4;
	Wed, 19 Dec 2012 12:24:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3543BFB1; Wed, 19 Dec 2012
 12:24:56 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0259B7EA-4A01-11E2-B75E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211836>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> By default wildmatch(,, 0) is equivalent with fnmatch(,, FNM_PATHNAME=
).

Is this stating a fact before or after the patch?

I think it is more like:

    So far, wildmatch() has always honoured directory boundary and
    there was no way to turn it off.  Make it behave more like
    fnmatch() by requiring all callers that want the FNM_PATHNAME
    behaviour to pass that in the flags parameter.  Callers that do
    not specify FNM_PATHNAME will get wildcards like ? and * in
    their patterns matched against '/' and ...

>  The choice of name "pathspec" is not good. I couldn't think of
>  anything appropriate and just did not care enough at this point.

Well, you should, before this series leaves the WIP state.  It seems
that all operating modes supported by test-wildmatch are named as
somethingmatch, so "pathmatch" may be a better candidate.

> diff --git a/test-wildmatch.c b/test-wildmatch.c
> index e384c8e..7fefa4f 100644
> --- a/test-wildmatch.c
> +++ b/test-wildmatch.c
> @@ -12,9 +12,11 @@ int main(int argc, char **argv)
>  			argv[i] +=3D 3;
>  	}
>  	if (!strcmp(argv[1], "wildmatch"))
> +		return !!wildmatch(argv[3], argv[2], FNM_PATHNAME);
> +	else if (!strcmp(argv[1], "pathspec"))
>  		return !!wildmatch(argv[3], argv[2], 0);

"ipathmatch" to pass only FNM_CASEFOLD may be a natural extension,
but I doubt we use that combination in the real life (yet).

I am probably two step ahead of what is being done (read: this will
be a Git 2.0 topic, if not later), but I am wondering how we'd
integrate this new machinery well with the pathspec limited
traversal.

Traditionally, when traversing a tree limited with a pathspec, say,
"Documentation/*.txt", we used the simple part of the prefix and
noticed that any subdirectory whose name is not "Documentation" can
never match the pathspec and avoided descending into it.  As the
user can use "**" to expand to "any levels of subdirectory", I think
the pathspec limited traversal eventually can safely (and should)
use FNM_PATHNAME by default. =20

That will allow people to say "Documentation/**/*.txt" to match both
"git.txt" and "howto/maintain-git.txt", without resorting to the
more traditional !FNM_PATHNAME semantics "Documentation/*.txt" to
match the latter (i.e. "*" matches "howto/maintain-git").

When that happens, we should want to retain the same "do not bother
to descend into subdirectories that will never match" optimization
for a pattern like "Doc*tion/**/*.txt".  Because of FNM_PATHNAME, we
can tell if a subdirectory is worth descending into by looking at
the not-so-simple prefix "Doc*tion/"; "Documentation" will match,
"Doc" will not (because '*' won't match '/').

Which tells me that integrating this _well_ into the rest of the
system is not just a matter of replacing fnmatch() with wildmatch().

I also expect that wildmatch() would be much slower than fnmatch()
especially when doing its "**" magic, but I personally do not think
it will be a showstopper.  If the user asks for a more powerful but
expensive operation, we are saving time for the user by doing a more
powerful thing (reducing the need to postprocess the results) and
can afford to spend extra cycles.

As long as simpler patterns fnmatch() groks (namely, '?', '*', and
'[class]' wildcards only) are not slowed down by replacing it with
wildmatch(), that is, of course.
