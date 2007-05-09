From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH v2] Custom compression levels for objects and packs
Date: Wed, 9 May 2007 02:21:45 -0700
Message-ID: <56b7f5510705090221g38ab0973x8631dacc601abb16@mail.gmail.com>
References: <4640FBDE.1000609@gmail.com>
	 <7vk5vi27ko.fsf@assigned-by-dhcp.cox.net>
	 <56b7f5510705081725v655d2ce1j28712507cfa7fa55@mail.gmail.com>
	 <alpine.LFD.0.99.0705082106590.24220@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 09 11:21:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HliMt-0003Za-U9
	for gcvg-git@gmane.org; Wed, 09 May 2007 11:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032AbXEIJVs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 05:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756030AbXEIJVs
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 05:21:48 -0400
Received: from nz-out-0506.google.com ([64.233.162.227]:38776 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900AbXEIJVq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 05:21:46 -0400
Received: by nz-out-0506.google.com with SMTP id o1so124208nzf
        for <git@vger.kernel.org>; Wed, 09 May 2007 02:21:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xs5VangQl2amyT8IjgNAan1IWI9EtBQUqFagpqLsg9t1z0mteSNCjYMRqZfyFaj1RDJmE6EHY5EHjfNybAPEvEnDKHjwHdavAb8mupCNHES1zOouGufDacIRTmsxQdrofMhCMdEBMvhg+LMrOaF7hZKM7l7N7Lp0iy/l66bhwro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HsUr51Vp4JyPuIO4NVWhDoRUGY17RLupMGpnCQq2VJAdcT0+cYitbjK/uemOOeS8NG9SHZqDJkZYwrkkahsQ15N5qqDxVSXw3owPJQ/a6xjIqb7vj2b0NUqiAKhwCSpfRFdAze3DNZOe3pw9wh5lKRUc4ULB7DKUvbzW94rtH04=
Received: by 10.114.181.1 with SMTP id d1mr133102waf.1178702505375;
        Wed, 09 May 2007 02:21:45 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Wed, 9 May 2007 02:21:45 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.99.0705082106590.24220@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46688>

On 5/8/07, Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 8 May 2007, Dana How wrote:
> > I think it should be straightforward for me to re-submit this
> > based on current master.
> Since this patch is simpler it could be merged much faster, before the
> pack limit series.
Yes,  I will do "custom compression" patch first.

> > > > +     /* differing core & pack compression when loose object -> must
> > > recompress */
> > > I am not sure if that is worth it, as you do not know if the
> > > loose object you are looking at were compressed with the current
> > > settings.
> > You do not know for certain, that is correct.  However, config
> > settings setting unequal compression levels signal that you
> > care differently about the two cases. (For me,  I want the
> > compression investment to correspond to the expected lifetime of the file.)
> > Also,  *if* we have the knobs we want in the config file,
> > I don't think we're going to be changing these settings all that often.
> >
> > If I didn't have this check forcing recompression in the pack,
> > then in the absence of deltification each object would enter the pack
> > by being copied (in the preceding code block) and pack.compression
> > would have little effect.  I actually experienced this the very first
> > time I imported a large dataset into git (I was trying to achieve the
> > effect of this patch by changing core.compression dynamically,  and
> > was a bit mystified for a while by the result).
> >
> > Thus,  if core.loosecompression is set to speed up git-add,  I should
> > take the time to recompress the object when packing if pack.compression
> > is different (of course the hit of not doing so will be lessened by
> > deltification
> > which forces a new compression).
>
> Right.  And this also depends whether or not you have core.legacyheaders
> set to false or not.
>
> And the whole purpose for setting core.legacyheaders is exactly to allow
> for loose objects to be copied straight into the pack.  This should have
> priority over mismatched compression levels IMHO.
OK,  I got really confused here, so I looked over the code,
and figured out 2 causes for my confusion.
(1) core.legacyheaders controls use_legacy_headers, which defaults to 1.
So currently all loose objects are in legacy format and the code block
I spoke of doesn't trigger [without a config setting].  I didn't realize
legacy headers were still being produced (mislead by the name!).
(2) I read your "setting core.legacyheaders" as followed by TRUE,
but you meant FALSE, which is not the default.

I also read that 1 year after 1.4.2, the default for core.legacyheaders is going
to change to FALSE.  I think our discussion should assume this has
happened.  So let's assume FALSE in the following.  The point of that
is that such a FALSE setting can't be assumed to have any special intent;
it will be the default.

[Everything I write here boils down to only one question,
 which I repeat at the end.]

Data gets into a pack in these ways:
1. Loose object copied in;
2. Loose object newly deltified;
3. Packed object to be copied;
4. Packed object to be newly deltified;
5. Packed deltified object we can't re-use;
6. Packed deltified object we can re-use.
["copied" includes recompressed.]

In (2), (4), and (5), pack.compression will always be newly used.
If pack.compression doesn't change,  this means (6)
will be using pack.compression since it comes from (2) or (4).
So if I "guarantee" that (1) uses pack.compression,
(3) will as well, meaning everything in the pack will be
at pack.compression.

Thus if pack.compression != core.loosecompression takes precedence
over core.legacyheaders = false,  then for pack.compression constant
we get all 6 cases at level pack.compression.  If core.legacyheaders =
false takes precedence as you suggest,  then all undeltified objects
(20%?) will be stuck at core.loosecompression [since I see no way
to sensibly re-apply compression to something copied pack-to-pack].
I think this is inconsistent with what a pack.compression !=
core.loosecompression setting is telling us.

My arguments have 2 biases.
(a) I assume pack.compression stays constant, and if it changes,
I see little value in worrying about "forcing" all objects in a new pack,
some of which might be copied from an old pack, to be at the same
compression level.
(b) I focused first on packing to disk,  where a constant pack.compression
makes sense. For packing to stdout (pack transfer),  especially on
a popular, hence loaded, repository server, we may want to use
--compress=N to crank down on effort spent compressing new deltas [2+4]
(or loose objects [1]) (or unusable deltas [5]).  This still lets
better compressed
objects flow through in the other cases [3+6].  So for one-use packs,
a mix of compression levels could be desirable and
is achievable with --compression=N if/when so.

> Also, when repacking, delta reuse does not recompress objects for the
> same reason, regardless of the compression level used when they were
> compressed initially.  Same argument goes for delta depth.
Delta reuse doesn't need recompression.  For pack.compression
constant,  they will already be at the correct level.  I think we agree
on behavior here for different reasons.

> So if you really want to ensure a compression level on the whole pack,
> you'll have to use -f with git-repack. Or leave core.legacyheaders
> unset.
-f would be needed if you were in the practice of changing
pack.compression, yes.

So, after covering all these cases, have I convinced you that
recompression takes precedence over legacyheaders = FALSE?

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
