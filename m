From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 11/14] pull: teach git pull about --rebase
Date: Tue, 19 May 2015 15:04:23 +0200
Organization: gmx
Message-ID: <ea07c7ecec761a0bb2d9f4936a8d2411@www.dscho.org>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
 <1431961571-20370-12-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 19 15:04:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuhCB-0008Ga-O7
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 15:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbbESNE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 09:04:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:50931 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932385AbbESNE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 09:04:26 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M8m7Q-1Z2Mho0NO0-00CCD2; Tue, 19 May 2015 15:04:24
 +0200
In-Reply-To: <1431961571-20370-12-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:T5vqTN+XpV1WKWz1vOSVPXx3l8NxiEN3rsghP+dJdfedhPkrbN2
 9TFasRZ10Q+8X1gxwwKIUDRVffqBrTXY646Y65nkYnuPcw91JvZR+6Or4HksPg8BB+tNf5/
 iihOgk/07Azr7vmP2OajLFDDsQ2hLcCEKuZTGzoC7Y0P9OckhkP2PbMb3F2I7pZxozcbXf1
 JQZd/lLjthy/tayatxT6Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269350>

Hi Paul,

I would like to add more suggestions to Stefan's comments, please find them below.

On 2015-05-18 17:06, Paul Tan wrote:
> @@ -506,11 +547,185 @@ static int run_merge(void)
>  	return ret;
>  }
>  
> +/**
> + * Returns the merge branch for the current branch. Returns NULL if repo is not
> + * a valid remote, HEAD does not point to a branch, repo is not the branch's
> + * configured remote or the branch does not have any configured merge branch.
> + */
> +static char *get_merge_branch_1(const char *repo)

A better name might be `get_upstream_branch(const char *repo)`, in line with the function in `sha1_name.c` that implements the `@{upstream}` functionality.

> +{
> +	struct remote *rm;
> +	struct branch *curr_branch;
> +
> +	if (repo && !(rm = remote_get(repo)))
> +		return NULL;
> +	if (!(curr_branch = branch_get("HEAD")))
> +		return NULL;
> +	if (repo && curr_branch->remote != rm)
> +		return NULL;
> +	if (!curr_branch->merge_nr)
> +		return NULL;
> +	return xstrdup(curr_branch->merge[0]->dst);
> +}
> +
> +/**
> + * Given a refspec, returns the merge branch. Returns NULL if the refspec src
> + * does not refer to a branch.
> + *
> + * FIXME: It should return the tracking branch. Currently only works with the
> + * default mapping.
> + */
> +static char *get_merge_branch_2(const char *repo, const char *refspec)
> +{
> +	struct refspec *spec;
> +	const char *remote;
> +	char *merge_branch;
> +
> +	spec = parse_fetch_refspec(1, &refspec);
> +	remote = spec->src;
> +	if (!*remote || !strcmp(remote, "HEAD"))
> +		remote = "HEAD";
> +	else if (skip_prefix(remote, "heads/", &remote))
> +		;
> +	else if (skip_prefix(remote, "refs/heads/", &remote))
> +		;
> +	else if (starts_with(remote, "refs/") ||
> +		starts_with(remote, "tags/") ||
> +		starts_with(remote, "remotes/"))
> +		remote = "";
> +
> +	if (*remote) {
> +		if (!strcmp(repo, "."))
> +			merge_branch = mkpathdup("refs/heads/%s", remote);
> +		else
> +			merge_branch = mkpathdup("refs/remotes/%s/%s", repo, remote);
> +	} else
> +		merge_branch = NULL;
> +
> +	free_refspec(1, spec);
> +	return merge_branch;
> +}

I have to admit that it took me a substantial amount of time to deduce from the code what `get_merge_branch_2()` really does (judging from the description, I thought that it would be essentially the same as `get_merge_branch_1()` without the hard-coded "HEAD"). If the comment above the function would have said something like:

/**
 * Given a refspec, returns the name of the local tracking ref.
 */

I would have had an easier time. Also, I wonder if something like this would do the job:

	spec = parse_fetch_refspec(1, &refspec);
	if (spec->dst)
		return spec->dst;
	if (!(remote = get_remote(remote_name)))
		return NULL;
	if (remote_find_tracking(remote, spec))
		return spec->dst;
	return NULL;

(I guess we'd have to `xstrdup()` the return values because the return value of `get_merge_branch_1()` needs to be `free()`d, but maybe we can avoid so much `malloc()/free()`ing.) Again, the function name should probably be changed to something clearer, maybe to `get_tracking_branch()`.

One thing that is not clear at all to me is whether

	git pull --rebase origin master next

would error out as expected, or simply rebase to `origin/master`.

> +/**
> + * Sets fork_point to the point at which the current branch forked from its
> + * remote merge branch. Returns 0 on success, -1 on failure.
> + */
> +static int get_rebase_fork_point(unsigned char fork_point[GIT_SHA1_RAWSZ],
> +		const char *repo, const char *refspec)
> +{
> +	int ret;
> +	struct branch *curr_branch;
> +	char *remote_merge_branch;
> +	struct argv_array args = ARGV_ARRAY_INIT;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	if (!(curr_branch = branch_get("HEAD")))
> +		return -1;
> +
> +	if (refspec)
> +		remote_merge_branch = get_merge_branch_2(repo, refspec);
> +	else
> +		remote_merge_branch = get_merge_branch_1(repo);
> +
> +	if (!remote_merge_branch)
> +		return -1;

We should probably `return error(_"No tracking branch found for %s@, refspec ? refspec : "HEAD");` so that the user has a chance to understand that there has been a problem and how to solve it.

> +	argv_array_pushl(&args, "merge-base", "--fork-point",
> +			remote_merge_branch, curr_branch->name, NULL);
> +	cp.argv = args.argv;

Let's just use `cp.args` directly...

> +	cp.no_stdin = 1;
> +	cp.no_stderr = 1;
> +	cp.git_cmd = 1;
> +
> +	if ((ret = capture_command(&cp, &sb, GIT_SHA1_HEXSZ)))
> +		goto cleanup;
> +
> +	if ((ret = get_sha1_hex(sb.buf, fork_point)))
> +		goto cleanup;
> +
> +cleanup:
> +	free(remote_merge_branch);
> +	strbuf_release(&sb);
> +	return ret ? -1 : 0;
> +}
> +
> +[...]
> +/**
> + * Given the current HEAD SHA1, the merge head returned from git-fetch and the
> + * fork point calculated by get_rebase_fork_point(), runs git-rebase with the
> + * appropriate arguments and returns its exit status.
> + */
> +static int run_rebase(unsigned char curr_head[GIT_SHA1_RAWSZ],
> +		unsigned char merge_head[GIT_SHA1_RAWSZ],
> +		unsigned char fork_point[GIT_SHA1_RAWSZ])
> +{
> +	int ret;
> +	unsigned char oct_merge_base[GIT_SHA1_RAWSZ];
> +	struct argv_array args = ARGV_ARRAY_INIT;
> +
> +	if (!get_octopus_merge_base(oct_merge_base, curr_head, merge_head,
> fork_point))

It might be my mail program only that mangled the diff here. But it could also be that this line is a little long (by my count, it is 81 columns wide).

Otherwise, this looks really good to me.

Ciao,
Dscho
