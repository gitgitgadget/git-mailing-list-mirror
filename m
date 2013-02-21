From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: segfault fixes and validation
Date: Thu, 21 Feb 2013 09:47:50 -0800
Message-ID: <7vvc9lv9rt.fsf@alter.siamese.dyndns.org>
References: <512612AD.4000609@opera.com>
 <1361456285-29611-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 18:48:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8aFp-00019t-1u
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 18:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756525Ab3BURrz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Feb 2013 12:47:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56004 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753184Ab3BURry convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Feb 2013 12:47:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B85DEA955;
	Thu, 21 Feb 2013 12:47:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ErK8yVEX/Qzi
	z1wgNX6dAtDNc0k=; b=chLoEpXKe9VEOZgwU3K20oqYLEsvKAl8xLI+VGQpnu5h
	OPBBXyd+GYzYwd3YM2NZgIkATBRsOMqfdJgAFEDJFOxuNQW+DdJ5kRgTCjIkpVvQ
	vlxWW1vyPSmXRjjiCFAyP3RxPl83mYT3RxAgPQbwRlvCeEzXGyD6tjaqDSoHW08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=uvUIeg
	+dKxpJS4eELfvufnXbD67lNFddOkzQzhbgG/dBTccx7wdT7GAyRrFHD20+6BavqD
	OTC64rm1poP+YobQKnqONZBpv7520T8KkHs/3ZmYEEJQZRoy2tf19GbqPfOKtkX+
	DNgdEpiaU+1whHjZ26PjwflAB5Jpn/Vxy8ivA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACD4EA953;
	Thu, 21 Feb 2013 12:47:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99553A93F; Thu, 21 Feb 2013
 12:47:52 -0500 (EST)
In-Reply-To: <1361456285-29611-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 21 Feb
 2013 21:18:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0DE9322-7C4E-11E2-94C5-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216782>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> branch_get() can return NULL (so far on detached HEAD only)...

Do you anticipate any other cases where the API call should validly
return NULL?  I offhand do not, ...

> but some
> code paths in builtin/branch.c cannot deal with that and cause
> segfaults. Fix it.
>
> While at there, make sure to bail out when the user gives 2 or more
> arguments, but only the first one is processed.
>
> Reported-by: Per Cederqvist <cederp@opera.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/branch.c  | 20 ++++++++++++++++++++
>  t/t3200-branch.sh | 21 +++++++++++++++++++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 6371bf9..c1d688e 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -889,6 +889,13 @@ int cmd_branch(int argc, const char **argv, cons=
t char *prefix)
>  	} else if (new_upstream) {
>  		struct branch *branch =3D branch_get(argv[0]);
> =20
> +		if (argc > 1)
> +			die(_("too many branches to set new upstream"));
> +
> +		if (!branch)
> +			die(_("could not figure out the branch name from '%s'"),
> +			    argc =3D=3D 1 ? argv[0] : "HEAD");

=2E.. and find this "could not figure out" very unfriendly to the
user.  Is it a bug in the implementation, silly Git failing to find
what branch the user meant?  What recourse does the user have at
this point?

Or is it a user error to ask Git to operate on the branch pointed at
by HEAD, when HEAD does not refer to any branch?  If that is the
case, then the message should say that there is no current branch to
operate on because the user is on a detached HEAD.  That would point
the user in the right direction to correct the user error, no?

Of course, argv[0] may not be HEAD and in that case you may have to
say "no such branch %s" % argv[0] or something.  The point is that
"could not figure out" feels a bit too lazy.

> @@ -901,6 +908,13 @@ int cmd_branch(int argc, const char **argv, cons=
t char *prefix)
>  		struct branch *branch =3D branch_get(argv[0]);
>  		struct strbuf buf =3D STRBUF_INIT;
> =20
> +		if (argc > 1)
> +			die(_("too many branches to unset upstream"));
> +
> +		if (!branch)
> +			die(_("could not figure out the branch name from '%s'"),
> +			    argc =3D=3D 1 ? argv[0] : "HEAD");

Likewise.

> @@ -916,6 +930,12 @@ int cmd_branch(int argc, const char **argv, cons=
t char *prefix)
>  		int branch_existed =3D 0, remote_tracking =3D 0;
>  		struct strbuf buf =3D STRBUF_INIT;
> =20
> +		if (!strcmp(argv[0], "HEAD"))
> +			die(_("it does not make sense to create 'HEAD' manually"));
> +
> +		if (!branch)
> +			die(_("could not figure out the branch name from '%s'"), argv[0])=
;

Likewise.

Thanks.
