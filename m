From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] remote show: fix the -n option
Date: Mon, 9 Jun 2008 02:16:52 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806090212270.1783@racer>
References: <484B2DD3.8050307@free.fr> <1212927772-10006-1-git-send-email-dkr+ml.git@free.fr> <7v63sjk6yo.fsf@gitster.siamese.dyndns.org> <484C7CBE.4070700@free.fr> <484C7DCC.6080303@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Mon Jun 09 03:19:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5W2P-0000s0-Qp
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 03:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725AbYFIBSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 21:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754350AbYFIBSQ
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 21:18:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:54959 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752771AbYFIBSP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 21:18:15 -0400
Received: (qmail invoked by alias); 09 Jun 2008 01:18:13 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp037) with SMTP; 09 Jun 2008 03:18:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+rwr8seH6rUmUKMlbj20b/kzzlsMwPVeSvvBtjei
	EJHu4tAUEQGdTE
X-X-Sender: gene099@racer
In-Reply-To: <484C7DCC.6080303@free.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84356>

Hi,

On Mon, 9 Jun 2008, Olivier Marin wrote:

> The perl version accepted a -n flag, to show local informations only 
> without querying remote heads, that seems to have been lost in the C 
> rewrite.

Would have been nice to Cc: the author of the C rewrite.

> diff --git a/builtin-remote.c b/builtin-remote.c
> index c49f00f..cb9e282 100644
> --- a/builtin-remote.c
> +++ b/builtin-remote.c
> @@ -421,10 +421,10 @@ static void show_list(const char *title, struct path_list *list)
>  
>  static int show_or_prune(int argc, const char **argv, int prune)
>  {
> -	int dry_run = 0, result = 0;
> +	int no_query = 0, result = 0;

Why?

>  	struct option options[] = {
>  		OPT_GROUP("show specific options"),
> -		OPT__DRY_RUN(&dry_run),
> +		OPT_BOOLEAN('n', NULL, &no_query, "do not query remotes"),

Why?


> +			transport = transport_get(NULL, states.remote->url_nr > 0 ?

Please rewrap.

> @@ -486,17 +490,17 @@ static int show_or_prune(int argc, const char **argv, int prune)
>  			printf("\n");
>  		}
>  
> -		if (got_states)
> -			continue;
> -		strbuf_init(&buf, 0);
> -		strbuf_addf(&buf, "  New remote branch%%s (next fetch will "
> -			"store in remotes/%s)", states.remote->name);
> -		show_list(buf.buf, &states.new);
> -		strbuf_release(&buf);
> -		show_list("  Stale tracking branch%s (use 'git remote prune')",
> -				&states.stale);
> -		show_list("  Tracked remote branch%s",
> -				&states.tracked);
> +		if (!got_states) {
> +			strbuf_init(&buf, 0);
> +			strbuf_addf(&buf, "  New remote branch%%s (next fetch will "
> +				"store in remotes/%s)", states.remote->name);
> +			show_list(buf.buf, &states.new);
> +			strbuf_release(&buf);
> +			show_list("  Stale tracking branch%s (use 'git remote prune')",
> +					&states.stale);
> +			show_list("  Tracked remote branch%s",
> +					&states.tracked);
> +		}
>  
>  		if (states.remote->push_refspec_nr) {
>  			printf("  Local branch%s pushed with 'git push'\n   ",

Maybe we need two different values of got_states; not calling ls-remote 
and then showing things is okay, but calling ls-remote, getting an error 
and _then_ showing stuff is not okay, IMO.

Thanks,
Dscho
