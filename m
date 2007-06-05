From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] git-merge-file: refuse to merge binary files
Date: Mon, 04 Jun 2007 22:16:53 -0700
Message-ID: <7vr6orgeuy.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706050337010.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 05 07:17:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvRPi-0000gm-3Y
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 07:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754612AbXFEFQ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 01:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755205AbXFEFQ4
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 01:16:56 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:46676 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612AbXFEFQz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 01:16:55 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070605051656.PSDC7825.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 5 Jun 2007 01:16:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7hGu1X00B1kojtg0000000; Tue, 05 Jun 2007 01:16:54 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49162>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin-merge-file.c  |    6 +++++-
>  t/t6023-merge-file.sh |    5 +++++
>  2 files changed, 10 insertions(+), 1 deletions(-)
>
> diff --git a/builtin-merge-file.c b/builtin-merge-file.c
> index 9135773..10ec63b 100644
> --- a/builtin-merge-file.c
> +++ b/builtin-merge-file.c
> @@ -36,9 +36,13 @@ int cmd_merge_file(int argc, char **argv, char **envp)
>  	for (; i < 3; i++)
>  		names[i] = argv[i + 1];
>  
> -	for (i = 0; i < 3; i++)
> +	for (i = 0; i < 3; i++) {
>  		if (read_mmfile(mmfs + i, argv[i + 1]))
>  			return -1;
> +		if (buffer_is_binary(mmfs[i].ptr, mmfs[i].size))
> +			return error("Cannot merge binary files: %s\n",
> +					argv[i + 1]);
> +	}
>  
>  	ret = xdl_merge(mmfs + 1, mmfs + 0, names[0], mmfs + 2, names[2],
>  			&xpp, XDL_MERGE_ZEALOUS, &result);

Oh, my.

I wonder if we can expose ll_merge() from merge-recursive to
this part, instead of raw xdl_merge().  That would give you the
custom merge driver the user may have specified in
.gitattributes.
