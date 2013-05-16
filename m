From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] branch: add show-tracking option
Date: Thu, 16 May 2013 10:00:31 +0200
Message-ID: <5194921F.4080103@drmicha.warpmail.net>
References: <1368690532-12093-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 10:00:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uct6y-0004Iq-Jb
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 10:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906Ab3EPIAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 04:00:24 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53295 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755726Ab3EPIAX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 May 2013 04:00:23 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7C4DB2056E;
	Thu, 16 May 2013 04:00:22 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute6.internal (MEProxy); Thu, 16 May 2013 04:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=AqhITgZKaPwhRL7GhfCUYc
	4QR4c=; b=Mf1UYYwArKExY8mR6f7mRepG1vqJ+vU1CWnDgbVgQeV9acQJtgMiMx
	ctmEGNFsvpiK53O4FgIKAB4SeoounWGa3uYbO2OtvF4FKxCNT+Ive3g8ySv54p8j
	ppmsu0wY5XMolWo7Y7kvmaz3Mb7OkOGO6W9MfGmRHvuvzIrF0a8Lg=
X-Sasl-enc: kSt0poKNGNf3o8lMdIC2Flu/y+8h3vOU+KKSC9Z/cEIy 1368691222
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id B9D93C80004;
	Thu, 16 May 2013 04:00:21 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130402 Thunderbird/17.0.5
In-Reply-To: <1368690532-12093-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224493>

Felipe Contreras venit, vidit, dixit 16.05.2013 09:48:
> Showing the tracking information for all the branches takes significant
> amount of time. The user might not want that. The --no-show-tracking
> option allows that.

I really like the idea of allowing that - not just because I've
suggested so myself in the past ;)

I feel, though, that we're really exploding our option and config realm.
For "git branch" in list mode, we are already able to stack "-v", i.e.
"-v" and "-vv" do different things. How about maybe adding "-vvv" and
arranging things so that the verbosity and the run time increases with
the number of v's?

-v list with sha1 + subject of last commit
-vv add upstream branch name
-vvv add ahead/behind info (the only costly mode)
-vvvv same with "--cherry" (ahead/behind/same)

Or maybe combine the middle two cases into "-vv", which means it would
be the same as "-vv", with only "-v" changing what it does now.

Yes, this changes current behavior (at least fpr -v), which sucks
anyways because of the costly lookup. And those scripting around "branch
-v" should get what they deserve. (I may sound annoyed by our
compatibility brakes, but here's a case where breaking it should be OK.)

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/git-branch.txt | 5 ++++-
>  builtin/branch.c             | 4 +++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index b7cb625..1db04cd 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -9,7 +9,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git branch' [--color[=<when>] | --no-color] [-r | -a]
> -	[--list] [-v [--abbrev=<length> | --no-abbrev]]
> +	[--list] [-v [--abbrev=<length> | --no-abbrev] --show-tracking]
>  	[--column[=<options>] | --no-column]
>  	[(--merged | --no-merged | --contains) [<commit>]] [<pattern>...]
>  'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
> @@ -154,6 +154,9 @@ This option is only applicable in non-verbose mode.
>  --no-abbrev::
>  	Display the full sha1s in the output listing rather than abbreviating them.
>  
> +--show-tracking::
> +	Display the tracking information when using --verbose, or not.
> +
>  -t::
>  --track::
>  	When creating a new branch, set up configuration to mark the
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 0836890..2b586ea 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -33,6 +33,7 @@ static const char * const builtin_branch_usage[] = {
>  
>  static const char *head;
>  static unsigned char head_sha1[20];
> +static int show_tracking = 1;
>  
>  static int branch_use_color = -1;
>  static char branch_colors[][COLOR_MAXLEN] = {
> @@ -424,7 +425,7 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
>  	struct branch *branch = branch_get(branch_name);
>  	struct strbuf fancy = STRBUF_INIT;
>  
> -	if (!stat_tracking_info(branch, &ours, &theirs)) {
> +	if (!(show_tracking && stat_tracking_info(branch, &ours, &theirs))) {
>  		if (branch && branch->merge && branch->merge[0]->dst &&
>  		    show_upstream_ref) {
>  			ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
> @@ -840,6 +841,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  			opt_parse_merge_filter, (intptr_t) "HEAD",
>  		},
>  		OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
> +		OPT_BOOL(0, "show-tracking", &show_tracking, N_("show tracking information")),
>  		OPT_END(),
>  	};
>  
> 
