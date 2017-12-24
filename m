Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 398DB1F424
	for <e@80x24.org>; Sun, 24 Dec 2017 17:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751169AbdLXRLU (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 12:11:20 -0500
Received: from ikke.info ([178.21.113.177]:39576 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750877AbdLXRLU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 12:11:20 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 1470A44079B; Sun, 24 Dec 2017 18:11:18 +0100 (CET)
Date:   Sun, 24 Dec 2017 18:11:18 +0100
From:   Kevin Daudt <me@ikke.info>
To:     Vadim Petrov <tridronet@yandex.ru>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] setup.c: move statement under condition
Message-ID: <20171224171118.GD27280@alpha.vpn.ikke.info>
References: <3853941514059379@web42g.yandex.ru>
 <alpine.DEB.2.21.1.1712232332000.406@MININT-6BKU6QN.europe.corp.microsoft.com>
 <1483761514103335@web45o.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1483761514103335@web45o.yandex.ru>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 24, 2017 at 12:15:35PM +0400, Vadim Petrov wrote:
> Thank you for your replay.
> 
> > I have to be honest: this commit message (including the subject) left me
> > quite puzzled as to the intent of this patch.
> 
> I still only learn English and correctly express my thoughts while somewhat difficult.
> 
> > If you also have a background story that motivated you to work on this
> > patch (for example, if you hit a huge performance bottleneck with some
> > tool that fed thousands of absolute paths to Git that needed to be turned
> > into paths relative to the worktree's top-level directory), I would
> > definitely put that into the commit message, too, if I were you.
> 
> I have no such reason. I just saw it and wanted to change it.

A commit message contains the reason why this is a good change to make.
It lets others know what problems it's trying to solve or what usecase
it tries to satisfy.

The commit message basically needs to convince others why the change is
necessary / desired, now, and in the future. 

This will help others to follow your thought process and it gives you
the possiblity to communicate trade-offs you made, all which cannot
inferred from the patch.

For simple changes, the motivation can be simple too.

To make it concrete: You are talking about a condition. What condition?
And you say that the previously obtained value will not be necessary.
What do you do with that value then? Why does this change improve the
situation? 

These are things you can state in your commit message.

Hope this helps, Kevin

> > Up until recently, we encouraged dropping the curly brackets from
> > single-line statements, but apparently that changed. It is now no longer
> > clear, and often left to the taste of the contributor. But not always.
> > Sometimes we start a beautiful thread discussion the pros and cons of
> > curly brackets in the middle of patch review, and drop altogether
> > reviewing the actual patch.
> 
> I was guided by the rule from the Documentation/CodingGuidelines:
> 	When there are multiple arms to a conditional and some of them
> 	require braces, enclose even a single line block in braces for
> 	consistency.
> And other code from setup.c:
> 	from function get_common_dir:
> 		if (!has_common) {
> 			/* several commands */
> 		} else {
> 			free(candidate->work_tree);
> 		}
> 	from function get_common_dir_noenv:
> 		if (file_exists(path.buf)) {
> 			/* several commands */
> 		} else {
> 			strbuf_addstr(sb, gitdir);
> 		}
> 
> > In short: I think your patch does the right thing, and I hope that you
> > find my suggestions to improve the patch useful.
> 
> I fixed the patch according to your suggestions.
> 
> 
> Signed-off-by: Vadim Petrov <tridronet@yandex.ru>
> ---
>  setup.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/setup.c b/setup.c
> index 8cc34186c..1a414c256 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -27,26 +27,26 @@ static int abspath_part_inside_repo(char *path)
>  {
>  	size_t len;
>  	size_t wtlen;
>  	char *path0;
>  	int off;
>  	const char *work_tree = get_git_work_tree();
>  
>  	if (!work_tree)
>  		return -1;
>  	wtlen = strlen(work_tree);
>  	len = strlen(path);
> -	off = offset_1st_component(path);
>  
> -	/* check if work tree is already the prefix */
> -	if (wtlen <= len && !strncmp(path, work_tree, wtlen)) {
> +	if (wtlen > len || strncmp(path, work_tree, wtlen))
> +		off = offset_1st_component(path);
> +	else { /* check if work tree is already the prefix */
>  		if (path[wtlen] == '/') {
>  			memmove(path, path + wtlen + 1, len - wtlen);
>  			return 0;
>  		} else if (path[wtlen - 1] == '/' || path[wtlen] == '\0') {
>  			/* work tree is the root, or the whole path */
>  			memmove(path, path + wtlen, len - wtlen + 1);
>  			return 0;
>  		}
>  		/* work tree might match beginning of a symlink to work tree */
>  		off = wtlen;
>  	}
> -- 
> 2.15.1.433.g936d1b989
