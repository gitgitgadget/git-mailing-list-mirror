From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2 (fix broken test)] rebase -i: add exec command to
 launch a shell command
Date: Wed, 11 Aug 2010 11:31:57 -0700
Message-ID: <7v62zhyp9e.fsf@alter.siamese.dyndns.org>
References: <vpq62ziv788.fsf@bauges.imag.fr>
 <1281453472-29835-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Aug 11 20:32:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjG6G-0001vp-MQ
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 20:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755267Ab0HKScK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 14:32:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46545 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755226Ab0HKScF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 14:32:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F2EFDCC3C7;
	Wed, 11 Aug 2010 14:32:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=1P/X+CWM9BYKO1Vv9FkI6pmbP14=; b=ZwnI6hbj0CIeM4qregXXB8c
	GGLwoItFhA/jJiSJS2i+jCFu3D6w2J/7snhn+Ez12CSJoPuHFReGa1yLgg7XwGI3
	062i738QG0w3nYwP7+mbF2ZwNbzPwqTwlwCgJzrT49SYE25EELS26cA3BGWlPKeL
	xp6lGB2YOpqZ0PC84EEc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=M5Zrv/6UeOZNZLjU3RQjsqUwO/EXg8TYbS8QagPYvxA5cDERy
	6LfzPT0tvl7CsbT9aXuKWtbiN0aTSxtubfeHA3rs7ylaMu2D96+PdDfo/Iuu2eAM
	tq0TstHv3OrdQXvNBWodbAz9lneUX/PV/jRF8R+VpPggswSvceNvDH5dx0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B4799CC3C3;
	Wed, 11 Aug 2010 14:32:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8042DCC3BC; Wed, 11 Aug
 2010 14:31:58 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BC37607C-A576-11DF-ABA5-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153273>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The typical usage pattern would be to run a test (or simply a compilation
> command) at given points in history.
>
> The shell command is ran (from the worktree root), and the rebase is
> stopped when the command fails, to give the user an opportunity to fix
> the problem before continuing with "git rebase --continue".
>
> This needs a little rework of skip_unnecessary_picks, which wasn't robust
> enough to deal with lines like
>
>   exec >"file    name with many spaces"
>
> in the todolist. The new version extracts command, sha1 and rest from
> each line, but outputs the line itself verbatim to avoid changing the
> whitespace layout.

Thanks.

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 9f03ce6..93b181e 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -64,6 +64,67 @@ test_expect_success 'setup' '
>  	done
>  '
>  
> +# "exec" commands are ran with the user shell by default, but this may
> +# be non-POSIX. For example, if SHELL=zsh then ">file" doesn't work
> +# to create a file. Unseting SHELL avoids such non-portable behavior
> +# in tests.
> +SHELL=

Tricky but true.

Do we have other callouts that we use $SHELL from the environment?
execv_shell_cmd() just runs "sh -c" from $PATH so diff (when running
external diff) nor ll-merge (when running external merge driver) that call
it via run_command_v_opt(RUN_USING_SHELL) are immune to this issue.
