From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] Make git-clone respect branch.autosetuprebase
Date: Thu, 05 Mar 2009 21:29:39 -0800
Message-ID: <7vsklrw75o.fsf@gitster.siamese.dyndns.org>
References: <7vsklt94ws.fsf@gitster.siamese.dyndns.org>
 <1236308321-13557-1-git-send-email-pknotz@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Pat Notz" <pknotz@sandia.gov>
X-From: git-owner@vger.kernel.org Fri Mar 06 06:31:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfSeS-0006aO-IF
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 06:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbZCFF3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 00:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbZCFF3r
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 00:29:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34727 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbZCFF3r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 00:29:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E04E432EA;
	Fri,  6 Mar 2009 00:29:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3EF5A32E9; Fri, 
 6 Mar 2009 00:29:41 -0500 (EST)
In-Reply-To: <1236308321-13557-1-git-send-email-pknotz@sandia.gov> (Pat
 Notz's message of "Thu, 5 Mar 2009 19:58:41 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CC7AF506-0A0F-11DE-B4E4-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112388>

"Pat Notz" <pknotz@sandia.gov> writes:

> Signed-off-by: Pat Notz <pknotz@sandia.gov>

Thanks.  I do not think there is substantial difference from the one I
queued in 'pu', so I'd keep that one instead, but here are a few comments
for future reference.

> diff --git a/branch.c b/branch.c
> index 1f00e44..332223b 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -32,21 +32,52 @@ static int find_tracked_branch(struct remote *remote, void *priv)
>  	return 0;
>  }
>  
> -static int should_setup_rebase(const struct tracking *tracking)
> +static int should_setup_rebase(const char * origin)

"const char *origin";

> +void install_branch_config(int verbose_flag,
> +			   const char *local,
> +			   const char *origin,
> +			   const char *remote)
> +{

I called the parameter "flag" not "verbose" very much on purpose; we can
introduce flags that control aspects other than verbosity if we wanted to
later.  Renaming it to verbose_flag defeats the extensibility.

> diff --git a/branch.h b/branch.h
> index 9f0c2a2..9f7fdb0 100644
> --- a/branch.h
> +++ b/branch.h
> @@ -21,4 +21,15 @@ void create_branch(const char *head, const char *name, const char *start_name,
>   */
>  void remove_branch_state(void);
>  
> +/*
> + * Configure local branch "local" to merge remote branch "remote"
> + * taken from origin "origin".
> + */
> +#define BRANCH_CONFIG_QUIET   00

This QUIET is also against the extensible design, as later flags may mean
things unrelated to verbosity.  With bitfield "flags" parameter, an unset
bit simply means "do not trigger this feature" and it is customary to pass
0 to such a function when the caller does not want anything special.
