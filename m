From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notice error exit from pager
Date: Mon, 01 Aug 2011 13:17:28 -0700
Message-ID: <7vd3goj38n.fsf@alter.siamese.dyndns.org>
References: <20110726210401.GA25207@toss.lan> <20110801175921.GA17092@toss>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Aug 01 22:17:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnyvi-00036S-7j
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 22:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269Ab1HAURc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 16:17:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57244 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753323Ab1HAURa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 16:17:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C56A48B7;
	Mon,  1 Aug 2011 16:17:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iLgOR+Y03agQkVUCCFAnnYj3/94=; b=r53E6v
	AJR2QzK4hUzPTjaOa1uquHyQoGV4FFe2IgeOj7ORVAXvJB3LhGzr96jvYSag/f6d
	OaL2jRc2CLQIUtC4Yq7lApuMhQvV7stYZPGNRFEDgqGSr58sgZ0WJoHgZkQMuo2z
	BexFbewQrWZQvcmHTRK6g5dkucn59a3FQLZnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=voLY0wt0XgTN55MaQ9LJbvb3r004HVRh
	NLnQZ34NzVOaW/HugSd2yBvPlGVzV2j7Dc0o4F7FwlAe0jFDEPlIfefHHNoJBVFv
	BraUCW/uTPiVsRsV1ceLMejngmPw6xckUqiwG3Wv/mr+Oq7ljICHK5ZCE/LFo8i+
	krIgrYOISTs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 849E148B6;
	Mon,  1 Aug 2011 16:17:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1335648B5; Mon,  1 Aug 2011
 16:17:29 -0400 (EDT)
In-Reply-To: <20110801175921.GA17092@toss> (Clemens Buchacher's message of
 "Mon, 1 Aug 2011 19:59:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48499654-BC7B-11E0-BB35-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178407>

Clemens Buchacher <drizzd@aon.at> writes:

> Since there is no reliable way to handle error reporting in the
> parent, produce the output in the child instead.

Hmm, how does this interact with your earlier "error_routine: use parent's
stderr if exec fails" patch?

> diff --git a/run-command.c b/run-command.c
> index 5c91f37..a2796c4 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -125,9 +125,6 @@ static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
>  		if (code == 127) {
>  			code = -1;
>  			failed_errno = ENOENT;
> -			if (!silent_exec_failure)
> -				error("cannot run %s: %s", argv0,
> -					strerror(ENOENT));
>  		}
>  	} else {
>  		error("waitpid is confused (%s)", argv0);
> @@ -282,14 +279,14 @@ fail_pipe:
>  		} else {
>  			execvp(cmd->argv[0], (char *const*) cmd->argv);
>  		}
> -		/*
> -		 * Do not check for cmd->silent_exec_failure; the parent
> -		 * process will check it when it sees this exit code.
> -		 */
> -		if (errno == ENOENT)
> +		if (errno == ENOENT) {
> +			if (!cmd->silent_exec_failure)
> +				error("cannot run %s: %s", cmd->argv[0],
> +					strerror(ENOENT));
>  			exit(127);
> -		else
> +		} else {
>  			die_errno("cannot exec '%s'", cmd->argv[0]);
> +		}
>  	}
>  	if (cmd->pid < 0)
>  		error("cannot fork() for %s: %s", cmd->argv[0],
