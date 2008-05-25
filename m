From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Clean up builtin-update-ref's option parsing
Date: Sun, 25 May 2008 11:40:24 -0700
Message-ID: <7vk5hii5wn.fsf@gitster.siamese.dyndns.org>
References: <20080525161125.25087.18083.stgit@yoghurt>
 <20080525161435.25087.82683.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun May 25 20:41:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0L9r-0000CQ-Qa
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 20:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756496AbYEYSkf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 May 2008 14:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755624AbYEYSkf
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 14:40:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43333 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110AbYEYSke convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 May 2008 14:40:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0B89F328F;
	Sun, 25 May 2008 14:40:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 26F9E328E; Sun, 25 May 2008 14:40:28 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0EA22D5C-2A8A-11DD-950D-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82873>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> builtin-update-ref's option parsing was somewhat tricky to follow,
> especially if the -d option was given. This patch cleans it upp a bit
> (including fixing an out-of-bounds argv access), at the expense of
> making it a bit longer.
>
> Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

Longer is fine but I am afraid that this patch is not much easier to
follow than the original, does not fix anything, and introduces a new b=
ug.

> diff --git a/builtin-update-ref.c b/builtin-update-ref.c
> index e90737c..0d3eb8e 100644
> --- a/builtin-update-ref.c
> +++ b/builtin-update-ref.c
> @@ -27,25 +27,29 @@ int cmd_update_ref(int argc, const char **argv, c=
onst char *prefix)
>  	if (msg && !*msg)
>  		die("Refusing to perform update with empty message.");
> =20
> -	if (argc < 2 || argc > 3)
> -		usage_with_options(git_update_ref_usage, options);
> -	refname =3D argv[0];
> -	value   =3D argv[1];
> -	oldval  =3D argv[2];
> -
> -	if (get_sha1(value, sha1))
> -		die("%s: not a valid SHA1", value);
> -
>  	if (delete) {
> -		if (oldval)
> +		if (argc !=3D 2)
>  			usage_with_options(git_update_ref_usage, options);
> -		return delete_ref(refname, sha1);
> +		refname =3D argv[0];
> +		value =3D NULL;
> +		oldval =3D argv[1];
> +	} else {
> +		if (argc < 2 || argc > 3)
> +			usage_with_options(git_update_ref_usage, options);
> +		refname =3D argv[0];
> +		value =3D argv[1];
> +		oldval =3D argc > 2 ? argv[2] : NULL;

When (argc =3D=3D 3), argv[2] has the old value string given on the com=
mand
line.  When (argc =3D=3D 2), argv[2] has the terminating NULL pointer. =
 So
either case you can safely use argv[2].  You do not allow other cases
upfront, so I do not understand why you need this conditional expressio=
n?

IOW, I do not see "an out-of-bounds argv access" in the original, and y=
ou
are making this assignment harder to follow.

>  	}
> =20
> +	if (value && *value && get_sha1(value, sha1))
> +		die("%s: not a valid SHA1", value);

Dropping *value in the sequence may fix it but I think this is wrong.

We used to barf if you said "git update-ref refs/heads/master '' master=
"
because it would be nonsense to give an empty string as the new value o=
f
the ref, didn't we?  Doesn't this change break it?  Does your set of
additional tests in [1/3] catch it?

>  	hashclr(oldsha1);
>  	if (oldval && *oldval && get_sha1(oldval, oldsha1))
>  		die("%s: not a valid old SHA1", oldval);
> =20
> -	return update_ref(msg, refname, sha1, oldval ? oldsha1 : NULL,
> -			  no_deref ? REF_NODEREF : 0, DIE_ON_ERR);
> +	if (delete)
> +		return delete_ref(refname, oldsha1);
> +	else
> +		return update_ref(msg, refname, sha1, oldval ? oldsha1 : NULL,
> +				  no_deref ? REF_NODEREF : 0, DIE_ON_ERR);
>  }
