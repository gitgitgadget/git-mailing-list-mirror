From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: replaced objects and working directory
Date: Sun, 25 Jul 2010 01:02:07 -0500
Message-ID: <20100725060207.GA17601@burratino>
References: <AANLkTi=3=MX8+U4Oq4q_RACyxFYj-HmBYXFBxxQdFf_e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 08:03:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcuIw-0003dw-12
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 08:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210Ab0GYGDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 02:03:13 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:32873 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858Ab0GYGDM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 02:03:12 -0400
Received: by iwn7 with SMTP id 7so1713724iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 23:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bR6fWMfasMF3XFjuSOnq4nSfP9y/yI0bGEU7SEt/EF8=;
        b=r9I8YBTkRrYz5+Q7C3APC2Czz3E0eonFMVyRh4t4nw82KZdhkNy/XUTGu9o3JfQ9OA
         Vl7wV1QbQQfFo3uWC264tV3FEwEBTX4RgmMuzzaryCWdS8cSTRq/HkJb3BfsVEV7huTz
         YfaC5a8CJR1yHKC6EPfQXJ4kNp/tBeD4Ja77k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dZYQRW4XXs3eIVGp38IsAJULcpfw5nRTNuAHkMkG98I01E7bC+Z2+9d52qQr3L2A4C
         i5HEosGDLnpPnMVMxDMMhjLdHs5lsgdDqqAVz6+ExyLC/VUMjVL1sEA+EJb+2o6J3LBr
         VHJpzsD5tJeGbVzUR0i8lezU3RK9yVz20ouXs=
Received: by 10.231.14.137 with SMTP id g9mr6311595iba.183.1280037791520;
        Sat, 24 Jul 2010 23:03:11 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 34sm2164662ibi.12.2010.07.24.23.03.10
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 23:03:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=3=MX8+U4Oq4q_RACyxFYj-HmBYXFBxxQdFf_e@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151708>

Nguyen Thai Ngoc Duy wrote:

> Should worktree (or the index) be aware of replaced objects?

The following is only about replaced blobs (replaced trees are
harder to deal with, I think).

Two uses to keep in mind:

 1. "git checkout", "git diff", and so on to explore the
    tweaked history (as you mentioned).

 2. "git write-tree" as used by filter-branch to set the
    new history in stone.

1) Currently read-tree does not do anything special with replaced
blobs; it is up to checkout-index to get the substituted blob object
and write a different file to disk.  Unfortunately when update-index
tries to read it back, that means it looks like the file has changed.

> Maybe "git status" and similar operations should also
> check worktree version against the replaced version, in addition to
> the original version?

It might be simpler to check against only the replaced version, like
this:

| diff --git i/read-cache.c w/read-cache.c
| index f1f789b..0f031da 100644
| --- i/read-cache.c
| +++ w/read-cache.c
| @@ -93,7 +93,7 @@ static int ce_compare_data(struct cache_entry *ce, struct stat *st)
|  	if (fd >= 0) {
|  		unsigned char sha1[20];
|  		if (!index_fd(sha1, fd, st, 0, OBJ_BLOB, ce->name))
| -			match = hashcmp(sha1, ce->sha1);
| +			match = hashcmp(sha1, lookup_replace_object(ce->sha1));
|  		/* index_fd() closed the file descriptor already */
|  	}
|  	return match;
| @@ -134,7 +134,7 @@ static int ce_compare_gitlink(struct cache_entry *ce)
|  	 */
|  	if (resolve_gitlink_ref(ce->name, "HEAD", sha1) < 0)
|  		return 0;
| -	return hashcmp(sha1, ce->sha1);
| +	return hashcmp(sha1, lookup_replace_object(ce->sha1));
|  }
|  
|  static int ce_modified_check_fs(struct cache_entry *ce, struct stat *st)
| @@ -232,7 +232,7 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
|  
|  	/* Racily smudged entry? */
|  	if (!ce->ce_size) {
| -		if (!is_empty_blob_sha1(ce->sha1))
| +		if (!is_empty_blob_sha1(lookup_replace_object(ce->sha1)))
|  			changed |= DATA_CHANGED;
|  	}
|  

The main downside is that if you remove and re-add an index entry,
this is no longer a no-op.  But I think that getting "update-index
--refresh" to be content should be enough to make exploring the
alternate objects bearable.

2) write-tree trusts the index as far as blobs go and rewrites all
the trees itself.  Probably it should dereference replace refs for
replaced blobs, which would make the "rewriting everything" behavior
more consistent.

| diff --git i/cache-tree.c w/cache-tree.c
| index d917437..43d5030 100644
| --- i/cache-tree.c
| +++ w/cache-tree.c
| @@ -324,7 +324,7 @@ static int update_one(struct cache_tree *it,
|  			mode = S_IFDIR;
|  		}
|  		else {
| -			sha1 = ce->sha1;
| +			sha1 = lookup_replace_object(ce->sha1);
|  			mode = ce->ce_mode;
|  			entlen = pathlen - baselen;
|  		}

I once had plans for these two tasks and time ran out.  
http://thread.gmane.org/gmane.comp.version-control.git/139204/focus=139222

Hope that helps,
Jonathan
