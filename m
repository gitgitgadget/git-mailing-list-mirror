From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/4] sequencer: add "make_patch" function to save a patch
Date: Sun, 28 Jun 2009 14:13:21 +0200
Message-ID: <200906281413.21454.chriscool@tuxfamily.org>
References: <20090626205319.3885.91532.chriscool@tuxfamily.org> <20090626210847.3885.18347.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 28 14:13:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKtG6-0001UI-At
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 14:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbZF1MNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 08:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbZF1MNH
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 08:13:07 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:40511 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757AbZF1MNG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 08:13:06 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D9D0F818157;
	Sun, 28 Jun 2009 14:12:58 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C85188180F9;
	Sun, 28 Jun 2009 14:12:55 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20090626210847.3885.18347.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122400>

Ooops, there should be a:

From: Stephan Beyer <s-beyer@gmx.net>

header in this patch.

Regards,
Christian.

On Friday 26 June 2009, Christian Couder wrote:
> This function generates an informational patch file.
>
> The "make_patch" and the "get_commit" functions are copied from the
> GSoC sequencer project:
>
> git://repo.or.cz/git/sbeyer.git
>
> (commit e7b8dab0c2a73ade92017a52bb1405ea1534ef20)
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin-sequencer--helper.c |   75
> ++++++++++++++++++++++++++++++++++++++++++- 1 files changed, 74
> insertions(+), 1 deletions(-)
>
> diff --git a/builtin-sequencer--helper.c b/builtin-sequencer--helper.c
> index 721c0d8..8d32480 100644
> --- a/builtin-sequencer--helper.c
> +++ b/builtin-sequencer--helper.c
> @@ -1,15 +1,83 @@
>  #include "builtin.h"
>  #include "cache.h"
>  #include "parse-options.h"
> +#include "run-command.h"
> +
> +#define SEQ_DIR "rebase-merge"
> +
> +#define PATCH_FILE	git_path(SEQ_DIR "/patch")
>
>  static const char * const git_sequencer_helper_usage[] = {
>  	"git sequencer--helper --make-patch <commit>",
>  	NULL
>  };
>
> +/* Generate purely informational patch file */
> +static void make_patch(struct commit *commit)
> +{
> +	struct commit_list *parents = commit->parents;
> +	const char **args;
> +	struct child_process chld;
> +	int fd = open(PATCH_FILE, O_WRONLY | O_CREAT, 0666);
> +	if (fd < 0)
> +		return;
> +
> +	memset(&chld, 0, sizeof(chld));
> +	if (!parents) {
> +		write(fd, "Root commit\n", 12);
> +		close(fd);
> +		return;
> +	} else if (!parents->next) {
> +		args = xcalloc(5, sizeof(char *));
> +		args[0] = "diff-tree";
> +		args[1] = "-p";
> +		args[2] = xstrdup(sha1_to_hex(parents->item->object.sha1));
> +		args[3] = xstrdup(sha1_to_hex(((struct object *)commit)->sha1));
> +	} else {
> +		int i = 0;
> +		int count = 1;
> +
> +		for (; parents; parents = parents->next)
> +			++count;
> +		args = xcalloc(count + 3, sizeof(char *));
> +		args[i++] = "diff";
> +		args[i++] = "--cc";
> +		args[i++] = xstrdup(sha1_to_hex(commit->object.sha1));
> +
> +		for (parents = commit->parents; parents;
> +		     parents = parents->next)
> +			args[i++] = xstrdup(sha1_to_hex(
> +					    parents->item->object.sha1));
> +	}
> +
> +	chld.argv = args;
> +	chld.git_cmd = 1;
> +	chld.out = fd;
> +
> +	/* Run, ignore errors. */
> +	if (start_command(&chld))
> +		return;
> +	finish_command(&chld);
> +
> +	/* TODO: free dup'ed SHAs in argument list */
> +}
> +
> +/* Return a commit object of "arg" */
> +static struct commit *get_commit(const char *arg)
> +{
> +	unsigned char sha1[20];
> +
> +	if (get_sha1(arg, sha1)) {
> +		error("Could not find '%s'", arg);
> +		return NULL;
> +	}
> +	return lookup_commit_reference(sha1);
> +}
> +
>  int cmd_sequencer__helper(int argc, const char **argv, const char
> *prefix) {
>  	char *commit = NULL;
> +	struct commit *c;
>  	struct option options[] = {
>  		OPT_STRING(0, "make-patch", &commit, "commit",
>  			   "create a patch from commit"),
> @@ -22,6 +90,11 @@ int cmd_sequencer__helper(int argc, const char **argv,
> const char *prefix) if (!commit)
>  		usage_with_options(git_sequencer_helper_usage, options);
>
> -	/* Nothing to do yet */
> +	c = get_commit(commit);
> +	if (!c)
> +		return 1;
> +
> +	make_patch(c);
> +
>  	return 0;
>  }
