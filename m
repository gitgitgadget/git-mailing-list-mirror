From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix false positives in t3404 due to SHELL=/bin/false
Date: Tue, 28 Dec 2010 11:58:08 -0800
Message-ID: <7vmxnpwtyn.fsf@alter.siamese.dyndns.org>
References: <robbat2-20101227T024837-537032076Z@orbis-terrarum.net>
 <7vsjxjyce6.fsf@alter.siamese.dyndns.org>
 <20101227080343.GA15026@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Tue Dec 28 20:58:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXfgb-0000us-Rn
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 20:58:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749Ab0L1T6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 14:58:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64608 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618Ab0L1T6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 14:58:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8076E2938;
	Tue, 28 Dec 2010 14:58:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rVh9n6TNbjDGvOcLxBnSd2gjdtI=; b=iI6yZS
	KHbgBx3s0W+siV30S8e6jZ5VKT6U8SKVfgXVxR+4zv/CtI8EE9hT9V9JhqTx2rX5
	Gi2qu48lAdC8o7mT+q31O3W9gbudpbz1Gm72tP+qnHDH8Ws7CfvDGd0h8+fb+Iau
	NOutz+iObUMFUub3ada7mEmDLXgr0J/thERmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lyaAIeBDQgF9QCDUZo4Mrpuf9i9WoSp9
	OyAeBiTcatiOjftOlvdMVjBwjy02q4XbRQnlzjOhALqWSpM2BnhEvQDWAZuAX29Z
	Fyah2eUGDcLv7g8/HAgJwADR00SvDM75R7rIePP+llRu6xG1zimt+ORW82/p/Vbc
	awjwy0SBNE8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5CEAB2937;
	Tue, 28 Dec 2010 14:58:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5931B2936; Tue, 28 Dec 2010
 14:58:41 -0500 (EST)
In-Reply-To: <20101227080343.GA15026@orbis-terrarum.net> (Robin H. Johnson's
 message of "Mon\, 27 Dec 2010 08\:03\:43 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E00FA6AE-12BC-11E0-AAC5-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164288>

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> If the user's shell in NSS passwd is /bin/false (eg as found during Gentoo's
> package building), the git-rebase exec tests will fail, because they call
> $SHELL around the command, and in the existing testcase, $SHELL was not being
> cleared sufficently.

> ---
>  t/t3404-rebase-interactive.sh |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index d3a3bd2..7d8147b 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -71,8 +71,9 @@ test_expect_success 'setup' '
>  # "exec" commands are ran with the user shell by default, but this may
>  # be non-POSIX. For example, if SHELL=zsh then ">file" doesn't work
>  # to create a file. Unseting SHELL avoids such non-portable behavior
> -# in tests.
> +# in tests. It must be exported for it to take effect where needed.
>  SHELL=
> +export SHELL

Thanks; will queue this version to 'maint'.

I have this nagging suspicion that we may want to revisit this to assign
$SHELL_PATH to it before exporting, and that this might be better done in
t/test-lib.sh at the beginning.  Note that unlike my earlier "your v1
might be less portable than desired", these two points are only
speculations and RFCs.
