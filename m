From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] git-{repack,pack-objects} accept --{pack,blob}-limit to control pack size
Date: Wed, 4 Apr 2007 15:55:18 -0700
Message-ID: <56b7f5510704041555q4e735961ra9ee8008be0d33db@mail.gmail.com>
References: <56b7f5510704041340l5997b04dp853e8270a644ab28@mail.gmail.com>
	 <alpine.LFD.0.98.0704041750030.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Apr 05 00:55:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZENy-0001No-EZ
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 00:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbXDDWzW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 18:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752558AbXDDWzV
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 18:55:21 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:18574 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552AbXDDWzT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 18:55:19 -0400
Received: by wr-out-0506.google.com with SMTP id 76so281281wra
        for <git@vger.kernel.org>; Wed, 04 Apr 2007 15:55:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M4Cn/MqVhbviRyJllebwsONBSJ81yw3lbonVD6YCAA2GF2QR2pJiIHlPnNux8oK+rf1GZW9+tEaV5WkiJqB2VmccMz13acxDnJGSmWIfpf7a/ootYW8Vj3aTiAoAzx4cOuTWHdhHGVhGT/VWRrDVpFN4JhNTaKS9AcR/wt3H6Zo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UmlcU8gtCTxJdJbGtgRu7/wo0x6ZST49jD1t3be/LwRCOloSahSg5HtghDhmgXyKXHAudBqbCh31mvPnQIaezGIaM4LL59lL0tWNaYfgvDT0LGQwwSy7w+qrrNK9dUaNVNGECw2pUBSsIQGF0GVKy9o27LZzvT2NSdKLAEja8S4=
Received: by 10.114.13.1 with SMTP id 1mr439390wam.1175727318498;
        Wed, 04 Apr 2007 15:55:18 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Wed, 4 Apr 2007 15:55:18 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0704041750030.28181@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43785>

On 4/4/07, Nicolas Pitre <nico@cam.org> wrote:
> On Wed, 4 Apr 2007, Dana How wrote:
> > The motivations are to better support portable media,
> > older filesystems,  and larger repositories without
> > awkward enormous packfiles.
>
> I wouldn't qualify "enormous" pack files as "awkward".
>
> It will always be more efficient to have only one pack to deal with
> (when possible of course).
Yes.  "(when possible of course)" refers to the remaining motivations
I didn't explicitly mention: the 32b offset limit in .idx files,
and keeping the mmap code working on a 32b system.
I realize there are better solutions in the pipeline,
but I'd like to address this now (for my own use) and hopefully
also create something useful for 4GB-limited filesystems,
USB sticks, etc.

> > When --pack-limit[=N] is specified and --stdout is not,
> > all bytes in the resulting packfile(s) appear at offsets
> > less than N (which defaults to 1<<31).  The default
> > guarantees mmap(2) on 32b systems never sees signed off_t's.
> > The object stream may be broken into multiple packfiles
> > as a result,  each properly and conventionally built.
> >
>
> This sounds fine.  *However* how do you ensure that the second pack (or
> subsequent packs) is self contained with regards to delta base objects
> when it is _not_ meant to be a thin pack?
Good question.  Search for "int usable_delta" in the patch.
With --pack-limit (offset_limit in C), you can use a delta if the base
is in the same pack and already written out.  The first condition
addresses your concern, and the second handles the case
where the base object gets pushed to the next pack.
These restrictions should be loosened for --thin-pack
but I didn't do that yet.
Also, --pack-limit turns on --no-reuse-delta.
This is not necessary, but not doing it would have meant
hacking up even more conditions which I didn't want to do
on a newbie submission.

> > When --stdout is also specified,  all objects in the
> > resulting packfile(s) _start_ at offsets less than N.
> > All the packfiles appear concatenated on stdout,
> > and each has its object count set to 0.  The behavior
> > without --stdout cannot be duplicated here since
> > lseek(2) is not generally possible on stdout.
>
> Please scrap that.  There is simply no point making --pack-limit and
> --stdout work together.  If the amount of data to send over the GIT
> protocol exceeds 4G (or whatever) it is the receiving end's business to
> split it up _if_ it wants/has to.  The alternative is just too ugly.
I have a similar but much weaker reaction, but Linus specifically asked for
this combination to work.  So I made it work as well as possible
given no seeking.

> > When --blob-limit=N is specified,  blobs whose uncompressed
> > size is greater than or equal to N are omitted from the pack(s).
> > If --pack-limit is specified, --blob-limit is not, and
> > --stdout is not,  then --blob-limit defaults to 1/4
> > of the --pack-limit.
> Is this really useful?
>
> If you have a pack size limit and a blob cannot make it even in a pack
> of its
> own then you're screwed anyway.  It is much better to simply fail the
> operation than leaving some blobs behind.  IOW I don't see the
> usefulness of this feature.
I agree if --stdout is specified.  This is why --pack-limit && --stdout
DON'T turn on --blob-limit if not specified.

However, if I'm building packs inside a non-(web-)published
repository, I find this useful. First of all, if there's some blob bigger
than the --pack-limit I must drop it anyway -- it's not clear to me that
the mmap window code works on 32b systems
with >2GB-sized objects in packs.  An "all-or-nothing" limitation
wouldn't be helpful to me.
But blobs even close to the packfile limit don't seem all that useful
to pack either (this of course is a weaker argument).
In the sample (p4) checkout I'm testing on [i.e. no history],
I have 56K+ objects consuming ~55GB uncompressed;
there are 9 blobs over 500MB each uncompressed.
I'm guessing packing them is not a performance advantage,
and I certainly wouldn't want frequently-used objects to be
stuck between them.  [ I guess my repo stats are going to
be a bit strange ;-) ]

Packing plays two roles: archive storage (long life) and
transmission (possibly short life).
These seem to pull the packing code in different directions.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
