From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v4] cleanup duplicate name_compare() functions
Date: Thu, 19 Jun 2014 13:45:54 -0700
Message-ID: <20140619204554.GA2481@hudson.localdomain>
References: <1403165242-16849-1-git-send-email-jmmahler@gmail.com>
 <1403165242-16849-2-git-send-email-jmmahler@gmail.com>
 <xmqqionwhj54.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 22:46:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxjDf-000239-6R
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 22:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965334AbaFSUp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 16:45:59 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:53257 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964975AbaFSUp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 16:45:58 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so2290679pab.29
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 13:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=qESgpDo7ol1kQF4rAXhAYI0yFfUgOgaCij0yZo15B2A=;
        b=DSdtRfQ2naN4kNtTVuZTEGZBd2TFk4B4hXN33tFrkp1z/rSR96ONp9C9TAyKVqsgJo
         OBzypK25ALHK6aJEZWDl5lxdY7rJtA3OIrxEHgdrIF14l0qHdsARz5B9R5o/TdtO6+Gn
         qiDAwh0OygqStqvJzO+Fn7y6t/qOLxCuT/rHYxTIPNPVm2vIm706H8RCjGG7ZowEDDhF
         9doIlXo1UIs5t1lIczBKgfJpcreoOAoNqZHONHxfuxE7Q83hdm81diLBVF3/0vQLMdqo
         b6TEg6CWzINWSIIjzplv5OD1ZgNnIx+h1ZtMrsQekdszgcr6YXMOgCijyNgiadx4Z7MD
         E9BQ==
X-Received: by 10.68.213.198 with SMTP id nu6mr8467406pbc.21.1403210758417;
        Thu, 19 Jun 2014 13:45:58 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id xk1sm31911551pac.21.2014.06.19.13.45.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jun 2014 13:45:56 -0700 (PDT)
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqionwhj54.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252182>

Junio,

On Thu, Jun 19, 2014 at 11:03:03AM -0700, Junio C Hamano wrote:
> Jeremiah Mahler <jmmahler@gmail.com> writes:
> 
> > Both unpack-trees.c and read-cache.c have their own name_compare()
> > function, which are identical.  And read-cache.c has a
> > cache_name_compare() function which is nearly identical to
> > name_compare() [1].  The cache_name_compare() function is not specific
> > to a cache, other than by being part of cache.h.
> 
> 'other than by designed to be used only for comparing names in the
> cache entries' is probably more accurate, I would think.
> 
> > Generalize the cache_name_compare() function by renaming it to
> > name_compare().  Simplify the cache_name_stage_compare() function using
> > name_compare().  Then change the few instances which used
> > cache_name_compare() to name_compare() [2].
> >
> > [1] cache_name_compare() is not identical to name_compare().  The former
> >     returns +1, -1, whereas the latter returns +N, -N.  But there is no
> >     place where name_compare() is used that needs the magnitude so this
> >     difference does not alter its behavior.
> 
> You chose to use the one that loses the information by unifying
> these two into the variant that only returns -1/0/+1.  We know that
> it does not matter for the current callers, but is it expected that
> no future callers will benefit by having the magnitude information?
> 
> > [2] The instances where cache_name_compare() is used have nothing to do
> >     with a cache.  The new name, name_compare(), makes it clear that no
> >     cache is involved.
> 
> This is redundant and should be dropped, as you already said "is not
> specific to a cache" earlier.
> 
> > Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
> > ---
> >  cache.h        |  2 +-
> >  dir.c          |  3 +--
> >  name-hash.c    |  2 +-
> >  read-cache.c   | 23 +++++++++++++----------
> >  tree-walk.c    | 10 ----------
> >  unpack-trees.c | 11 -----------
> >  6 files changed, 16 insertions(+), 35 deletions(-)
> >
> > diff --git a/cache.h b/cache.h
> > index c498a30..e3205fe 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -1027,7 +1027,7 @@ extern int validate_headref(const char *ref);
> >  
> >  extern int base_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
> >  extern int df_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
> > -extern int cache_name_compare(const char *name1, int len1, const char *name2, int len2);
> > +extern int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
> >  extern int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
> >  
> >  extern void *read_object_with_reference(const unsigned char *sha1,
> > diff --git a/dir.c b/dir.c
> > index 797805d..e65888d 100644
> > --- a/dir.c
> > +++ b/dir.c
> > @@ -1354,8 +1354,7 @@ static int cmp_name(const void *p1, const void *p2)
> >  	const struct dir_entry *e1 = *(const struct dir_entry **)p1;
> >  	const struct dir_entry *e2 = *(const struct dir_entry **)p2;
> >  
> > -	return cache_name_compare(e1->name, e1->len,
> > -				  e2->name, e2->len);
> > +	return name_compare(e1->name, e1->len, e2->name, e2->len);
> >  }
> >  
> >  static struct path_simplify *create_simplify(const char **pathspec)
> > diff --git a/name-hash.c b/name-hash.c
> > index be7c4ae..e2bea88 100644
> > --- a/name-hash.c
> > +++ b/name-hash.c
> > @@ -179,7 +179,7 @@ static int same_name(const struct cache_entry *ce, const char *name, int namelen
> >  	 * Always do exact compare, even if we want a case-ignoring comparison;
> >  	 * we do the quick exact one first, because it will be the common case.
> >  	 */
> > -	if (len == namelen && !cache_name_compare(name, namelen, ce->name, len))
> > +	if (len == namelen && !name_compare(name, namelen, ce->name, len))
> >  		return 1;
> 
> The existing code is somewhat strange; while the update is correct
> in the context of this patch, it may further want to be fixed in a
> later patch to either
> 
> 	!name_compare(name, namelen, ce->name, len)
> 
> or
> 
> 	len == namelen && !memcmp(name, ce->name, len)
> 
I did not notice that, good catch.  Since that line is going to be
changed I can make a short fixup patch before the main patch and avoid
the rename.

> The patch text looks good.
> 
> Thanks.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
