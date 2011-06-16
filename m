From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] t1301-*.sh: Fix the 'forced modes' test on cygwin
Date: Thu, 16 Jun 2011 15:10:50 -0700
Message-ID: <7v8vt1h1g5.fsf@alter.siamese.dyndns.org>
References: <4DFA6632.40607@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Jun 17 00:11:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXKmC-0006t6-SO
	for gcvg-git-2@lo.gmane.org; Fri, 17 Jun 2011 00:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186Ab1FPWKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 18:10:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44844 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758448Ab1FPWKx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 18:10:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8C4AB5957;
	Thu, 16 Jun 2011 18:13:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=idL2xz4o4TXeinJKh3kLPSQ8aH0=; b=DZBPN0
	K70Z6iB9X3p/11tGJjoDb1JxqLbdtWoNHeem/0i00/bG1j/DUtWTqtODrx2ntMcr
	JE4M/WFpqRIIBrd8kkkEAOy5a344h0eq+1TQ96gGDjIyOxW4345cQ6uHdn/buNWJ
	+8OaCd7LmULHq0X61eoTYKcTFhDmRS8F8BKTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UJ59YQf+VtwV5iZIIplxunZAZyCqwR43
	8kGx/Djj0iYXlE2JfnhTXmWBsHAsdyqiGh/Sq/vHFylxrraXEH6P2TUO3qvFQjXw
	iAyiPYnTR7N0kp0Pzpum5VTpH3S9lUAinvUu4qo5y02BtgdJpL+GDJ54kwsH7hLW
	wSFBn5e7SXk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8543E5955;
	Thu, 16 Jun 2011 18:13:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CEAE35954; Thu, 16 Jun 2011
 18:13:01 -0400 (EDT)
In-Reply-To: <4DFA6632.40607@ramsay1.demon.co.uk> (Ramsay Jones's message of
 "Thu, 16 Jun 2011 21:23:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CCF10CB4-9865-11E0-8009-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175936>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> The 'forced modes' test fails on cygwin because the post-update
> hook loses it's executable bit when copied from the templates
> directory by git-init. The template loses it's executable bit
> because the lstat() function resolves to the "native Win32 API"
> implementation.

> This call to lstat() happens after git-init has set the "git_dir"
> (so has_git_dir() returns true), but before the configuration has
> been fully initialised. At this point git_config() does not find
> any config files to parse and returns 0. Unfortunately, the code
> used to determine the cygwin l/stat() function bindings did not
> check the return from git_config() and assumed that the config
> was complete and accessible once "git_dir" was set.

Ok, so this is not really about "a test fails so we will sweep the issue
under rag", but "we try to optimize too early, before we have enough
information, so let the code take slow path before we know what is in the
configuration file".

> In order to fix the test, we simply change the binding code to
> test the return value from git_config(), to ensure that it actually
> had config values to read, before determining the requested binding.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>  compat/cygwin.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/compat/cygwin.c b/compat/cygwin.c
> index b4a51b9..b38dbd7 100644
> --- a/compat/cygwin.c
> +++ b/compat/cygwin.c
> @@ -114,8 +114,7 @@ static int git_cygwin_config(const char *var, const char *value, void *cb)
>  
>  static int init_stat(void)
>  {
> -	if (have_git_dir()) {
> -		git_config(git_cygwin_config, NULL);
> +	if (have_git_dir() && git_config(git_cygwin_config,NULL)) {
>  		if (!core_filemode && native_stat) {
>  			cygwin_stat_fn = cygwin_stat;
>  			cygwin_lstat_fn = cygwin_lstat;
