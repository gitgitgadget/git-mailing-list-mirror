From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/16] unpack_trees(): add support for narrow checkout
Date: Mon, 15 Sep 2008 12:34:57 -0700
Message-ID: <7vsks1b3tq.fsf@gitster.siamese.dyndns.org>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
 <1221397685-27715-2-git-send-email-pclouds@gmail.com>
 <1221397685-27715-3-git-send-email-pclouds@gmail.com>
 <1221397685-27715-4-git-send-email-pclouds@gmail.com>
 <1221397685-27715-5-git-send-email-pclouds@gmail.com>
 <1221397685-27715-6-git-send-email-pclouds@gmail.com>
 <1221397685-27715-7-git-send-email-pclouds@gmail.com>
 <1221397685-27715-8-git-send-email-pclouds@gmail.com>
 <1221397685-27715-9-git-send-email-pclouds@gmail.com>
 <1221397685-27715-10-git-send-email-pclouds@gmail.com>
 <1221397685-27715-11-git-send-email-pclouds@gmail.com>
 <1221397685-27715-12-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 21:36:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfJrs-0006Nx-Bk
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 21:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbYIOTfI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Sep 2008 15:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753260AbYIOTfI
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 15:35:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48945 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017AbYIOTfF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Sep 2008 15:35:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A4A49611C5;
	Mon, 15 Sep 2008 15:35:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B73FB611C4; Mon, 15 Sep 2008 15:34:59 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 64291660-835D-11DD-8A57-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95931>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/cache.h b/cache.h
> index 2b2c90f..1fc0f83 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -167,6 +167,9 @@ struct cache_entry {
>  #define CE_HASHED    (0x100000)
>  #define CE_UNHASHED  (0x200000)
> =20
> +/* Only remove in work directory, not index */
> +#define CE_WD_REMOVE (0x400000)
> +
>  /*
>   * Extended on-disk flags
>   */
> diff --git a/unpack-trees.c b/unpack-trees.c
> index e59d144..968cc98 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -96,6 +96,15 @@ static int check_updates(struct unpack_trees_optio=
ns *o)
>  	if (o->update && o->verbose_update) {
>  		for (total =3D cnt =3D 0; cnt < index->cache_nr; cnt++) {
>  			struct cache_entry *ce =3D index->cache[cnt];
> +
> +			if (ce->ce_flags & CE_WD_REMOVE) {
> +				total++;
> +				continue;
> +			}
> +
> +			if (ce_no_checkout(ce))
> +				continue;
> +
>  			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE))
>  				total++;
>  		}

This check for ce_no_checkout() before the existing check to see if
CE_UPDATE and/or CE_REMOVE are on puzzles me (you have the same check
sequence in later loop that does the actualy worktree updates).  If
apply_narrow_checkout() check is working correctly, would we ever give
CE_UPDATE and/or CE_REMOVE bits to a cache entry with CE_NO_CHECKOUT se=
t?

IOW, I think this extra check is Ok as it is expected to be no-op when
combined with the existing check, but it leaves me wondering if it is
hiding some codepath that incorrectly sets CE_UPDATE/CE_REMOVE to an en=
try
outside the narrow checkout area.

I have two more messages but other than these the series is nicely done
and a pleasure to read.
