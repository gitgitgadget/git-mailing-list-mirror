From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] cache-tree: Create/update cache-tree on checkout
Date: Sun, 29 Jun 2014 23:31:16 -0700
Message-ID: <xmqqvbrizz63.fsf@gitster.dls.corp.google.com>
References: <1403914856-3546-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 08:31:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1V7i-0002iN-EN
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 08:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbaF3Gb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 02:31:26 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55868 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751794AbaF3GbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 02:31:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0404D1D453;
	Mon, 30 Jun 2014 02:31:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IETVtq8nhXnSvypkQsMYxMJncr8=; b=jVposr
	5KooKLtU9T557Az5oGWJr9m/B5xWz31We9/c+mYlMKiXtNv6foiAj81EUpPtJGJp
	2mJhu3s5uB78x72Agy/XbEjTXcw/XAFTI9KKkRZWrN072i2sLcRZKSbosqmaJQyg
	4CPtmTq0ZVFwGEP/OUzJMs6HGDJQLPm5BZMEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PNj3alIxhn96BQPffZ3GNVqquWuiekb6
	vvG9Ta2xQ/S7yTHGxdKOZPrFNb/2n1Z/TS2H6u90wt7QzqUQ9sRf92n67ibGr+8O
	v+K7MoDq2FyPwh71rOqAfMhpsqKk05yzOWb/bE7xXTTg09bTa5j0ICO3KDOihVBS
	Po/lC1cEw6k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EA38A1D452;
	Mon, 30 Jun 2014 02:31:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8CDD61D44C;
	Mon, 30 Jun 2014 02:31:10 -0400 (EDT)
In-Reply-To: <1403914856-3546-1-git-send-email-dturner@twitter.com> (David
	Turner's message of "Fri, 27 Jun 2014 17:20:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 202D6290-0020-11E4-867F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252653>

David Turner <dturner@twopensource.com> writes:

> When git checkout checks out a branch, create or update the
> cache-tree so that subsequent operations are faster.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
>  builtin/checkout.c    |  4 ++++
>  cache-tree.c          | 22 ++++++++++++----------
>  cache-tree.h          |  1 +
>  t/t0090-cache-tree.sh | 15 ++++++++++++++-
>  4 files changed, 31 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 07cf555..df791e8 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -553,6 +553,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
>  		}
>  	}
>  
> +	if (write_cache_as_tree(NULL, WRITE_TREE_DO_NOT_WRITE, "")) {
> +		warn("Unable to write cache_tree");
> +	}
> +

This is not even warn-worthy event, isn't it?  "checkout -m other"
would attempt a three-way merge to replay your local changes
relative to your current HEAD in the context of "other" branch and
will leave conflicts in the index and in the working tree, and it is
perfectly a normal thing that you cannot write the index in such a
state as a tree object.  Perhaps you should check if the index is
unmerged before even attempting to compute the cache tree.

Also it looks very strange that write-cache-as-tree, whose *PRIMARY*
function is to write a tree, receives a "DO NOT WRITE" option here.
I understand that you want a new interface into the cache-tree
subsystem that only updates the cache-tree but it somehow smells
like a sloppy/lazy refactoring that is not done quite right.
