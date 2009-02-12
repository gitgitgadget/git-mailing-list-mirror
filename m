From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Bugfix: GIT_EXTERNAL_DIFF with more than one changed
	files
Date: Thu, 12 Feb 2009 09:07:40 -0500
Message-ID: <20090212140740.GB3057@coredump.intra.peff.net>
References: <20090212133614.GA12746@bigbear>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 15:09:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXcFp-0000ss-0z
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 15:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755183AbZBLOHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 09:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754719AbZBLOHn
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 09:07:43 -0500
Received: from peff.net ([208.65.91.99]:36747 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752896AbZBLOHn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 09:07:43 -0500
Received: (qmail 8710 invoked by uid 107); 12 Feb 2009 14:07:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 12 Feb 2009 09:07:59 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Feb 2009 09:07:40 -0500
Content-Disposition: inline
In-Reply-To: <20090212133614.GA12746@bigbear>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109618>

On Thu, Feb 12, 2009 at 09:36:14PM +0800, Nazri Ramliy wrote:

> Regression introduced in 479b0ae81c9291a8bb8d7b2347cc58eeaa701304.
> 
> When there is more than one file that are changed, running
> git diff with GIT_EXTERNAL_DIFF works only for the first file.
> 
> This patch fixes this problem and added a test case for it.

Yikes. Thanks for finding this.

Actually, the situation is a little more complex than what you describe.

We used to just re-use the diff_temp array unconditionally; the commit
you mention introduced a safety check to make sure we are not
overwriting an existing tempfile that should be cleaned up. That safety
check looks for the "name" field being NULL to signal an unused slot.

But the "remove_tempfile" function uses a different test to see if a
slot needs to be deleted: if the name and the tmp_path are the same.
And they would not be if we were able to reuse a working tree file as
part of the diff, in which case there would be nothing to clean up. And
if we did clean something up, we set the name field to NULL.

So this bug should trigger only in the face of reusing worktree files. I
checked your test; it constructs a diff between the worktree and the
index, so it correctly finds the problem.

>  {
>  	int i;
> -	for (i = 0; i < ARRAY_SIZE(diff_temp); i++)
> -		if (diff_temp[i].name == diff_temp[i].tmp_path) {
> +	for (i = 0; i < ARRAY_SIZE(diff_temp); i++) {
> +		if (diff_temp[i].name == diff_temp[i].tmp_path)
>  			unlink(diff_temp[i].name);
> -			diff_temp[i].name = NULL;
> -		}
> +		diff_temp[i].name = NULL;
> +	}

Note that the other possible fix for this bug is to change
claim_diff_tempfile to use the same test. But I prefer this, as it is
more idiomatic to use NULL as a marker for "not in use".

Acked-by: Jeff King <peff@peff.net>

-Peff
