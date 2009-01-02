From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] unpack-trees: fix path search bug in verify_absent
Date: Fri, 2 Jan 2009 22:59:47 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901022248070.27818@racer>
References: <1230843273-11056-1-git-send-email-drizzd@aon.at> <1230843273-11056-2-git-send-email-drizzd@aon.at> <1230843273-11056-3-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Jan 02 23:00:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIs4V-00083y-Gi
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 23:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758831AbZABV7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 16:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758735AbZABV7W
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 16:59:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:60551 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758580AbZABV7V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 16:59:21 -0500
Received: (qmail invoked by alias); 02 Jan 2009 21:59:18 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 02 Jan 2009 22:59:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+sc70FDVysZyASjd0YdDRIFwzxi+eyPlGO6nlY1T
	v+PxmVbDTiRkr/
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1230843273-11056-3-git-send-email-drizzd@aon.at>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104427>

Hi,

On Thu, 1 Jan 2009, Clemens Buchacher wrote:

> Commit 0cf73755 (unpack-trees.c: assume submodules are clean during
> check-out) changed an argument to verify_absent from 'path' to 'ce',
> which is however shadowed by a local variable of the same name.

This explanation makes sense.  However, this:

> @@ -289,7 +289,8 @@ static int unpack_nondirectories(int n, unsigned long mask, unsigned long dirmas
>  	return 0;
>  }
>  
> -static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *names, struct traverse_info *info)
> +static int unpack_callback(int n, unsigned long mask, unsigned long dirmask,
> +		struct name_entry *names, struct traverse_info *info)
>  {
>  	struct cache_entry *src[5] = { NULL, };
>  	struct unpack_trees_options *o = info->data;

... is distracting during review, and this:

> @@ -517,22 +518,22 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
>  	namelen = strlen(ce->name);
>  	pos = index_name_pos(o->src_index, ce->name, namelen);
>  	if (0 <= pos)
> -		return cnt; /* we have it as nondirectory */
> +		return 0; /* we have it as nondirectory */
>  	pos = -pos - 1;
>  	for (i = pos; i < o->src_index->cache_nr; i++) {

... is not accounted for in the commit message.  Intended or not, that is 
the question.

Ciao,
Dscho "whether 'tis noble"
