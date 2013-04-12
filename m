From: Junio C Hamano <gitster@pobox.com>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Fri, 12 Apr 2013 11:23:46 -0700
Message-ID: <7vbo9jehfx.fsf@alter.siamese.dyndns.org>
References: <20130411222301.GA11283@sigill.intra.peff.net>
 <20130412005748.GA17116@odin.tremily.us>
 <7vvc7sfkwn.fsf@alter.siamese.dyndns.org>
 <20130412043501.GA12942@sigill.intra.peff.net>
 <7vr4igfj9w.fsf@alter.siamese.dyndns.org>
 <20130412050550.GA15724@sigill.intra.peff.net>
 <20130412112636.GC20178@odin.tremily.us>
 <20130412144855.GA17968@sigill.intra.peff.net>
 <7vk3o7g29s.fsf@alter.siamese.dyndns.org>
 <20130412161600.GA20492@sigill.intra.peff.net>
 <20130412170505.GA2383@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "W. Trevor King" <wking@tremily.us>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Mike Galbraith <bitbucket@online.de>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 12 20:24:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQide-0002xl-IL
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 20:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920Ab3DLSXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 14:23:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44919 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751406Ab3DLSXs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 14:23:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7854C156DC;
	Fri, 12 Apr 2013 18:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7eZmyGSJvttz/Y1kF3MZFgdCkk8=; b=PBjJBd
	hFw0h6C89mrSbFbmVQsnuMd8sFqRv7aKPvrlNxCSMQmDLCWWM6hIsTaTsS3Vtmxt
	mp8oIQNGR1SuUcKaNobAKQEHpmruUIAs1oaGbx6R/BnyqTC1hLBOhlPdexK5EfVV
	+63maLLTlsNh6JOwpjEDBG+rE8LUns7HOsCFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LMZYFTKFF0g6twj7jQ7mmginZmM2bGoy
	kN8+6OKbYUXIDbBu6X/i95YwtQEmQeruE2kevrgSS5bayBpbm30Vp7Q5i/FA1Tk8
	HVahC24gfVMrDrQAjqKA9YweeMI325nmxot6nuQ43zSulpJAZCV4k07QtWRKZ/uA
	NaTg7CUgPkk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C8F9156DA;
	Fri, 12 Apr 2013 18:23:48 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1729156D9; Fri, 12 Apr
 2013 18:23:47 +0000 (UTC)
In-Reply-To: <20130412170505.GA2383@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 12 Apr 2013 13:05:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1DEC51D8-A39E-11E2-9708-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221009>

Jeff King <peff@peff.net> writes:

> So here's what I came up with. I tried to make the exception as tight as
> possible by checking that $HOME was actually the problem, as that is the
> common problem (you switch users, but HOME is pointing to the old user).
> ...
> diff --git a/daemon.c b/daemon.c
> index 131b049..6c56cc0 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -1091,7 +1091,7 @@ static void drop_privileges(struct credentials *cred)
>  	if (cred && (initgroups(cred->pass->pw_name, cred->gid) ||
>  	    setgid (cred->gid) || setuid(cred->pass->pw_uid)))
>  		die("cannot drop privileges");
> -	setenv("GIT_CONFIG_INACCESSIBLE_HOME_OK", "1", 0);
> +	setenv(GIT_INACCESSIBLE_HOME_OK_ENVIRONMENT, "1", 0);
>  }

Compared against an unpublished diffbase???

>  
>  static struct credentials *prepare_credentials(const char *user_name,
> diff --git a/wrapper.c b/wrapper.c
> index bac59d2..644f867 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -416,11 +416,52 @@ int access_or_die(const char *path, int mode)
>  	return ret;
>  }
>  
> +/*
> + * Returns true iff the path is under $HOME, that directory is inaccessible,
> + * and the user has told us through the environment that an inaccessible HOME
> + * is OK. The results are cached so that repeated calls will not make multiple
> + * syscalls.
> + */
> +static int inaccessible_home_ok(const char *path)
> +{
> +	static int gentle = -1;
> +	static int home_inaccessible = -1;
> +	const char *home;
> +
> +	if (gentle < 0)
> +		gentle = git_env_bool(GIT_INACCESSIBLE_HOME_OK_ENVIRONMENT, 0);
> +	if (!gentle)
> +		return 0;
> +
> +	home = getenv("HOME");
> +	if (!home)
> +		return 0;
> +	/*
> +	 * We do not bother with normalizing PATHs to avoid symlinks
> +	 * here, since the point is to catch paths that are
> +	 * constructed as "$HOME/...".
> +	 */
> +	if (prefixcmp(path, home) && path[strlen(home)] == '/')
> +		return 0;
> +
> +	if (home_inaccessible < 0)
> +		home_inaccessible = access(home, R_OK|X_OK) < 0 && errno == EACCES;
> +	return home_inaccessible;
> +}
> +
>  int access_or_die(const char *path, int mode)
>  {
>  	int ret = access(path, mode);
> -	if (ret && errno != ENOENT && errno != ENOTDIR)
> +	if (ret && errno != ENOENT && errno != ENOTDIR) {
> +		/*
> +		 * We do not have to worry about clobbering errno
> +		 * in inaccessible_home_ok, because we get either EACCES
> +		 * again, or we die.
> +		 */
> +		if (errno == EACCES && inaccessible_home_ok(path))
> +			return ret;

OK, so the idea is

 - The environment can tell us to ignore permission errors for paths
   under $HOME if (and only if) $HOME itself is not readable;

 - We got a permission error here.  inaccessible_home_ok() will tell
   us if the path is under $HOME and the above condition holds (in
   which case it will say "ok, ignore that error").

which sounds good, but it relies on the caller of this function not
to try actually reading from the path.

If the access() failed due to ENOENT, the caller will get a negative
return from this function and will treat it as "ok, it does not
exist", with the original or the updated code.  This new case is
treated the same way by the existing callers, i.e. pretending as if
there is _no_ file in that unreadable $HOME directory.

That semantics sounds sane and safe to me.
