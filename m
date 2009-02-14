From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] config: Use parseopt.
Date: Sat, 14 Feb 2009 20:59:36 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902142041370.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de> <1234612989-32297-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 21:00:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYQgN-00057E-FH
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 21:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbZBNT6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 14:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbZBNT6o
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 14:58:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:53455 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751904AbZBNT6n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 14:58:43 -0500
Received: (qmail invoked by alias); 14 Feb 2009 19:58:41 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp052) with SMTP; 14 Feb 2009 20:58:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19XTexjxH1X/UrjGmewJYhTwqNvL2OeY/6G5uTEgn
	H/F1iXRI9TKfu2
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1234612989-32297-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109912>

Hi,

On Sat, 14 Feb 2009, Felipe Contreras wrote:

> @@ -231,7 +264,7 @@ static int get_diff_color_found;
>  static int git_get_colorbool_config(const char *var, const char *value,
>  		void *cb)
>  {
> -	if (!strcmp(var, get_color_slot)) {
> +	if (!strcmp(var, get_colorbool_slot)) {
>  		get_colorbool_found =
>  			git_config_colorbool(var, value, stdout_is_tty);
>  	}

Name changes like this make it harder to read the patch; can you separate 
that change out into its own patch?

> +	if (use_global_config) {
> +		char *home = getenv("HOME");
> +		if (home) {
> +			char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
> +			config_exclusive_filename = user_config;

In a subsequent patch, you might add a check only one of --global, 
--system or --file was given.

> +	else if (given_config_file) {
> +		if (!is_absolute_path(given_config_file) && file)
> +			file = prefix_filename(file, strlen(file),
> +					       given_config_file);
> +		else
> +			file = given_config_file;
> +		config_exclusive_filename = file;

It took me a considerable amount of time to figure out that "file" is 
actually the "prefix"!  That cleanup would be nice to have before the 
parseopt patch, methinks, especially since the code is reindented, and 
thus hard to follow in the diff.

> +	if (actions & ACTION_LIST) {
> +		if (git_config(show_all_config, NULL) < 0 &&
> +		    file && errno)

Should this not be config_exclusive_filename?

> +			die("unable to read config file %s: %s", file,
> +			    strerror(errno));

Do we really only want to die() in case we know the file name?  AFAICT at 
this point we have no idea in which of the possibly three files the error 
occurred.  And there need not be any errno set, for example when there was 
a parse error.

> +	else if (actions & ACTION_EDIT) {
> +		const char *config_filename;
> +		if (config_exclusive_filename)
> +			config_filename = config_exclusive_filename;
> +		else
> +			config_filename = git_path("config");

Why not reuse config_exclusive_filename here?

> +	else if (actions & ACTION_ADD) {
> +		check_argc(argc, 2, 2);

BTW what about check_argc() in the previous two cases?

> +		return git_config_set_multivar(argv[0], value, "^$", 0);

Now that I see this, there is another idea for a possible cleanup after 
the parseoptification: cmd_config() should not return -1, as that will be 
turned into the exit status.  So maybe prefix the return value with "!!"?

Or maybe even better: set a variable "ret" and at the end of cmd_config(), 
"return !!ret;"?

The rest looks good to me.
 
Thanks,
Dscho
