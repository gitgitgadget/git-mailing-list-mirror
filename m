From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/19] tree_entry_interesting(): support wildcard
 matching
Date: Mon, 13 Dec 2010 10:10:12 -0800
Message-ID: <7vaak935ob.fsf@alter.siamese.dyndns.org>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
 <1292233616-27692-13-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 19:10:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSCr7-0000Ws-3T
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 19:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758621Ab0LMSKW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 13:10:22 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59274 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758556Ab0LMSKU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Dec 2010 13:10:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7F4162F2E;
	Mon, 13 Dec 2010 13:10:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=j2w2FR+zf9CDKXEoU93ZIawCo
	3o=; b=rs317JBRjeccYlHq8RaahtcrphQMBx+IDwM1mN/P5VhdLmCSz08+zTNZd
	3QhS0Hsh7ycxB7L5UzAep42paLZzPiqXd0BIMOnC9oamLSzB7vi+E/5irhbs7g1B
	veSYtelbqiTAZccgC+eZrx5glDvNoQ0/H1ADwgvuKiUDjgIvxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=rRsadVnxLsW6jVcfu7i
	RDfQyVukv/FJ3VXw6rUIsq2DC/1CPsXetnp4jVTn6tpJMU+EBmPdk75YuOqQY4Bl
	TckN97kn6+XbkgpTKaCDi3hGlBulerzrUjMy5kE5Qm5LCRgRppmpuz9Tv/XK72ki
	3QHxfThIc+EpQl7ebacewyao=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3ED312F2C;
	Mon, 13 Dec 2010 13:10:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E78AB2F2A; Mon, 13 Dec 2010
 13:10:39 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4CBB36A4-06E4-11E0-9F76-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163575>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  tree-walk.c |   33 ++++++++++++++++++++++++++++++---
>  tree-walk.h |    2 +-
>  2 files changed, 31 insertions(+), 4 deletions(-)

;-)  Looks almost too easy.

> diff --git a/tree-walk.c b/tree-walk.c
> index d28de30..b5ad42b 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -596,6 +598,31 @@ int tree_entry_interesting(const struct name_ent=
ry *entry,
>  					&never_interesting))
>  				return 1;
>  		}
> +
> +match_wildcards:
> +		/*
> +		 * Concatenate base and entry->path into one and do
> +		 * fnmatch() on it.
> +		 */
> +
> +		if (!item->has_wildcard)
> +			continue;

I think the comment comes after this if--continue.

> +		never_interesting =3D 0;

When we have wildcard we would want to disable the never-interesting
optimization, but I wonder if doing so only when we do not have exact h=
it
is what we want.  If a sick person had a path "a?b" tracked, and asked =
to
match a pathspec "a?b", don't we still want to say "'a?b' of course
matches, but 'a1b' ('1' comes earlier than '?' in the sort order) and
'aAb' ('A' comes later) also match"?
