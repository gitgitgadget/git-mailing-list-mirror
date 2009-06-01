From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/11] test-chmtime: work around Windows limitation
Date: Mon, 01 Jun 2009 00:43:40 -0700
Message-ID: <7vab4smmab.fsf@alter.siamese.dyndns.org>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de>
	<1243786525-4493-2-git-send-email-prohaska@zib.de>
	<1243786525-4493-3-git-send-email-prohaska@zib.de>
	<1243786525-4493-4-git-send-email-prohaska@zib.de>
	<1243786525-4493-5-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Jun 01 09:43:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB2BX-000301-Ix
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 09:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbZFAHnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 03:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752910AbZFAHnj
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 03:43:39 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:36993 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbZFAHni (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 03:43:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090601074339.OPVG25927.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Mon, 1 Jun 2009 03:43:39 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id yXjg1b0034aMwMQ03Xjgz8; Mon, 01 Jun 2009 03:43:40 -0400
X-Authority-Analysis: v=1.0 c=1 a=4n06hotiqrIA:10 a=YZBqRnCg1bkA:10
 a=VOOERgDTbnW5-a77gvMA:9 a=vxvx9YFEhGAUhnM2ti4xs78rkX0A:4 a=JO-CUkcG2iAA:10
 a=_RhRFcbxBZMA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120449>

Steffen Prohaska <prohaska@zib.de> writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Windows has problems changing the mtime when the file is write protected,
> even by the owner of said file.
>
> Add a Windows-only workaround to change the mode if necessary before
> trying to change the mtime.

I'll queue this as-is for now, but shouldn't the code remember the
original mode and change it back?

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> ---
>  test-chmtime.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/test-chmtime.c b/test-chmtime.c
> index d5358cb..fe476cb 100644
> --- a/test-chmtime.c
> +++ b/test-chmtime.c
> @@ -87,6 +87,15 @@ int main(int argc, const char *argv[])
>  			return -1;
>  		}
>  
> +#ifdef WIN32
> +		if (!(sb.st_mode & S_IWUSR) &&
> +				chmod(argv[i], sb.st_mode | S_IWUSR)) {
> +			fprintf(stderr, "Could not make user-writable %s: %s",
> +				argv[i], strerror(errno));
> +			return -1;
> +		}
> +#endif
> +
>  		utb.actime = sb.st_atime;
>  		utb.modtime = set_eq ? set_time : sb.st_mtime + set_time;
>  
> -- 
> 1.6.3.1.54.g99dd
