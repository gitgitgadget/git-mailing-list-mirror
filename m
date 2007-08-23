From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Thu, 23 Aug 2007 12:14:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708231158120.20400@racer.site>
References: <46CC3090.7080500@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 13:15:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOAer-00078s-3a
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 13:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117AbXHWLPU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 07:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753437AbXHWLPT
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 07:15:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:45137 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751290AbXHWLPS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 07:15:18 -0400
Received: (qmail invoked by alias); 23 Aug 2007 11:15:16 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO [192.168.0.57]) [132.187.25.128]
  by mail.gmx.net (mp019) with SMTP; 23 Aug 2007 13:15:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/3GsFQ86P3bphHUc1+/vz+oL0//VyEWifcWgsfTD
	o436WfVejPLNR8
X-X-Sender: gene099@racer.site
In-Reply-To: <46CC3090.7080500@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56494>

Hi,

[I thought that it was high time in this thread to review the code]

On Wed, 22 Aug 2007, Carlos Rica wrote:

> The tests I made for it are not finished so they are not included, but 
> it seems to pass the rest of the test suite.

AFAICS there are only "reset --hard"s in the test suite.

> diff --git a/builtin-reset.c b/builtin-reset.c
> [...]
> +
> +static int unmerged_files(void)
> +{
> +	char b;
> +	ssize_t len;
> +	struct child_process cmd;
> +	const char *argv_ls_files[] = {"ls-files", "--unmerged", NULL};
> +
> +	memset(&cmd, 0, sizeof(cmd));
> +	cmd.argv = argv_ls_files;
> +	cmd.git_cmd = 1;
> +	cmd.out = -1;
> +
> +	if (start_command(&cmd))
> +		die("Could not run sub-command: git ls-files");
> +
> +	len = xread(cmd.out, &b, 1);
> +	if (len < 0)
> +		die("Could not read output from git ls-files: %s",
> +						strerror(errno));
> +	finish_command(&cmd);
> +
> +	return len;
> +}

I think it is a good idea to start out using run_command, and if we ever 
run into performance issues, we can always switch to calling the functions 
directly.

> +static int print_line_current_head(void)
> +{
> +	const char *argv_log[] = {"log", "--max-count=1", "--pretty=oneline",
> +					"--abbrev-commit", "HEAD", NULL};
> +	printf("HEAD is now at ");
> +	unsetenv("GIT_PAGER");
> +	return run_command_v_opt(argv_log, RUN_GIT_CMD);
> +}

This is a candidate to refactoring, using commit.c's get_one_line() 
function.

> +int cmd_reset(int argc, const char **argv, const char *prefix)
> +{
> +	int i = 1, reset_type = MIXED, update_ref_status = 0;
> +	const char *rev = "HEAD";
> +	unsigned char sha1[20], *orig = NULL, sha1_orig[20],
> +				*old_orig = NULL, sha1_old_orig[20];
> +	struct object *obj;
> +	char *reflog_action;
> +
> +	git_config(git_default_config);
> +
> +	reflog_action = args_to_str(argv);
> +	setenv("GIT_REFLOG_ACTION", reflog_action, 0);
> +
> +	if (i < argc) {
> +		if (!strcmp(argv[i], "--mixed")) {
> +			reset_type = MIXED;
> +			i++;
> +		}
> +		else if (!strcmp(argv[i], "--soft")) {
> +			reset_type = SOFT;
> +			i++;
> +		}
> +		else if (!strcmp(argv[i], "--hard")) {
> +			reset_type = HARD;
> +			i++;
> +		}
> +	}
> +
> +	if (i < argc && argv[i][0] != '-')
> +		rev = argv[i++];
> +
> +	if (get_sha1(rev, sha1))
> +		die("Failed to resolve '%s' as a valid ref.", rev);
> +
> +	obj = deref_tag(parse_object(sha1), sha1_to_hex(sha1), 40);

IMHO it would be better to use "..., rev, strlen(rev));" instead.

> +	if (!obj)
> +		die("Could not parse object '%s'.", rev);
> +	memcpy(sha1, obj->sha1, sizeof(sha1));
> +
> +	if (i < argc && argv[i][0] == '-') {
> +		if (strcmp(argv[i], "--"))
> +			usage(builtin_reset_usage);
> +		else
> +			i++;
> +	}

IMHO this would be clearer:

	if (i < argc && !strcmp(argv[i], "--"))
		i++;
	else if (i < argc && argv[i][0] == '-')
		usage(builtin_reset_usage);

but I do not care _that_ deeply.

> +	/* git reset --mixed tree [--] paths... can be used to
> +	 * load chosen paths from the tree into the index without
> +	 * affecting the working tree nor HEAD. */
> +	if (i < argc) {
> +		if (reset_type != MIXED)
> +			die("Cannot do partial %s reset.", argv[1]);

Hmm.  Maybe use a static const array of "hard", "mixed" and "soft"?

> +		/*
> +		git diff-index --cached $rev -- "$@" |
> +		sed -e 's/^:\([0-7][0-7]*\) [0-7][0-7]* \([0-9a-f][0-9a-f]*\) [0-9a-f][0-9a-f]* [A-Z]	\(.*\)$/\1 \2	\3/' |
> +		git update-index --add --remove --index-info || exit
> +		*/
> +		update_index_refresh();

AFAICT this code misses out on added files, i.e. files which are in $rev, 
but not in the index.

> +	/* Any resets update HEAD to the head being switched to,
> +	 * saving the previous head in ORIG_HEAD before. */
> +	if (!get_sha1("ORIG_HEAD", sha1_old_orig))
> +		old_orig = sha1_old_orig;
> +	if (!get_sha1("HEAD", sha1_orig)) {
> +		orig = sha1_orig;
> +		update_ref("updating ORIG_HEAD", "ORIG_HEAD", orig, old_orig);
> +	}
> +	else if (old_orig)
> +		delete_ref("ORIG_HEAD", old_orig);

Why not put the get_sha1() into the else if()?  You spare a variable and a 
few lines there.

Otherwise it looks good to me.  It would be good if you could post your 
test script, though, so that people can get a feel what works and what 
needs work.

Ciao,
Dscho
