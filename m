From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/3] t1301-*.sh: Fix the 'forced modes' test on cygwin
Date: Fri, 17 Jun 2011 10:12:22 +0200
Message-ID: <4DFB0C66.5080904@kdbg.org>
References: <4DFA6632.40607@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Erik Faye-Lund <kusmabite@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Jun 17 10:12:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXUAT-0007Ps-Ss
	for gcvg-git-2@lo.gmane.org; Fri, 17 Jun 2011 10:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757556Ab1FQIMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jun 2011 04:12:33 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:53585 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756482Ab1FQIMa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2011 04:12:30 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1F708130063;
	Fri, 17 Jun 2011 10:12:23 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id DD60519F3E9;
	Fri, 17 Jun 2011 10:12:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.17) Gecko/20110414 SUSE/3.1.10 Thunderbird/3.1.10
In-Reply-To: <4DFA6632.40607@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175942>

Am 16.06.2011 22:23, schrieb Ramsay Jones:
> 
> The 'forced modes' test fails on cygwin because the post-update
> hook loses it's executable bit when copied from the templates
> directory by git-init. The template loses it's executable bit
> because the lstat() function resolves to the "native Win32 API"
> implementation.
> 
> This call to lstat() happens after git-init has set the "git_dir"
> (so has_git_dir() returns true), but before the configuration has
> been fully initialised. At this point git_config() does not find
> any config files to parse and returns 0. Unfortunately, the code
> used to determine the cygwin l/stat() function bindings did not
> check the return from git_config() and assumed that the config
> was complete and accessible once "git_dir" was set.
> 
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

So, this means that if neither core.filemode nor
core.ignorecygwinfstricks is assigned a value, then regular (Cygwin's)
l/stat is used. Ok, that's what we need: the default value of
core.filemode is true, which means we need Cygwin's l/stat; it trumps
the default value of core.ignorecygwinfstricks, which is also true. Good!

BTW, it seems the patch fixes a bug when the two config parameters are
not assigned a value: the initialization looks like this[*]:

static int native_stat = 1;
static int core_filemode;

i.e., the default value of core.filemode seen by compat/cygwin.c is
actually false, and the fast native l/stat would be used, contrary to
the documentation. Am I missing something?

[*] Note to bystanders: compat/cygwin.c keeps its own copy of
core.filemode; see the comments near these variables.

-- Hannes
