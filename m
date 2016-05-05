From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v16 7/7] commit: add a commit.verbose config variable
Date: Thu, 05 May 2016 12:14:30 -0700
Message-ID: <xmqqbn4kb9m1.fsf@gitster.mtv.corp.google.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
	<1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
	<1462441802-4768-8-git-send-email-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: sunshine@sunshineco.com, szeder@ira.uka.de, git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 21:14:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayOjO-0006Dp-8Q
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 21:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771AbcEETOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 15:14:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55866 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753503AbcEETOe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 15:14:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E351617EFF;
	Thu,  5 May 2016 15:14:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vql7xmanhRmokaw3Hs5Iheho980=; b=I9wWQr
	C/YwpC5bXo4DYQMOvl8yJjWXh3q5thVgHYy8aQ3f38e3C3JsSPhvfhaz/b1bRwTO
	qKPuF1fGCIgZX7Ojmpkcae514Eeem4tEUEvkaNJg1FjBukBbojWkKpS49hhybs6Q
	qjQgH8MlpGYrNLETQrNFCGUzcX/PhsTvH7VKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A3luumGyV66cSnS802pVx+1PeH+lLGWZ
	6fzbMY/lNIA0RDdoLi0Kxfpcr+5HJ+d0SMhB9frzWRXzj6MCJCIuC9yLpMKpCtHU
	cKdCTD95F/UAdfdoc9W6MabyBeW1mZjMYA00RVCVKbl7yIUACVlJ54kO+xkaRdx/
	jcOOvfEAr80=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DBB2917EFE;
	Thu,  5 May 2016 15:14:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 27A3117EFD;
	Thu,  5 May 2016 15:14:32 -0400 (EDT)
In-Reply-To: <1462441802-4768-8-git-send-email-pranit.bauva@gmail.com> (Pranit
	Bauva's message of "Thu, 5 May 2016 15:20:02 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 98D4B830-12F5-11E6-8566-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293663>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 391126e..114ffc9 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -113,7 +113,9 @@ static char *edit_message, *use_message;
>  static char *fixup_message, *squash_message;
>  static int all, also, interactive, patch_interactive, only, amend, signoff;
>  static int edit_flag = -1; /* unspecified */
> -static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
> +static int config_verbose = -1; /* unspecified */
> +static int verbose = -1; /* unspecified */
> +static int quiet, no_verify, allow_empty, dry_run, renew_authorship;

The name does not make it clear that config_verbose is only for
"commit" and not relevant to "status".

> @@ -1364,6 +1366,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>  			     builtin_status_usage, 0);
>  	finalize_colopts(&s.colopts, -1);
>  	finalize_deferred_config(&s);
> +	if (verbose == -1)
> +		verbose = 0;

Mental note: cmd_status() does not use git_commit_config() but uses
git_status_config(), hence config_verbose is not affected.  But
because verbose is initialised to -1, the code needs to turn it off
like this.

> @@ -1664,6 +1673,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
>  					  builtin_commit_usage,
>  					  prefix, current_head, &s);
> +	if (verbose == -1)
> +		verbose = (config_verbose < 0) ? 0 : config_verbose;
> +

cmd_commit() does use git_commit_config(), and verbose is
initialised -1, so without command line option, we fall back to
config_verbose if it is set from the configuration.

I wonder if the attached patch squashed into this commit makes
things easier to understand, though.  The points are:

 - We rename the configuration to make it clear that it is about
   "commit" and does not apply to "status".

 - We initialize verbose to 0 as before.  The only thing "git
   status" cares about is if "--verbose" was given.  Giving it
   "--no-verbose" or nothing should not make any difference.

 - But we do need to stuff -1 to verbose in "git commit" before
   handling the command line options, because the distinction
   between having "--no-verbose" and not having any matter there,
   and we do so in cmd_commit(), i.e. only place where it matters.

 builtin/commit.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 583d1e3..a486620 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -113,9 +113,8 @@ static char *edit_message, *use_message;
 static char *fixup_message, *squash_message;
 static int all, also, interactive, patch_interactive, only, amend, signoff;
 static int edit_flag = -1; /* unspecified */
-static int config_verbose = -1; /* unspecified */
-static int verbose = -1; /* unspecified */
-static int quiet, no_verify, allow_empty, dry_run, renew_authorship;
+static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
+static int config_commit_verbose = -1; /* unspecified */
 static int no_post_rewrite, allow_empty_message;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
 static char *sign_commit;
@@ -1366,8 +1365,6 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 			     builtin_status_usage, 0);
 	finalize_colopts(&s.colopts, -1);
 	finalize_deferred_config(&s);
-	if (verbose == -1)
-		verbose = 0;
 
 	handle_untracked_files_arg(&s);
 	if (show_ignored_in_status)
@@ -1521,7 +1518,7 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 	}
 	if (!strcmp(k, "commit.verbose")) {
 		int is_bool;
-		config_verbose = git_config_bool_or_int(k, v, &is_bool);
+		config_commit_verbose = git_config_bool_or_int(k, v, &is_bool);
 		return 0;
 	}
 
@@ -1670,11 +1667,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		if (parse_commit(current_head))
 			die(_("could not parse HEAD commit"));
 	}
+	verbose = -1; /* unspecified */
 	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
 					  builtin_commit_usage,
 					  prefix, current_head, &s);
 	if (verbose == -1)
-		verbose = (config_verbose < 0) ? 0 : config_verbose;
+		verbose = (config_commit_verbose < 0) ? 0 : config_commit_verbose;
 
 	if (dry_run)
 		return dry_run_commit(argc, argv, prefix, current_head, &s);
