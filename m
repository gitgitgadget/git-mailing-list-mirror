From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/4] Allow specifying specialized merge-backend per path.
Date: Tue, 17 Apr 2007 02:20:30 -0700
Message-ID: <7vabx7qrvl.fsf@assigned-by-dhcp.cox.net>
References: <11767973183627-git-send-email-junkio@cox.net>
	<11767973191314-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 11:20:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdjrm-0005LR-5T
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 11:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbXDQJUc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 05:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753049AbXDQJUc
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 05:20:32 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:42335 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915AbXDQJUb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 05:20:31 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070417092031.SYYO1226.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Tue, 17 Apr 2007 05:20:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id o9LW1W00K1kojtg0000000; Tue, 17 Apr 2007 05:20:30 -0400
In-Reply-To: <11767973191314-git-send-email-junkio@cox.net> (Junio C. Hamano's
	message of "Tue, 17 Apr 2007 01:08:37 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44745>

Junio C Hamano <junkio@cox.net> writes:

I hate to nitpick my own patches, but...

> There is one caveat, though.  ll_merge() is called for both
> internal ancestor merge and the outer "final" merge.  I think an
> interactive custom per-path merge backend should refrain from
> going interactive when performing an internal merge (you can
> tell it by checking call_depth) and instead just call either
> ll_xdl_merge() if the content is text, or call ll_ours_merge()
> otherwise.

After having thought about this a bit more, I think a conflict
in *internal* merge for a binary file should probably take the
ancestor's, instead of ours.

A conflict during the internal merge happens when there are
multiple common ancestors, and the development lines continuing
from these ancestores may have disagreed on the result of this
conflicting merge earlier.

             o---A---C---o---Y
            /     \ /         \
          GP       .           M
            \     / \         /
             o---B---D---o---Z

When we are trying to do the merge M between Y and Z, we find
two closest common ancestors, A and B.  An internal merge to
merge them, using the grandparent ancestor, GP, is attempted,
and we will use the result as the virtual common ancestor to
create a merge between Y and Z.

The fact the internal merge between A and B conflicted means
that the development lines leading to Y and Z already saw that
same conflict before reaching Y and Z (in the above picture, at
C and D, respectively), and they might have resolved it
differently.

When it is a text file, Fredrik's clever "recursive merge"
leaves conflicted merge as the common ancestor, which is
different from either C or D's resolution (perhaps we can think
of it being somewhere areound sign X in the above picture), and
merge between Y and Z using that as the common ancestor cancels
the conflict out if C and D resolved it the same way.

However, when the file is a binary guck, the result of such a
half-merge with conflict markers is simply a corrupt binary
data, and is unusable even for inspection.  That was the reason
why I initially suggested to use 'ours'.  But that means, when
we are on the branch that leads to Y, we essentially favor C's
resolution, defeating the "accidental revert avoidance" the
recursive merge strategy offers.  If instead we take the version
from GP as the common ancestor, we have a usable binary guck as
an ancestor as well, and also we are being neutral between the
branches, giving the end user a chance to make an unbiased
decision on his own.

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 4eb62cf..a6c08a1 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -659,6 +660,124 @@ static void fill_mm(const unsigned char *sha1, mmfile_t *mm)
>  	mm->size = size;
>  }
>  
> +/* Low-level merge functions */
> +typedef int (*ll_merge_fn)(mmfile_t *orig,
> +			   mmfile_t *src1, const char *name1,
> +			   mmfile_t *src2, const char *name2,
> +			   mmbuffer_t *result);
> +
> +static int ll_xdl_merge(mmfile_t *orig,
> +			mmfile_t *src1, const char *name1,
> +			mmfile_t *src2, const char *name2,
> +			mmbuffer_t *result)
> +{
> +	xpparam_t xpp;
> +	memset(&xpp, 0, sizeof(xpp));
> +	memset(&xpp, 0, sizeof(xpp));

I caught this after sending this message, and already fixed it
in the version I pushed out on 'pu'.
