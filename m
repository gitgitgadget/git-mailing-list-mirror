From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-mv: Keep moved index entries inact
Date: Sat, 19 Jul 2008 16:54:20 -0700
Message-ID: <7vej5pwhub.fsf@gitster.siamese.dyndns.org>
References: <20080717130651.GU32184@machine.or.cz>
 <20080717223036.20680.9672.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Jul 20 01:55:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKMGw-0006CT-03
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 01:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330AbYGSXy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 19:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754194AbYGSXy1
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 19:54:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63138 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218AbYGSXy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 19:54:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 611A2390DD;
	Sat, 19 Jul 2008 19:54:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8B76A390DC; Sat, 19 Jul 2008 19:54:22 -0400 (EDT)
In-Reply-To: <20080717223036.20680.9672.stgit@localhost> (Petr Baudis's
 message of "Fri, 18 Jul 2008 00:31:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 044F1ACE-55EE-11DD-8019-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89145>

Petr Baudis <pasky@suse.cz> writes:

> A new test has been added to the testsuite to reflect this change.
> Also, based on suggestion by Junio about desired symlink behaviour
> of git mv, I have added two tests for that; however, I do not have
> need or desire to spend time fixing this, so they are expected
> to fail for now until someone gets around to fixing that.

Well, somebody would eventually come to help, then ;-).

>  builtin-mv.c  |   62 ++++++++-------------------------------------------------
>  cache.h       |    2 ++
>  read-cache.c  |   15 ++++++++++++++
>  t/t7001-mv.sh |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 83 insertions(+), 53 deletions(-)

Very nice code reduction, isn't it?

> diff --git a/read-cache.c b/read-cache.c
> index 1648428..70e5f57 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -38,6 +38,21 @@ static void replace_index_entry(struct index_state *istate, int nr, struct cache
>  	istate->cache_changed = 1;
>  }
>  
> +void rename_index_entry_at(struct index_state *istate, int nr, const char *new_name)
> +{
> +	struct cache_entry *old = istate->cache[nr], *new;
> +	int namelen = strlen(new_name);
> +
> +	new = xmalloc(cache_entry_size(namelen));
> +	copy_cache_entry(new, old);
> +	new->ce_flags = (new->ce_flags & ~CE_NAMEMASK) | namelen;
> +	memcpy(new->name, new_name, namelen);
> +
> +	cache_tree_invalidate_path(istate->cache_tree, old->name);
> +	remove_index_entry_at(istate, nr);
> +	add_index_entry(istate, new, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
> +}

Hmm, would this use of copy_cache_entry() kosher, I have to wonder.  This
new copy of cache entry begins its life unhashed, doesn't it?  Shouldn't
we be not copying its hashed/unhashed bits from the old one?

Also setting of that ce_flags looks wrong when namelen does not fit within
the width of CE_NAMEMASK.  Shouldn't it be doing the same thing as
create_ce_flags()?

> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> index 336cfaa..6b615f8 100755
> --- a/t/t7001-mv.sh
> +++ b/t/t7001-mv.sh
> @@ -156,4 +156,61 @@ test_expect_success 'absolute pathname outside should fail' '(
>  
>  )'
>  
> +# git mv meets angry Git maintainer

What's this comment about?

> +test_expect_success 'git mv should not change sha1 of moved cache entry' '
> +
> +	rm -fr .git &&
> +	git init &&
> +	echo 1 >dirty &&
> +	git add dirty &&
> +	entry="$(git ls-files --stage dirty | cut -f 1)"

"rev-parse :dirty"?
