From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] Support environment variables in config file
Date: Mon, 4 Jun 2007 07:34:43 +0200
Message-ID: <20070604053443.GA15148@moooo.ath.cx>
References: <20070603223727.GA16637@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Mon Jun 04 07:35:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv5DX-0005ah-7t
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 07:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbXFDFes (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 01:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbXFDFes
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 01:34:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:35094 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751694AbXFDFer (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 01:34:47 -0400
Received: (qmail invoked by alias); 04 Jun 2007 05:34:44 -0000
Received: from pd9ebb5ac.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.172]
  by mail.gmx.net (mp002) with SMTP; 04 Jun 2007 07:34:44 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1/gQAQk453g5Fac9NC8Si1KKHFUuyDlRnSENcu+iE
	S27fkP40GdLXuG
Content-Disposition: inline
In-Reply-To: <20070603223727.GA16637@admingilde.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49061>

Martin Waitz <tali@admingilde.org> wrote:
> Environment variables (e.g. $HOME) can be helpful for the GIT configuration.
> With this change you can use them with the normal shell "$" syntax.
> If you want to insert a plain "$" in a variable, it can be escaped as \$
> or put inside quotes (").

Perhaps we should also allow variable interpolation in double quoted
strings as this is quite common in various languages.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 5868d58..042a354 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -65,17 +65,24 @@ a string, an integer, or a boolean.  Boolean values may be given as yes/no,
>  converting value to the canonical form using '--bool' type specifier;
>  `git-config` will ensure that the output is "true" or "false".
>  
> +You can use the $VARIABLE shell syntax to use environment variables
> +in the configuration file.  All alpha-numeric characters after the
> +leading '`$`' will be interpreted as name of an environment variable
> +and the value of this variable will be used instead.
> +If the variable does not exist it will be treated as an empty string.

We could have a short example here how to concatenate a variable and a
string without a space in between.  I came up with '$FOO""bar' which
is not that obvious imo.

> diff --git a/config.c b/config.c
> index 0614c2b..058c0df 100644
> --- a/config.c
> +++ b/config.c
> @@ -43,12 +43,27 @@ static int get_next_char(void)
>  static char *parse_value(void)
>  {
>  	static char value[1024];
> -	int quote = 0, comment = 0, len = 0, space = 0;
> +	int quote = 0, comment = 0, envvar = -1, len = 0, space = 0;
>  
>  	for (;;) {
>  		int c = get_next_char();
>  		if (len >= sizeof(value))
>  			return NULL;
> +		if ((envvar >= 0) && !isalnum(c)) {

You should allow at least underscores in environment variables too.

> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index 3f3fd2d..eb84437 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -513,5 +513,18 @@ git config --list > result
>  
>  test_expect_success 'value continued on next line' 'cmp result expect'
>  
> +cat > .git/config <<\EOF
> +[quoted]
> +	withvar = "$HOME/foo"
> +[unquoted]
> +	withvar = $HOME/foo
> +EOF
> +
> +test_expect_success 'quoted $VAR' \
> +	'test x"\$HOME/foo" = x$(git config quoted.withvar)'
> +
> +test_expect_success 'unquoted $VAR' \
> +	'test x"$HOME/foo" = x$(git config unquoted.withvar)'
> +
>  test_done

If you use the HOME environment variable without setting it yourself
you should place quotes around the $(..) in case there is a space in
$HOME:
    $ ./git-config test.var '$HOME'
    $ export HOME='/tmp/foo bar'
    $ ./git-config test.var
    /tmp/foo bar
    $ test x"$HOME/foo" = x$(./git-config test.var)
    test: 4: bar: unexpected operator
    $ test x"$HOME/foo" = x"$(./git-config test.var)"
