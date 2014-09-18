From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help: Fix size passed to qsort
Date: Thu, 18 Sep 2014 10:17:14 -0700
Message-ID: <xmqq8ulgq25h.fsf@gitster.dls.corp.google.com>
References: <1410956079-23513-1-git-send-email-stefanbeller@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pdebie@ai.rug.nl, git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 19:17:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUfKe-0006Cx-7b
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 19:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbaIRRRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2014 13:17:18 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59971 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932117AbaIRRRR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2014 13:17:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8E71D39F40;
	Thu, 18 Sep 2014 13:17:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X/npjxvYEII0lZ56Z/GajQh7Ryw=; b=e8aYxu
	yqgBoP5zrkgSfjM+zsYlXogQmX3LFkEFrTd7Ku4dmg5q2uyVsrOx8kSm3QMDeENU
	uRqyG6xaAmrngd31G+esBPJe8QCUwzQiysxq+MSZE8WNqkwHSnI4Gi7W9r9lkLKW
	Va8INNn3vVpcaZKidN+gOVp2/rJS9A3vV+m+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qdGuFErrk8UCV7jkmMZ2M4ZK//AbM8xW
	aTU4ytmdcGlNNAXfdR9hfiyiyUr6LATyMVw8m32SiQDW5P+VwdVDQ2xq5wB7kpIZ
	MGM3Qd3oaMr/uMmADLSngrhHymPn7vi1IcDKz7futPhtxI/NWAWDcssa8FDvghEN
	ia4O+n/NTnE=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 80F7039F3F;
	Thu, 18 Sep 2014 13:17:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8B7BA39F3D;
	Thu, 18 Sep 2014 13:17:15 -0400 (EDT)
In-Reply-To: <1410956079-23513-1-git-send-email-stefanbeller@gmail.com>
	(Stefan Beller's message of "Wed, 17 Sep 2014 14:14:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A2E89DDC-3F57-11E4-9881-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257267>

Stefan Beller <stefanbeller@gmail.com> writes:

> We actually want to have the size of one 'name' and not the size
> of the names array.

I suspect that the latter is "size of a pointer that points at a
cmdname structure", but the original code in help_unknown_cmd() is
wrong.  The ones in load_command_list() do this correctly and
another qsort() invocation in this function does so as well.  I
wonder why they didn't correctly cut&paste ;-)

746c221a (git wrapper: also use aliases to correct mistyped
commands, 2008-09-10) seemed to have introduced the culprit.

The call to uniq() would fail to uniquify because main_cmds would
have the standard command all in front and then aliases and commands
in the user's PATH later, but I do not quite see if there is any
end-user observable breakages that can arise from this.  What is the
practical implication of this breakage?

No, I am not saying we do not have to fix it; I am just being
curious why this patch does not show the existing breakage with a
new test.

Thanks.

>
> Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
> ---
>  help.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/help.c b/help.c
> index 7af65e2..2072a87 100644
> --- a/help.c
> +++ b/help.c
> @@ -305,7 +305,7 @@ const char *help_unknown_cmd(const char *cmd)
>  	add_cmd_list(&main_cmds, &aliases);
>  	add_cmd_list(&main_cmds, &other_cmds);
>  	qsort(main_cmds.names, main_cmds.cnt,
> -	      sizeof(main_cmds.names), cmdname_compare);
> +	      sizeof(*main_cmds.names), cmdname_compare);
>  	uniq(&main_cmds);
>  
>  	/* This abuses cmdname->len for levenshtein distance */
