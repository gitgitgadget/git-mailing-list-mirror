From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 4/4] git-rebase: add keep_empty flag
Date: Wed, 18 Apr 2012 15:58:53 -0700
Message-ID: <7vmx68k5oy.fsf@alter.siamese.dyndns.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334686809-17634-1-git-send-email-nhorman@tuxdriver.com>
 <1334686809-17634-5-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Clemens Buchacher <drizzd@aon.at>,
	Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 00:59:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKdqN-0000jd-9L
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 00:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414Ab2DRW7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 18:59:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43750 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754013Ab2DRW6z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 18:58:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1620692C;
	Wed, 18 Apr 2012 18:58:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=sxdbfhX2t2dKG35xuVv/xDZzpI0=; b=cGPd8iuOwag2DZi1wCjr
	bqA/zVXEmzr0YAg1rOTBZyRfkEEomcp7YeCoRaLAwZs04rW2ndL/CMv4rdEfeRIb
	yE15egRacwzoq6LDese87TdwmqFfdTrrIpSVLfqrjZCT3545MW0oUMDUPSC0smJV
	kAeJMTbFcLYw2VxnqR4XIuw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=hiVZjUzseAT4lYBFe7rc03QsLF5VdjfSdOLQrD4jtLLYSx
	EWISK4vvJwnyb6U/F5oo3Tr6Zm55xV2Y6ZnmldNMIxD3je8QuQuzuLOOtOBUqjVA
	SoitkGooGJ7HhjbZFqbfyVag03RH9vHK+EejK/ydBfSGjEaqEGyADcVLjQccc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E96C1692B;
	Wed, 18 Apr 2012 18:58:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56748692A; Wed, 18 Apr 2012
 18:58:54 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12619FB2-89AA-11E1-A892-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195914>

Neil Horman <nhorman@tuxdriver.com> writes:

> Add a command line switch to git-rebase to allow a user the ability to specify
> that they want to keep any commits in a series that are empty.
>
> When git-rebase's type is am, then this option will automatically keep any
> commit that has a tree object identical to its parent.
>
> This patch changes the default behavior of interactive rebases as well.  With
> this patch, git-rebase -i will produce a revision set passed to
> git-revision-editor, in which empty commits are commented out.  Empty commits
> may be kept manually by uncommenting them.  If the new --keep-empty option is
> used in an interactive rebase the empty commits will automatically all be
> uncommented in the editor.
>
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> ---

The earlier one in the series seem to be getting solid enough.  Nice.

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 5812222..cef290b 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -167,6 +167,12 @@ has_action () {
>  	sane_grep '^[^#]' "$1" >/dev/null
>  }
>  
> +is_empty_commit() {
> +	tree=$(git rev-parse "$1"^{tree})
> +	ptree=$(git rev-parse "$1"^^{tree})
> +	return $(test "$tree" = "$ptree")
> +}

Could "$1" ever be a root commit without a parent?
