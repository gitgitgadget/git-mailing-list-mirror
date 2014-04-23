From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2 2/3] run-command: make sure hooks have always GIT_DIR
Date: Wed, 23 Apr 2014 13:37:59 -0700
Message-ID: <xmqqoazrye6w.fsf@gitster.dls.corp.google.com>
References: <1398282160-26151-1-git-send-email-felipe.contreras@gmail.com>
	<1398282160-26151-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ilya Bobyr <ilya.bobyr@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 22:38:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd3vn-0006St-Vo
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 22:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754400AbaDWUiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 16:38:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44792 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752767AbaDWUiD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 16:38:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7C517EC6D;
	Wed, 23 Apr 2014 16:38:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F8wQebDTH4vvtIj5rtS9+iLNBpE=; b=xmBAGc
	hox0ejKX/okGDOCZu+cLZMQbViIfdZBugAUSLvaAKgRQ5bb2trijURXiRU1H+VR4
	FREskG78ASRidFUOiZtkd0+tUO0/csw/qREt9BSXppqgCRmHsvCfsLVlUaI+bPMH
	oSO90a7juNokGtwwhPs817zooSYEHA+BIwGDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eBACw8bhgunPM+n4toRQiIllHp79neiX
	NbuNhgcKkw8M+38N8nC1zIVkIefwM2gxrITkaUXCKcAiegpXnZ9/K9Zlw83k6Ovf
	KZPxhITfLFw0oUkMyGmyJ1tzt07gH4d9XNcHMATNnqSGo6m4O7LNVvUF3SVQNsU+
	28g6qngJ4to=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB2547EC6A;
	Wed, 23 Apr 2014 16:38:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 846687EC5C;
	Wed, 23 Apr 2014 16:38:00 -0400 (EDT)
In-Reply-To: <1398282160-26151-3-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Wed, 23 Apr 2014 14:42:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 292A2618-CB27-11E3-8C9B-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246890>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

Why is this a good change?  From a zero-line log message, I cannot
even tell if this is trying to fix some problem, or trying to give
new capabilities to hooks.

How does it prevent existing hook scripts from suddenly start
misbehaving, where they do *not* expect to see an explicit GIT_DIR
pointing at the original repository hook gets run in exported into
their environment?  For example, one of my post-receive hooks in a
repository I push into records $cwd (which is the GIT_DIR of
receiving repository), chdir's to another repository and then
executes "git pull $cwd" from there, and that relies on the fact
that being at the top-level of that other repository without GIT_DIR
environment pointing at elsewhere but having .git directory in that
top-level repository is sufficient to kick the auto-discovery of the
repository that receives the "pull" in order to work correctly.



> ---
>  run-command.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index 75abc47..8e188f6 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -765,12 +765,29 @@ int run_hook_ve(const char *const *env, const char *name, va_list args)
>  	struct child_process hook;
>  	struct argv_array argv = ARGV_ARRAY_INIT;
>  	const char *p;
> -	int ret;
> +	const char **mod_env = NULL;
> +	int ret, i = 0;
> +	struct strbuf buf = STRBUF_INIT;
>  
>  	p = find_hook(name);
>  	if (!p)
>  		return 0;
>  
> +	if (!getenv(GIT_DIR_ENVIRONMENT)) {
> +		if (env)
> +			for (i = 0; env[i]; i++);
> +
> +		mod_env = xcalloc(i + 2, sizeof(*mod_env));
> +
> +		if (env)
> +			for (i = 0; env[i]; i++)
> +				mod_env[i] = env[i];
> +
> +		strbuf_addf(&buf, "GIT_DIR=%s", get_git_dir());
> +		mod_env[i++] = buf.buf;
> +		mod_env[i++] = NULL;
> +	}
> +
>  	argv_array_push(&argv, p);
>  
>  	while ((p = va_arg(args, const char *)))
> @@ -778,12 +795,15 @@ int run_hook_ve(const char *const *env, const char *name, va_list args)
>  
>  	memset(&hook, 0, sizeof(hook));
>  	hook.argv = argv.argv;
> -	hook.env = env;
> +	hook.env = mod_env ? mod_env : env;
>  	hook.no_stdin = 1;
>  	hook.stdout_to_stderr = 1;
>  
>  	ret = run_command(&hook);
>  	argv_array_clear(&argv);
> +	strbuf_release(&buf);
> +	free(mod_env);
> +
>  	return ret;
>  }
