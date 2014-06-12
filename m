From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v2 01/19] add strbuf_set operations
Date: Thu, 12 Jun 2014 00:10:45 -0700
Message-ID: <20140612071045.GC25353@hudson.localdomain>
References: <cover.1402348696.git.jmmahler@gmail.com>
 <6fe33498512fc2ca1678517e51dc2e94a4260ff4.1402348696.git.jmmahler@gmail.com>
 <5398460F.3040900@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 12 09:10:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wuz9w-0001hQ-S5
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 09:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbaFLHKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 03:10:49 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:60824 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932111AbaFLHKs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 03:10:48 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so707586pab.1
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 00:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+26c0OUEB8jsvb3ZOpk+BN0YsUxO7BtWzjHSumuxzw4=;
        b=HFDFRT10D01cKvyVAAlC8mIUvXgOODCcxxWOuoDHu11rhLn4knabM4pL7B9z2A8oHe
         3z6Yg07UybFB0YDmEAXEPitX+xMP1JhZH5XEYM6sBrMt9yJU41CURlRq4eG3uq9wzv2M
         VKhWvlGH3ososyERvkE/FHo5CjxPAnwD8D+NjSEcyE+4z7+libQPdCCokitHBibhJZgQ
         +MzjvweyJn5/O6t6f55tBVxfvsI7S0CQjaHLaVGQLXq8ROE2MtV4Sx70vkh2wnzkrTgV
         CfhbBf6ZEi4oJB0xuLTbOURO3Y+rfDv+pEUzFzrbgJJrOIm9g9xgMlvbubKGa27Js99H
         pmLA==
X-Received: by 10.68.163.197 with SMTP id yk5mr10561342pbb.57.1402557048358;
        Thu, 12 Jun 2014 00:10:48 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id ib5sm78648414pbb.55.2014.06.12.00.10.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jun 2014 00:10:47 -0700 (PDT)
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <5398460F.3040900@alum.mit.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251397>

Michael,

On Wed, Jun 11, 2014 at 02:05:35PM +0200, Michael Haggerty wrote:
> On 06/10/2014 12:19 AM, Jeremiah Mahler wrote:
> > Currently, the data in a strbuf is modified using add operations.  To
> > set the buffer to some data a reset must be performed before an add.
> > 
...
> > diff --git a/strbuf.c b/strbuf.c
> > index ac62982..9d64b00 100644
> > --- a/strbuf.c
> > +++ b/strbuf.c
> > @@ -189,6 +189,27 @@ void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
> >  	strbuf_setlen(sb, sb->len + dlen - len);
> >  }
> >  
> > +void strbuf_set(struct strbuf *sb, const void *data, size_t len)
> > +{
> > +	strbuf_reset(sb);
> > +	strbuf_add(sb, data, len);
> > +}
> > +
> 
> I never know how much intelligence to attribute to modern compilers, but
> it seems like even after optimization this function will be doing more
> work than necessary:
> 
>     strbuf_reset(sb)
>     -> strbuf_setlen(sb, 0)
>        -> sb->len = 0
>        -> sb->buf[len] = '\0'
>     -> strbuf_add(sb, data, len)
>        -> strbuf_grow(sb, len)
>           -> ...lots of stuff...
>        -> memcpy(sb->buf + sb->len, data, len)
>        -> strbuf_setlen(sb, sb->len + len)
>           -> sb->len = len
>           -> sb->buf[len] = '\0'
> 
> If there were a function like strbuf_grow_to(sb, len):
> 
> void strbuf_grow_to(struct strbuf *sb, size_t len)
> {
> 	int new_buf = !sb->alloc;
> 	if (unsigned_add_overflows(len, 1))
> 		die("you want to use way too much memory");
> 	if (new_buf)
> 		sb->buf = NULL;
> 	ALLOC_GROW(sb->buf, len + 1, sb->alloc);
> 	if (new_buf)
> 		sb->buf[0] = '\0';
> }
> 
grow_to() which could reduce in size, interesting.

> (strbuf_grow() could call it:
> 
> static inline void strbuf_grow(struct strbuf *sb, size_t extra)
> {
> 	if (unsigned_add_overflows(sb->len, extra))
> 		die("you want to use way too much memory");
> 	strbuf_grow_to(sb, sb->len + extra);
> }
> 
> ), then your function could be minimized to
> 
> void strbuf_set(struct strbuf *sb, const void *data, size_t len)
> {
> 	strbuf_grow_to(sb, len);
> 	memcpy(sb->buf, data, len);
> 	strbuf_setlen(sb, len);
> }
> 
> I think strbuf_grow_to() would be useful in other situations too.
> 
> This is just an idea; I'm not saying that you have to make this change.
> 
I like your idea.  I am leaning towards doing the un-optimized
strbuf_set operations first, then optimizing in a later patch.

> > [...]
> 
> Michael
> 
> -- 
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
