From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce get_octopus_merge_bases() in commit.c
Date: Mon, 9 Jun 2008 15:02:07 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806091458190.1783@racer>
References: <1212874720-22324-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Jun 09 16:05:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5hyx-00067V-GE
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 16:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbYFIOD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 10:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752227AbYFIOD3
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 10:03:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:40472 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751958AbYFIOD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 10:03:28 -0400
Received: (qmail invoked by alias); 09 Jun 2008 14:03:26 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp067) with SMTP; 09 Jun 2008 16:03:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19UvTEZZahU6XLfZ7xzRuY7mTAal5oE7tb2S3Ihel
	F+TQNCUik0s3Wn
X-X-Sender: gene099@racer
In-Reply-To: <1212874720-22324-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84383>

Hi,

On Sat, 7 Jun 2008, Miklos Vajna wrote:

> diff --git a/commit.c b/commit.c
> index 1dba717..685a144 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -618,6 +618,23 @@ static struct commit_list *merge_bases(struct commit *one, struct commit *two)
>  	return merge_bases_many(one, 1, &two);
>  }
>  
> +struct commit_list *get_octopus_merge_bases(struct commit_list *in, int cleanup)
> +{
> +	struct commit *head = in->item;
> +	int n = 0;
> +	struct commit **commits = xmalloc(n*sizeof(struct commit *));

Here, n will be 0 and therefore commits will be xmalloc(0), right?

> +	struct commit_list *ret, *i;
> +
> +	for(i = in; i; i = i->next, n++)
> +		commits[n] = i->item;

And here, commits will never be realloc()ed.

> +	ret = merge_bases_many(head, n, commits);

If merge_bases_many took a commit_list (yes, as I suggested to Junio), 
this transformation would not be necessary.

IIRC nothing in merge_bases_many() needed a commit array.

Oh, and whose responsibility is it to free "in"?  Caller or callee?  
(Because it is a non-const parameter, I would have expected the callee, 
but I think it makes more sense if the caller can do whatever she wants 
with the heads after calling octopus_merge_bases()).

Ciao,
Dscho
