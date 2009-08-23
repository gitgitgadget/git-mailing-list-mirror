From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH-v2/RFC 3/6] xutils: fix ignore-all-space on incomplete
 line
Date: Sun, 23 Aug 2009 14:14:27 -0700
Message-ID: <7vtyzyteq4.fsf@alter.siamese.dyndns.org>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name>
 <1250999357-10827-3-git-send-email-git@tbfowler.name>
 <7vvdkfx8rl.fsf@alter.siamese.dyndns.org>
 <20090823171819.6117@nanako3.lavabit.com>
 <7v1vn2yklo.fsf@alter.siamese.dyndns.org>
 <20090824060708.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thell Fowler <git@tbfowler.name>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 23:14:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfKOq-00020U-Uq
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 23:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934135AbZHWVOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 17:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755972AbZHWVOi
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 17:14:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49227 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755967AbZHWVOh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 17:14:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3B29034961;
	Sun, 23 Aug 2009 17:14:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BZTN3NHDVCKMnm9PTqqgNJ2qkZM=; b=r/vn+h
	8Uz9j9r/qxthafnMzyEtv2ULIR9ICadP3UB4N8Ff58EFwxRF1hZGyuLwY8tp2c4h
	2LzPASkgoo0G1k3a1+IlO1lpzIvfFO/Wcti/82pMc+oD5gSBXKyCIi6ZPuxUuwys
	QlbpiwC/tQWBkeR9Dm7jXGFGvmlvc9S2/84M4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e315yJ861z/ziOjEBqAW1Kk61bt7uqqG
	LgQNbimANPVCkxRKDUHFlY/hIzuA0Lqf3fj3ZJkt3Gs99j/AXLKzyd75JUF08iPg
	1qUPvlEi7VCKxNOTx5cSPS0XNI9hJaPsaRrvkyBt0eIwL6PBgvOyBJLRzIoScpPu
	0k9HZFCiV+U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F41CF34960;
	Sun, 23 Aug 2009 17:14:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 419653495E; Sun, 23 Aug 2009
 17:14:28 -0400 (EDT)
In-Reply-To: <20090824060708.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Mon\, 24 Aug 2009 06\:07\:08 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F52D0980-9029-11DE-A053-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126882>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> There are left handed people whose scissors run in the wrong direction.

Heh.

> diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
> index b0906ef..38c01e4 100644
> --- a/builtin-mailinfo.c
> +++ b/builtin-mailinfo.c
> @@ -725,7 +725,8 @@ static int scissors(const struct strbuf *line)
>  			scissors_dashes_seen |= 02;
>  			continue;
>  		}
> -		if (i + 1 < len && !memcmp(buf + i, ">8", 2)) {
> +		if (i + 1 < len &&
> +		    !memcmp(buf + i, ">8", 2) || !memcmp(buf + i, "8<", 2)) {
>  			scissors_dashes_seen |= 01;

You need a pair of parentheses around the memcmp || memcmp.

I'll squash that in.
