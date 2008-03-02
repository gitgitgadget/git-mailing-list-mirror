From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add pretty format configuration to git
 log/show/whatchanged
Date: Sat, 01 Mar 2008 19:44:25 -0800
Message-ID: <7vr6etvlgm.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0803011821420.22527@racer.site>
 <1204401056-8763-1-git-send-email-crquan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Denis Cheng <crquan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 04:45:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVf8c-0008VQ-W5
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 04:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbYCBDop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 22:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbYCBDop
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 22:44:45 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40610 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbYCBDoo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 22:44:44 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D6A7C1990;
	Sat,  1 Mar 2008 22:44:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9625B1989; Sat,  1 Mar 2008 22:44:35 -0500 (EST)
In-Reply-To: <1204401056-8763-1-git-send-email-crquan@gmail.com> (Denis
 Cheng's message of "Sun, 2 Mar 2008 03:50:56 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75718>

Denis Cheng <crquan@gmail.com> writes:

>  * New configuration variable "format.pretty" can be used
>     in git log/show/whatchanged.
>
> the "format.pretty" configuration's design background is that I often use
> "--pretty=fuller" on my command line, and different "--pretty=format:..."
>  on my different local repos, I hope there is a configuration to store this
> to git-config, and I think many people also need this to avoid specifying
> "--pretty=..." every time.

I had to wonder what foreign project this commit log format message was
borrowed from.  also, in english, each sentence begins with a capital
letter.  not only the the first sentence ;-).

> with applying the patch, code in `git log/show/whatchanged` executed in
> the following order:
> 1. call to gitconfig will set static fmt_pretty according to user's git-config:
>    if the user never config "format.pretty", fmt_pretty doesn't need to be
>    initialized;
> 2. rev->commit_format set to CMIT_FMT_DEFAULT in init_revisions;
> 3. set rev->commit_format according to fmt_pretty if the user has configured
>    "format.pretty" in git-config, else default to CMIT_FMT_DEFAULT;
> 4. setup_revisions will accept "--pretty=" from the command line;

It is good to show that you looked at the codepath, but I think this can
go after the three-dashes line.  But what this part describes.

> so the pretty format's setting precedence will be:
> 1. the command line "--pretty=";
> 2. "format.pretty" from the git-config;
> 3. default CMIT_FMT_DEFAULT;

is a must-have in the commit log message.  The precedence order looks
sane.

By the way, I also share the concern Linus raised earlier that end-user
configuration may break existing scripts.

In-tree, there are only two callers that do not use --pretty on the
command line when calling these three commands:

 * "bisect visualize" calls "git log" when gitk is not available, with the
   user supplied formatting options.  This is very much Ok --- we actively
   want your configuration feature for this caller.

 * "git merge --squash" calls "git log" to prepare the commit message
   template.  This is _not_ Ok, and will be broken if we accept your
   patch.

So you will need a preliminary patch to "git-merge" _before_ submitting
this patch to make the latter codepath use "git log --pretty" instead.
Doing so would have raised _my_ confidence level of the patch that you
made your best effort not to introduce regression.

> diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
> index 54947b6..a6e7bd4 100644
> --- a/Documentation/git-whatchanged.txt
> +++ b/Documentation/git-whatchanged.txt
> @@ -38,11 +38,6 @@ OPTIONS
>  	Show git internal diff output, but for the whole tree,
>  	not just the top level.
>  
> ---pretty=<format>::
> -	Controls the output format for the commit logs.
> -	<format> can be one of 'raw', 'medium', 'short', 'full',
> -	and 'oneline'.
> -
>  -m::
>  	By default, differences for merge commits are not shown.
>  	With this flag, show differences to that commit from all
> @@ -51,6 +46,10 @@ OPTIONS
>  However, it is not very useful in general, although it
>  *is* useful on a file-by-file basis.
>  
> +include::pretty-options.txt[]
> +
> +include::pretty-formats.txt[]
> +
>  Examples
>  --------
>  git-whatchanged -p v2.6.12.. include/scsi drivers/scsi::

While this may be a sensible clean-up (note: I didn't actually formatted
the results and proofread it), it does not belong to your topic, does it?
It is also a preliminary clean-up before your change.

> diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
> index 973d8dd..15e01fa 100644
> --- a/Documentation/pretty-options.txt
> +++ b/Documentation/pretty-options.txt
> @@ -4,6 +4,14 @@
>  	where '<format>' can be one of 'oneline', 'short', 'medium',
>  	'full', 'fuller', 'email', 'raw' and 'format:<string>'.
>  	When omitted, the format defaults to 'medium'.
> ++
> +Note: now you can specify the default pretty format in the repository
> +configuration (see linkgit:git-config[1]), like this in .git/config:

In the commit log message, it is very sane to say "earlier we couldn't but
now we can", but in the end-user documentation we should avoid that.  The
documentation does not talk only to git old timers, but should be written
for first time readers as well.  Drop "now".

> diff --git a/builtin-log.c b/builtin-log.c
> index bbadbc0..23c05bc 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -221,6 +224,12 @@ static int cmd_log_walk(struct rev_info *rev)
>  
>  static int git_log_config(const char *var, const char *value)
>  {
> +	if (!strcmp(var, "format.pretty")) {
> +		if (!value)
> +			config_error_nonbool(var);
> +		fmt_pretty = xstrdup(value);
> +		return 0;
> +	}

These days, this can be written as:

	if (!strcmp(var, "format.pretty"))
		return git_config_string(&fmt_pretty, var, value);

Other than that, I think it is reasonably well done.

My suggestion would be to (re)do this as three series of patches:

 [1/3] whatchanged documentation: share description of --pretty with others

    The documentation had its own description for --pretty and did not
    include pretty-options/formats as documentation for other commands in
    the "log" family did.

 [2/3] merge --squash: explicitly ask for --pretty when preparing the message

    "git-merge --squash" uses "git log" when preparing the commit log
    message template without passing --pretty.

    When format.pretty configuration variable is used by the end user,
    this will result in the message template to be formatted with the
    configured format, regressing the current behaviour.

    This commit makes it explicitly ask for the default pretty format by
    passing the --pretty option when running "git log".

 [3/3] log/show/whatchanged: introduce format.pretty configuration

    When running log/show/whatchanged from the command line, the user may
    want to use a preferred format without having to pass --pretty=<fmt>
    option every time from the command line.  This teaches these three
    commands to honor a new configuration variable, format.pretty.

    The --pretty option given from the command line will override the
    configured format.

    The earlier patch fixed the only in-tree caller that runs these
    commands for a purpose other than showing the output directly to the
    end user (the other in-tree caller is "git bisect visualize", whose
    output directly goes to the end user and should be affected by this
    patch).  Similar fixes will be needed for end-user scripts that expect
    the output from these commands to be in the default pretty format
    (i.e. for the purpose of parsing it themselves).

Thanks.
