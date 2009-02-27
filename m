From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] "git branch -M @{-1}"
Date: Thu, 26 Feb 2009 22:49:39 -0800
Message-ID: <7vljrsnzlo.fsf@gitster.siamese.dyndns.org>
References: <7v4oyxzeay.fsf@gitster.siamese.dyndns.org>
 <76718490902132311j5add87bcpb103c951a8192b05@mail.gmail.com>
 <7vzlgpxz4g.fsf@gitster.siamese.dyndns.org>
 <7vskmhuzla.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902142332210.10279@pacific.mpi-cbg.de>
 <86d4c5e00902262027y13b19eb7nf89a45e83b986801@mail.gmail.com>
 <7veixkpi4a.fsf@gitster.siamese.dyndns.org>
 <7vprh4o1bt.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Deskin Miller <deskinm@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 07:51:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcwZ3-0006bx-DV
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 07:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813AbZB0Gtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 01:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752436AbZB0Gtu
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 01:49:50 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46359 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbZB0Gtt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 01:49:49 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4DA349D8CC;
	Fri, 27 Feb 2009 01:49:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9229C9D8CB; Fri,
 27 Feb 2009 01:49:41 -0500 (EST)
In-Reply-To: <7vprh4o1bt.fsf_-_@gitster.siamese.dyndns.org> (Junio C.
 Hamano's message of "Thu, 26 Feb 2009 22:12:22 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D2A11250-049A-11DE-BA84-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111637>

Junio C Hamano <gitster@pobox.com> writes:

> Earlier, we've taught "git branch -d <name>" that <name> is supposed to be
> a branch name and not a random extended SHA-1.  "git branch -m <name> [<name>]" 
> needs to be taught the same.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin-branch.c |   14 ++++++++++----
>  1 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/builtin-branch.c b/builtin-branch.c
> index c34af27..3f97838 100644
> --- a/builtin-branch.c
> +++ b/builtin-branch.c
> @@ -425,21 +425,27 @@ static void rename_branch(const char *oldname, const char *newname, int force)
>  	if (!oldname)
>  		die("cannot rename the current branch while not on any.");
>  
> -	strbuf_addf(&oldref, "refs/heads/%s", oldname);
> +	if (interpret_nth_last_branch(oldname, &oldref) == strlen(oldname))
> +		strbuf_splice(&oldref, 0, 0, "refs/heads/", 11);
> +	else
> +		strbuf_addf(&oldref, "refs/heads/%s", oldname);

A few comments on this patch.

 (1) I am actually very reluctant to queue this, or any unproven "fix"
     that adds obscure codepath, for 1.6.2, this close to the final.  Most
     likely I won't be queueing any more @{-n] fixes until 1.6.2 final and
     defer them to 1.6.2.X series if necessary.

 (2) If we are to have full @{-n} support, and if we do not mind small
     leaks, it would make more sense to introduce a leaky helper function
     like this and use it everywhere:

	const char *handle_branch_arg(const char *name)
        {
        	struct strbuf buf = STRBUF_INIT;
		size_t len = strlen(name);
                if (interpret_nth_last_branch(name, &buf) == len)
			return strbuf_detach(&buf);
		return name;
	}

 (3) I think this "The argument could be previous branch name" conversion
     should be done only when the command is about local branch names
     (i.e. when run without -r option), and the above codepath needs to be
     protected with if (kinds == REF_LOCAL_BRANCH)
