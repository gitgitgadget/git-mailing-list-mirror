From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] fast-import: use struct hash_table for atom strings
Date: Fri, 1 Apr 2011 21:42:09 -0500
Message-ID: <20110402024209.GA6039@elie>
References: <1301572798-9973-1-git-send-email-david.barr@cordelta.com>
 <1301572798-9973-2-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Stephen Boyd <bebarino@gmail.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 04:42:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5qnA-0005mg-4E
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 04:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442Ab1DBCmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 22:42:18 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:62522 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab1DBCmR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 22:42:17 -0400
Received: by yia27 with SMTP id 27so1643318yia.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 19:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=dnxY9Ib/SukludjDA7m2VqB5dCOW/ZXxBu2FzBtHz3Q=;
        b=SNmAGh6nIOFihUSwyIDCyrss7upqB6Gxnftsc3uY4catFRdF4tymbeg58pvRmv2WlW
         D0YRktrmi6vjKyfPUkiWFGN/uBCOc2u6XU19QExhq7aGIsPPvncxhTgzridI6a3+U/DA
         2ir2pApgmrklnTp/Te9FJlvp2IT3lLBUh2tL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dejtFX3xbo9Ij45Jl4cOvEZE/a/Ry5N3I99iGXMnhOz1dhgUyL25aneM0A3ISg7pqV
         I+7XUwpV/473Nwkh5fLAblzKAjnEeJiwmpkaIuuLUfCdTLt9GmJ5n8wa9TklMoBIXQpJ
         Z2UZMcgpAzTUL+QPTlYVvJGAiYrRucRFU3F2k=
Received: by 10.151.62.38 with SMTP id p38mr4657909ybk.12.1301712136374;
        Fri, 01 Apr 2011 19:42:16 -0700 (PDT)
Received: from elie (adsl-68-255-107-98.dsl.chcgil.ameritech.net [68.255.107.98])
        by mx.google.com with ESMTPS id f5sm645441ybh.13.2011.04.01.19.42.13
        (version=SSLv3 cipher=OTHER);
        Fri, 01 Apr 2011 19:42:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1301572798-9973-2-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170638>

Hi,

David Barr wrote:

> Signed-off-by: David Barr <david.barr@cordelta.com>

Thanks, this is a welcome change.  But perhaps it would be nice to
explain why, here? :)

E.g., what is stored in the atom table? does it tend to get big?  does
the existing code allow it to grow? this change will allow it to grow,
right? what is the downside to this change (if any)?

Especially, numbers (timings) illustrating the effect on typical
use and effect on scalability would be interesting.

> ---
>  fast-import.c |   17 ++++++++++-------
>  1 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/fast-import.c b/fast-import.c
> index 65d65bf..0592b21 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -300,9 +300,8 @@ static size_t total_allocd;
>  static struct mem_pool *mem_pool;
>  
>  /* Atom management */
> -static unsigned int atom_table_sz = 4451;
>  static unsigned int atom_cnt;
> -static struct atom_str **atom_table;
> +static struct hash_table atom_table;
>  
>  /* The .pack file being generated */
>  static unsigned int pack_id;
> @@ -680,10 +679,11 @@ static struct object_entry *find_mark(uintmax_t idnum)
>  
>  static struct atom_str *to_atom(const char *s, unsigned short len)
>  {
> -	unsigned int hc = hc_str(s, len) % atom_table_sz;
> +	unsigned int hc = hc_str(s, len);
>  	struct atom_str *c;
> +	void **pos;
>  
> -	for (c = atom_table[hc]; c; c = c->next_atom)
> +	for (c = lookup_hash(hc, &atom_table); c; c = c->next_atom)
>  		if (c->str_len == len && !strncmp(s, c->str_dat, len))
>  			return c;
>  
> @@ -691,8 +691,12 @@ static struct atom_str *to_atom(const char *s, unsigned short len)
>  	c->str_len = len;
>  	strncpy(c->str_dat, s, len);
>  	c->str_dat[len] = 0;
> -	c->next_atom = atom_table[hc];
> -	atom_table[hc] = c;
> +	c->next_atom = NULL;
> +	pos = insert_hash(hc, c, &atom_table);
> +	if (pos) {
> +		c->next_atom = *pos;
> +		*pos = c;
> +	}

If I understand correctly, this puts new atoms at the start of the
chain, just like v1.7.4-rc0~40^2 (fast-import: insert new object
entries at start of hash bucket, 2010-11-23) did for objects.  Did you
measure and find this faster, or is it just for simplicity or
consistency?  (I'd personally be fine with it either way, but it seems
prudent to ask.)

>  	atom_cnt++;
>  	return c;
>  }
> @@ -3263,7 +3267,6 @@ int main(int argc, const char **argv)
>  
>  	alloc_objects(object_entry_alloc);
>  	strbuf_init(&command_buf, 0);
> -	atom_table = xcalloc(atom_table_sz, sizeof(struct atom_str*));
>  	branch_table = xcalloc(branch_table_sz, sizeof(struct branch*));
>  	avail_tree_table = xcalloc(avail_tree_table_sz, sizeof(struct avail_tree_content*));
>  	marks = pool_calloc(1, sizeof(struct mark_set));

We never call init_hash.  That's technically safe because init_hash
just zeroes out the table, but I think I'd rather see us using it
anyway or documenting in api-hash.txt that it's safe not to use.

Looks good.  Will queue to give it some testing.
