From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v3 1/2] rev-parse: add --prefix option
Date: Fri, 19 Apr 2013 11:22:07 +0100
Message-ID: <20130419102207.GF2278@serenity.lan>
References: <82316c445320b3cec3a35cbc87ad94a04ed26d1e.1366314439.git.john@keeping.me.uk>
 <1366365217-17674-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 12:22:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT8SY-0006Lb-55
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 12:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757337Ab3DSKWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 06:22:22 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:37023 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756991Ab3DSKWV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 06:22:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 7A6872307F;
	Fri, 19 Apr 2013 11:22:19 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IQ5jeQgyzA4d; Fri, 19 Apr 2013 11:22:18 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 9782922F25;
	Fri, 19 Apr 2013 11:22:09 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1366365217-17674-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221754>

On Fri, Apr 19, 2013 at 03:23:37PM +0530, Ramkumar Ramachandra wrote:
> John Keeping wrote:
> > Changes since v2:
> >     - Rewrite commit message
> >     - Add a new test for 'prefix ignored with HEAD:top'
> >     - Use '<<-\EOF' where appropriate in t1513
> 
> Thanks for the re-roll.
> 
> In the previous iteration, I wasn't sure this was the right approach
> because I thought it would be better to pass RUN_SETUP and let
> run_builtin_command() take care of the prefix-setting.  Unfortunately,
> as 5410a02 (git-rev-parse --parseopt, 2007-11-06) indicates, we have
> to run setup_git_directory() in cmd_rev_parse() after parsing
> --parseopt, as 'git rev-parse --parseopt' can be run outside a git
> repository.  You might want to include this note in your commit
> message for the benefit of other readers.
> 
> Other than that, I just have one small suggestion: it's possible to
> avoid passing output_prefix around, and simplify show_file() a bit if
> we acknowledge that printing "--" is not the same as printing a file
> (although the condition is the same).  Would you like to squash this
> in?

I'm not actually sure this is better.  I'm more afraid of the condition
for outputting files changing in the future than of passing
output_prefix around, so I'd much rather keep that condition in one
place.

If you really feel strongly about it, I'd prefer to extract the if
condition to a function and use that directly when deciding whether to
print "--".

[Also, you introduce a potential segfault via passing a NULL prefix to
strlen.]

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> -- 8< --
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index de894c7..7e69b3f 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -29,6 +29,7 @@ static int abbrev;
>  static int abbrev_ref;
>  static int abbrev_ref_strict;
>  static int output_sq;
> +static int output_prefix;
>  
>  /*
>   * Some arguments are relevant "revision" arguments,
> @@ -212,15 +213,13 @@ static void show_datestring(const char *flag, const char *datestr)
>  	show(buffer);
>  }
>  
> -static int show_file(const char *arg, int output_prefix)
> +static int show_file(const char *arg)
>  {
>  	show_default();
>  	if ((filter & (DO_NONFLAGS|DO_NOREV)) == (DO_NONFLAGS|DO_NOREV)) {
>  		if (output_prefix) {
>  			const char *prefix = startup_info->prefix;
> -			show(prefix_filename(prefix,
> -					     prefix ? strlen(prefix) : 0,
> -					     arg));
> +			show(prefix_filename(prefix, strlen(prefix), arg));
>  		} else
>  			show(arg);
>  		return 1;
> @@ -228,6 +227,16 @@ static int show_file(const char *arg, int output_prefix)
>  	return 0;
>  }
>  
> +static int show_dashdash()
> +{
> +	show_default();
> +	if ((filter & (DO_NONFLAGS | DO_NOREV)) == (DO_NONFLAGS | DO_NOREV)) {
> +		show("--");
> +		return 1;
> +	}
> +	return 0;
> +}
> +
>  static int try_difference(const char *arg)
>  {
>  	char *dotdot;
> @@ -476,7 +485,6 @@ N_("git rev-parse --parseopt [options] -- [<args>...]\n"
>  int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  {
>  	int i, as_is = 0, verify = 0, quiet = 0, revs_count = 0, type = 0;
> -	int output_prefix = 0;
>  	unsigned char sha1[20];
>  	const char *name = NULL;
>  
> @@ -510,7 +518,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  		const char *arg = argv[i];
>  
>  		if (as_is) {
> -			if (show_file(arg, output_prefix) && as_is < 2)
> +			if (show_file(arg) && as_is < 2)
>  				verify_filename(prefix, arg, 0);
>  			continue;
>  		}
> @@ -534,7 +542,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  				as_is = 2;
>  				/* Pass on the "--" if we show anything but files.. */
>  				if (filter & (DO_FLAGS | DO_REVS))
> -					show_file(arg, 0);
> +					show_dashdash();
>  				continue;
>  			}
>  			if (!strcmp(arg, "--default")) {
> @@ -543,7 +551,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  				continue;
>  			}
>  			if (!strcmp(arg, "--prefix")) {
> -				prefix = argv[i+1];
> +				prefix = argv[i + 1];
>  				startup_info->prefix = prefix;
>  				output_prefix = 1;
>  				i++;
> @@ -768,7 +776,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  		if (verify)
>  			die_no_single_rev(quiet);
>  		as_is = 1;
> -		if (!show_file(arg, output_prefix))
> +		if (!show_file(arg))
>  			continue;
>  		verify_filename(prefix, arg, 1);
>  	}
