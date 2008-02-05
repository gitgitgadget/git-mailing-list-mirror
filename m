From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 9/9] Build in checkout
Date: Tue, 5 Feb 2008 02:14:35 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802050143050.8543@racer.site>
References: <alpine.LNX.1.00.0802041336060.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 03:16:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMDMK-0005rl-Pb
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 03:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755485AbYBECPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 21:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756049AbYBECPT
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 21:15:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:33057 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754428AbYBECPR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 21:15:17 -0500
Received: (qmail invoked by alias); 05 Feb 2008 02:15:14 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp008) with SMTP; 05 Feb 2008 03:15:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX194X2cKuVt4i+itZyx5aknFYZbu2cOKzw0zS7/zzc
	no16WeTsugnSI5
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802041336060.13593@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72613>

Hi,

On Mon, 4 Feb 2008, Daniel Barkalow wrote:

> diff --git a/builtin-checkout.c b/builtin-checkout.c
> new file mode 100644
> index 0000000..2950d5c
> --- /dev/null
> +++ b/builtin-checkout.c
> @@ -0,0 +1,478 @@
> +#include "cache.h"
> +#include "builtin.h"
> +#include "parse-options.h"
> +#include "refs.h"
> +#include "commit.h"
> +#include "tree.h"
> +#include "tree-walk.h"
> +#include "unpack-trees.h"
> +#include "dir.h"
> +#include "run-command.h"
> +#include "merge-recursive.h"
> +#include "diff.h"
> +#include "revision.h"
> +
> +static const char * const checkout_usage[] = {
> +	"git checkout [options] <branch>",
> +	"git checkout [options] [<branch>] -- <file>...",
> +	NULL,
> +};
> +
> +static int post_checkout_hook(struct commit *old, struct commit *new,
> +			      int changed)
> +{
> +	struct child_process proc;
> +	const char *name = git_path("hooks/post-checkout");
> +	const char *argv[5];
> +
> +	if (access(name, X_OK) < 0)
> +		return 0;
> +
> +	memset(&proc, 0, sizeof(proc));
> +	argv[0] = name;
> +	argv[1] = xstrdup(sha1_to_hex(old->object.sha1));
> +	argv[2] = xstrdup(sha1_to_hex(new->object.sha1));
> +	argv[3] = changed ? "1" : "0";
> +	argv[4] = NULL;
> +	proc.argv = argv;
> +	proc.no_stdin = 1;
> +	proc.stdout_to_stderr = 1;
> +	return run_command(&proc);
> +}

Would this not be helped by the patch of Paolo in 
http://article.gmane.org/gmane.comp.version-control.git/72495?

We would only need to move the function into run-command.[ch]...

> +static int cache_unmerged(void)
> +{
> +	int i;
> +	for (i = 0; i < active_nr; i++) {
> +		if (ce_stage(active_cache[i]))
> +			return 1;
> +	}
> +	return 0;
> +}

AFAICT we have this function in merge-recursive.c (unmerged_index()) and 
builtin-reset.c (unmerged_files()) already.  Maybe it is time to 
consolidate them into one function in read-cache.c?

> +
> +static int update_some(const unsigned char *sha1, const char *base, int baselen,

Heh, nice function name ;-)

> +		       const char *pathname, unsigned mode, int stage)
> +{
> +	if (S_ISGITLINK(mode)) {
> +		return 0;
> +	} else if (S_ISDIR(mode)) {
> +		return READ_TREE_RECURSIVE;
> +	}

You could lose the curly brackets and the "else", for readability.

> +	int len = baselen + strlen(pathname);
> +	struct cache_entry *ce = xcalloc(1, cache_entry_size(len));

These variables need to be declared before the code (the if()s) starts.

> +	hashcpy(ce->sha1, sha1);
> +	memcpy(ce->name, base, baselen);
> +	memcpy(ce->name + baselen, pathname, len - baselen);
> +	ce->ce_flags = create_ce_flags(len, 0);
> +	ce->ce_mode = create_ce_mode(mode);
> +	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
> +	return 0;
> +}
> +
> +static int read_tree_some(struct tree *tree, const char **pathspec)

I have a hunch that you could share code with builtin-reset.c, namely 
call function read_from_tree() here.

> +static int remove_merge_head(void)
> +{
> +	unlink(git_path("MERGE_HEAD"));
> +	return 0;
> +}

Please make this either void, or return what the unlink() returns.

> +static void show_local_changes(struct object *head)
> +{
> +	struct rev_info rev;
> +	// I think we want full paths, even if we're in a subdirectory.

Please avoid C++-style comments.

> +	init_revisions(&rev, NULL);
> +	rev.abbrev = 0;
> +	rev.diffopt.output_format |= DIFF_FORMAT_NAME_STATUS;
> +	add_pending_object(&rev, head, NULL);
> +	run_diff_index(&rev, 0);
> +}
> +
> +static void describe_detached_head(char *msg, struct commit *commit)
> +{
> +	struct strbuf sb;
> +	strbuf_init(&sb, 0);
> +	parse_commit(commit);
> +	pretty_print_commit(CMIT_FMT_ONELINE, commit, &sb, 0, "", "", 0, 0);
> +	fprintf(stderr, "%s %s... %s\n", msg,
> +		find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV), sb.buf);

I am tempted to suggest

	pretty_print_commit(get_commit_format("format:%h... %s"), <...>);

here...

> +static int reset_to_new(struct tree *tree, int quiet)

Again, I think that this would benefit from code sharing with 
builtin-reset.  It can be a bit tricky to avoid writing files when they 
are already up-to-date...

> +struct checkout_opts {
> +	int quiet;
> +	int merge;
> +	int force;
> +
> +	char *new_branch;
> +	int new_branch_log;
> +	int track;
> +	int no_track;
> +};
> +
> +struct branch_info {
> +	const char *name; /* The short name used */
> +	const char *path; /* The full name of a real branch */
> +	struct commit *commit; /* The named commit */
> +};
> +
> +static void setup_branch_path(struct branch_info *branch)
> +{
> +	char *path = xmalloc(strlen(branch->name) +
> +			     strlen("refs/heads/") + 1);
> +	sprintf(path, "refs/heads/%s", branch->name);
> +	branch->path = path;

Looks like a perfect candidate for strbuf to me.

> +static void update_refs_for_switch(struct checkout_opts *opts,
> +				   struct branch_info *old,
> +				   struct branch_info *new)
> +{
> +	char *msg;
> +	const char *old_desc;
> +	if (opts->new_branch) {
> +		create_branch(opts->new_branch, new->name, 0,
> +			      opts->new_branch_log, opts->track);
> +		new->name = opts->new_branch;
> +		setup_branch_path(new);
> +	}
> +
> +	msg = malloc(1024);
> +	old_desc = old->name;
> +	if (!old_desc)
> +		old_desc = sha1_to_hex(old->commit->object.sha1);
> +	snprintf(msg, 1024, "checkout: moving from %s to %s",
> +		 old_desc, new->name);

Again, a perfect candidate for strbuf.

Unfortunately, I am a bit too tired to go on (especially for finding 
common ground between builtin-reset and read_tree_some(), 
checkout_paths(), reset_to_new(), and reset_clean_to_new()).  Hopefully 
I'll find time to look at it tomorrow...

Ciao,
Dscho
