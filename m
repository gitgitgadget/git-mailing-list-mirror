From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] Move commit GPG signature verification to
 commit.c
Date: Mon, 25 Mar 2013 08:54:42 -0700
Message-ID: <7v8v5b1nlp.fsf@alter.siamese.dyndns.org>
References: <514D0C15.9000100@physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sebastian =?utf-8?Q?G=C3=B6tte?= <jaseg@physik.tu-berlin.de>
X-From: git-owner@vger.kernel.org Mon Mar 25 16:55:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK9jv-0007ku-Ly
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 16:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758602Ab3CYPys convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Mar 2013 11:54:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47686 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758527Ab3CYPyr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Mar 2013 11:54:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7044AF65;
	Mon, 25 Mar 2013 11:54:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=8niTytqgqRHUNqM142WZ7G3pB
	r0=; b=UrQ0oQvMSBiOUeE/bMel0R+3H0OP+dDsJmu63h2VQipyOQhkJo/ZEw9rr
	3kJ9W8eYxJpVwX47ARgAh2Ab+weIOXTIJL0+QvK04X5htkLLQokFnTrmcZXMUMq/
	IJxgAvAKGaT6vc83MtweXeqeHWDUXNpIc01fqUK7J18X4pAWY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=wizbV9H3mc0XY6ftU3f
	kpbnMi+shTrNbUsLMX1RoxiJ5UaYqAV9mNwMBp8p6At20scvsWzAj+7raDHGRsRd
	4CfoUnNQ6LWN0YNpif7W52CikTw3uOul80EoythlEdCHHsR7CId8SCl7rwlHjkpZ
	tKcmPg1YoWKhmkXoqsJJNL1M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABAEFAF64;
	Mon, 25 Mar 2013 11:54:44 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21AEAAF62; Mon, 25 Mar 2013
 11:54:44 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4FBB0FC6-9564-11E2-952E-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219038>

Sebastian G=C3=B6tte <jaseg@physik.tu-berlin.de> writes:

> Signed-off-by: Sebastian G=C3=B6tte <jaseg@physik-pool.tu-berlin.de>
> ---
>  commit.c        | 54 ++++++++++++++++++++++++++++++++++++++++++++++
>  commit.h        |  9 ++++++++
>  gpg-interface.h |  6 ++++++
>  pretty.c        | 67 +++++------------------------------------------=
----------
>  4 files changed, 74 insertions(+), 62 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index e8eb0ae..d0d9135 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1023,6 +1023,60 @@ free_return:
>  	free(buf);
>  }
> =20
> +static struct {
> +	char result;
> +	const char *check;
> +} signature_check[] =3D {
> +	{ 'G', ": Good signature from " },
> +	{ 'B', ": BAD signature from " },
> +};

This seems to be based on the old codebase.  4a868fd655a7 (pretty:
parse the gpg status lines rather than the output, 2013-02-14) is
already in 'master' for this cycle, and it is likely that we would
want to have the same fix for 1.8.1.x maintenance track as well.
