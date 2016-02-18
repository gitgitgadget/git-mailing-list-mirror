From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv12 0/7]  Expose submodule parallelism to the user
Date: Thu, 18 Feb 2016 14:55:10 -0800
Message-ID: <xmqqr3g9eii9.fsf@gitster.mtv.corp.google.com>
References: <1455833964-3629-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 23:55:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWXTk-0004ZE-1J
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 23:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947005AbcBRWzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 17:55:15 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63266 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1946941AbcBRWzN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 17:55:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4785A45CD6;
	Thu, 18 Feb 2016 17:55:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=az252jQHJv3B8MBxtkEgXkKQ+ac=; b=v8ZBZ0
	EDbQ5+d2G7VfHArEdzrjc8aZsLrs5mC3UeYej/MLmlZUqKxZs1LSsuAQchN+YnIL
	6B7JwpJkgbdhtdGk5qz9Fk0mzl4wMekmi6Ds5IfW5TRZonRZH7mrk1IQV0eRMLoS
	sgef0+Fu13bfYPOp4A/E9VmATSx5C2n/qs0pI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rgjkBOh6SSk/NCtGKl7ywUCsV//Md7zd
	57SuLzClSAohhmfKa8HDYVMcp3eliaYY8hYn0tQRAalTl3Z10iRtuOhLOq7aPuOU
	5ttaXoMvwgGBvkVFEpGuxaAI5tbzUvQJ+mOrIcU8TsmM26/+VzVkoG3B0WWk+2u2
	qWs5/NHbtos=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3D34B45CD5;
	Thu, 18 Feb 2016 17:55:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B571145CD4;
	Thu, 18 Feb 2016 17:55:11 -0500 (EST)
In-Reply-To: <1455833964-3629-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 18 Feb 2016 14:19:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AA6DD634-D692-11E5-B99E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286636>

Stefan Beller <sbeller@google.com> writes:

> Thanks Junio for a review of v11!
>
> I addressed the memory issue with the interdiff (in patch 1/7) as follows:
> Interdiff to v11:
>
> diff --git a/submodule.c b/submodule.c
> index 263cb2a..45d0967 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -219,6 +219,9 @@ void gitmodules_config(void)
>  int parse_submodule_update_strategy(const char *value,
>                 struct submodule_update_strategy *dst)
>  {
> +       const char *com;
> +
> +       free((void*)dst->command);
>         dst->command = NULL;
>         if (!strcmp(value, "none"))
>                 dst->type = SM_UPDATE_NONE;
> @@ -228,9 +231,10 @@ int parse_submodule_update_strategy(const char *value,
>                 dst->type = SM_UPDATE_REBASE;
>         else if (!strcmp(value, "merge"))
>                 dst->type = SM_UPDATE_MERGE;
> -       else if (skip_prefix(value, "!", &dst->command))
> +       else if (skip_prefix(value, "!", &com)) {
>                 dst->type = SM_UPDATE_COMMAND;
> -       else
> +               dst->command = xstrdup(com);
> +       } else
>                 return -1;
>         return 0;
>  }

Unless you count "I want to write differently from what was
suggested" is a desirable thing to do, I do not see a point in
favouring the above that uses an extra variable and skip_prefix()
over what I gave you as "how about" patch.  But whatever.

 - Is dst->command always initialized to a NULL (otherwise the
   unconditional upfront free() makes it unsafe)?

 - Is there a global free_something() or something_clear() function
   that are used to release the resource held by a structure that
   has submodule_update_strategy structure embedded in it?  If so
   dst->command needs to be freed there as well.

Thanks.

> Stefan Beller (7):
>   submodule-config: keep update strategy around
>   submodule-config: drop check against NULL
>   fetching submodules: respect `submodule.fetchJobs` config option
>   submodule update: direct error message to stderr
>   git submodule update: have a dedicated helper for cloning
>   submodule update: expose parallelism to the user
>   clone: allow an explicit argument for parallel submodule clones
>
>  Documentation/config.txt        |   6 +
>  Documentation/git-clone.txt     |   6 +-
>  Documentation/git-submodule.txt |   7 +-
>  builtin/clone.c                 |  19 +++-
>  builtin/fetch.c                 |   2 +-
>  builtin/submodule--helper.c     | 239 ++++++++++++++++++++++++++++++++++++++++
>  git-submodule.sh                |  54 ++++-----
>  submodule-config.c              |  18 ++-
>  submodule-config.h              |   2 +
>  submodule.c                     |  39 ++++++-
>  submodule.h                     |  18 +++
>  t/t5526-fetch-submodules.sh     |  14 +++
>  t/t7400-submodule-basic.sh      |   4 +-
>  t/t7406-submodule-update.sh     |  27 +++++
>  14 files changed, 406 insertions(+), 49 deletions(-)
