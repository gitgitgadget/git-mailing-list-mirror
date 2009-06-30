From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove filename from conflict markers
Date: Tue, 30 Jun 2009 15:16:33 -0700
Message-ID: <7v63ed5pvi.fsf@alter.siamese.dyndns.org>
References: <20090628154559.GA29049@old.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Renold <martinxyz@gmx.ch>
X-From: git-owner@vger.kernel.org Wed Jul 01 00:16:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLld5-0008NG-9B
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 00:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894AbZF3WQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 18:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753612AbZF3WQc
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 18:16:32 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:57643 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbZF3WQb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 18:16:31 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090630221634.ZXMP20976.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 30 Jun 2009 18:16:34 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id ANGa1c0024aMwMQ04NGag4; Tue, 30 Jun 2009 18:16:34 -0400
X-VR-Score: 0.00
X-Authority-Analysis: v=1.0 c=1 a=SBpeI9OMwxYA:10 a=hn5kwi6epu-m7hh0uaMA:9
 a=cyCqm1TV5g2sl8A2HGPgmFMaLwsA:4
X-CM-Score: 0.00
In-Reply-To: <20090628154559.GA29049@old.homeip.net> (Martin Renold's message of "Sun\, 28 Jun 2009 17\:45\:59 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122547>

Martin Renold <martinxyz@gmx.ch> writes:

> Put filenames into the conflict markers only when they are different.
> Otherwise they are redundant information clutter.
>
> Signed-off-by: Martin Renold <martinxyz@gmx.ch>
> ---
>  merge-recursive.c             |    9 +++++++--
>  t/t3404-rebase-interactive.sh |    4 ++--

The change seems to break more tests than just 3404.

I also wondered briefly if it will break people's existing scripts;
I suspect it will not likely to be a huge problem.

>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index c703445..53cad96 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -622,8 +622,13 @@ static int merge_3way(struct merge_options *o,
>  	char *name1, *name2;
>  	int merge_status;
>  
> -	name1 = xstrdup(mkpath("%s:%s", branch1, a->path));
> -	name2 = xstrdup(mkpath("%s:%s", branch2, b->path));
> +	if (strcmp(a->path, b->path)) {
> +		name1 = xstrdup(mkpath("%s:%s", branch1, a->path));
> +		name2 = xstrdup(mkpath("%s:%s", branch2, b->path));
> +	} else {
> +		name1 = xstrdup(mkpath("%s", branch1));
> +		name2 = xstrdup(mkpath("%s", branch2));
> +	}
>  
>  	fill_mm(one->sha1, &orig);
>  	fill_mm(a->sha1, &src1);
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index c32ff66..a973628 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -119,11 +119,11 @@ index e69de29..00750ed 100644
>  EOF
>  
>  cat > expect2 << EOF
> -<<<<<<< HEAD:file1
> +<<<<<<< HEAD
>  2
>  =======
>  3
> ->>>>>>> b7ca976... G:file1
> +>>>>>>> b7ca976... G
>  EOF
>  
>  test_expect_success 'stop on conflicting pick' '
> -- 
> 1.6.3.1
