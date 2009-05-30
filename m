From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/2] add new output-tuning flags to 'git cherry'
Date: Sat, 30 May 2009 14:18:23 +0200
Message-ID: <4A21240F.8090902@drmicha.warpmail.net>
References: <1243647555-25098-1-git-send-email-user@lamp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff Epler <jepler@unpythonic.net>
To: Jeff Epler <unpythonic.net@unpythonic.net>
X-From: git-owner@vger.kernel.org Sat May 30 14:18:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MANWD-0006GP-Cu
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 14:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757327AbZE3MSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 08:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756703AbZE3MSX
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 08:18:23 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:46060 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751325AbZE3MSX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 May 2009 08:18:23 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 0A804347A06;
	Sat, 30 May 2009 08:18:24 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Sat, 30 May 2009 08:18:24 -0400
X-Sasl-enc: TValcM+eDkFK2tVi5N/Xa/VYb+uh8HZXFaNPCNS/SqWF 1243685903
Received: from localhost.localdomain (p54859D99.dip0.t-ipconnect.de [84.133.157.153])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D34A338FB0;
	Sat, 30 May 2009 08:18:22 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090525 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <1243647555-25098-1-git-send-email-user@lamp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120349>

Jeff Epler venit, vidit, dixit 30.05.2009 03:39:
> From: Jeff Epler <jepler@unpythonic.net>

git cherry certainly could use a few enhancements. About the proposed
ones, I'm a bit doubtful, besides the issue of unusual option names
which Jakub mentioned:

> 
> The new flags are:
>     -a or -##: abbreviate SHA1s to 7 or ## places
>     -r: reverse 'upstream' and 'head' (useful when on 'head' and wanting to
>         pick from 'upstream')

What's wrong with using "git cherry HEAD upstream" in that case?

>     -d: only show "+" (doesn't have) patches
>     -D: only show "-" (does have) patches

Those are a matter of "git cherry <options> | egrep '^\+' etc.

So I don't think the patch adds new functionality. If anything I would
probably suggest having --abbrev and leaving the others out.

Useful new functionality would be:
- Display the upstream commit name which has the same patch id.
- Deal differently with a limit which is a predecessor of the merge-base.

> 
> Signed-off-by: Jeff Epler <jepler@unpythonic.net>
> ---
>  builtin-log.c |   54 ++++++++++++++++++++++++++++++++++++++++++++----------
>  1 files changed, 44 insertions(+), 10 deletions(-)
> 
> diff --git a/builtin-log.c b/builtin-log.c
> index f10cfeb..420f39e 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -1130,7 +1130,7 @@ static int add_pending_commit(const char *arg, struct rev_info *revs, int flags)
>  }
>  
>  static const char cherry_usage[] =
> -"git cherry [-v] [<upstream> [<head> [<limit>]]]";
> +"git cherry [-v] [-a|-#] [-r] [-d|-D] [<upstream> [<head> [<limit>]]]";
>  int cmd_cherry(int argc, const char **argv, const char *prefix)
>  {
>  	struct rev_info revs;
> @@ -1142,9 +1142,29 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
>  	const char *head = "HEAD";
>  	const char *limit = NULL;
>  	int verbose = 0;
> +	int reverse = 0;
> +	int abbrev = 40;
> +	int show_has = 0;
> +	int show_hasnt = 0;
> +
> +	while(argc > 1 && argv[1][0] == '-')
> +	{
> +		if (!strcmp(argv[1], "-v")) {
> +			verbose = 1;
> +		} else if(!strcmp(argv[1], "-a")) {
> +			abbrev = DEFAULT_ABBREV;
> +		} else if(isdigit(argv[1][1])) {
> +			abbrev = atoi(argv+1);
> +		} else if(!strcmp(argv[1], "-r")) {
> +			reverse = 1;
> +		} else if(!strcmp(argv[1], "-d")) {
> +			show_hasnt = 1;
> +		} else if(!strcmp(argv[1], "-D")) {
> +			show_has = 1;
> +		} else {
> +			die("unrecognized argument: %s", argv[1]);
> +		}
>  
> -	if (argc > 1 && !strcmp(argv[1], "-v")) {
> -		verbose = 1;
>  		argc--;
>  		argv++;
>  	}
> @@ -1173,6 +1193,16 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
>  		upstream = current_branch->merge[0]->dst;
>  	}
>  
> +	if(reverse) {
> +		const char *temp = upstream;
> +		upstream = head;
> +		head = temp;
> +	}
> +
> +	if(!show_has && !show_hasnt) {
> +		show_has = show_hasnt = 1;
> +	}
> +
>  	init_revisions(&revs, prefix);
>  	revs.diff = 1;
>  	revs.combine_merges = 0;
> @@ -1207,27 +1237,31 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
>  		commit_list_insert(commit, &list);
>  	}
>  
> -	while (list) {
> +	for (; list; list=list->next) {
>  		char sign = '+';
> +		int has;
>  
>  		commit = list->item;
> -		if (has_commit_patch_id(commit, &ids))
> +
> +		if ((has = has_commit_patch_id(commit, &ids))) {
>  			sign = '-';
> +			if(!show_has) continue;
> +		} else {
> +			if(!show_hasnt) continue;
> +		}
>  
>  		if (verbose) {
>  			struct strbuf buf = STRBUF_INIT;
>  			pretty_print_commit(CMIT_FMT_ONELINE, commit,
> -			                    &buf, 0, NULL, NULL, 0, 0);
> -			printf("%c %s %s\n", sign,
> +					    &buf, 0, NULL, NULL, 0, 0);
> +			printf("%c %.*s %s\n", sign, abbrev,
>  			       sha1_to_hex(commit->object.sha1), buf.buf);
>  			strbuf_release(&buf);
>  		}
>  		else {
> -			printf("%c %s\n", sign,
> +			printf("%c %.*s\n", sign, abbrev,
>  			       sha1_to_hex(commit->object.sha1));
>  		}
> -
> -		list = list->next;
>  	}
>  
>  	free_patch_ids(&ids);
