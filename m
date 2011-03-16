From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff-lib.c: Fix diff-files --diff-filter --quiet exit
 code
Date: Wed, 16 Mar 2011 14:13:37 -0700
Message-ID: <7v62ri7oqm.fsf@alter.siamese.dyndns.org>
References: <4D80EBC1.7010105@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de,
	johannes.schindelin@gmx.de
To: Jakob Pfender <jpfender@elegosoft.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 22:15:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzy3f-0002hb-BO
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 22:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870Ab1CPVOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 17:14:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754828Ab1CPVNw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 17:13:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DB3F230D0;
	Wed, 16 Mar 2011 17:15:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vzvi1S5OgnZYVeRrEe745OeuwOE=; b=ZIr6I5
	/WVMnmnu1jz3ptxLXk2P/slQmh6Bhfa4ArCWOf5tBsR1oYEMzwitJiDNnjliFtiA
	w0qCliFDPdKxLTUnaGrDAbWqAzzU+OyOJxaK70Mg7xnQ1Pfr2hgprm/gg/U9+GvH
	Bg9HLsIgBiRFvSmasRZmjZvCUkibFsE7n/C/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qj1jgZvXdL89pO8pgOv0MuMvfdgOit7x
	uO5PRk3jHFC5L8mquxTjQgZVE1+oATmDlI6MX9h9CONFXzHRxTpIto+F+h4peYZP
	s/Y6PWPD2/Pa4hTnSktMN4G30Yu/3yxumSraoDi+FQFYhb7OTK4H0gllCfhoHIMb
	Ee1laEoc60Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 96CA730CB;
	Wed, 16 Mar 2011 17:15:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3B1DA30CA; Wed, 16 Mar 2011
 17:15:11 -0400 (EDT)
In-Reply-To: <4D80EBC1.7010105@elegosoft.com> (Jakob Pfender's message of
 "Wed, 16 Mar 2011 17:56:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E0A7A68-5012-11E0-896C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169198>

Jakob Pfender <jpfender@elegosoft.com> writes:

> Given the following status:
>
> 	$ git status -s
> 	 M bar
> 	UU foo
>
> There is an unexpected difference in the return code of git diff-files
> when used with --quiet as opposed to --exit-code:
>
> 	$ git diff-files --diff-filter=U --quiet
> 	$ echo $?
> 	0
>
> 	$ git diff-files --diff-filter=U --exit-code
> 	<usual output, lots of 0's and U<TAB>foo>
> 	$ echo $?
> 	1
>
> Notice the different return codes. Now, according to the documentation,
> --quiet implies --return-code. However, the return code of the former is
> clearly not correct if --return-code was supposed to be on.
>
> This patch removes a useless bit of code that caused the return codes to
> differ.

How did you determine it is "useless bit"?

The code notices that the caller, by specifying --quiet, does not want any
details of the changes and instead wants to know if there is a change or
not.  And it breaks out of the loop because it already found what it
wanted to know, namely, there is a change.

When you have a post-process filter (like -w or -S), the path we found to
be different here may be uninteresting and there may be no output (hence
we should exit with status 0).  So it is true that the optimization you
are removing needs to be disabled in _some_ situations, and the current
code doesn't, and it needs fixing.

But is it a justifiable fix to disable the optimization for even the
normal cases?

> Signed-off-by: Jakob Pfender <jpfender@elegosoft.com>
> ---
>  diff-lib.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
>
> diff --git a/diff-lib.c b/diff-lib.c
> index 392ce2b..a7aa42b 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -102,10 +102,6 @@ int run_diff_files(struct rev_info *revs,
> unsigned int option)
>  		int changed;
>  		unsigned dirty_submodule = 0;
>
> -		if (DIFF_OPT_TST(&revs->diffopt, QUICK) &&
> -			DIFF_OPT_TST(&revs->diffopt, HAS_CHANGES))
> -			break;
> -
>  		if (!ce_path_match(ce, revs->prune_data))
>  			continue;
