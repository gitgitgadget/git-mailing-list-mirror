From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/3] git-apply: fix whitespace stripping
Date: Tue, 18 Sep 2007 10:55:25 +0200
Message-ID: <86r6kw4aki.fsf@lola.quinscape.zz>
References: <11899829424040-git-send-email-bfields@citi.umich.edu> <11899829424173-git-send-email-bfields@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 10:55:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXYrz-0001jx-Od
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 10:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbXIRIzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 04:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753518AbXIRIzi
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 04:55:38 -0400
Received: from main.gmane.org ([80.91.229.2]:56740 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753051AbXIRIzh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 04:55:37 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IXYrk-00037o-GY
	for git@vger.kernel.org; Tue, 18 Sep 2007 10:55:33 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 18 Sep 2007 10:55:32 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 18 Sep 2007 10:55:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:5gmVKKW9ByHaATHI8pzqkJQBlEw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58549>

"J. Bruce Fields" <bfields@citi.umich.edu> writes:

> The algorithm isn't right here: it accumulates any set of 8 spaces into
> tabs even if they're separated by tabs, so
>
> 	<four spaces><tab><four spaces><tab>
>
> is converted to
>
> 	<tab><tab><tab>
>
> when it should be just
>
> 	<tab><tab>
>
> So teach git-apply that a tab hides any group of less than 8 previous
> spaces in a row.
>
> Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
> ---
>  builtin-apply.c |   13 ++++++++++---
>  1 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/builtin-apply.c b/builtin-apply.c
> index 976ec77..70359c1 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -1642,15 +1642,22 @@ static int apply_line(char *output, const char *patch, int plen)
>  
>  	buf = output;
>  	if (need_fix_leading_space) {
> +		int consecutive_spaces = 0;
>  		/* between patch[1..last_tab_in_indent] strip the
>  		 * funny spaces, updating them to tab as needed.
>  		 */
>  		for (i = 1; i < last_tab_in_indent; i++, plen--) {
>  			char ch = patch[i];
> -			if (ch != ' ')
> +			if (ch != ' ') {
> +				consecutive_spaces = 0;
>  				*output++ = ch;
> -			else if ((i % 8) == 0)
> -				*output++ = '\t';
> +			} else {
> +				consecutive_spaces++;
> +				if (consecutive_spaces == 8) {
> +					*output++ = '\t';
> +					consecutive_spaces = 0;
> +				}
> +			}
>  		}
>  		fixed = 1;
>  		i = last_tab_in_indent;
> -- 
> 1.5.3.1.42.gfe5df

As far as I can see, this does not really work since it does not
maintain an idea of a current column.

If you have

abcd<four spaces><tab><four spaces><tab>

then indeed the resulting conversion needs to be <tab><tab><tab>
whereas with

abc<four spaces><tab><four spaces><tab>

the resulting conversion needs to be just <tab><tab>


-- 
David Kastrup
