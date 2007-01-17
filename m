From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] Introduce 'git-format-patch --suffix=patch'
Date: Wed, 17 Jan 2007 19:20:48 +0000
Message-ID: <45AE7710.40503@shadowen.org>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>	<Pine.LNX.4.63.0701171446410.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7v4pqpsbre.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Josh Boyer <jwboyer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 17 20:21:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7GLS-00083j-Ma
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 20:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654AbXAQTU7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 14:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbXAQTU7
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 14:20:59 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:3356 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932654AbXAQTUz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 14:20:55 -0500
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1H7GK9-0005Kq-Ky; Wed, 17 Jan 2007 19:19:53 +0000
User-Agent: Icedove 1.5.0.9 (X11/20061220)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4pqpsbre.fsf_-_@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.1.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37026>

Junio C Hamano wrote:
> The default can also be changed with "format.suffix" configuration.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
> 
>   Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>   > Why not
>   >
>   > 	static const char *file_extension = ".txt"
>   >
>   > Hmm?
> 
>   Let's do this instead.  By the way, there is a bug in the
>   configuration parsing for format.headers from commit 20ff0680,
>   which needs to be check NULLness of the value the same way as
>   this one deals with format.suffix, which I've already fixed in
>   my tree.
> 
>  Documentation/git-format-patch.txt |   13 ++++++++++++-
>  builtin-log.c                      |   19 ++++++++++++++++---
>  2 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 67425dc..34abd2f 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -11,7 +11,7 @@ SYNOPSIS
>  [verse]
>  'git-format-patch' [-n | -k] [-o <dir> | --stdout] [--attach] [--thread]
>  	           [-s | --signoff] [--diff-options] [--start-number <n>]
> -		   [--in-reply-to=Message-Id]
> +		   [--in-reply-to=Message-Id] [--suffix=<sfx>]
>  		   <since>[..<until>]
>  
>  DESCRIPTION
> @@ -78,6 +78,12 @@ OPTIONS
>  	reply to the given Message-Id, which avoids breaking threads to
>  	provide a new patch series.
>  
> +--suffix=<sfx>::
> +	Instead of using `txt` as the suffix for generated
> +	filenames, use specifed suffix.  A common alternative is
> +	`--suffix=patch`.
> +
> +
>  CONFIGURATION
>  -------------
>  You can specify extra mail header lines to be added to each
> @@ -86,6 +92,11 @@ message in the repository configuration as follows:
>  [format]
>          headers = "Organization: git-foo\n"
>  
> +You can specify default suffix used:
> +
> +[format]
> +        suffix = patch
> +
>  
>  EXAMPLES
>  --------
> diff --git a/builtin-log.c b/builtin-log.c
> index a59b4ac..04e3144 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -197,6 +197,7 @@ static int istitlechar(char c)
>  
>  static char *extra_headers = NULL;
>  static int extra_headers_size = 0;
> +static const char *fmt_patch_suffix = "txt";
>  
>  static int git_format_config(const char *var, const char *value)
>  {
> @@ -208,6 +209,12 @@ static int git_format_config(const char *var, const char *value)
>  		strcat(extra_headers, value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "format.suffix")) {
> +		if (!value)
> +			die("format.suffix without value");
> +		fmt_patch_suffix = xstrdup(value);
> +		return 0;
> +	}
>  	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
>  		return 0;
>  	}
> @@ -223,9 +230,10 @@ static void reopen_stdout(struct commit *commit, int nr, int keep_subject)
>  	char filename[1024];
>  	char *sol;
>  	int len = 0;
> +	int suffix_len = strlen(fmt_patch_suffix) + 10; /* ., NUL and slop */
>  
>  	if (output_directory) {
> -		strlcpy(filename, output_directory, 1010);
> +		strlcpy(filename, output_directory, 1000);
>  		len = strlen(filename);
>  		if (filename[len - 1] != '/')
>  			filename[len++] = '/';
> @@ -249,7 +257,10 @@ static void reopen_stdout(struct commit *commit, int nr, int keep_subject)
>  			}
>  		}
>  
> -		for (j = 0; len < 1024 - 6 && sol[j] && sol[j] != '\n'; j++) {
> +		for (j = 0;
> +		     len < sizeof(filename) - suffix_len &&
> +			     sol[j] && sol[j] != '\n';
> +		     j++) {
>  			if (istitlechar(sol[j])) {
>  				if (space) {
>  					filename[len++] = '-';
> @@ -265,7 +276,7 @@ static void reopen_stdout(struct commit *commit, int nr, int keep_subject)
>  		while (filename[len - 1] == '.' || filename[len - 1] == '-')
>  			len--;
>  	}
> -	strcpy(filename + len, ".txt");
> +	sprintf(filename + len, ".%s", fmt_patch_suffix);

This doesn't give us any possibility of not having a suffix.  Can we not
include the . in the suffix here so that we can specify it as "".

>  	fprintf(realstdout, "%s\n", filename);
>  	freopen(filename, "w", stdout);
>  }
> @@ -436,6 +447,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  				die("Need a Message-Id for --in-reply-to");
>  			in_reply_to = argv[i];
>  		}
> +		else if (!strncmp(argv[i], "--suffix=", 9))
> +			fmt_patch_suffix = argv[i] + 9;
>  		else
>  			argv[j++] = argv[i];
>  	}

-apw
