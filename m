From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/1] Support updating working trees when pushing into non-bare repos
Date: Thu, 13 Nov 2014 09:47:36 -0800
Message-ID: <xmqqbnob2ds7.fsf@gitster.dls.corp.google.com>
References: <cover.1415629053.git.johannes.schindelin@gmx.de>
	<cover.1415876330.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 13 18:47:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoyUh-0001TI-N2
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 18:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933545AbaKMRrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 12:47:40 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57525 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933296AbaKMRrj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 12:47:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 452861D641;
	Thu, 13 Nov 2014 12:47:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rJvNhP5jWRuw43JU9vy22urdOWo=; b=Ua/0/z
	z8S1dM8y5JxKxqAwuEa/fjOcbwTIHSEDdQ+iNaxPGaqUXt0PnNagO+syc5T5ui/6
	ufqk517JeU1a9mZcROn6mb1JShxI/lxHGRN4CpDHqqt2rhKzRaJY8Ynmr+jRlP49
	G4ZBYXP3ZzO62u8T96eOAIW89q+SGqI8TQfH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b9OXn1/00WRzp4Z1m6U16nQNpfV56uvT
	X4eoMGEbLDjLsPASnW+I4RpSiSY44tX1Yqcjeha0q+tMmdmISL8pviAK8VOOKxqo
	NBe5uJW+WQ4MG98/JV/On0LFL7GUz+6kbQWsUJlZBgKYTxILUS7KFPAc2Q0rGzbQ
	K7x3kl1+ZNE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 39DD51D640;
	Thu, 13 Nov 2014 12:47:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB5721D63F;
	Thu, 13 Nov 2014 12:47:37 -0500 (EST)
In-Reply-To: <cover.1415876330.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Thu, 13 Nov 2014 12:03:41 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 281E130C-6B5D-11E4-A980-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This patch series adds support for a new receive.denyCurrentBranch setting
> to update the working directory (which must be clean, i.e. there must not be
> any uncommitted changes) when pushing into the current branch.
>
> The scenario in which the 'updateInstead' setting became a boon in this
> developer's daily work is when trying to get a bug fix from a Windows
> computer, a virtual machine or a user's machine onto his main machine (in
> all of those cases it is only possible to connect via ssh in one direction,
> but not in the reverse direction).
>
> Interdiff vs v2 below the diffstat.
>
> Johannes Schindelin (1):
>   Add another option for receive.denyCurrentBranch
>
>  Documentation/config.txt |  5 ++++
>  builtin/receive-pack.c   | 78 ++++++++++++++++++++++++++++++++++++++++++++++--
>  t/t5516-fetch-push.sh    | 17 +++++++++++
>  3 files changed, 98 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 4f9fe81..c384515 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2134,10 +2134,6 @@ Another option is "updateInstead" which will update the working
>  directory (must be clean) if pushing into the current branch. This option is
>  intended for synchronizing working directories when one side is not easily
>  accessible via ssh (e.g. inside a VM).
> -+
> -Yet another option is "detachInstead" which will detach the HEAD if updates
> -are pushed into the current branch; That way, the current revision, the
> -index and the working directory are always left untouched by pushes.

I think we had an exchange to clarify the workflow in which
updateInstead is useful and how to help readers, but I do not see
any change on that in this part of documentation.  Forgot to revise?

> @@ -737,36 +733,66 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
>  	return 0;
>  }
>  
> -static const char *merge_worktree(unsigned char *sha1)
> +static const char *update_worktree(unsigned char *sha1)
>  {
>  	const char *update_refresh[] = {
>  		"update-index", "--ignore-submodules", "--refresh", NULL
>  	};
> +	const char *diff_index[] = {
> +		"diff-index", "--quiet", "--cached", "--ignore-submodules",
> +		"HEAD", "--", NULL
> +	};
>  	const char *read_tree[] = {
>  		"read-tree", "-u", "-m", sha1_to_hex(sha1), NULL
>  	};

OK.

"update-index --refresh && diff-files && diff-index --cached" is how
we traditionally ensure the working tree is absolutely clean (see
require_clean_work_tree in git-sh-setup.sh), but I do not think of a
reason why diff-files step is not redundant.  As a totally separate
topic outside this series, we may want to visit that shell function.
