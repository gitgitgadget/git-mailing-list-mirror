From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] Split out merge_recursive() to merge-recursive.c
Date: Tue, 12 Aug 2008 19:56:29 +0200
Message-ID: <20080812175629.GA28014@leksak.fem-net>
References: <7v7ianuo8q.fsf@gitster.siamese.dyndns.org> <1218559514-16890-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Aug 12 19:57:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSy7k-00078Q-Nv
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 19:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbYHLR4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 13:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbYHLR4e
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 13:56:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:49786 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751267AbYHLR4d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 13:56:33 -0400
Received: (qmail invoked by alias); 12 Aug 2008 17:56:31 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp023) with SMTP; 12 Aug 2008 19:56:31 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19egCZQOmReUBCxca+ikNoh0rxWjeKoPnuTZxSKLB
	gE4ltwKxbg/YXk
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KSy6f-0001fg-Do; Tue, 12 Aug 2008 19:56:29 +0200
Content-Disposition: inline
In-Reply-To: <1218559514-16890-1-git-send-email-vmiklos@frugalware.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92122>

Hi,

Miklos Vajna wrote:
> Move most of the of code from builtin-merge-recursive.c to a new file
> merge-recursive.c and introduce merge_recursive_setup() in there so that
> builtin-merge-recursive and other builtins call it.

So, according to that change my "revert" patch is the same plus this
interdiff:

--8<--
diff --git a/builtin-revert.c b/builtin-revert.c
index dcee181..941b875 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -281,7 +281,8 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	const char *message, *encoding;
 	const char *defmsg = xstrdup(git_path("MERGE_MSG"));
 
-	git_config(git_default_config, NULL);
+	git_config(merge_recursive_config, NULL);
+	merge_recursive_setup(0);
 	me = action == REVERT ? "revert" : "cherry-pick";
 	setenv(GIT_REFLOG_ACTION, me, 0);
 	parse_args(argc, argv);
-->8--

I'm fine with that, but my hope(?) was that we could have some more
generic function that takes SHAs ("unsigned char *") instead of commits.
I don't know if this is bad for builtin-merge, but from the "revert" and
"sequencer" point of view this is all I need.

Hmm, I think it takes less time to implement it based on your patch than
explaining :-)

One further comment:
> -static int merge_config(const char *var, const char *value, void *cb)
> +int merge_recursive_config(const char *var, const char *value, void *cb)
>  {
>  	if (!strcasecmp(var, "merge.verbosity")) {
> -		verbosity = git_config_int(var, value);
> +		merge_recursive_verbosity = git_config_int(var, value);
[...]
> diff --git a/merge-recursive.h b/merge-recursive.h
> index f37630a..73e4413 100644
> --- a/merge-recursive.h
> +++ b/merge-recursive.h
> @@ -14,7 +14,11 @@ int merge_trees(struct tree *head,
>  		const char *branch1,
>  		const char *branch2,
>  		struct tree **result);
> -
> +struct commit *make_virtual_commit(struct tree *tree, const char *comment);
> +int merge_recursive_config(const char *var, const char *value, void *cb);
> +void merge_recursive_setup(int is_subtree_merge);
>  struct tree *write_tree_from_memory(void);
>  

> +extern int merge_recursive_verbosity;

Why this?

So we have:
 1. "merge.verbosity" config value
 2. GIT_MERGE_VERBOSITY environment
 3. merge_recursive_verbosity variable

I wonder if 3 is really necessary.

Kind regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
