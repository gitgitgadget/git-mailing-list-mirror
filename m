From: Marcus Karlsson <mk@acc.umu.se>
Subject: Re: [PATCH] diff: avoid stack-buffer-read-overrun for very long name
Date: Tue, 17 Apr 2012 00:27:17 +0200
Message-ID: <20120416222713.GA2396@moj>
References: <87ty0jbt5p.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Tue Apr 17 00:38:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJuYt-0001i1-E6
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 00:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217Ab2DPWiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 18:38:15 -0400
Received: from mail.acc.umu.se ([130.239.18.156]:54497 "EHLO mail.acc.umu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335Ab2DPWiO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 18:38:14 -0400
X-Greylist: delayed 645 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Apr 2012 18:38:14 EDT
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id 3A2BFC45;
	Tue, 17 Apr 2012 00:27:28 +0200 (MEST)
X-Virus-Scanned: amavisd-new at acc.umu.se
Received: from moj (c-0971e155.122-2-64736c10.cust.bredbandsbolaget.se [85.225.113.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: mk)
	by mail.acc.umu.se (Postfix) with ESMTPSA id 38D8AC44;
	Tue, 17 Apr 2012 00:27:27 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <87ty0jbt5p.fsf@rho.meyering.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195718>

On Mon, Apr 16, 2012 at 05:20:02PM +0200, Jim Meyering wrote:
> 
> Due to the use of strncpy without explicit NUL termination,
> we could end up passing names n1 or n2 that are not NUL-terminated
> to queue_diff, which requires NUL-terminated strings.
> Ensure that each is NUL terminated.
> 
> Signed-off-by: Jim Meyering <meyering@redhat.com>
> ---
> After finding strncpy problems in other projects, I audited
> git for the same and found only these two.
> 
>  diff-no-index.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 3a36144..5cd3ff5 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -109,6 +109,7 @@ static int queue_diff(struct diff_options *o,
>  				n1 = buffer1;
>  				strncpy(buffer1 + len1, p1.items[i1++].string,
>  						PATH_MAX - len1);
> +				buffer1[PATH_MAX-1] = 0;
>  			}
> 
>  			if (comp < 0)
> @@ -117,6 +118,7 @@ static int queue_diff(struct diff_options *o,
>  				n2 = buffer2;
>  				strncpy(buffer2 + len2, p2.items[i2++].string,
>  						PATH_MAX - len2);
> +				buffer2[PATH_MAX-1] = 0;
>  			}
> 
>  			ret = queue_diff(o, n1, n2);
> --
> 1.7.10.169.g146fe

Are there any guarantees that len1 and len2 does not exceed PATH_MAX?
Because if there aren't any then that function looks like it could need
even more improvements.

	Marcus
