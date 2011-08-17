From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] commit: accept tag objects in HEAD/MERGE_HEAD
Date: Wed, 17 Aug 2011 10:59:15 -0700
Message-ID: <7vy5yrex70.fsf@alter.siamese.dyndns.org>
References: <1313422716-26432-1-git-send-email-pclouds@gmail.com>
 <1313545369-7096-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 19:59:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtkOj-00075J-2t
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 19:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534Ab1HQR7U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Aug 2011 13:59:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34982 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458Ab1HQR7S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2011 13:59:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C67632BE;
	Wed, 17 Aug 2011 13:59:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KLziW3aDVqf3
	oHTW9MqQOMPYL9s=; b=frGUiwgiEHClPnbjrNkWxWLWH1DJVqErJ3YOwT26I7Vj
	MoHcir/jHf8neSURgLO6lkg/3YjLGMphauRGRYOnZTf0/jYSD5QAmeLtenRBjGjc
	po79VaxrnGWY0bkOnpfPHOwr+uwywG/FAXvPFnON0p49HbMBoH2n8Ppnk9dPmi0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QbocTJ
	djQlbA9BL3sAuufnPDZbwuqAd0byX7Hl74fKe9i55sg7GvoJ1HJMp5aGYltkYz/U
	P+PwwLm0RpvGfwX8y9fmQqM+1PeNwDsBFEFrdN0lYUw9FwYbr06wYYI9oWAXhOwN
	dRvPGzsXYxbCz39xmACltWZNLzyCJAsWS1M9k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3411032BD;
	Wed, 17 Aug 2011 13:59:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8008832BC; Wed, 17 Aug 2011
 13:59:17 -0400 (EDT)
In-Reply-To: <1313545369-7096-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 17 Aug
 2011 08:42:49 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A0261F6A-C8FA-11E0-A75B-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179521>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> HEAD, MERGE_HEAD (or any other branches) should only have SHA-1 of a
> commit object. However broken tools can put a tag object there. While
> it's wrong, it'd be better to tolerate the situation and move on

The best part in your patch is that you made it _warn_ when it happens;=
 I
would suggest rewording this with s/situation/&, warn/.

> ("commit" is an often used operation, unable to commit could be bad).

Neither "often used" nor "unable to commit" is a good reason for this
added leniency. The real reason is that such a condition left by broken
tools is cumbersome to fix by an end user with:

	$ git update-ref HEAD $(git rev-parse HEAD^{commit})

which may look like a magic to a new person.

By the way, what happens when you try to merge when HEAD points at a ta=
g
that points at a commit? Would we end up creating a commit that points =
at
a bogus parent?

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 2088b6b..f327595 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1387,6 +1387,7 @@ int cmd_commit(int argc, const char **argv, con=
st char *prefix)
>  	unsigned char commit_sha1[20];
>  	struct ref_lock *ref_lock;
>  	struct commit_list *parents =3D NULL, **pptr =3D &parents;
> +	struct commit *commit;
>  	struct stat statbuf;
>  	int allow_fast_forward =3D 1;
>  	struct wt_status s;

Here, you are being inconsistent with your own argument you made in you=
r
previous message "later somebody may forget to update the former while
updating the latter" when I suggested to separate the two logically
separate operations (grab the head_commit object when necessary, and
decide how the commit is made). By hoisting of the scope of "commit", y=
ou
made the variable undefined when dealing with the initial_commit, expos=
ing
the code to the same risk that somebody may try to use "commit" variabl=
e
after the if/elseif/... cascade, where it may or may not be defined.

Not that I buy your previous argument in this case---it's not like we h=
ave
deeply nested callchain that sometimes sets a variable and sometimes
doesn't. It's all there for the updater to see in a single function.

> @@ -1423,12 +1424,11 @@ int cmd_commit(int argc, const char **argv, c=
onst char *prefix)
>  			reflog_msg =3D "commit (initial)";
>  	} else if (amend) {
>  		struct commit_list *c;
> -		struct commit *commit;
> =20
>  		if (!reflog_msg)
>  			reflog_msg =3D "commit (amend)";
> -		commit =3D lookup_commit(head_sha1);
> -		if (!commit || parse_commit(commit))
> +		commit =3D lookup_expect_commit(head_sha1, "HEAD");
> +		if (parse_commit(commit))
>  			die(_("could not parse HEAD commit"));

Is this still necessary? I think your lookup_expect_commit() already
checks this condition and barfs.
