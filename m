From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Turn off pathspec magic on "{checkout,reset,add} -p"
 on native Windows builds
Date: Mon, 02 Sep 2013 08:42:18 +0200
Message-ID: <5224334A.2090300@viscovery.net>
References: <521EF02A.2020300@viscovery.net> <1378001284-18426-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 02 08:42:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGNqC-00063V-Cv
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 08:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756978Ab3IBGmU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Sep 2013 02:42:20 -0400
Received: from so.liwest.at ([212.33.55.13]:51515 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753713Ab3IBGmU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 02:42:20 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VGNq6-0006SC-4i; Mon, 02 Sep 2013 08:42:18 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E0A651660F;
	Mon,  2 Sep 2013 08:42:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <1378001284-18426-1-git-send-email-pclouds@gmail.com>
X-Enigmail-Version: 1.5.2
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233618>

Am 9/1/2013 4:08, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> git-add--interactive.perl rejects arguments with colons in 21e9757
> (Hack git-add--interactive to make it work with ActiveState Perl -
> 2007-08-01). Pathspec magic starts with a colon, so it won't work if
> these pathspecs are passed to git-add--interactive.perl running with
> ActiveState Perl. Make sure we only pass plain paths in this case.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Johannes, can you check the test suite passes for you with this
>  patch? I assume that Cygwin Perl behaves differently and does not hi=
t
>  this limit. So I keep the special case to GIT_WINDOWS_NATIVE only.
>  I'll resend the patch with a few others on the same topic if it work=
s
>  for you.

It does not help. The error in git-add--interactive is avoided, but the
failure in t2016-checkout-patch.sh is now:

expecting success:
        set_state dir/foo work head &&
        # the third n is to get out in case it mistakenly does not appl=
y
        (echo y; echo n; echo n) | (cd dir && git checkout -p foo) &&
        verify_saved_state bar &&
        verify_state dir/foo head head

No changes.
not ok 13 - path limiting works: foo inside dir

and the same "No changes." happens in t7105-reset-patch.sh

> +#ifdef GIT_WINDOWS_NATIVE
> +	/*
> +	 * Pathspec magic is completely turned off on native Windows
> +	 * builds because git-add-interactive.perl won't accept
> +	 * arguments with colons in them. :/foo is an exception
> +	 * because no colons remain after parsing.
> +	 */
> +	parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP,
> +		       PATHSPEC_PREFER_FULL |
> +		       PATHSPEC_SYMLINK_LEADING_PATH,
> +		       prefix, argv);
> +#else
>  	/*
>  	 * git-add--interactive itself does not parse pathspec. It
>  	 * simply passes the pathspec to other builtin commands. Let's
> @@ -281,6 +293,7 @@ int interactive_add(int argc, const char **argv, =
const char *prefix, int patch)
>  		       PATHSPEC_SYMLINK_LEADING_PATH |
>  		       PATHSPEC_PREFIX_ORIGIN,
>  		       prefix, argv);
> +#endif
> [etc.]

-- Hannes
