X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Improve git-prune -n output
Date: Thu, 26 Oct 2006 10:21:54 -0700
Message-ID: <7vlkn3kn65.fsf@assigned-by-dhcp.cox.net>
References: <200610261138.24761.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 17:22:07 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30243>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd8vZ-00030M-TA for gcvg-git@gmane.org; Thu, 26 Oct
 2006 19:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423626AbWJZRV4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 13:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423629AbWJZRV4
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 13:21:56 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:60616 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1423626AbWJZRVz
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 13:21:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061026172155.CQBG12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>; Thu, 26
 Oct 2006 13:21:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id f5Md1V00R1kojtg0000000 Thu, 26 Oct 2006
 13:21:37 -0400
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> prune_object() in show_only mode would previously just show the path to the
> object that would be deleted.  The path the object is stored in shouldn't be
> shown to users, they only know about sha1 identifiers so show that instead.

I do not have an objection to what this does, except I wonder if
somebody's script relies on parsing this output already.

> Further, the sha1 alone isn't that useful for examining what is going to be
> deleted.  This patch also adds the object type to the output, which makes it
> easy to pick out, say, the commits and use git-show to display them.
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>

It is customary to have one empty line before the S-o-b: line.

> ---
>  builtin-prune.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/builtin-prune.c b/builtin-prune.c
> index 7290e6d..e3bcf5f 100644
> --- a/builtin-prune.c
> +++ b/builtin-prune.c
> @@ -16,8 +16,13 @@ static struct rev_info revs;
>  
>  static int prune_object(char *path, const char *filename, const unsigned char *sha1)
>  {
> +	char type[20];
> +
>  	if (show_only) {
> -		printf("would prune %s/%s\n", path, filename);
> +		if (sha1_object_info(sha1, type, NULL)) {
> +			strcpy( type, "unknown type" );
> +		}
> +		printf("would prune %s %s\n", sha1_to_hex( sha1 ), type );

Style.

 - We do not leave blank inside () pairs.
 - We do not enclose a single statement in {}.

Perhaps an extra variable of type "char *" that initially point
at type[] but later points at the "unknown" might be more
efficient, but that being on the error path I do not think
saving one strcpy() that way is worth it.

So, just the style and a slight worry that this _might_ break
people's scripts.

Objections?
