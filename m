From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git checkout creates strange '(null)'-branch
Date: Tue, 08 May 2012 08:05:40 -0700
Message-ID: <7vhavqzpa3.fsf@alter.siamese.dyndns.org>
References: <CABPQNSZbgZsQBReSqOskNQ4oZokHSibVr=yHdn6oSFjtdRvVVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue May 08 17:05:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRlz9-00030q-PQ
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 17:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755913Ab2EHPFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 11:05:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61643 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755718Ab2EHPFn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 11:05:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FF6E6E69;
	Tue,  8 May 2012 11:05:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xe1sQe4MRh5FZlTLlT4Ho3biBhY=; b=bgH22f
	vNs/AfQT2ZRIcfdFt/XW9JyogIrJyoHniHrbY/AUOXT7kAI7/2aNPSerdqENF7Je
	yBm1yWoIsqvZQAF+wZp/X8zV62SoegA5ere+btYSqdUEylT5rRDGAkKmyr+aCNC4
	gg99NqKCocXSN+EaKfBB3qKcWzDRcTIe1Kctc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i4AoQjtvc25isUXrRDTDEIxHGEX+f1ie
	+vdvjF382bb6cX0z9tQ2wCSZ83u1vFakCbeOtP2FdrrNHd5TIsNQrfvxg3MlWyg0
	mYKxT4dqjDte4Pu6entRRz3LL/QA/7Gm5SQpr3NyQwON0GTxJyoCS8TUly1GeuFC
	7L4hJpnOMSQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 984A86E68;
	Tue,  8 May 2012 11:05:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 317846E67; Tue,  8 May 2012
 11:05:42 -0400 (EDT)
In-Reply-To: <CABPQNSZbgZsQBReSqOskNQ4oZokHSibVr=yHdn6oSFjtdRvVVA@mail.gmail.com> (Erik
 Faye-Lund's message of "Tue, 8 May 2012 13:24:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4799FA10-991F-11E1-90FB-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197372>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> Before this commit, the checkout would error out with "fatal: You are
> on a branch yet to be born". Perhaps abe1998 was too optimistic about
> allowing this, and something like this would be in order?

> ---8<---
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 23fc56d..35924d4 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1091,7 +1091,7 @@ int cmd_checkout(int argc, const char **argv,
> const char *prefix)
>  	if (opts.writeout_stage)
>  		die(_("--ours/--theirs is incompatible with switching branches."));
>
> -	if (!new.commit) {
> +	if (!new.commit && opts.new_branch) {
>  		unsigned char rev[20];
>  		int flag;
> ---8<---

The patch looks like it will avoid flipping the HEAD, and in that case we
would go to switch_branches() codepath and will resurrect the old error
message, so it seems correct.

Thanks for digging.
