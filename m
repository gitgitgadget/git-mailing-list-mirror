From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] fast-import: use struct hash_table for objects
Date: Fri, 1 Apr 2011 21:46:36 -0500
Message-ID: <20110402024636.GB6039@elie>
References: <1301572798-9973-1-git-send-email-david.barr@cordelta.com>
 <1301572798-9973-3-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Stephen Boyd <bebarino@gmail.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 04:46:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5qrR-0003Db-U3
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 04:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728Ab1DBCqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 22:46:42 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:53433 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082Ab1DBCql (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 22:46:41 -0400
Received: by yia27 with SMTP id 27so1644139yia.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 19:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=bcKoEyQizOpNIx8IiQBcGv0FpCsPTyFbBfGo+ICU4m4=;
        b=pZgZyBAaPnR7Wgm6sxaPBrmAuS+hvs3FZveDn7wIYnfeEGK3Ku7fQbruXp8ihsFbjN
         nx5Khb3LrzDkzLkPM6wX34iA6PJip66eiVHKw4d5HyqLVFh7t79Q5LA2HXIo8SXLH+nx
         12QFmfZDb0aiBcSwy6E7RP5V/o0Qd4jTFx33k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ibwNComhX8NVyDp8jFfbMGYj7lEzvnBtxzNok/GoMUBLACcQ1Z5U3yVpfdK46wgy56
         6Mn2tIjxv5R2lCo8Lww6l0fguzO0W7UGhxye3/KttEHWqzrpOa+JozD+9QC7c9zA3OmO
         NV26e4vOCRV76CmZrqLya4/8gE2o1me/FZmcg=
Received: by 10.42.97.66 with SMTP id m2mr2012839icn.515.1301712401121;
        Fri, 01 Apr 2011 19:46:41 -0700 (PDT)
Received: from elie (adsl-68-255-107-98.dsl.chcgil.ameritech.net [68.255.107.98])
        by mx.google.com with ESMTPS id 13sm1857314ibo.25.2011.04.01.19.46.39
        (version=SSLv3 cipher=OTHER);
        Fri, 01 Apr 2011 19:46:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1301572798-9973-3-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170639>

David Barr wrote:

> Signed-off-by: David Barr <david.barr@cordelta.com>

Thanks, this one is even more welcome. :)  Same comments as the other
patch apply.  Keeping the patch in full below so others can comment.

One comment below (search for object.c to find it; sorry).

> ---
>  fast-import.c |   19 ++++++++++++-------
>  1 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/fast-import.c b/fast-import.c
> index 0592b21..8fd8ea9 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -313,7 +313,7 @@ static off_t pack_size;
>  /* Table of objects we've written. */
>  static unsigned int object_entry_alloc = 5000;
>  static struct object_entry_pool *blocks;
> -static struct object_entry *object_table[1 << 16];
> +static struct hash_table object_table;
>  static struct mark_set *marks;
>  static const char *export_marks_file;
>  static const char *import_marks_file;
> @@ -555,9 +555,9 @@ static struct object_entry *new_object(unsigned char *sha1)
>  
>  static struct object_entry *find_object(unsigned char *sha1)
>  {
> -	unsigned int h = sha1[0] << 8 | sha1[1];
> +	unsigned int h = sha1[0] << 24 | sha1[1] << 16 | sha1[2] << 8 | sha1[3];
>  	struct object_entry *e;
> -	for (e = object_table[h]; e; e = e->next)
> +	for (e = lookup_hash(h, &object_table); e; e = e->next)
>  		if (!hashcmp(sha1, e->idx.sha1))
>  			return e;
>  	return NULL;
> @@ -565,8 +565,9 @@ static struct object_entry *find_object(unsigned char *sha1)
>  
>  static struct object_entry *insert_object(unsigned char *sha1)
>  {
> -	unsigned int h = sha1[0] << 8 | sha1[1];
> -	struct object_entry *e = object_table[h];
> +	unsigned int h = sha1[0] << 24 | sha1[1] << 16 | sha1[2] << 8 | sha1[3];
> +	struct object_entry *e = lookup_hash(h, &object_table);
> +	void **pos;

object.c uses memcpy for this, like so:

	memcpy(&h, sha1, sizeof(unsigned int));

which strikes me as sensible (to avoid fighting with the machine about
endianness since this table is only in memory).

>  
>  	while (e) {
>  		if (!hashcmp(sha1, e->idx.sha1))
> @@ -575,9 +576,13 @@ static struct object_entry *insert_object(unsigned char *sha1)
>  	}
>  
>  	e = new_object(sha1);
> -	e->next = object_table[h];
> +	e->next = NULL;
>  	e->idx.offset = 0;
> -	object_table[h] = e;
> +	pos = insert_hash(h, e, &object_table);
> +	if (pos) {
> +		e->next = *pos;
> +		*pos = e;
> +	}
>  	return e;
>  }
>  
> -- 
> 1.7.3.2.846.gf4b062
> 
