From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git blame date output format configurable, a la git
 log
Date: Fri, 20 Feb 2009 08:59:44 -0800
Message-ID: <7vwsblrqm7.fsf@gitster.siamese.dyndns.org>
References: <1235136252-29649-1-git-send-email-eletuchy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, marius@trolltech.com,
	Eugene Letuchy <eugene@facebook.com>
To: eletuchy@gmail.com
X-From: git-owner@vger.kernel.org Fri Feb 20 18:01:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaYki-0001gQ-Ex
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 18:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823AbZBTQ74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 11:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753573AbZBTQ74
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 11:59:56 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61030 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbZBTQ7z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 11:59:55 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3DC289B29B;
	Fri, 20 Feb 2009 11:59:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 04ADD9B29A; Fri,
 20 Feb 2009 11:59:45 -0500 (EST)
In-Reply-To: <1235136252-29649-1-git-send-email-eletuchy@gmail.com>
 (eletuchy@gmail.com's message of "Fri, 20 Feb 2009 05:24:12 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E4935926-FF6F-11DD-8873-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110864>

eletuchy@gmail.com writes:

> From: Eugene Letuchy <eugene@facebook.com>
>
> Adds the following:
>  - git config value blame.date that expects one of the git log date
>    formats ({relative,local,default,iso,rfc,short})
>  - git blame command line option --date-format expects one of the git
>    log date formats ({relative,local,default,iso,rfc,short})
>  - documentation in blame-options.txt
>  - git blame uses the appropriate date.c functions and enums to
>    make sense of the date format and provide appropriate data
>
> The tests pass. The mailmap test needed to be modified to expect iso
> formatted blames rather than the new "default".
>
> Signed-off-by: Eugene Letuchy <eugene@facebook.com>

Doesn't your need to modify existing tests mean you broke the default
output?  IOW, shouldn't the defeault output format stay the same?

If you are proposing to change the default to use a different format, then
the commit log must explain why such a change is a good thing, and the
benefit of changing outweighs the downside of backward imcompatibility.

I am not opposed to hearing such an argument but I think it should be a
separate patch that comes after this patch, that flips the default and
does nothing else.

> ---
>  Documentation/blame-options.txt |    6 ++++++
>  builtin-blame.c                 |   31 ++++++++++++++++++-------------
>  t/t4203-mailmap.sh              |    2 +-
>  3 files changed, 25 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
> index 1ab1b96..75663ec 100644
> --- a/Documentation/blame-options.txt
> +++ b/Documentation/blame-options.txt
> @@ -63,6 +63,12 @@ of lines before or after the line given by <start>.
>  	tree copy has the contents of the named file (specify
>  	`-` to make the command read from the standard input).
>  
> +--date-format <format>::
> +	The value is one of the following alternatives:
> +	{relative,local,default,iso,rfc,short}.  The default format
> +	can be set using the blame.date config variable. See the
> +	discussion of the --date option at linkgit:git-log[1].

Please specify what format is used when this option is not used and there
is no blame.date configuration variable.

You need an entry in Documentation/config.txt as well.

> diff --git a/builtin-blame.c b/builtin-blame.c
> index 114a214..9ebab43 100644
> --- a/builtin-blame.c
> +++ b/builtin-blame.c
> @@ -1,5 +1,5 @@
>  /*
> - * Pickaxe
> + * Blame / Pickaxe

It's time we drop "/ Pickaxe" ;-)  It was a codename while the algorithm
was being polished to replace two old "blame" implementations we had.

> @@ -40,6 +40,9 @@ static int reverse;
>  static int blank_boundary;
>  static int incremental;
>  static int xdl_opts = XDF_NEED_MINIMAL;
> +
> +static enum date_mode date_mode;

Even though this is file-scope static today, I'd prefer to call it
"blame_date_mode".

> @@ -1507,9 +1510,7 @@ static const char *format_time(unsigned long time, const char *tz_str,
> ...
> +	return show_date(time, tz, date_mode);

Nice code reduction.

> @@ -1967,6 +1960,8 @@ static void prepare_blame_range(struct scoreboard *sb,
>  
>  static int git_blame_config(const char *var, const char *value, void *cb)
>  {
> +	const char *default_date_mode;

That is misnamed, placed in a wrong scope, and is unneeded.

> ...
> +	if (!strcmp(var, "blame.date")) {
> +		git_config_string(&default_date_mode, var, value);
> +		date_mode = parse_date_format(default_date_mode);
> +		return 0;
> +	}
>  	return git_default_config(var, value, cb);
>  }

 * It is not "default" in the sense that "this is the format used when no
   option nor configuration is given".  It is "configured_date_mode" if 
   you want to be explicit, but...

 * You could scope it in the relevant "if (!strcmp()) {...}", and then
   just call it "str" or something less specific, but ...

 * You do not use the value as the string in the rest of the code, so you
   do not need this variable.  Stop using git_config_string(), and
   inside "if (!strcmp()) {...}":
   
   - detect "[blame] date" with missing value (means "boolean true") as an
     error;

   - otherwise feed value directly to parse_date_format().

   That way you save one xstrdup() and one less memleak.

> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index 9a7d1b4..13b64dc 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -208,7 +208,7 @@ ff859d96 (Other Author 2005-04-07 15:15:13 -0700 4) four
>  EOF
>  
>  test_expect_success 'Blame output (complex mapping)' '
> -	git blame one >actual &&
> +	git blame --date-format=iso one >actual &&
>  	test_cmp expect actual
>  '

This strongly suggests that the file-scope variable should be initialized
to keep backward compatibility:

> +static enum date_mode date_mode = DATE_ISO8601;

Other than that the idea sounds good.

I didn't check if the code tries to align columns properly (the default
ISO format is of uniform length so existing code wouldn't have needed to
take variable length into account); if not, it should.

I didn't check if "git annotate compatibility mode" ignores this new
setting either; if not, it should.

Thanks.
