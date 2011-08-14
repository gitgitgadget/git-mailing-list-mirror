From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/7] sequencer: Expose API to cherry-picking machinery
Date: Sun, 14 Aug 2011 08:13:03 -0500
Message-ID: <20110814131303.GF18466@elie.gateway.2wire.net>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 15:13:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsaVB-0001yA-4x
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 15:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295Ab1HNNNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 09:13:12 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62207 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753008Ab1HNNNL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 09:13:11 -0400
Received: by iye16 with SMTP id 16so5480111iye.1
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 06:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FGIBSPVeVpz6MzSDJvt+g0M8UoHYLgLqfYZNpBiB9eY=;
        b=d+lDK4ITGYsL0VjCSv18c8SK7w3gkpOggaJXEuL216sbe2WRvdvIqdNwCC0EVoEWFa
         6r5AojHnJ2JQGlPVnii5Sp4miZjh7Yxwb1QBGDX5sSH+lMiZJu7G6v6yKb7wRaIBELHa
         iEI/mHOmgSLfZZDVo4I6SpqXi0nxM64UJ7ihc=
Received: by 10.231.6.99 with SMTP id 35mr3045755iby.7.1313327590927;
        Sun, 14 Aug 2011 06:13:10 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-68-255-106-30.dsl.chcgil.ameritech.net [68.255.106.30])
        by mx.google.com with ESMTPS id b6sm3239786ibg.14.2011.08.14.06.13.09
        (version=SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 06:13:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313310789-10216-7-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179323>

Ramkumar Ramachandra wrote:

> Move code from builtin/revert.c to sequencer.c and expose a public API
> without making any functional changes.  Although it is useful only to
> existing callers of cherry-pick and revert now, this patch lays the
> foundation for future expansion.

:)  It sounds like you are running a business.

I guess I would suggest clarifying that you mean exposing further
functionality through this API for more callers, rather than just
generally bloating git further.

[...]
> +++ b/sequencer.c
> @@ -1,13 +1,656 @@
[...]
> +#define COMMIT_MESSAGE_INIT  { NULL, NULL, NULL, NULL, NULL };

As much as I like this change (and I do, modulo the stray semicolon),
it does not belong in a patch where it can be unnoticed in the code
movement.

> +static const char *action_keyword(const struct replay_opts *opts)
> +{
> +	return opts->action == REPLAY_REVERT ? "revert" : "cherry-pick";
> +}

Another (non-functional) change.  Probably (?) this renaming has a
good reason to be part of this patch, but it should definitely be
mentioned in the commit message.

> +static void write_cherry_pick_head(struct commit *commit)
> +{
> +	int fd;
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	strbuf_addf(&buf, "%s\n", sha1_to_hex(commit->object.sha1));
> +
> +	fd = open(git_path("CHERRY_PICK_HEAD"), O_WRONLY | O_CREAT, 0666);
> +	if (fd < 0)
> +		die_errno(_("Could not open '%s' for writing"),
> +			  git_path("CHERRY_PICK_HEAD"));

git_path() calls vsnprintf which clobbers errno, so depending on the
platform this can print messages like

	fatal: Could not open '.git/CHERRY_PICK_HEAD' for writing: Success

The natural fix would be to add a local for it (as a separate patch).
Sorry I missed this when the code first arrived.

> +static struct tree *empty_tree(void)
> +{
> +	struct tree *tree = xcalloc(1, sizeof(struct tree));
> +
> +	tree->object.parsed = 1;
> +	tree->object.type = OBJ_TREE;
> +	pretend_sha1_file(NULL, 0, OBJ_TREE, tree->object.sha1);
> +	return tree;

This tree is leaked (for example if you cherry-pick a sequence of
root commits).

> +static int fast_forward_to(const unsigned char *to, const unsigned char *from)
> +{
> +	struct ref_lock *ref_lock;
> +
> +	read_cache();
> +	if (checkout_fast_forward(from, to))
> +		exit(1); /* the callee should have complained already */
> +	ref_lock = lock_any_ref_for_update("HEAD", from, 0);
> +	return write_ref_sha1(ref_lock, to, "cherry-pick");
> +}

The exit code here violates the usual "exit with status 128 for
errors other than conflicts" rule.  Perhaps it should be changed to
"return -1" in a separate patch (to accompany the patch that returns
error() instead of die()-ing so often to allow callers to give
additional context to errors from this machinery).

>  void remove_sequencer_state(int aggressive)
>  {
>  	struct strbuf seq_dir = STRBUF_INIT;
>  	struct strbuf seq_old_dir = STRBUF_INIT;
> -
>  	strbuf_addf(&seq_dir, "%s", git_path(SEQ_DIR));

Unrelated change snuck in?

> --- a/sequencer.h
> +++ b/sequencer.h
[...]
> @@ -25,4 +49,7 @@ struct replay_insn_list {
>   */
>  void remove_sequencer_state(int aggressive);
>  
> +void sequencer_parse_args(int argc, const char **argv, struct replay_opts *opts);
> +int sequencer_pick_revisions(struct replay_opts *opts);
> +

I thought sequencer_parse_args() wasn't being exposed.

Except where noted above, I hope this is just simple code movement,
but I haven't checked.  If I could be sure, it would be easier to
review.

Ciao,
Jonathan
