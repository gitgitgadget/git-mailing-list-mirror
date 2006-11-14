X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/5] allow cloning a repository "shallowly"
Date: Mon, 13 Nov 2006 23:24:46 -0800
Message-ID: <7v4pt21oe9.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0610302009160.26682@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 14 Nov 2006 07:25:00 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31337>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gjsf8-0001bF-ND for gcvg-git@gmane.org; Tue, 14 Nov
 2006 08:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933139AbWKNHYs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 02:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933239AbWKNHYs
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 02:24:48 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:42139 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S933139AbWKNHYs
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 02:24:48 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061114072447.VFYR4817.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Tue, 14
 Nov 2006 02:24:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id mXQt1V00S1kojtg0000000; Tue, 14 Nov 2006
 02:24:53 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> By specifying a depth, you can now clone a repository such that
> all fetched ancestor-chains' length is at most "depth". For example,
> if the upstream repository has only 2 branches ("A" and "B"), which
> are linear, and you specify depth 3, you will get A, A~1, A~2, A~3,
> B, B~1, B~2, and B~3. The ends are automatically made shallow
> commits.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  fetch-pack.c  |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  git-clone.sh  |   19 +++++++++++++++--
>  upload-pack.c |   21 ++++++++++++++++++-
>  3 files changed, 96 insertions(+), 5 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 488adc9..9619d6e 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
>...
> +		while ((len = packet_read_line(fd[0], line, sizeof(line)))) {
> +			if (!strncmp("shallow ", line, 8)) {
> +				if (get_sha1_hex(line + 8, sha1))
> +					die("invalid shallow line: %s", line);
> +				/* no need making it shallow if we have it already */
> +				if (lookup_object(sha1))
> +					continue;
> +				register_shallow(sha1);
> +			}
> +		}
> +	}

I understand "no need making it shallow", but I am not sure if a
non-NULL return from lookup_object() tells us that.

Before this part of the code, we have scanned the local refs in
everything_local (which parses their refs).

I think register_shallow() can take commits that are already
shallow() so maybe we can remove this "if() continue"?
