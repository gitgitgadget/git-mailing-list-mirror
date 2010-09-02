From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/3] don't write to git_log_output_encoding outside git_config()
Date: Thu, 02 Sep 2010 10:56:41 +0200
Message-ID: <vpq7hj4h6ba.fsf@bauges.imag.fr>
References: <vpqhbibbthi.fsf@bauges.imag.fr>
	<1283210123-19752-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 10:58:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Or5ca-00052X-R8
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 10:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253Ab0IBI6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 04:58:07 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37521 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752623Ab0IBI6F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 04:58:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o828r5P6016551
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 2 Sep 2010 10:53:05 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Or5b7-0003VC-EQ; Thu, 02 Sep 2010 10:56:41 +0200
In-Reply-To: <1283210123-19752-2-git-send-email-Matthieu.Moy@imag.fr> (Matthieu Moy's message of "Tue\, 31 Aug 2010 01\:15\:22 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 02 Sep 2010 10:53:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o828r5P6016551
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1284022387.23216@KAsYaTbw9ucpRDUpICYCIA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155116>

Hi,

I'm just raising attention on this patch. It didn't receive any
comment and didn't find its way to pu.

I think it makes the code more robust, and would prevent accidental
bugs like the one I introduced patching the gitattributes patch, but
it's not critical.

Anyway, if you (i.e. the mailing list, not Junio) don't like the
patch, I'd prefer to have counter-argument than having the patch
silently ignored ;-).

Thanks,

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The log encoding can be given by the user either with --encoding=foo or
> with i18n.logoutputencoding. The code dealing with this used to write to
> git_log_output_encoding in both places, making sure that --encoding=foo
> is dealt with after reading the configuration file.
>
> This is a very fragile mechanism, since any further call to
> git_config(git_default_config, ...) the value given on the command line.
>
> Instead, keep the config value and the cli value, and decide which one to
> take at read time (in the straightforward accessor
> get_git_log_output_encoding()).
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> So, this isn't strictly necessary since the new version of the patch
> implementing the gitattributes file doesn't read the full config
> anymore, but I think that makes the code more robust.
>
>  builtin/log.c |    4 ++--
>  cache.h       |   18 ++++++++++++++++++
>  environment.c |    4 +++-
>  pretty.c      |    4 ++--
>  revision.c    |    4 ++--
>  5 files changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index eaa1ee0..f30a6ba 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -329,8 +329,8 @@ static void show_tagger(char *buf, int len, struct rev_info *rev)
>  	struct strbuf out = STRBUF_INIT;
>  
>  	pp_user_info("Tagger", rev->commit_format, &out, buf, rev->date_mode,
> -		git_log_output_encoding ?
> -		git_log_output_encoding: git_commit_encoding);
> +		get_git_log_output_encoding() ?
> +		get_git_log_output_encoding(): git_commit_encoding);
>  	printf("%s", out.buf);
>  	strbuf_release(&out);
>  }
> diff --git a/cache.h b/cache.h
> index eb77e1d..7e10a39 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1005,7 +1005,25 @@ extern int user_ident_explicitly_given;
>  extern int user_ident_sufficiently_given(void);
>  
>  extern const char *git_commit_encoding;
> +
> +/* Value found in config file */
>  extern const char *git_log_output_encoding;
> +
> +/* Value given in command line with --encoding */
> +extern const char *git_log_output_encoding_cli;
> +
> +/* 
> + * Prioritize the value given by the command-line over the value found
> + * in the config file.
> + */
> +static inline
> +const char *get_git_log_output_encoding()
> +{
> +	return git_log_output_encoding_cli ?
> +		git_log_output_encoding_cli :
> +		git_log_output_encoding;
> +}
> +
>  extern const char *git_mailmap_file;
>  
>  /* IO helper functions */
> diff --git a/environment.c b/environment.c
> index 83d38d3..212f086 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -23,7 +23,9 @@ int log_all_ref_updates = -1; /* unspecified */
>  int warn_ambiguous_refs = 1;
>  int repository_format_version;
>  const char *git_commit_encoding;
> -const char *git_log_output_encoding;
> +const char *git_log_output_encoding = NULL;
> +const char *git_log_output_encoding_cli = NULL;
> +
>  int shared_repository = PERM_UMASK;
>  const char *apply_default_whitespace;
>  const char *apply_default_ignorewhitespace;
> diff --git a/pretty.c b/pretty.c
> index f85444b..4187a50 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1159,8 +1159,8 @@ char *reencode_commit_message(const struct commit *commit, const char **encoding
>  {
>  	const char *encoding;
>  
> -	encoding = (git_log_output_encoding
> -		    ? git_log_output_encoding
> +	encoding = (get_git_log_output_encoding()
> +		    ? get_git_log_output_encoding()
>  		    : git_commit_encoding);
>  	if (!encoding)
>  		encoding = "UTF-8";
> diff --git a/revision.c b/revision.c
> index b1c1890..791c757 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1402,9 +1402,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  		revs->grep_filter.all_match = 1;
>  	} else if ((argcount = parse_long_opt("encoding", argv, &optarg))) {
>  		if (strcmp(optarg, "none"))
> -			git_log_output_encoding = xstrdup(optarg);
> +			git_log_output_encoding_cli = xstrdup(optarg);
>  		else
> -			git_log_output_encoding = "";
> +			git_log_output_encoding_cli = "";
>  		return argcount;
>  	} else if (!strcmp(arg, "--reverse")) {
>  		revs->reverse ^= 1;

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
