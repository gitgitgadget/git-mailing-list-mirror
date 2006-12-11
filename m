X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [ANNOUNCE] CGit v0.1-pre
Date: Mon, 11 Dec 2006 18:40:48 +0100
Message-ID: <8c5c35580612110940p767fd360p52762a8818fbc8c1@mail.gmail.com>
References: <8c5c35580612101542n72d300c7o106e53e219670510@mail.gmail.com>
	 <Pine.LNX.4.64.0612101653420.12500@woody.osdl.org>
	 <8c5c35580612110033y4f6260c9xffeaf4457f4ead21@mail.gmail.com>
	 <Pine.LNX.4.64.0612110859200.12500@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 17:41:04 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TWCJ1QqoTez1Uw3I2tFic7SOezmD7qxKZqagogiyaq8zAG+SyIVdu7/AjOuYYisxzQjQvGVTQB1KAo56uAYOqwrQdBsxGOowN9HR0+KchwsU94DghoRt0wAgRBDNCM7LIrhOCOpdX1MYlr+DJnQeKZTyRMu4Pny2NTx4APKb0aY=
In-Reply-To: <Pine.LNX.4.64.0612110859200.12500@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34022>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtp94-0007xW-CW for gcvg-git@gmane.org; Mon, 11 Dec
 2006 18:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1763002AbWLKRkv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 12:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763003AbWLKRkv
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 12:40:51 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:33818 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1763002AbWLKRku (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 12:40:50 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2058375nfa for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 09:40:49 -0800 (PST)
Received: by 10.82.172.15 with SMTP id u15mr1108512bue.1165858848538; Mon, 11
 Dec 2006 09:40:48 -0800 (PST)
Received: by 10.82.171.10 with HTTP; Mon, 11 Dec 2006 09:40:48 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 12/11/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
> On Mon, 11 Dec 2006, Lars Hjemli wrote:
> > Anyway, I must say I find it rather unlikely for these cases to occur
> > (frequently) in real life. That would seem to imply that the caching
> > isn't really needed at all.
>
> The point is, if you have races, you will hit them _occasionally_. It may
> not be a performance problem in real life, BUT:
>
>  - quite often, you can take advantage of the serialization guarantees
>    that a front-side cache offers you, and do the uncached accesses (or
>    writing the final cache-file) knowing that there's only one thing that
>    does that.
>
>  - If so, then a race condition in the cache goes from a "unlikely
>    performance problem" to a BUG.

Yes, I finally understood (see my other reply)


> > > As a side note: how do you release your caches?
> >
> > Simple timeouts (time()-stat.st_mtime), depending on what kind of page
> > was requested. If anyone cares about invalid cache content (branch
> > head moving), relevant cachefiles can be deleted with an update-hook.
>
> I was more thinking about the locking part. Again, to be safe, you should
> probably take the lock before releasing any cache.

Ok. Code speeks louder than words, so I'll blatantly paste the key functions:

--->8----

const int NOLOCK = -1;

int cache_lock(struct cacheitem *item)
{
	int i = 0;
	char *lockfile = fmt("%s.lock", item->name);

 top:
	if (++i > cgit_max_lock_attempts)
		die("cache_lock: unable to lock %s: %s",
		    item->name, strerror(errno));

       	item->fd = open(lockfile, O_WRONLY|O_CREAT|O_EXCL, S_IRUSR|S_IWUSR);

	if (item->fd == NOLOCK && errno == ENOENT && cache_create_dirs())
		goto top;

	if (item->fd == NOLOCK && errno == EEXIST &&
	    cache_refill_overdue(lockfile) && !unlink(lockfile))
			goto top;

	return (item->fd > 0);
}

int cache_unlock(struct cacheitem *item)
{
	close(item->fd);
	return (rename(fmt("%s.lock", item->name), item->name) == 0);
}


static void cgit_check_cache(struct cacheitem *item)
{
	int i = 0;

	cache_prepare(item);
 top:
	if (++i > cgit_max_lock_attempts) {
		die("cgit_refresh_cache: unable to lock %s: %s",
		    item->name, strerror(errno));
	}
	if (!cache_exist(item)) {
		if (!cache_lock(item)) {
			sleep(1);
			goto top;
		}
		if (!cache_exist(item))
			cgit_fill_cache(item);
		cache_unlock(item);
	} else if (cache_expired(item) && cache_lock(item)) {
		if (cache_expired(item))
			cgit_fill_cache(item);
		cache_unlock(item);
	}
}

--->8----

I am a bit conserned about the effect of cache_unlink() if another
concurrent process gets "lucky" with the test
"cache_refill_overdue(lockfile) && !unlink(lockfile)".

This is supposed to be a safety valve against a stale lock file (lock
file not modified in n secs), but it doesn't feel quite right.

Probably, if cache_unlink() fails in cgit_check_cache(), I should "goto top".

Opinions?

-- 
