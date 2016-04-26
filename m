From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/83] builtin/apply: move 'check_index' global into 'struct apply_state'
Date: Tue, 26 Apr 2016 13:25:04 -0700
Message-ID: <xmqq7ffkf78f.fsf@gitster.mtv.corp.google.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-11-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 22:46:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av9si-0004m4-BN
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 22:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040AbcDZUZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 16:25:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61115 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752489AbcDZUZI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 16:25:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AD57F14347;
	Tue, 26 Apr 2016 16:25:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Yi8koC8dpNb4YUWzwNytKFFfGiU=; b=AMCs43
	q7TLNA/k/BOlLd3rA1gYxYJ6wzjw8W7PUACjivKHkkpdo+OsX3uLoZO9bZnEk6Yj
	+m2bx+4R+MAnM+VOj8eoPhNwNPgpx3pccUyvuS4HjBDnm4vAR4w2dMyfMoRFfyKn
	E6eBM7FUbxvlMPlLkeKlcSsQBZrXubmaWokic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pOm5rF+Y0b17mlODYZIyzzV0K9zN/A2k
	1/FtFhX0XIZD08tBTG55DuQloydPbEnG2vELjO6ty3sWsWd1oXyb6h105Pu9RXZ+
	LDhZAnlxdfCY5j8riUZc4ITbylMzG85tPta3l5z1/TdljETxsX5G1/ftwAA3NVS/
	1gv0YS/1ZEM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A4A4F14346;
	Tue, 26 Apr 2016 16:25:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 00BEF14345;
	Tue, 26 Apr 2016 16:25:06 -0400 (EDT)
In-Reply-To: <1461504863-15946-11-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Sun, 24 Apr 2016 15:33:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F6B7EDE2-0BEC-11E6-9EA6-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292665>

Christian Couder <christian.couder@gmail.com> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/apply.c | 69 +++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 40 insertions(+), 29 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 6c628f6..3f8671c 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -30,6 +30,10 @@ struct apply_state {
>  	 *    files that are being modified, but doesn't apply the patch
>  	 */
>  	int check;
> +
> +	/* --index updates the cache as well. */
> +	int check_index;
> +
>  	int unidiff_zero;
>  };
>  
> @@ -37,14 +41,12 @@ struct apply_state {
>   *  --stat does just a diffstat, and doesn't actually apply
>   *  --numstat does numeric diffstat, and doesn't actually apply
>   *  --index-info shows the old and new index info for paths if available.
> - *  --index updates the cache as well.
>   *  --cached updates only the cache without ever touching the working tree.
>   */
>  static int newfd = -1;
>  
>  static int state_p_value = 1;
>  static int p_value_known;
> -static int check_index;
>  static int update_index;
>  static int cached;

I like the way this series moves only a few variables at a time to
limit the scope of each step.  I would have expected check-index and
cached to touch pretty much the same codepaths (the latter would
involve a subset of the codepaths involved for the former), but
doing them separately is fine.
