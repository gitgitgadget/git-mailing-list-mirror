From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git bugs
Date: Thu, 12 Jun 2008 13:06:17 -0700
Message-ID: <7v4p7y1kqu.fsf@gitster.siamese.dyndns.org>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>
 <alpine.LFD.1.10.0806101028040.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Lynn <benlynn@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 12 22:07:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6t4u-0001WH-Vx
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 22:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754283AbYFLUGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 16:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753641AbYFLUGa
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 16:06:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39972 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbYFLUG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 16:06:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E6F423EE9;
	Thu, 12 Jun 2008 16:06:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 130413EE7; Thu, 12 Jun 2008 16:06:23 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0806101028040.3101@woody.linux-foundation.org>
 (Linus Torvalds's message of "Tue, 10 Jun 2008 10:44:43 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0AA0C5EE-38BB-11DD-959B-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84780>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> The other approach is to know that an empty blob always has a very 
> specific SHA1. Here's an trial patch.

>  read-cache.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 8e5fbb6..f83de8c 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> ...
> @@ -193,6 +203,12 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
>  	if (ce->ce_size != (unsigned int) st->st_size)
>  		changed |= DATA_CHANGED;
>  
> +	/* Racily smudged entry? */
> +	if (!ce->ce_size) {
> +		if (!is_empty_blob_sha1(ce->sha1))
> +			changed |= DATA_CHANGED;
> +	}
> +
>  	return changed;
>  }

Thanks.  This would be a good fix to the issue.

The only theoretical worry I can think of is if there is an insane
convert_to_worktree() filter that turns a non-empty blob into an empty
work tree file.

An "In blobs, always store everything as UTF16 with BOM" filter, when
badly implemented, might turn an empty work tree file into a blob with BOM
and nothing else in it, but we can safely declare that such use case is
simply insane and broken ;-).
