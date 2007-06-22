From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diffcore-rename: favour identical basenames
Date: Fri, 22 Jun 2007 01:41:42 -0400
Message-ID: <20070622054142.GA7699@coredump.intra.peff.net>
References: <20070621030622.GD8477@spearce.org> <alpine.LFD.0.98.0706202031200.3593@woody.linux-foundation.org> <Pine.LNX.4.64.0706211248420.4059@racer.site> <20070621131915.GD4487@coredump.intra.peff.net> <Pine.LNX.4.64.0706220214250.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	govindsalinas <govindsalinas@yahoo.com>, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 22 07:41:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1btz-00035L-KW
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 07:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbXFVFlq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 01:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbXFVFlq
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 01:41:46 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3469 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937AbXFVFlp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 01:41:45 -0400
Received: (qmail 6972 invoked from network); 22 Jun 2007 05:42:01 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 22 Jun 2007 05:42:01 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jun 2007 01:41:42 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706220214250.4059@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50679>

On Fri, Jun 22, 2007 at 02:14:43AM +0100, Johannes Schindelin wrote:

> @@ -313,20 +297,24 @@ void diffcore_rename(struct diff_options *options)
>  			if (rename_dst[i].pair)
>  				continue; /* dealt with an earlier round */
>  			for (j = 0; j < rename_src_nr; j++) {
> -				int k;
> +				int k, distance;
>  				struct diff_filespec *one = rename_src[j].one;
>  				if (!is_exact_match(one, two, contents_too))
>  					continue;
>  
> +				distance = levenshtein(one->path, two->path);
>  				/* see if there is a basename match, too */
>  				for (k = j; k < rename_src_nr; k++) {

This loop can start at k = j+1, since otherwise we are just checking
rename_src[j] against itself.

> +int levenshtein(const char *string1, const char *string2)
> +{
> +	int len1 = strlen(string1), len2 = strlen(string2);
> +	int *row1 = xmalloc(sizeof(int) * (len2 + 1));
> +	int *row2 = xmalloc(sizeof(int) * (len2 + 1));
> +	int i, j;
> +
> +	for (j = 1; j <= len2; j++)
> +		row1[j] = j;

This loop must start at j=0, not j=1; otherwise you have an undefined
value in row1[0], which gets read when setting row2[1], and you get
a totally meaningless distance (I got -1209667248 on my test case!).

-Peff
