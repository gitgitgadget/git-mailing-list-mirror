From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] commit: fix patch hunk editing with "commit -p -m"
Date: Thu, 06 Mar 2014 13:25:14 -0800
Message-ID: <xmqqr46fvx39.fsf@gitster.dls.corp.google.com>
References: <1394117424-29780-1-git-send-email-benoit.pierre@gmail.com>
	<1394117424-29780-3-git-send-email-benoit.pierre@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benoit Pierre <benoit.pierre@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 22:25:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLfnA-0006lG-UX
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 22:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbaCFVZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 16:25:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34982 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829AbaCFVZU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 16:25:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90A6270BAC;
	Thu,  6 Mar 2014 16:25:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2lwB8NwNqAXix3iCzTF07I9l/ho=; b=uZUYBg
	SIwSfjcjnk7zM3kha58NqmIRDHD3FuYmQZAiV1ErPg/pQVlS7m1y2fMnvbiZv9Hm
	vN3ARimdwybYOUYO1BcAn1rFw94q9E7kKScwoBoLA+3g3WynB+sX/LQDuBTp8VnZ
	fLuGFdouwQINAPVxJ6SCGZNd67b1tkbHbuNtg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qojoZZqKGEieTOHs1kyF2RbSsWbL5C0Q
	FDz2Gqp6OblD2qAE0kbvdhBph2fwSnGe4H0sfX/eZE8LBUM5dk/YQTlHYqbFIr4p
	RVoMpAkgguTW38l/qY6iBh4y/Wfm7fM1a0nshglGvV8TO8T977i5ustOp7eytRDH
	L3GUoWLVMDU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AD0F70BAB;
	Thu,  6 Mar 2014 16:25:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 643BB70BA8;
	Thu,  6 Mar 2014 16:25:18 -0500 (EST)
In-Reply-To: <1394117424-29780-3-git-send-email-benoit.pierre@gmail.com>
	(Benoit Pierre's message of "Thu, 6 Mar 2014 15:50:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D0CE4232-A575-11E3-9219-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243555>

Benoit Pierre <benoit.pierre@gmail.com> writes:

> +int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...)
> +{
> +	const char *hook_env[3] =  { NULL };
> +	char index[PATH_MAX];
> +	va_list args;
> +	int ret;
> +
> +	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
> +	hook_env[0] = index;
> +
> +	/*
> +	 * Let the hook know that no editor will be launched.
> +	 */
> +	if (!editor_is_used)
> +		hook_env[1] = "GIT_EDITOR=:";
> +
> +	va_start(args, name);
> +	ret = run_hook_v(hook_env, name, args);

> diff --git a/run-command.c b/run-command.c
> index 3914d9c..4e9be12 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -760,13 +760,11 @@ char *find_hook(const char *name)
>  	return path;
>  }
>  
> -int run_hook(const char *index_file, const char *name, ...)
> +int run_hook_v(const char *const *env, const char *name, va_list args)
>  {

I think you named it as "foo_v()" for "this takes va_list" in a way
similar to the "v" in "execv()", but this also takes environment, so
perhaps we want to say "ve" instead?

Other than that, I like it---I admit that I am biased that I
essentially did the same earlier but with a _le variant ;-)

> +int run_hook(const char *const *env, const char *name, ...)
> +{

I'd rather not to see this changed in the same commit, so that any
other topic in-flight that adds a new call to run_hook() that expects
to pass the index file as its first parameter will not be broken.

Name it run_hook_le() (name modelled after execle()), and call it in
your change where you add new calls to this function, and add a thin
wrapper run_hook() that preserves the traditional "We can pass only
the index-file" for new callers we do not even know about on the
topics in flight.

Later we can eradicate callers of run_hook() that treats the index-file
specially, which was a grave mistake in a public API.
