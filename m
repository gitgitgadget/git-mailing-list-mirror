From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: diffcore-rename performance mode
Date: Tue, 18 Sep 2007 15:12:48 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0709181510460.16478@woody.linux-foundation.org>
References: <20070918082321.GA9883@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 19 00:13:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXlJw-0008CX-AB
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 00:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674AbXIRWNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 18:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752919AbXIRWNW
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 18:13:22 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51659 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751435AbXIRWNV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Sep 2007 18:13:21 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8IMCaJn021254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Sep 2007 15:12:37 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8IMCYkj025862;
	Tue, 18 Sep 2007 15:12:34 -0700
In-Reply-To: <20070918082321.GA9883@coredump.intra.peff.net>
X-Spam-Status: No, hits=-2.742 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.35__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58637>



On Tue, 18 Sep 2007, Jeff King wrote:
> 
> With this patch:
> 
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index 6bde439..531a844 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -362,10 +362,7 @@ void diffcore_rename(struct diff_options *options)
>  			m->score = estimate_similarity(one, two,
>  						       minimum_score);
>  			m->name_score = basename_same(one, two);
> -			diff_free_filespec_data(one);
>  		}
> -		/* We do not need the text anymore */
> -		diff_free_filespec_data(two);
>  		dst_cnt++;
>  	}
>  	/* cost matrix sorted by most to least similar pair */
> 
> My 20-minute diff becomes a 2-minute diff.

I think this is a reasonable patch, but only now *after* we limit the 
rename matrix.

The whole reason for freeing the filespec data was to avoid exploding the 
memory usage, but now that we aggressively limit the number of renames in 
flight anyway, I think we can probably remove the code that frees the file 
data in between all the rename similarity analysis.

			Linus
