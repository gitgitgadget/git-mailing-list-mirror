From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH v2 2/3] builtin-status: submodule summary support
Date: Fri, 11 Apr 2008 15:31:54 -0700
Message-ID: <7vtzi8owf9.fsf@gitster.siamese.dyndns.org>
References: <1207841727-7840-1-git-send-email-pkufranky@gmail.com>
 <1207841727-7840-2-git-send-email-pkufranky@gmail.com>
 <1207841727-7840-3-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 00:32:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkRnc-0003zS-Si
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 00:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757083AbYDKWcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 18:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756688AbYDKWcF
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 18:32:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63517 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756660AbYDKWcE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 18:32:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E794D1F70;
	Fri, 11 Apr 2008 18:32:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C9C771F6C; Fri, 11 Apr 2008 18:31:56 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79302>

Ping Yin <pkufranky@gmail.com> writes:

> This commit teaches 'git commit/status' show 'Modified submodules'
> section given by
>
> git submodule summary --cached --for-status --summary-limit <limit>
>
> just before 'Untracked files' section.
>
> The <limit> is given by the config variable status.submodulesummary
> to limit the submodule summary size. status.submodulesummary is 0 by
> default which disables the summary.

This begs an obvious question "What if I want to have an unlimited summary
in the status output?"

> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> index 3ea269a..32b6660 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -52,6 +52,10 @@ If the config variable `status.relativePaths` is set to false, then all
>  paths shown are relative to the repository root, not to the current
>  directory.
>  
> +If 'status.submodulesummary' is set to a non zero number, the submodule
> +summary will be enabled and a summary of commits for modified submodules
> +will be shown (see --summary-limit option of linkgit:git-submodule[1]).
> +

The docs quote configuration variables in typewriter face by using
backticks (pay attention to how status.relativePaths is quoted in your
hunk header comment).

> diff --git a/wt-status.c b/wt-status.c
> index b3fd57b..369c519 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -8,9 +8,11 @@
>  #include "revision.h"
>  #include "diffcore.h"
>  #include "quote.h"
> +#include "run-command.h"
>  
>  int wt_status_relative_paths = 1;
>  int wt_status_use_color = -1;
> +int wt_status_submodule_summary = 0;

Don't initialize to 0.  BSS takes care of it.

>  static char wt_status_colors[][COLOR_MAXLEN] = {
>  	"",         /* WT_STATUS_HEADER: normal */
>  	"\033[32m", /* WT_STATUS_UPDATED: green */
> @@ -219,6 +221,38 @@ static void wt_status_print_changed(struct wt_status *s)
>  	rev.diffopt.format_callback_data = s;
>  	run_diff_files(&rev, 0);
>  }
> +static void wt_status_print_submodule_summary(struct wt_status *s)
> +{
> ...
> +	memset(&sm_summary, 0, sizeof(sm_summary));
> +	sm_summary.argv = argv;
> +	sm_summary.env = env;
> +	sm_summary.git_cmd = 1;
> +	sm_summary.no_stdin = 1;
> +	fflush(s->fp);
> +	sm_summary.out = dup(fileno(s->fp));    /* run_command closes it */
> +	run_command(&sm_summary);

I recall we had some clean-up on how file descriptors are inherited and
duped around when run_command() runs a subprocess.  Hannes, is this dup()
consistent with how the things ought to be these days?

> @@ -330,6 +365,10 @@ void wt_status_print(struct wt_status *s)
>  
>  int git_status_config(const char *k, const char *v)
>  {
> +	if (!strcmp(k, "status.submodulesummary")) {
> +		wt_status_submodule_summary = atoi(v);

With this code, you would feed a NULL to atoi() with:

        [status]
                submoduleSummary

How about making this a bool-or-number, and boolean true gives whatever
the default limit (may be unlimited) when no --summary-limit is given?

We may want to have git_config_bool_or_int() in config.c so that the
caller can tell if the value is boolean true or integer 1, which would be
a reasonable improvement independent from this submodule summary
codepath.

int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
{
        *is_bool = 1;
	if (!value)
		return 1;
	if (!*value)
		return 0;
	if (!strcasecmp(value, "true") || !strcasecmp(value, "yes"))
		return 1;
	if (!strcasecmp(value, "false") || !strcasecmp(value, "no"))
		return 0;
	*is_bool = 0;
	return git_config_int(name, value) != 0;
}

With that, your configuration parser can do something like:

	if (!strcmp(k, "status.submodulesummary")) {
		int is_bool, val;
		val = git_config_bool_or_int(k, v, &b);
		if (is_bool || val <= 0) {
                	wt_status_submodule_summary_enabled = val;
		} else {
                	wt_status_submodule_summary = val;
                	wt_status_submodule_summary_enabled = 1;
		}
	}

and skip the call to wt_status_print_submodule_summary() when not
enabled.

>  int wt_status_relative_paths = 1;
>  int wt_status_use_color = -1;
> +int wt_status_submodule_summary = -1; /* unspecified */
  +int wt_status_submodule_summary_enabled;

The call site in wt_status_print() would look like: 

	...
 	wt_status_print_changed(s);
	if (wt_status_submodule_summary_enabled > 0)
		wt_status_print_submodule_summary(s);
 	wt_status_print_untracked(s);
	...

and the wt_status_print_submodule_summary() would not add --summary-limit
parameter if wt_status_submodule_summary is left unspecified (i.e. -1).
