From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH v2] Custom compression levels for objects and packs
Date: Tue, 8 May 2007 17:25:24 -0700
Message-ID: <56b7f5510705081725v655d2ce1j28712507cfa7fa55@mail.gmail.com>
References: <4640FBDE.1000609@gmail.com>
	 <7vk5vi27ko.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 09 02:25:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlZzo-0007DX-IV
	for gcvg-git@gmane.org; Wed, 09 May 2007 02:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967363AbXEIAZ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 20:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967378AbXEIAZ1
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 20:25:27 -0400
Received: from nz-out-0506.google.com ([64.233.162.231]:58753 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967363AbXEIAZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 20:25:26 -0400
Received: by nz-out-0506.google.com with SMTP id o1so18049nzf
        for <git@vger.kernel.org>; Tue, 08 May 2007 17:25:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qq9P2hRt886fbRS7MkzH3auNCJ1f5Qv6EHayAotl91gIAi4d14pZ8FCFi41wui1olfb3Ieyy6QwHhVpgCfUYwb21FKyehs2zVubzR/PkjSCXDSw+PUpQ3VuZqzNOpTBSZpQRSXzXdRwVoYBMLiT6WJKEV6aPDLMMziQEz+AKhpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F413tBfJtsMcLELkM5BbqR0xtVaSVdD78SMS3kjjEVsevvz+/0uxuJkcDMF5UNTtxIqg1r7/ZpuOMHGjeSk7vS+F8ldB6JhPYx9IWy0UmnMGqgzqZJFWS92N5ifaF+jaFMqmgwHTNticFwgO2RPFnEQ//ghgDDksC5dquR5xZpM=
Received: by 10.114.24.1 with SMTP id 1mr2814645wax.1178670324923;
        Tue, 08 May 2007 17:25:24 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Tue, 8 May 2007 17:25:24 -0700 (PDT)
In-Reply-To: <7vk5vi27ko.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46644>

On 5/8/07, Junio C Hamano <junkio@cox.net> wrote:
> Dana How <danahow@gmail.com> writes:
> > Add config variables pack.compression and core.loosecompression .
> > Loose objects will be compressed using level
> >   isset(core.loosecompression) ? core.loosecompression :
> >   isset(core.compression) ? core.compression : Z_BEST_SPEED
> > and objects in packs will be compressed using level
> >   isset(pack.compression) ? pack.compression :
> >   isset(core.compression) ? core.compression : Z_DEFAULT_COMPRESSION
> > pack-objects also accepts --compression=N which
> > overrides the latter expression.
>
> Do you think the above is readable?
>   Compression level for loose objects is controlled by variable
>   core.loosecompression (or core.compression, if the former is
>   missing), and defaults to best-speed.
> or something like that?
Your phrasing is much better.

> > This applies on top of the git-repack --max-pack-size patchset.
> Hmph, that makes the --max-pack-size patchset take this more
> trivial and straightforward improvements hostage.  In general,
> I'd prefer more elaborate ones based on less questionable
> series.
The max-pack-size and pack.compression patches touch the same lines.
I thought my options were:
* Submit independently and make you merge; or
* Make one precede the other.
Since max-pack-size has been out there since April 4 and
the first acceptable version was May 1 (suggested by 0 comments),
I didn't realize it was a "questionable series".

I think it should be straightforward for me to re-submit this
based on current master.

> > +     /* differing core & pack compression when loose object -> must recompress */
> > +     if (!entry->in_pack && pack_compression_level != zlib_compression_level)
> > +             to_reuse = 0;
> > +     else
> I am not sure if that is worth it, as you do not know if the
> loose object you are looking at were compressed with the current
> settings.
You do not know for certain, that is correct.  However, config
settings setting unequal compression levels signal that you
care differently about the two cases. (For me,  I want the
compression investment to correspond to the expected lifetime of the file.)
Also,  *if* we have the knobs we want in the config file,
I don't think we're going to be changing these settings all that often.

If I didn't have this check forcing recompression in the pack,
then in the absence of deltification each object would enter the pack
by being copied (in the preceding code block) and pack.compression
would have little effect.  I actually experienced this the very first
time I imported a large dataset into git (I was trying to achieve the
effect of this patch by changing core.compression dynamically,  and
was a bit mystified for a while by the result).

Thus,  if core.loosecompression is set to speed up git-add,  I should
take the time to recompress the object when packing if pack.compression
is different (of course the hit of not doing so will be lessened by
deltification
which forces a new compression).

> > diff --git a/cache.h b/cache.h
> > index 8e76152..2b3f359 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -283,6 +283,8 @@ extern int warn_ambiguous_refs;
> >  extern int shared_repository;
> >  extern const char *apply_default_whitespace;
> >  extern int zlib_compression_level;
> > +extern int core_compression_level;
> > +extern int core_compression_seen;
>
> Could we somehow remove _seen?  Perhaps by initializing the
> _level to -1?
>
> > +int core_compression_level;
> > +int core_compression_seen;
>
> Same here.
I agree completely.  But,  what magic value should I use
to initialize the _level variables so I know they are not set?
All valid settings come from zlib.h through #define's but
there is no "invalid" defined.  Maybe I'll use -99.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
