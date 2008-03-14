From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-recursive: handle file mode changes
Date: Fri, 14 Mar 2008 03:15:26 -0700
Message-ID: <7vhcf9r4qp.fsf@gitster.siamese.dyndns.org>
References: <20080308171726.GA16129@localhost>
 <alpine.LSU.1.00.0803081850470.3975@racer.site>
 <20080313125229.GA24758@localhost>
 <alpine.LSU.1.00.0803131607030.1656@racer.site>
 <20080313192246.GA30361@localhost>
 <alpine.LSU.1.00.0803132216580.4174@racer.site>
 <20080313224741.GA5000@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Mar 14 11:16:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja6xU-0007K2-Gk
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 11:16:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbYCNKPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 06:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752789AbYCNKPi
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 06:15:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbYCNKPh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 06:15:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E87DD257F;
	Fri, 14 Mar 2008 06:15:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D0744257E; Fri, 14 Mar 2008 06:15:28 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77201>

Clemens Buchacher <drizzd@aon.at> writes:

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 34e3167..d8938cc 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1025,12 +1025,21 @@ static struct merge_file_info merge_file(struct diff_filespec *o,
>  			hashcpy(result.sha, b->sha1);
>  		}
>  	} else {
> -		if (!sha_eq(a->sha1, o->sha1) && !sha_eq(b->sha1, o->sha1))
> -			result.merge = 1;
> -
> -		result.mode = a->mode == o->mode ? b->mode: a->mode;
> +		/*
> +		 * If mode changed in only one branch, keep the changed
> +		 * version. Otherwise, keep remote version and create a
> +		 * conflict.
> +		 */

Reading the rest of the function, I notice that it consistently favor "a"
over "b", when a conflict cannot be reconciled.

> +		if (a->mode != o->mode && b->mode != o->mode &&
> +				a->mode != b->mode) {
> +			result.clean = 0;
> +			result.mode = b->mode;
> +		} else
> +			result.mode = o->mode == a->mode ? b->mode : a->mode;

I think this is much easier to read:

		if (a->mode == b->mode || a->mode == o->mode)
			result.mode = b->mode;
		else {
			result.mode = a->mode;
			if (b->mode != o->mode) {
				result.clean = 0;
				result.merge = 1;
			}
		}

We keep "b" only if "a" hasn't touched the mode, or it happens to be the
same as "a".  Otherwise we take "a" anyway, but taking "a" when "b" also
touched means we detected an unreconcilable conflict.

> @@ -1062,6 +1071,8 @@ static struct merge_file_info merge_file(struct diff_filespec *o,
>  		} else {
>  			die("unsupported object type in the tree");
>  		}
> +
> +		result.merge = !result.clean;

As pointed out by Dscho, this is too much.  We could mimick the one that
is done for the contents, which is why I have "result.merge = 1" where it
is in the above.

> diff --git a/t/t6031-merge-recursive.sh b/t/t6031-merge-recursive.sh
> new file mode 100755
> index 0000000..36cd664
> --- /dev/null
> +++ b/t/t6031-merge-recursive.sh
> @@ -0,0 +1,39 @@
> +#!/bin/sh
> ...
> +	! (git merge-recursive master -- a2 b2 || test $? -ne 1) &&
> +	! test -x file2
> +'

As we would favor our side in unreconsilable conflicts, the last test
needs to become "test -x file2".

Also we should test ls-files -u output to make sure we have correct stages
in the index.

I've done minor fixups and committed the result.
