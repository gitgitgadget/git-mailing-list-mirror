From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: be quiet if not on isatty()
Date: Sat, 27 Aug 2011 23:22:31 -0700
Message-ID: <7vaaau9hso.fsf@alter.siamese.dyndns.org>
References: <cover.1314472512.git.sdaoden@gmail.com>
 <c70a246a601bec0ce973b177bf5553d3fee47014.1314472512.git.sdaoden@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Daode Nurpmeso <sdaoden@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Aug 28 08:22:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxYlV-00051P-Oy
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 08:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850Ab1H1GWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 02:22:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37153 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750778Ab1H1GWe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2011 02:22:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D42FF2227;
	Sun, 28 Aug 2011 02:22:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I12sc5PRm+AVLgleESL3rjNUX/M=; b=DayceO
	8Ei6RA/qt3YVjr1WMEA6dpxNF6UgXyhFyFGNbCjs0ouvSH5xtV2FetdisoVyhCEu
	c4GMR9MyJj+ViTmckAb+Hi+MeMZrabefejI6//nEK/0yl2Ntz/GJqETrjIqbXtcc
	f8aSRwekRG/9BQrB0XgZYXSCPYwpZN6ZhuC1w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lJqZK/2RXkbdKni/nePyS378bU3r4iQ9
	Vgt2YHiAkfuXr+gq13fSV02ou9+Ovw0nNE3QCj468jW8n1yBMZd6ESf2KB2Eb6zi
	GbFe2RbqVW1Yokek8zAuCrECZcbh4KVzHrX0T/29zoJa/ZehfJOdAEGAFD0AphIo
	5TCMeiH36Pw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB94F2226;
	Sun, 28 Aug 2011 02:22:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D3A42225; Sun, 28 Aug 2011
 02:22:33 -0400 (EDT)
In-Reply-To: <c70a246a601bec0ce973b177bf5553d3fee47014.1314472512.git.sdaoden@gmail.com>
 (Steffen Daode Nurpmeso's message of "Sat, 27 Aug 2011 21:45:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1D7B8D74-D13E-11E0-ABAB-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180257>

Steffen Daode Nurpmeso <sdaoden@googlemail.com> writes:

> Signed-off-by: Steffen Daode Nurpmeso <sdaoden@gmail.com>

Justification is necessary why this is a good change.

Perhaps you meant something like this:

	In general, the progress output should not be given unless the
        output is sent to a tty (i.e. an interactive session).

But this patch may be squelching the output a bit too much. The opts.quiet
field is used not just to set verbose_update in the unpack_trees_options
used in reset_tree() and merge_working_tree(), but also used to report the
local changes at the end of merge_working_tree(), report tracking
information, and report where the detached HEAD is at, among other things.

Independently, it might make sense to squelch advice messages in a
non-interactive session, but I think that should probably be done by
flipping advice_* variables in advice.c, I think.

> ---
>  builtin/checkout.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 4eaedff..6fb6d48 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -958,6 +958,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  	gitmodules_config();
>  	git_config(git_checkout_config, &opts);
>  
> +	opts.quiet = !isatty(2);
>  	opts.track = BRANCH_TRACK_UNSPECIFIED;
>  
>  	argc = parse_options(argc, argv, prefix, options, checkout_usage,
