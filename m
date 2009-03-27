From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Make local branches behave like remote branches when
 --tracked
Date: Fri, 27 Mar 2009 01:08:23 -0700
Message-ID: <7vprg3fkw8.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0903201358440.19665@iabervon.org>
 <1238100805-19619-1-git-send-email-git@drmicha.warpmail.net>
 <1238100805-19619-2-git-send-email-git@drmicha.warpmail.net>
 <1238100805-19619-3-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 27 09:10:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln78i-0002mc-E5
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 09:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbZC0IIh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Mar 2009 04:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752860AbZC0IIh
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 04:08:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53272 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360AbZC0IIe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Mar 2009 04:08:34 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A58F0A588B;
	Fri, 27 Mar 2009 04:08:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E06D0A5887; Fri,
 27 Mar 2009 04:08:25 -0400 (EDT)
In-Reply-To: <1238100805-19619-3-git-send-email-git@drmicha.warpmail.net>
 (Michael J. Gruber's message of "Thu, 26 Mar 2009 21:53:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 761C3542-1AA6-11DE-AE0B-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114870>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> This makes sure that local branches, when followed using --track, beh=
ave
> the same as remote ones (e.g. differences being reported by git statu=
s
> and git checkout). This fixes 1 known failure.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  remote.c                 |    9 +++++----
>  t/t6040-tracking-info.sh |    2 +-
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index 2b037f1..5d2d7a1 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1170,8 +1170,9 @@ struct branch *branch_get(const char *name)
>  			for (i =3D 0; i < ret->merge_nr; i++) {
>  				ret->merge[i] =3D xcalloc(1, sizeof(**ret->merge));
>  				ret->merge[i]->src =3D xstrdup(ret->merge_name[i]);
> -				remote_find_tracking(ret->remote,
> -						     ret->merge[i]);
> +				if(remote_find_tracking(ret->remote,
> +						     ret->merge[i]) && !strcmp(ret->remote_name, "."))
> +					ret->merge[i]->dst =3D xstrdup(ret->merge_name[i]);
>  			}
>  		}
>  	}

Yuck; please have a SP betweeen "if" and "(", and also have a decency t=
o
break a long line at a more sensible place, like:

			if (remote_find_tracking(ret->remote, ret->merge[i])
			    && !strcmp(...))
                            	then do this;

A na=C3=AFve question from me to this change is why this "fix-up" is do=
ne here.

The remote_find_tracking() function is given a half-filled refspec (thi=
s
caller fills the src side, and asks to find the dst side to the functio=
n).
After it fails to find a fetch refspec that copies remote refs to track=
ing
refs in the local repository that match the criteria, it returns -1 to
signal an error, otherwise it returns 0 after updating the other half o=
f
the refspec.

After calling r-f-t, because this new code assumes that for the "." rem=
ote
(aka "local repository"), r-f-t lies and does not give back what it
expects, fixes what it got back from r-f-t.  Shouldn't we be fixing thi=
s
inside r-f-t?

> @@ -1449,8 +1450,8 @@ int format_tracking_info(struct branch *branch,=
 struct strbuf *sb)
>  		return 0;
> =20
>  	base =3D branch->merge[0]->dst;
> -	if (!prefixcmp(base, "refs/remotes/")) {
> -		base +=3D strlen("refs/remotes/");
> +	if (!prefixcmp(base, "refs/")) {
> +		base +=3D strlen("refs/");

I am not sure if this is a good change.  The majority of the case would
be remotes/ and we would be better off not repeating them.  Can't you
limit the use of longer refs only when disambiguation is necessary?
