From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] checkout: reorder option handling
Date: Tue, 28 Aug 2012 13:45:31 -0700
Message-ID: <7vipc2zqxg.fsf@alter.siamese.dyndns.org>
References: <7vr4qroel6.fsf@alter.siamese.dyndns.org>
 <1346161748-25651-1-git-send-email-pclouds@gmail.com>
 <1346161748-25651-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 28 22:45:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6SfO-0001T9-0y
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 22:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238Ab2H1Upf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Aug 2012 16:45:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55405 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753097Ab2H1Upe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Aug 2012 16:45:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 181F48733;
	Tue, 28 Aug 2012 16:45:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zgR4oE1YSeJV
	2Oqo4VlF33cjeks=; b=a2qZyGysXxENpnx+j4FkeNQcoywQ/sJDen95qbW0DXmM
	EaCVVWdk3N1PfBhuxLZCX70VDQgedi5t63IH9tMOV9vNIC3rIt0EkofymNugF0Nw
	oITaPS4oOujRwgSbgVdT5WTJoOP1Ar4ftz+7SjoGKBr0gWoHecUawwD0myxi3KM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=m141OW
	6shgVkI8ORCPserhiTw+zoAYg4bYR5txBbEepfU3cvhfcPO/mN4fyUYWhRc8HcUN
	XIl0ScmXA+Z4xsRODs8z4vOGDmu5z2dzYRmkb8Q746I0rPMJd+DvTMOj9ncRO7v+
	fnQkE/VmnwsoSJ8H+244wsa5IdjDqS/9D5Gn0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 058008732;
	Tue, 28 Aug 2012 16:45:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00FC7872F; Tue, 28 Aug 2012
 16:45:32 -0400 (EDT)
In-Reply-To: <1346161748-25651-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 28 Aug
 2012 20:49:07 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4FBAD658-F151-11E1-87FE-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204451>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> checkout operates in three different modes. On top of that it tries t=
o
> be smart by guessing the branch name for switching. This results in
> messy option handling code. This patch reorders it so:
>
>  - easy option handling comes first
>  - the big chunk of branch name guessing comes next
>  - mode detection comes last. Once the mode is known, check again to
>    see if users specify any incompatible options
>  - the actual action is done
>
> Another slight improvement is always print branch name (or commit
> name) when printing errors related ot them. This helps catch the case
> where an option is mistaken as branch/commit.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> ...
> +	/* Easy mode-independent incompatible checks */
>  	if (opts.force_detach && (opts.new_branch || opts.new_orphan_branch=
))
>  		die(_("--detach cannot be used with -b/-B/--orphan"));

Did you catch "--detach -B" combination without checking new_branch_for=
ce?

>  	if (opts.force_detach && 0 < opts.track)
>  		die(_("--detach cannot be used with -t"));
> +	if (opts.force && opts.merge)
> +		die(_("git checkout: -f and -m are incompatible"));
> +
> +	if (conflict_style) {
> +		opts.merge =3D 1; /* implied */
> +		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
> +	}

"checkout --conflict=3Ddiff3 -f <branch>" would imply combination of
"-m" and "-f", which is supposed to be forbidden in the previous
check, no?

I very much like the idea of separating things in phases like your
proposed log message explains.  But I wonder if the order should be
to do dwimming and parameter canonicalization first, then decide the
mode (these might have to be swapped, as the same parameter may dwim
down to different things depending on the mode), and finally check
for sanity before performing.

To avoid confusion, it also might not be a bad idea to remove
new_branch_force and new_orphan_branch from the structure and
introduce "enum branch_creation_type" or something, and always have
the new branch name in "new_branch" field (this needs to get various
pointers into opts out of the parseopt options[] array; parse into
separate variables and decide what to put in "struct checkout_opts"),
independent from how that branch is going to be created (either -b,
-B, or --orphan).
