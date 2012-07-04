From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH/RFC] Replace ce_namelen() with a ce_namelen field
Date: Wed, 4 Jul 2012 12:00:48 +0200
Message-ID: <87txxn3kxb.fsf@thomas.inf.ethz.ch>
References: <1341393528-21037-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, <gitster@pobox.com>, <mhagger@alum.mit.edu>,
	<pclouds@gmail.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 12:00:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmMOH-0005QZ-Hl
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 12:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756586Ab2GDKAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jul 2012 06:00:53 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:1532 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753541Ab2GDKAw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2012 06:00:52 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 4 Jul
 2012 12:00:48 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 4 Jul
 2012 12:00:48 +0200
In-Reply-To: <1341393528-21037-1-git-send-email-t.gummerer@gmail.com> (Thomas
	Gummerer's message of "Wed, 4 Jul 2012 11:18:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200999>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Replace the ce_namelen() function in cache.h with a ce_namelen
> field in struct cache_entry. This will both give us a tiny bit
> of a performance enhancement when working with long pathnames
> and is part of the refactoring for the index-v5 file format.

Expand this, at least proportionally to the damage incurred.

For example, I know that you know that there's a good reason why we want
to put it in a new field when reading from v5 :-)

> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  builtin/add.c            |    4 ++--
>  builtin/apply.c          |    1 +
>  builtin/blame.c          |    1 +
>  builtin/checkout-index.c |    8 ++++----
>  builtin/checkout.c       |    7 ++++---
>  builtin/clean.c          |    2 +-
>  builtin/commit.c         |    2 +-
>  builtin/grep.c           |    2 +-
>  builtin/ls-files.c       |    8 ++++----
>  builtin/rm.c             |    2 +-
>  builtin/update-index.c   |    9 ++++++---
>  cache-tree.c             |    4 ++--
>  cache.h                  |   11 ++---------
>  diff-lib.c               |    6 +++---
>  entry.c                  |    2 +-
>  merge-recursive.c        |    2 +-
>  name-hash.c              |    4 ++--
>  preload-index.c          |    2 +-
>  read-cache.c             |   43 ++++++++++++++++++++++++-------------------
>  rerere.c                 |    2 +-
>  resolve-undo.c           |    2 +-
>  sha1_name.c              |    6 +++---
>  submodule.c              |    2 +-
>  tree.c                   |    1 +
>  unpack-trees.c           |   31 ++++++++++++++++---------------
>  25 files changed, 85 insertions(+), 79 deletions(-)
[...]
> diff --git a/cache.h b/cache.h
> index cc5048c..5f93f22 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -128,6 +128,7 @@ struct cache_entry {
>  	unsigned int ce_gid;
>  	unsigned int ce_size;
>  	unsigned int ce_flags;
> +	unsigned int ce_namelen;
>  	unsigned char sha1[20];
>  	struct cache_entry *next;
>  	struct cache_entry *dir_next;
> @@ -205,15 +206,7 @@ static inline unsigned create_ce_flags(size_t len, unsigned stage)
>  	return (len | (stage << CE_STAGESHIFT));
>  }
>  
> -static inline size_t ce_namelen(const struct cache_entry *ce)
> -{
> -	size_t len = ce->ce_flags & CE_NAMEMASK;
> -	if (len < CE_NAMEMASK)
> -		return len;
> -	return strlen(ce->name + CE_NAMEMASK) + CE_NAMEMASK;
> -}

AFAICT almost all of the changes relate to the change from ce_namelen(ce)
to ce->ce_namelen.  What's stopping you from defining

#define ce_namelen(ce) ((ce)->ce_namelen)

as a simple compatibility macro?

I'm not sure whether such internal backwards-compatibility is desirable,
but it would certainly make the patch much more reviewable.  If Junio
would rather see the conversion, maybe do it in a separate patch that
simply substitutes the ce->ce_namelen for all the ce_namelen(ce)?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
