From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] bisect: avoid signed integer overflow
Date: Tue, 02 Apr 2013 14:09:09 -0700
Message-ID: <7vzjxgabd6.fsf@alter.siamese.dyndns.org>
References: <cover.1364931627.git.john@keeping.me.uk>
 <0cb4456948b0874a1cedc5679a7b23b82e755e94.1364931627.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Apr 02 23:09:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN8Sc-00075S-2L
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 23:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762340Ab3DBVJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 17:09:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36122 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762311Ab3DBVJM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 17:09:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0F8C12865;
	Tue,  2 Apr 2013 21:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZLLpn9e58wOCtGL3JYp9le2Lcp4=; b=MjsWKP
	m8dcH7rXZjDYAm1Ky0EuoKVLsy1Sukahz+QiOXFE4S+g95r1QBGNVEsHAcsi4WA8
	G+7zRglW3AvxQR1vvg5lTCi7DrmgoG/BwSF+vlJcjIazG0ajX/X55ygvZx5Re+OI
	XznRCBESfXYtfGlSGa8Xmk9JcTCWP7nog7Eh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eOMlxmBm30jsIfHZBeL0S4m6Gl6FN1n5
	4MfGdfAUsy+87xEHCeVXxRgahVin6E3TKy9/PHahWsJUsdIBsdASdx7HWfe9yJHU
	rHslwmMyxZiJ801WxN9V+Baj3yFvcXeITQJUgI5IiXnGlRkB05P5B30NjTJZvcxn
	6Frj2byeWMQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C614A12864;
	Tue,  2 Apr 2013 21:09:11 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4796F12861; Tue,  2 Apr
 2013 21:09:11 +0000 (UTC)
In-Reply-To: <0cb4456948b0874a1cedc5679a7b23b82e755e94.1364931627.git.john@keeping.me.uk>
 (John Keeping's message of "Tue, 2 Apr 2013 20:50:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 90BC8FE2-9BD9-11E2-ABEF-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219886>

John Keeping <john@keeping.me.uk> writes:

> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  bisect.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bisect.c b/bisect.c
> index bd1b7b5..0d33c6f 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -526,7 +526,7 @@ struct commit_list *filter_skipped(struct commit_list *list,
>   * for this application.
>   */
>  static int get_prn(int count) {
> -	count = count * 1103515245 + 12345;
> +	count = ((unsigned) count) * 1103515245 + 12345;
>  	return ((unsigned)(count/65536) % PRN_MODULO);

I wonder

	static int get_prn(unsigned);

or even

	static unsigned get_prn(unsigned);

to lose the existing cast may be a better alternative.
