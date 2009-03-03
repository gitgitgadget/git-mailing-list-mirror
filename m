From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git-clone respect branch.autosetuprebase
Date: Tue, 03 Mar 2009 10:48:19 -0800
Message-ID: <7v4oyabfyk.fsf@gitster.siamese.dyndns.org>
References: <1236105352-21335-1-git-send-email-pknotz@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: pknotz@sandia.gov
X-From: git-owner@vger.kernel.org Tue Mar 03 19:49:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeZgh-0005sl-Su
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 19:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915AbZCCSs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 13:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbZCCSs2
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 13:48:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbZCCSs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 13:48:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 20E413F85;
	Tue,  3 Mar 2009 13:48:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 77A053F84; Tue, 
 3 Mar 2009 13:48:21 -0500 (EST)
In-Reply-To: <1236105352-21335-1-git-send-email-pknotz@sandia.gov>
 (pknotz@sandia.gov's message of "Tue, 3 Mar 2009 11:35:52 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DFEA5DE0-0823-11DE-BD49-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112146>

pknotz@sandia.gov writes:

> diff --git a/builtin-clone.c b/builtin-clone.c
> index c338910..f547267 100644
> --- a/builtin-clone.c
> +++ b/builtin-clone.c
> @@ -360,6 +360,14 @@ static void install_branch_config(const char *local,
>  	strbuf_reset(&key);
>  	strbuf_addf(&key, "branch.%s.merge", local);
>  	git_config_set(key.buf, remote);
> +	switch (autorebase) {
> +	case AUTOREBASE_REMOTE:
> +	case AUTOREBASE_ALWAYS:
> +		strbuf_reset(&key);
> +		strbuf_addf(&key, "branch.%s.rebase", local);
> +		git_config_set(key.buf, "true");
> +		printf("Default branch '%s' will rebase on pull.\n", local);
> +	}
>  	strbuf_release(&key);
>  }

I think this whole function should be moved to to branch.c to be usable
across "git checkout -b", "git branch" and "git clone", and make the two
existing callers in builtin-clone.c and setup_tracking() in branch.c call
it.  "git checkout -b" already shares the same codepath with "git branch",
and you would allow "git clone" to be in the family.  That would help
supporting new tracking options without having to maintain more than one
copy of the code.
