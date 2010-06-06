From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Improve parent blame to detect renames by using the
 previous information
Date: Sun, 6 Jun 2010 18:35:45 -0400
Message-ID: <20100606223545.GA11424@coredump.intra.peff.net>
References: <20100523075503.GA24598@coredump.intra.peff.net>
 <1275767765-8509-1-git-send-email-fonseca@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Mon Jun 07 00:35:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLORc-0001sn-OD
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 00:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491Ab0FFWfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 18:35:48 -0400
Received: from peff.net ([208.65.91.99]:39575 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717Ab0FFWfr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 18:35:47 -0400
Received: (qmail 13922 invoked by uid 107); 6 Jun 2010 22:35:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 06 Jun 2010 18:35:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Jun 2010 18:35:45 -0400
Content-Disposition: inline
In-Reply-To: <1275767765-8509-1-git-send-email-fonseca@diku.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148560>

On Sat, Jun 05, 2010 at 03:56:05PM -0400, Jonas Fonseca wrote:

>  I finally got some more time to dig around this. What if we simply uses
>  the information given by the porcelain output's previous line? It
>  handles your simple test case, and navigating in the tig repository. It
>  also makes it possible to delete a lot of code.

Yes, I think that is the right way to go. The whole time I was doing the
other patches, I kept thinking that we had something like this in the
blame output, but when I looked I couldn't find it (which I can't see
how I would manage now, it's quite obvious to see).

So I think it does the right thing, and I see you also included my fix:

> +	char from[SIZEOF_REF + SIZEOF_STR];
> +	char to[SIZEOF_REF + SIZEOF_STR];
>  	const char *diff_tree_argv[] = {
> -		"git", "diff-tree", "-U0", blame->commit->id,
> -			"--", blame->commit->filename, NULL
> +		"git", "diff", "--no-textconv", "--no-extdiff", "--no-color",
> +			"-U0", from, to, "--", NULL
>  	};
>  	struct io io;
>  	int parent_lineno = -1;
>  	int blamed_lineno = -1;
>  	char *line;
>  
> +	snprintf(from, sizeof(from), "%s:%s", opt_ref, opt_file);
> +	snprintf(to, sizeof(to), "%s:%s", blame->commit->id,
> +		 blame->commit->filename);
> +

to handle the line-jumping properly.

One minor bug:

> @@ -5204,10 +5148,13 @@ blame_request(struct view *view, enum request request, struct line *line)
>  		break;
>  
>  	case REQ_PARENT:
> -		if (check_blame_commit(blame, TRUE) &&
> -		    select_commit_parent(blame->commit->id, opt_ref,
> -					 blame->commit->filename)) {
> -			string_copy(opt_file, blame->commit->filename);
> +		if (!check_blame_commit(blame, TRUE))
> +			break;
> +		if (!*blame->commit->parent_id) {
> +			report("The selected commit has no parents");
> +		} else {
> +			string_copy_rev(opt_ref, blame->commit->parent_id);
> +			string_copy_rev(opt_file, blame->commit->parent_filename);

This second string_copy_rev should be a string_ncopy, shouldn't it?

-Peff
