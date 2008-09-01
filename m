From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Bust the ghost of long-defunct diffcore-pathspec.
Date: Mon, 01 Sep 2008 16:00:52 -0700
Message-ID: <7vbpz7tqsb.fsf@gitster.siamese.dyndns.org>
References: <20080901215353.30399.33432.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Tue Sep 02 01:02:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaIPQ-0006xv-PB
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 01:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbYIAXBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 19:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbYIAXBA
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 19:01:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53938 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbYIAXBA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 19:01:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BC7445D19F;
	Mon,  1 Sep 2008 19:00:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CE8665D19C; Mon,  1 Sep 2008 19:00:54 -0400 (EDT)
In-Reply-To: <20080901215353.30399.33432.stgit@gandelf.nowhere.earth> (Yann
 Dirson's message of "Mon, 01 Sep 2008 23:53:54 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D697609C-7879-11DD-A6EE-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94623>

Yann Dirson <ydirson@altern.org> writes:

> This concept was retired by 77882f60d9df2fd410ba7d732b01738315643c05,
> more than 2 years ago.
> ---

Signoff.

> diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
> index 2bdbc3d..fc54bfb 100644
> --- a/Documentation/gitdiffcore.txt
> +++ b/Documentation/gitdiffcore.txt
> @@ -52,9 +52,8 @@ unmerged       :000000 000000 0000000... 0000000... U file6
>  The diffcore mechanism is fed a list of such comparison results
>  (each of which is called "filepair", although at this point each
>  of them talks about a single file), and transforms such a list
> -into another list.  There are currently 6 such transformations:
> +into another list.  There are currently 5 such transformations:
>
> -- diffcore-pathspec
>  - diffcore-break
>  - diffcore-rename
>  - diffcore-merge-broken

I left this in more-or-less deliberately, because this description is
still true at the conceptual level (which this document is about).

But I am not opposed to your change in this hunk...

> @@ -62,21 +61,22 @@ into another list.  There are currently 6 such transformations:
>  - diffcore-order
>  
>  These are applied in sequence.  The set of filepairs 'git-diff-{asterisk}'
> -commands find are used as the input to diffcore-pathspec, and
> -the output from diffcore-pathspec is used as the input to the
> +commands find are used as the input to diffcore-break, and
> +the output from diffcore-break is used as the input to the
>  next transformation.  The final result is then passed to the
>  output routine and generates either diff-raw format (see Output
>  format sections of the manual for 'git-diff-{asterisk}' commands) or
>  diff-patch format.

... and this part of the hunk is also fine.

> -diffcore-pathspec: For Ignoring Files Outside Our Consideration
> ----------------------------------------------------------------
> +Pathspec filtering: For Ignoring Files Outside Our Consideration
> +----------------------------------------------------------------
>  
> -The first transformation in the chain is diffcore-pathspec, and
> +The first transformation in the chain is pathspec filtering, which
> +occurs before calling diffcore, and

... however, this is not.  You changed the way how diffcore works at the
conceptual level with your change, and pathspec filtering is _NOT_ part of
what diffcore does anymore, in this document.

So I'd suggest to remove this subsection altogether, and instead add some
sentence to describe that the list fed to diffcore machinery is already
narrowed by the pathspecs, around:

    ...
     - 'git-diff-tree' compares contents of two "tree" objects;

    In all of these cases, the commands themselves compare
    corresponding paths in the two sets of files.  The result of
    comparison is passed from these commands to what is internally
    ...

Namely, say something like:

    In all of these cases, the commands themselves first limit the two
    sets of files by pathspecs (if given), and compare corresponding paths
    in the resulting sets.  The result of the comparison is passed ...

Using the description from this part...

>  is controlled by giving the pathname parameters to the
> -'git-diff-{asterisk}' commands on the command line.  The pathspec is used
> -to limit the world diff operates in.  It removes the filepairs
> +'git-diff-{asterisk}' commands on the command line.  The pathspec is
> +used to limit the world diff operates in.  It removes the filepairs
>  outside the specified set of pathnames.  E.g. If the input set
>  of filepairs included:

The last two hunks to remove "Implementation note" and "extern void ..."
are good.

Thanks.
