From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: fact-import: failed to apply delta
Date: Tue, 10 Feb 2009 16:51:13 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0902101646530.19665@iabervon.org>
References: <20090210155626.GM30949@spearce.org> <alpine.LNX.1.00.0902101118110.19665@iabervon.org> <20090210172212.GR30949@spearce.org> <alpine.LNX.1.00.0902101226580.19665@iabervon.org> <20090210191220.GT30949@spearce.org> <alpine.LNX.1.00.0902101427300.19665@iabervon.org>
 <20090210201203.GU30949@spearce.org> <alpine.LNX.1.00.0902101520240.19665@iabervon.org> <20090210212539.GV30949@spearce.org> <alpine.LNX.1.00.0902101628140.19665@iabervon.org> <20090210213612.GW30949@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 10 22:53:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX0X7-00050B-3b
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 22:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755771AbZBJVvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 16:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755681AbZBJVvR
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 16:51:17 -0500
Received: from iabervon.org ([66.92.72.58]:42289 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754888AbZBJVvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 16:51:16 -0500
Received: (qmail 2492 invoked by uid 1000); 10 Feb 2009 21:51:13 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Feb 2009 21:51:13 -0000
In-Reply-To: <20090210213612.GW30949@spearce.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109320>

On Tue, 10 Feb 2009, Shawn O. Pearce wrote:

> Daniel Barkalow <barkalow@iabervon.org> wrote:
> > On Tue, 10 Feb 2009, Shawn O. Pearce wrote:
> > > 
> > > We should dump the cached_objects table in sha1_file.c during
> > > a checkpoint in fast-import.
> > 
> > No, that one's keyed by sha1, and doesn't get collisions; it's the 
> > delta_base_cache that's the issue; it's keyed by struct packed_git * and 
> > offset.
> 
> Uh, yea, I realize that after I sent the message.  Does this patch
> fix it for you?

Aside from the trivial typo, yes. (Although I can't be 100% sure it didn't 
just happen to change things leading to needing a different test case; I 
can say for sure that it got past the previous code's MTBF, which is a 
good sign.)

> --8<--
> Clear the delta base cache during fast-import checkpoint
> 
> Otherwise we may reuse the same memory address for a totally
> different "struct packed_git", and a previously cached object from
> the prior occupant might be returned when trying to unpack an object
> from the new pack.
> 
> Found-by: Daniel Barkalow <barkalow@iabervon.org>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  cache.h       |    1 +
>  fast-import.c |    1 +
>  sha1_file.c   |    7 +++++++
>  3 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index 8dcc53c..7f1a6e8 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -830,6 +830,7 @@ extern unsigned char* use_pack(struct packed_git *, struct pack_window **, off_t
>  extern void close_pack_windows(struct packed_git *);
>  extern void unuse_pack(struct pack_window **);
>  extern void free_pack_by_name(const char *);
> +extern void clear_delta_base_cache(void);
>  extern struct packed_git *add_packed_git(const char *, int, int);
>  extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t);
>  extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t);
> diff --git a/fast-import.c b/fast-import.c
> index 1935206..03b13e0 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -945,6 +945,7 @@ static void end_packfile(void)
>  {
>  	struct packed_git *old_p = pack_data, *new_p;
>  
> +	clear_delta_base_cache();
>  	if (object_count) {
>  		char *idx_name;
>  		int i;
> diff --git a/sha1_file.c b/sha1_file.c
> index 8868b80..d2dbc96 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1663,6 +1663,13 @@ static inline void release_delta_base_cache(struct delta_base_cache_entry *ent)
>  	}
>  }
>  
> +void clear_delta_base_cache(void)
> +{
> +	unsigned long p;
> +	for (p = 0; p < MAX_DELTA_CACHE; p++)
> +		release_delta_base_cache(&delta_base_cache[p])
> +}
> +
>  static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
>  	void *base, unsigned long base_size, enum object_type type)
>  {
> -- 
> 1.6.2.rc0.186.g417c
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
