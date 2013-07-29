From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] imap-send: use Apple's Security framework for base64 encoding
Date: Mon, 29 Jul 2013 08:51:26 -0700
Message-ID: <7vhafd1i0x.fsf@alter.siamese.dyndns.org>
References: <1374957092-41505-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeremy Huddleston <jeremyhu@apple.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 17:51:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3pjb-0007D2-1T
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 17:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746Ab3G2Pvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 11:51:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59165 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754590Ab3G2Pv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 11:51:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24CFA3423B;
	Mon, 29 Jul 2013 15:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dUFrfWBsRZrLYIsuyeEhYMb+yaI=; b=sJF6kP
	2bzojRgPEnqAEk0tje3bIclKdUwHy+8IXoRGZWm+J8C4t7/AtsM0IGQcr+/cfXRm
	OkTE999rFY5a3010E8djCKBEpbQgekUgA4MZc4qVhsO2RCGJKoJMUvSs4/hC3cCu
	L+Pplu75Qt6w4R4KF+F9K2L0T0Tf/rDEPbjkI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N83nXRHQ4qE2xgY6ypUr/d8BxSzaVssl
	8eAVYEvA8VRbylbuCreWia1HDfPVqG6MIeLb4dTNbbWt09bwXeu57+2hQIP4FSD5
	+Q6ssoyf9RCXA2pZLHgn9Ia3jyv7GeLH2TrLkTmZ4+K+KIJ4zNTT8YCXQiKz1aOK
	ZpqnHYuV5P4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 177C03423A;
	Mon, 29 Jul 2013 15:51:29 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63EF934230;
	Mon, 29 Jul 2013 15:51:28 +0000 (UTC)
In-Reply-To: <1374957092-41505-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Sat, 27 Jul 2013 13:31:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB1DC9B0-F866-11E2-91A0-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231295>

David Aguilar <davvid@gmail.com> writes:

> diff --git a/imap-send.c b/imap-send.c
> index d6b65e2..3fd9c0e 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -22,14 +22,11 @@
>   *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>   */
>  
> -#include "cache.h"
> -#include "exec_cmd.h"
> -#include "run-command.h"
> -#include "prompt.h"
>  #ifdef NO_OPENSSL
>  typedef void *SSL;
>  #else
>  #ifdef APPLE_COMMON_CRYPTO
> +/* git-compat-util.h overwrites ctype.h; this must be included first */

I do not like this part of the patch, for the exact reason Jonathan
already mentioned.  The concern this comment addresses is exactly
the kind of thing git-compat-util.h was introduced for.

Could we keep the encapsulation of the logic to decide what to
include and in what order in git-compat-util.h, please?
