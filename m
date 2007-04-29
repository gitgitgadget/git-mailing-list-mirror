From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/5] Add remote functions
Date: Sat, 28 Apr 2007 22:52:11 -0700
Message-ID: <7virbfg22c.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704281303570.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Apr 29 07:52:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hi2KY-0002Ya-Cj
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 07:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756218AbXD2FwP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 01:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756221AbXD2FwP
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 01:52:15 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:46881 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756218AbXD2FwN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 01:52:13 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070429055212.ZZIT24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 29 Apr 2007 01:52:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id stsC1W00R1kojtg0000000; Sun, 29 Apr 2007 01:52:12 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45813>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Make a struct and a set of functions to handle the parsing of remote
> configurations (branches files, remotes files, and config sections),
> and do some simple operations on lists of refspecs in the struct.
>
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

I do not have any objection to making a generally useful library
function to deal with branches/remotes/config, and this is
probably a good start.  Eventually we would want to do a built-in
git-remote command that supports interactive editing of remote
information, not just fetch/push in C.

But I do not think I can apply this patch as is, even for 'pu'.
Comments below.

> diff --git a/remote.c b/remote.c
> new file mode 100644
> index 0000000..58e6a96
> --- /dev/null
> +++ b/remote.c
> @@ -0,0 +1,241 @@
> +#include "cache.h"
> +#include "remote.h"
> +
> +#define MAX_REMOTES 16
> +
> +static struct remote *remotes[MAX_REMOTES];

I do not think the limitation of MAX_URI=16 in the original is
unreasonable, but this MAX_REMOTES is way too low, if we want to
eventually support somebody like Andrew, who has to deal with a
few dozen git trees.

> +static void add_uri(struct remote *remote, const char *uri)
> +{
> +	int i;
> +	for (i = 0; i < MAX_REMOTE_URI; i++) {
> +		if (!remote->uri[i]) {
> +			remote->uri[i] = uri;
> +			return;
> +		}
> +	}
> +	error("ignoring excess uri");
> +}

Why not do this just like refspecs, as an array of URIs?  Doing
so would also lift the MAX_REMOTE_URI limitation.  Although more
than one URIs per remote is not a norm but an exception (and
makes sense only for push), it would shrink the base structure,
and probably make the code simpler.

> +
> +static struct remote *make_remote(const char *name, int len)
> +{
> +	int i, empty = -1;
> +
> +	for (i = 0; i < MAX_REMOTES; i++) {
> +		if (!remotes[i]) {
> +			if (empty < 0)
> +				empty = i;
> +		} else {
> +			if (len ? !strncmp(name, remotes[i]->name, len) :
> +			    !strcmp(name, remotes[i]->name))
> +				return remotes[i];
> +		}

If you have "remote.foobar.url = /git/repo.git", this is called
with "foobar.url" in name and 6 in len.  Do you want to match an
existing remote whose name is "foobarbaz"?

> +static void read_remotes_file(struct remote *remote)
> +{
> +	FILE *f = fopen(git_path("remotes/%s", remote->name), "r");
> +
> +	if (!f)
> +		return;
> +	while (fgets(buffer, BUF_SIZE, f)) {
> +		int is_refspec;

The original dealt with URL or refspec, so "is_refspec" made
some sense.  It isn't anymore as you differentiate between push
and fetch refspecs.

> +static void read_branches_file(struct remote *remote)
> +{
> +	const char *slash = strchr(remote->name, '/');
> +	int n = slash ? slash - remote->name : 1000;
> +	FILE *f = fopen(git_path("branches/%.*s", n, remote->name), "r");
> +	char *s, *p;
> +	int len;

I know you inherited this from builtin-push.c, but can't we
clean up this magic 1000 somehow, please?

> +static const char *default_remote_name = NULL;
> +static const char *current_branch = NULL;
> +static int current_branch_len = 0;
> +
> +static int handle_config(const char *key, const char *value)
> +{
> +	const char *name;
> +	const char *subkey;
> +	struct remote *remote;
> +	if (!prefixcmp(key, "branch.") && current_branch &&
> +	    !strncmp(key + 7, current_branch, current_branch_len) &&
> +	    !strcmp(key + 7 + current_branch_len, ".remote")) {
> +		default_remote_name = xstrdup(value);
> +	}

Who sets current_branch to non-NULL value?  It is static and I
do not see anybody setting it in this file.

Also the original value of default_remote_name leaks here.  But
you cannot blindly free the original value, as you could end up
storing it in ret->uri[0] when somebody calls remote_get(NULL).

> +	if (prefixcmp(key,  "remote."))
> +		return 0;
> +	name = key + 7;
> +	subkey = strchr(name, '.');
> +	if (!subkey)
> +		return error("Config with no key for remote %s", name);

This is not right.

	[section "section name"]
                 variable = value

allows dot in "section name" part, so you would want strrchr()
to find out the end of it, not the first dot with strchr().  You
found an input error (missing subkey) if strrchr() finds the dot
at the end of "remote." (i.e. subkey == key + 6).

> +char *remote_fetch_to(struct remote *remote, const char *ref)
> +{
> +	int i;
> +	for (i = 0; i < remote->fetch_refspec_nr; i++) {
> +		const char *refspec = remote->fetch_refspec[i];
> +		const char *cons = strchr(refspec, ':');
> +		const char *glob = strchr(refspec, '*');
> +		if (*refspec == '+')
> +			refspec++;

I cannot offhand tell what this function is about...

Would there be callers who are interested in finding out if
refspec is forcing or not?

You are not protecting yourself from refspecs without tracking
branch (i.e. sans any colon) and would segfault in the rest of
this function.

> +		if (glob) {
> +			if (!strncmp(ref, refspec, glob - refspec)) {
> +				const char *cons_glob = strchr(cons, '*');
> +				char *ret =
> +					xmalloc(cons_glob - cons + strlen(ref) - (glob - refspec));
> +				memcpy(ret, cons + 1, cons_glob - cons - 1);
> +				memcpy(ret + (cons_glob - cons) - 1,
> +				       ref + (glob - refspec),
> +				       strlen(ref) - (glob - refspec) + 1);
> +				return ret;
> +			}
> +		} else if (!strncmp(ref, refspec, cons - refspec)) {
> +			return xstrdup(cons + 1);
> +		}
> +	}
> +	return NULL;
> +}

> diff --git a/remote.h b/remote.h
> new file mode 100644
> index 0000000..7e881f7
> --- /dev/null
> +++ b/remote.h
> @@ -0,0 +1,25 @@
> +#ifndef _REMOTE_H
> +#define _REMOTE_H

We do not seem to use leading underscore in most our header
files.  Let's be consistent (we need to fix diffcore.h and
path-list.h).
