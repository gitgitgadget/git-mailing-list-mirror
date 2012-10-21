From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/2] Fix failure to delete a packed ref through a symref
Date: Sun, 21 Oct 2012 19:46:45 +0200
Message-ID: <50843505.3040509@lsrfire.ath.cx>
References: <7vpq4flb1c.fsf@alter.siamese.dyndns.org> <1350816032-16312-1-git-send-email-johan@herland.net> <1350816032-16312-3-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, vmiklos@suse.cz
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Oct 21 19:47:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPzcB-0001bW-79
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 19:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380Ab2JURqz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Oct 2012 13:46:55 -0400
Received: from india601.server4you.de ([85.25.151.105]:44954 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932303Ab2JURqy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 13:46:54 -0400
Received: from [192.168.2.105] (p579BE26F.dip.t-dialin.net [87.155.226.111])
	by india601.server4you.de (Postfix) with ESMTPSA id B1959105;
	Sun, 21 Oct 2012 19:46:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <1350816032-16312-3-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208127>

Am 21.10.2012 12:40, schrieb Johan Herland:
> When deleting a ref through a symref (e.g. using 'git update-ref -d H=
EAD'
> to delete refs/heads/master), we would remove the loose ref, but a pa=
cked
> version of the same ref would remain, the end result being that inste=
ad of
> deleting refs/heads/master we would appear to reset it to its state a=
s of
> the last repack.
>
> This patch fixes the issue, by making sure we pass the correct ref na=
me
> when invoking repack_without_ref() from within delete_ref().
>
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>   refs.c                | 2 +-
>   t/t1400-update-ref.sh | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 726c53c..6cec1c8 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1779,7 +1779,7 @@ int delete_ref(const char *refname, const unsig=
ned char *sha1, int delopt)
>   	 * packed one.  Also, if it was not loose we need to repack
>   	 * without it.
>   	 */
> -	ret |=3D repack_without_ref(refname);
> +	ret |=3D repack_without_ref(lock->ref_name);
>
>   	unlink_or_warn(git_path("logs/%s", lock->ref_name));
>   	invalidate_ref_cache(NULL);

Looks reasonable.

=46WIW, this is independent of 547d058f in next (refs: lock symref that=
 is=20
to be deleted, not its target), which only affects behaviour when=20
REF_NODEREF is set, while this one here only makes a difference with=20
symrefs and REF_NODEREF unset.

Ren=E9
