From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v6 08/13] notes: implement helpers needed for note copying
 during rewrite
Date: Thu, 11 Mar 2010 11:50:58 +0100
Message-ID: <201003111150.58740.johan@herland.net>
References: <cover.1268229087.git.trast@student.ethz.ch>
 <cf0765f47b3a97061997125d4440a475cda03e22.1268229087.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 11 11:51:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npfyx-0004L7-5B
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 11:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756911Ab0CKKvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 05:51:06 -0500
Received: from smtp.getmail.no ([84.208.15.66]:32827 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756670Ab0CKKvE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 05:51:04 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KZ400GH0651RU20@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 11 Mar 2010 11:51:01 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KZ400F3464ZA940@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 11 Mar 2010 11:51:01 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.3.11.103635
User-Agent: KMail/1.13.1 (Linux/2.6.32-ARCH; KDE/4.4.1; x86_64; ; )
In-reply-to: <cf0765f47b3a97061997125d4440a475cda03e22.1268229087.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141949>

On Wednesday 10 March 2010, Thomas Rast wrote:
> Implement helper functions to load the rewriting config, and to
> actually copy the notes.  Also document the config.
> 
> Secondly, also implement an undocumented --for-rewrite=<cmd> option to
> 'git notes copy' which is used like --stdin, but also puts the
> configuration for <cmd> into effect.  It will be needed to support the
> copying in git-rebase.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>

Acked-by: Johan Herland <johan@herland.net>

[...]

> diff --git a/builtin/notes.c b/builtin/notes.c
> index 576a989..6c2297a 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c

[...]

> +struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd)
> +{
> +	struct notes_rewrite_cfg *c = xmalloc(sizeof(struct
> notes_rewrite_cfg)); +	const char *rewrite_mode_env =
> getenv(GIT_NOTES_REWRITE_MODE_ENVIRONMENT); +	const char
> *rewrite_refs_env = getenv(GIT_NOTES_REWRITE_REF_ENVIRONMENT); +	c->cmd
> = cmd;
> +	c->enabled = 1;
> +	c->combine = combine_notes_concatenate;
> +	c->refs = xcalloc(1, sizeof(struct string_list));
> +	c->refs->strdup_strings = 1;
> +	c->refs_from_env = 0;
> +	c->mode_from_env = 0;
> +	if (rewrite_mode_env) {
> +		c->mode_from_env = 1;
> +		c->combine = parse_combine_notes_fn(rewrite_mode_env);
> +		if (!c->combine)
> +			error("Bad " GIT_NOTES_REWRITE_MODE_ENVIRONMENT
> +			      " value: '%s'", rewrite_mode_env);
> +	}
> +	if (rewrite_refs_env) {
> +		c->refs_from_env = 1;
> +		string_list_add_refs_from_colon_sep(c->refs, rewrite_refs_env);
> +	}
> +	git_config(notes_rewrite_config, c);
> +	if (!c->enabled || !c->refs->nr) {
> +		string_list_clear(c->refs, 0);
> +		free(c->refs);
> +		free(c);
> +		return NULL;
> +	}
> +	c->trees = load_notes_trees(c->refs);

Ah, this invalidates some of my comments to PATCH 02/13. Please disregard 
those comments.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
