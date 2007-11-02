From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 1/2] War on whitespace: first, a bit of retreat.
Date: Fri, 2 Nov 2007 13:45:52 -0400
Message-ID: <20071102174552.GE15595@fieldses.org>
References: <7vwst15ceq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brian Downing <bdowning@lavos.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 18:46:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io0bE-0008Aj-UP
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 18:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755713AbXKBRpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 13:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755252AbXKBRpz
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 13:45:55 -0400
Received: from mail.fieldses.org ([66.93.2.214]:33241 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755512AbXKBRpy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 13:45:54 -0400
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1Io0ae-0005U5-RX; Fri, 02 Nov 2007 13:45:52 -0400
Content-Disposition: inline
In-Reply-To: <7vwst15ceq.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63147>

On Fri, Nov 02, 2007 at 12:34:05AM -0700, Junio C Hamano wrote:
> This introduces core.whitespace configuration variable that lets
> you specify the definition of "whitespace error".
> 
> Currently there are two kinds of whitespace errors defined:
> 
>  * trailing-space: trailing whitespaces at the end of the line.
> 
>  * space-before-tab: a SP appears immediately before HT in the
>    indent part of the line.

The whitespace policy varies based on the project (and in some cases,
based on the file within that project).  It shouldn't vary from user to
user or repo to repo.  So the configuration variable mechanism seems a
poor match.  Would it be possible to use something like gitattributes
instead?  Then the whitespace policy would be associated with the
project itself, would automatically be propagated on clone, etc.

Thanks for working on this.

--b.

> 
> You can specify the desired types of errors to be detected by
> listing their names (unique abbreviations are accepted)
> separated by comma.  By default, these two errors are always
> detected, as that is the traditional behaviour.  You can disable
> detection of a particular type of error by prefixing a '-' in
> front of the name of the error, like this:
> 
> 	[core]
> 		whitespace = -trailing-space
> 
> This patch teaches the code to output colored diff with
> DIFF_WHITESPACE color to highlight the detected whitespace
> errors to honor the new configuration.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  cache.h       |    9 +++++++++
>  config.c      |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  diff.c        |   13 ++++++++-----
>  environment.c |    1 +
>  4 files changed, 70 insertions(+), 5 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index bfffa05..a6e5988 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -602,4 +602,13 @@ extern int diff_auto_refresh_index;
>  /* match-trees.c */
>  void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, int);
>  
> +/*
> + * whitespace rules.
> + * used by both diff and apply
> + */
> +#define WS_TRAILING_SPACE	01
> +#define WS_SPACE_BEFORE_TAB	02
> +#define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB)
> +extern unsigned whitespace_rule;
> +
>  #endif /* CACHE_H */
> diff --git a/config.c b/config.c
> index dc3148d..ffb418c 100644
> --- a/config.c
> +++ b/config.c
> @@ -246,6 +246,53 @@ static unsigned long get_unit_factor(const char *end)
>  	die("unknown unit: '%s'", end);
>  }
>  
> +static struct whitespace_rule {
> +	const char *rule_name;
> +	unsigned rule_bits;
> +} whitespace_rule_names[] = {
> +	{ "trailing-space", WS_TRAILING_SPACE },
> +	{ "space-before-tab", WS_SPACE_BEFORE_TAB },
> +};
> +
> +static unsigned parse_whitespace_rule(const char *string)
> +{
> +	unsigned rule = WS_DEFAULT_RULE;
> +
> +	while (string) {
> +		int i;
> +		size_t len;
> +		const char *ep;
> +		int negated = 0;
> +
> +		string = string + strspn(string, ", \t\n\r");
> +		ep = strchr(string, ',');
> +		if (!ep)
> +			len = strlen(string);
> +		else
> +			len = ep - string;
> +
> +		if (*string == '-') {
> +			negated = 1;
> +			string++;
> +			len--;
> +		}
> +		if (!len)
> +			break;
> +		for (i = 0; i < ARRAY_SIZE(whitespace_rule_names); i++) {
> +			if (strncmp(whitespace_rule_names[i].rule_name,
> +				    string, len))
> +				continue;
> +			if (negated)
> +				rule &= ~whitespace_rule_names[i].rule_bits;
> +			else
> +				rule |= whitespace_rule_names[i].rule_bits;
> +			break;
> +		}
> +		string = ep;
> +	}
> +	return rule;
> +}
> +
>  int git_parse_long(const char *value, long *ret)
>  {
>  	if (value && *value) {
> @@ -431,6 +478,11 @@ int git_default_config(const char *var, const char *value)
>  		return 0;
>  	}
>  
> +	if (!strcmp(var, "core.whitespace")) {
> +		whitespace_rule = parse_whitespace_rule(value);
> +		return 0;
> +	}
> +
>  	/* Add other config variables here and to Documentation/config.txt. */
>  	return 0;
>  }
> diff --git a/diff.c b/diff.c
> index a6aaaf7..2112353 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -508,7 +508,8 @@ static void emit_line_with_ws(int nparents,
>  	for (i = col0; i < len; i++) {
>  		if (line[i] == '\t') {
>  			last_tab_in_indent = i;
> -			if (0 <= last_space_in_indent)
> +			if ((whitespace_rule & WS_SPACE_BEFORE_TAB) &&
> +			    0 <= last_space_in_indent)
>  				need_highlight_leading_space = 1;
>  		}
>  		else if (line[i] == ' ')
> @@ -540,10 +541,12 @@ static void emit_line_with_ws(int nparents,
>  	tail = len - 1;
>  	if (line[tail] == '\n' && i < tail)
>  		tail--;
> -	while (i < tail) {
> -		if (!isspace(line[tail]))
> -			break;
> -		tail--;
> +	if (whitespace_rule & WS_TRAILING_SPACE) {
> +		while (i < tail) {
> +			if (!isspace(line[tail]))
> +				break;
> +			tail--;
> +		}
>  	}
>  	if ((i < tail && line[tail + 1] != '\n')) {
>  		/* This has whitespace between tail+1..len */
> diff --git a/environment.c b/environment.c
> index b5a6c69..624dd96 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -35,6 +35,7 @@ int pager_in_use;
>  int pager_use_color = 1;
>  char *editor_program;
>  int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
> +unsigned whitespace_rule = WS_DEFAULT_RULE;
>  
>  /* This is set by setup_git_dir_gently() and/or git_default_config() */
>  char *git_work_tree_cfg;
> -- 
> 1.5.3.5.1452.ga93d
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
