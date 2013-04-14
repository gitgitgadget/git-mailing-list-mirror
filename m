From: Lukas Fleischer <git@cryptocrack.de>
Subject: Re: [PATCH v2 1/3] Add public function
 read_blob_data_from_index_path()
Date: Sun, 14 Apr 2013 22:14:15 +0200
Message-ID: <20130414201415.GA9683@blizzard>
References: <1365787573-597-1-git-send-email-git@cryptocrack.de>
 <1365859712-8400-1-git-send-email-git@cryptocrack.de>
 <7vwqs56418.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 14 22:14:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URTJr-0004eX-Iz
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 22:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473Ab3DNUOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 16:14:23 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:40414 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339Ab3DNUOW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 16:14:22 -0400
Received: from localhost (p57B43CE4.dip.t-dialin.net [87.180.60.228])
	by elnino.cryptocrack.de (OpenSMTPD) with ESMTP id 878eab63
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128);
	Sun, 14 Apr 2013 22:14:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vwqs56418.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221160>

On Sat, Apr 13, 2013 at 10:49:36PM -0700, Junio C Hamano wrote:
> Thanks. I'll queue with the following API fix-up on this, with
> obvious adjustments necessary for the later ones.
> 
>  * read_blob_data_from_index() is descriptive enough. If you read a
>    blob from the index, you would ask for it with a path; there is
>    no other sensible key to do so.
> 
>  * A function in read-cache API that works on an index should have
>    the istate as the first argument and called with name "index";
> 
>  * If callers want to operate on the default index, macro with a
>    similar name but replacing "index" with "cache" can be supplied,
>    e.g.
> 
>    #define distim_cache(x) distim_index(&the_index, x)
> ---
>  attr.c       | 2 +-
>  cache.h      | 3 ++-
>  read-cache.c | 4 +---
>  3 files changed, 4 insertions(+), 5 deletions(-)

Sounds reasonable to me -- squashing the fixed up version into my
original patch ([PATCH v2 1/1] Add public function
read_blob_data_from_index_path()) probably makes sense here :)

Thanks for reviewing and reworking!

> 
> diff --git a/attr.c b/attr.c
> index a668a63..46bde57 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -387,7 +387,7 @@ static struct attr_stack *read_attr_from_index(const char *path, int macro_ok)
>  	char *buf, *sp;
>  	int lineno = 0;
>  
> -	buf = read_blob_data_from_index_path(path, use_index);
> +	buf = read_blob_data_from_index(use_index, path);
>  	if (!buf)
>  		return NULL;
>  
> diff --git a/cache.h b/cache.h
> index 85ddb13..5d66c74 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -307,6 +307,7 @@ extern void free_name_hash(struct index_state *istate);
>  #define resolve_undo_clear() resolve_undo_clear_index(&the_index)
>  #define unmerge_cache_entry_at(at) unmerge_index_entry_at(&the_index, at)
>  #define unmerge_cache(pathspec) unmerge_index(&the_index, pathspec)
> +#define read_blob_data_from_cache(path) read_blob_data_from_index(&the_index, (path))
>  #endif
>  
>  enum object_type {
> @@ -452,7 +453,7 @@ extern int add_file_to_index(struct index_state *, const char *path, int flags);
>  extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, int refresh);
>  extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
>  extern int index_name_is_other(const struct index_state *, const char *, int);
> -extern void *read_blob_data_from_index_path(const char *path, struct index_state *use_index);
> +extern void *read_blob_data_from_index(struct index_state *, const char *);
>  
>  /* do stat comparison even if CE_VALID is true */
>  #define CE_MATCH_IGNORE_VALID		01
> diff --git a/read-cache.c b/read-cache.c
> index cbeb248..48d87e8 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1896,14 +1896,12 @@ int index_name_is_other(const struct index_state *istate, const char *name,
>  	return 1;
>  }
>  
> -void *read_blob_data_from_index_path(const char *path,
> -				     struct index_state *use_index)
> +void *read_blob_data_from_index(struct index_state *istate, const char *path)
>  {
>  	int pos, len;
>  	unsigned long sz;
>  	enum object_type type;
>  	void *data;
> -	struct index_state *istate = use_index ? use_index : &the_index;
>  
>  	len = strlen(path);
>  	pos = index_name_pos(istate, path, len);
> -- 
> 1.8.2.1-514-gf369d36
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
