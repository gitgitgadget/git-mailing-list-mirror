From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] git cherry-pick: Add NULL check to sequencer parsing
 of HEAD
Date: Thu, 03 May 2012 13:45:54 +0200
Message-ID: <4FA26FF2.2050607@lsrfire.ath.cx>
References: <1336044026-16897-1-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mmueller@vigilantsw.com,
	Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Thu May 03 13:46:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPuUM-0000WC-QD
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 13:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129Ab2ECLp4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 May 2012 07:45:56 -0400
Received: from india601.server4you.de ([85.25.151.105]:58287 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688Ab2ECLp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 07:45:56 -0400
Received: from [192.168.2.105] (p4FFDA20E.dip.t-dialin.net [79.253.162.14])
	by india601.server4you.de (Postfix) with ESMTPSA id 54BC02F804F;
	Thu,  3 May 2012 13:45:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <1336044026-16897-1-git-send-email-nhorman@tuxdriver.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196898>

Am 03.05.2012 13:20, schrieb Neil Horman:
> Michael Mueller noted that a feature I recently added failed to check=
 the return
> of lookup_commit to ensure that it was not NULL.  I don't think a NUL=
L can
> actually happen in the this particular use case, but regardless it se=
ems a good
> idea to check.
>
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> ---
>   sequencer.c |   11 ++++++++++-
>   1 files changed, 10 insertions(+), 1 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index f83cdfd..ad4d781 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -261,7 +261,16 @@ static int is_index_unchanged(void)
>   		return error(_("Could not resolve HEAD commit\n"));
>
>   	head_commit =3D lookup_commit(head_sha1);
> -	if (!head_commit || parse_commit(head_commit))
> +
> +	/*
> +	 * If head_commit is NULL, just return, as check_commit,
> +	 * called from lookup_commit, would have indicated that
> +	 * head_commit is not a commit object already.
> +	 */
> +	if (!head_commit)
> +		return;

A return value is missing.  Perhaps -1?

> +
> +	if (parse_commit(head_commit))
>   		return error(_("could not parse commit %s\n"),
>   			     sha1_to_hex(head_commit->object.sha1));

Note: parse_commit() can handle NULL, and it already reports error=20
details itself.

Ren=E9
