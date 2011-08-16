From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] update-index: add --swap to swap index and worktree content
Date: Tue, 16 Aug 2011 15:01:55 +0200
Message-ID: <4E4A6A43.7040706@drmicha.warpmail.net>
References: <1313158058-7684-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 16 15:02:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtJHR-00088a-3W
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 15:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622Ab1HPNB7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Aug 2011 09:01:59 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:54912 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751377Ab1HPNB6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2011 09:01:58 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 61D8E20CAA;
	Tue, 16 Aug 2011 09:01:57 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 16 Aug 2011 09:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=4UmiaZ6LDTbqQzjLMpacMd
	JqkC4=; b=dND3DnT5CCfTCIfhTpF3f10wmubmA2NhuYPy+FdzEqUtGM2z4uENcY
	zKvQtwkfzqSSEH8o7OBVRCUrrHzCezy3fGk8K5sGpf1P7u9pv83oH23SgZD4lpF4
	etxCL4d2Xd5ESvjJsTu1KMPSgvofveODpdrGnYM+/DehURzizWGfQ=
X-Sasl-enc: 6xAl7RCkvvA437jNKk3XfL5iOGc0MxS+oL8hhoaulkwE 1313499717
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BDE6F41E39E;
	Tue, 16 Aug 2011 09:01:56 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
In-Reply-To: <1313158058-7684-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179444>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy venit, vidit, dixit 12.08.201=
1 16:07:
> Sometimes "git add -p" with "e" to edit the patch does not satisfy me=
=2E
> What I want is a quick way to modify index content without changing
> worktree, then I can continue adding more hunks to the index.
>=20
> With this option, I can swap index out for a quick edit, then swap it=
 in
> again.

I had to think about that explanation for a while (partly because "git
add" does not alter the wt either). So, your patch would support the
following workflow:

git add foo # have index =3D=3D wt
hack foo # change foo in wt
git update-index --swap foo # add foo and reset to previous state

Am I understanding you right? The option could trickle down to "add".

I share the pov that "add -p with e" sometimes doesn't cut it. But
similarly, the fact that "add -p" can't be used to undo a previous "add
-p" is suboptimal. Both issues could be solved with a 3way stage tool. =
I
have this on my todo/wish list, and I seem to recall that Jeff or Junio
came up with a few lines of (scripting) code for that. That would depen=
d
on the availability of proper tools, though (e.g. vim in diff mode).

--swap might be useful nevertheless.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Not sure if anybody has the same needs, enough to polish it and make
>  it to master.
>=20
>  builtin/update-index.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
>=20
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index a6a23fa..b96065a 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -22,6 +22,7 @@
>  static int allow_add;
>  static int allow_remove;
>  static int allow_replace;
> +static int swap_entry;
>  static int info_only;
>  static int force_remove;
>  static int verbose;
> @@ -104,6 +105,19 @@ static int add_one_path(struct cache_entry *old,=
 const char *path, int len, stru
>  		free(ce);
>  		return -1;
>  	}
> +	if (swap_entry) {
> +		struct checkout state;
> +		if (allow_add || allow_remove)
> +			die("--add, --replace and --swap do not play together");
> +		memset(&state, 0, sizeof(state));
> +		state.force =3D 1;
> +		state.not_new =3D 1;
> +		if (add_cache_entry(ce, 0))
> +			return error("%s: cannot add to the index", path);
> +		if (checkout_entry(old, &state, NULL))
> +			return error("%s: cannot swap", path);
> +		return 0;
> +	}
>  	option =3D allow_add ? ADD_CACHE_OK_TO_ADD : 0;
>  	option |=3D allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
>  	if (add_cache_entry(ce, option))
> @@ -727,6 +741,8 @@ int cmd_update_index(int argc, const char **argv,=
 const char *prefix)
>  			"let files replace directories and vice-versa", 1),
>  		OPT_SET_INT(0, "remove", &allow_remove,
>  			"notice files missing from worktree", 1),
> +		OPT_SET_INT(0, "swap", &swap_entry,
> +			"swap the content of index and worktree", 1),
>  		OPT_BIT(0, "unmerged", &refresh_args.flags,
>  			"refresh even if index contains unmerged entries",
>  			REFRESH_UNMERGED),
