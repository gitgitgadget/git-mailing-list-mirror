From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fast-import: Stream very large blobs directly to pack
Date: Fri, 29 Jan 2010 07:22:54 -0800
Message-ID: <20100129152254.GC21821@spearce.org>
References: <20100129012350.GD20488@spearce.org> <7vockdjx6w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 16:29:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nasn5-0003y9-Dz
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 16:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755556Ab0A2P3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 10:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755327Ab0A2P3l
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 10:29:41 -0500
Received: from mail-yx0-f193.google.com ([209.85.210.193]:52527 "EHLO
	mail-yx0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569Ab0A2P3k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 10:29:40 -0500
Received: by yxe31 with SMTP id 31so1900634yxe.21
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 07:29:40 -0800 (PST)
Received: by 10.150.56.19 with SMTP id e19mr1702376yba.316.1264778577942;
        Fri, 29 Jan 2010 07:22:57 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 6sm740370yxg.12.2010.01.29.07.22.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Jan 2010 07:22:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vockdjx6w.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138327>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > +static void stream_blob(
> > +	uintmax_t len,
> > +	unsigned char *sha1out,
> > +	uintmax_t mark)
> 
> A funny way to indent and line wrap...

Consistent with something else in the same file that has a similar
task... store_object().  I literally just copied the lines from
there and pasted here.
 
> > +	/* Determine if we should auto-checkpoint. */
> > +	if ((pack_size + 60 + len) > max_packsize
> > +		|| (pack_size + 60 + len) < pack_size)
> > +		cycle_packfile();
> 
> What's "60" in this math?

IIRC 60 is 20 bytes for the SHA-1 footer, and another 40 padding
for the object header, and the deflate() wrapping.

Again, the 60 was stolen from the existing store_object(), which
already has the same assumption.  Only there I think we have len as
the fully compressed version, so the deflate() wrapping is already
being accounted for.
 
> If the data is not compressible, we could even grow and the end result
> might be more than (pack_size + len), busting max_packsize.

Yea, that's a good point.  I probably should run the length through
deflateBound() and use that here in the test.  But I didn't think it
would make a huge difference.  If the file isn't compressible what
is the real increment over the uncompressed size?  There's a header
and footer, and instructions in the stream to indicate literal data,
but its not like its doubling in size.

> As we are
> streaming out, we cannot say "oops, let me try again after truncating and
> closing the current file and then opening a new file", and instead may
> have to copy the data from the current one to a new one, and truncate the
> current one.  Is this something worth worrying about?

Hmm.  I'm not that worried about it, but then there's the case of
a blob that is larger than the max pack size.  We can't store that,
period.  Should we try to exceed max pack size for that one object?
Or should we refuse?

The major reason for this test is to ensure an object offset
starts before the 4 GiB boundary so idx v1 can hold the offset.
A much less important reason is to try to support older 32 bit
filesystems which can't do more than 2 GiB per file.

-- 
Shawn.
