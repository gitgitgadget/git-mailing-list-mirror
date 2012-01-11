From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] diff-index: pass pathspec down to unpack-trees
 machinery
Date: Wed, 11 Jan 2012 00:31:04 -0600
Message-ID: <20120111063104.GA3153@burratino>
References: <7vty9054qr.fsf@alter.siamese.dyndns.org>
 <1314653603-7533-1-git-send-email-gitster@pobox.com>
 <1314653603-7533-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 07:26:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkrdZ-0001a7-P2
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 07:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188Ab2AKG0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 01:26:12 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:62550 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753159Ab2AKG0L (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2012 01:26:11 -0500
Received: by obbup16 with SMTP id up16so418624obb.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 22:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OYVLoMdSryQYArFHLTh9wiNVdzCPedk/SNfX4Uf0iWo=;
        b=cvpvz1Opxef9936d2lCZRAgvofXDQz8x9G+Bo4s1r9aHQpXhHIQFkat2GQ5B3caTjg
         eaFfXJcSOMZwDacXUYtwogsTxRJYQNw3J+iuyk/++AkAJMcbiVjI1Vf31novdWMvtndS
         utxvzPJMcfRt4hYmTcX+rtmJVx2p8qgrlRVM8=
Received: by 10.50.170.35 with SMTP id aj3mr5688106igc.2.1326263170918;
        Tue, 10 Jan 2012 22:26:10 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id h9sm1636564ibh.11.2012.01.10.22.26.09
        (version=SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 22:26:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1314653603-7533-4-git-send-email-gitster@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188335>

Hi,

Junio C Hamano wrote:

> And finally, pass the pathspec down through unpack_trees() to traverse_trees()
> callchain.
>
> Before and after applying this series, looking for changes in the kernel
> repository with a fairly narrow pathspec gets a moderate speeds up.

Check this out:

	mkdir -p test-repo/subdir
	cd test-repo
	git init
	echo hi >subdir/hello.h
	git add subdir/hello.h
	git commit -m 'say hi'
	git diff-index --abbrev HEAD -- '*.h'

In git versions which include the patch described above, the unchanged
subdir/hello.h shows up as a newly added file.  Reverting that patch
(v1.7.7.1~22^2, diff-index: pass pathspec down to unpack-trees
machinery, 2011-08-29) makes "git diff HEAD" with wildcards work
again.

It looks like the pruning of the preimage by pathspec is too
aggressive and is omiting whole directories that do not match the
pathspec without realizing that the path to a file contained within
might match.

We could just add a test for this to the testsuite and do that revert,
but I'd rather not yet, in case this is a symptom of some deeper
unpack_trees() confusion.

Hints?

Thanks,
Jonathan

>  diff-lib.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/diff-lib.c b/diff-lib.c
> index f8454dd..ebe751e 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -468,6 +468,7 @@ static int diff_cache(struct rev_info *revs,
>  	opts.unpack_data = revs;
>  	opts.src_index = &the_index;
>  	opts.dst_index = NULL;
> +	opts.pathspec = &revs->diffopt.pathspec;
>  
>  	init_tree_desc(&t, tree->buffer, tree->size);
>  	return unpack_trees(1, &t, &opts);
> -- 
> 1.7.7.rc0.70.g82660
>
>
