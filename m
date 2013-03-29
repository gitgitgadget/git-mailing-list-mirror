From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] optimize set_shared_perm()
Date: Fri, 29 Mar 2013 14:20:27 -0700
Message-ID: <7vli95nbs4.fsf@alter.siamese.dyndns.org>
References: <201303251657.57222.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, j6t@kdbg.org, kusmabite@gmail.com,
	mlevedahl@gmail.com, ramsay@ramsay1.demon.co.uk,
	sunshine@sunshineco.com
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 29 22:21:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULgjP-0007vy-O0
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 22:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756976Ab3C2VUb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Mar 2013 17:20:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51692 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756865Ab3C2VUa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Mar 2013 17:20:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AC83F2C1;
	Fri, 29 Mar 2013 21:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/gV/u/gpV8+J
	c51gm+z4yntnGco=; b=dZ2cYSMfFj4N02SkykKkiDrBSMZKxARSxI3K4y9gRZyc
	Iov8NJmlMet//eVfyOnwnt37l1Yq3LtW/hUqt7/Fdy9X4ianmSOyz4Eaim86pJGI
	rO4q9oT3QFeZJo8gnOiUc25yL8Ok4X5EGyDNa3B8XZ5tD+pf2SWjbNzSPcO2Pik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rD47Ft
	WwMQ2YanR9/KO8zBeMTmKx1Is4lto1BH6aECuM4kxQCPGJswnR5OYLS7aRlbjlsx
	wffk6OC8+ck20Z/xuBgNkKzNZ8cXhu9kDBsVbqMNscttrpTzwAFBs09FD3LNHvft
	vECo9x61d+HrUxNMX7efMU7Kj7clFtE2CYeNU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F12CF2BF;
	Fri, 29 Mar 2013 21:20:29 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0565F2BE; Fri, 29 Mar 2013
 21:20:28 +0000 (UTC)
In-Reply-To: <201303251657.57222.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?= message of "Mon, 25 Mar 2013 16:57:56
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7AE7AF74-98B6-11E2-9A0B-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219531>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>   optimize set_shared_perm() in path.c:
>
>   - sometimes the chown() function is called even when not needed.
>     (This can be provoced by running t1301, and adding some debug cod=
e)
>
>     Save a chmod from 400 to 400, or from 600->600 on these files:
>     .git/info/refs+
>     .git/objects/info/packs+
>
>     Save chmod on directories from 2770 to 2770:
>     .git/refs
>     .git/refs/heads
>     .git/refs/tags
>
>   - as all callers use mode =3D=3D 0 when caling set_shared_perm(),
>     the function can be simplified.
>   - all callers use the macro adjust_shared_perm(path) from cache.h
>     Convert adjust_shared_perm() from a macro into a function prototy=
pe

The last two points can become a separate "preparation" step.  The
result would be easier to read.

Your updated adjust_shared_perm() does not begin with:

	if (!shared_repository)
        	return 0;

as the original, but it always first calls to get_st_mode_bits()
which makes a call to lstat(2).

That smells like a huge regression for !shared_repository case,
unless you have updated the existing callers of adjust_shared_perm()
not to call it when !shared_repository.

> diff --git a/path.c b/path.c
> index 2fdccc2..4bc918a 100644
> --- a/path.c
> +++ b/path.c
> @@ -1,14 +1,5 @@
>  /*
> - * I'm tired of doing "vsnprintf()" etc just to open a
> - * file, so here's a "return static buffer with printf"
> - * interface for paths.
> - *
> - * It's obviously not thread-safe. Sue me. But it's quite
> - * useful for doing things like
> - *
> - *   f =3D open(mkpath("%s/%s.git", base, name), O_RDONLY);
> - *
> - * which is what it's designed for.
> + * Different utilitiy functions for path and path names
>   */

Removing the stale "I'm tired of" is good; you do not have to move
it anywhere.  A single-liner

	/* Utilities for paths and pathnames */

should suffice.

Will discard this step (but will keep PATCH 1/2).
