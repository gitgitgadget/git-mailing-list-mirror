From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] merge-recursive: cause a conflict if file mode does not
 match
Date: Thu, 13 Mar 2008 22:17:07 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803132216580.4174@racer.site>
References: <20080308171726.GA16129@localhost> <alpine.LSU.1.00.0803081850470.3975@racer.site> <20080313125229.GA24758@localhost> <alpine.LSU.1.00.0803131607030.1656@racer.site> <20080313192246.GA30361@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Mar 13 22:17:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZuo9-0000Pu-Bt
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 22:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbYCMVRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 17:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752477AbYCMVRJ
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 17:17:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:43442 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752192AbYCMVRI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 17:17:08 -0400
Received: (qmail invoked by alias); 13 Mar 2008 21:17:04 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp057) with SMTP; 13 Mar 2008 22:17:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19iD0E276diW/Bw6jl1nsaOzT3QKDsCMn9h5ZeTH/
	XqXFNEKKDKuXrk
X-X-Sender: gene099@racer.site
In-Reply-To: <20080313192246.GA30361@localhost>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77139>

Hi,

On Thu, 13 Mar 2008, Clemens Buchacher wrote:

> Previously, mismatching file modes would be auto-merged by picking the 
> mode in the remote tree.
> 
> This also fixes a bug which caused merge-recursive to fail if the merged 
> files were empty.
> 
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> ---
> 
> Hi Dscho,
> 
> Your patch certainly fixes a bug in git-merge-file. It does not fix the 
> bug in git-merge-recursive, however. The test script also fails with 
> your patch.

Now, _that_ is funny.  I tested before sending, and my test suit runs just 
fine.

> On Thu, Mar 13, 2008 at 04:19:35PM +0100, Johannes Schindelin wrote:
> > On Sat, Mar 08, 2008 at 06:17:26PM +0100, Clemens Buchacher wrote:
> > > One could argue that it would be better to mark the mismatching 
> > > permissions as a conflict.
> > 
> > Right you are.  Your whole "it still is xdl_merge()s fault" point was 
> > just contradicted by your own analysis.  Calling xdl_merge() when the 
> > sha1 does _not_ differ is _a mistake_.  _That_ is the bug.
> 
> Alright, fixed in the appended patch.

I have to admit that I wanted you to fix that patch, instead of me, 
because you were already researching the issue.

>  merge-recursive.c          |    9 +++++++--
>  t/t6031-merge-recursive.sh |   23 +++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 2 deletions(-)
>  create mode 100755 t/t6031-merge-recursive.sh

Looks much better.

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 34e3167..01918a7 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1028,9 +1028,14 @@ static struct merge_file_info merge_file(struct diff_filespec *o,
>  		if (!sha_eq(a->sha1, o->sha1) && !sha_eq(b->sha1, o->sha1))
>  			result.merge = 1;
>  
> -		result.mode = a->mode == o->mode ? b->mode: a->mode;
> +		if (!o->mode) {
> +			if (a->mode != b->mode)
> +				result.clean = 0;
> +			result.mode = b->mode;
> +		} else
> +			result.mode = a->mode == o->mode ? b->mode: a->mode;

So you only set clean = 0 if o->mode == 0, i.e. the file did not exist?  
That was not what I had in mind.  I would have expected that "if (a->mode 
!= b->mode)" to come _before_ the assignment to result.mode, which should 
have been left alone.

The rationale would have been this:

If the modes are different, the merge is not clean.

If the SHA-1s differ, the merge is not clean, and xld_merge() should be 
called.

> -		if (sha_eq(a->sha1, o->sha1))
> +		if (sha_eq(a->sha1, b->sha1) || sha_eq(a->sha1, o->sha1))

Why do you still compare to o->sha1?

/me goes looking in the original source, since the issue and the fix does 
not become apparent from your patch, including the commit message.

Oh, okay.

You are reusing a _different_ case, which just happens to have the same 
outcome.

In a perfect world, this would have a one-line comment above to explain 
issues.

> diff --git a/t/t6031-merge-recursive.sh b/t/t6031-merge-recursive.sh
> new file mode 100755
> index 0000000..7ea371e
> --- /dev/null
> +++ b/t/t6031-merge-recursive.sh
> @@ -0,0 +1,23 @@
> +#!/bin/sh
> +
> +test_description='merge-recursive corner cases'
> +. ./test-lib.sh
> +
> +test_expect_success 'merge empty files with different permission flags' '

The point is not that they are empty.  Maybe you want to fix that message.

> +	: >dummy &&
> +	git add dummy &&
> +	git commit -m "initial commit" &&
> +	git checkout -b a master &&
> +	: >a &&
> +	git add a &&
> +	git commit -m "branch a" &&
> +	git checkout -b b master &&
> +	: >a &&
> +	chmod +x a &&
> +	git add a &&
> +	git commit -m "branch b" &&
> +	git checkout master &&
> +	! (git merge-recursive master -- a b || test $? -ne 1)
> +'
> +
> +test_done
> -- 
> 1.5.4.4.2.gd2fe
> 

Thanks,
Dscho
