From: "Dana How" <danahow@gmail.com>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 12:17:21 -0800
Message-ID: <56b7f5510711261217h56214321xb7acd9851b677dd6@mail.gmail.com>
References: <200711252248.27904.jnareb@gmail.com>
	 <56b7f5510711261118m7a402beah5d9cb75c1ad10b43@mail.gmail.com>
	 <alpine.LFD.0.99999.0711261433210.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 21:24:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwkVR-00084P-6N
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 21:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbXKZUYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 15:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752499AbXKZUYL
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 15:24:11 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:63197 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbXKZUYK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 15:24:10 -0500
Received: by nf-out-0910.google.com with SMTP id g13so865671nfb
        for <git@vger.kernel.org>; Mon, 26 Nov 2007 12:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=IICva7SjBswnycCtsKX03MOLruaA5H10GUJwW+u7wPA=;
        b=mmg+kpY2GJjuUJ4K0+sckW3y6GEdFJSq8N7piOU5R2jkqaQYiOqPe4SHer/HF/L8ZRTUeUGvVEomNQPdpStZJsrNukS+UsVs8GNZmY3JGDgg7U9e5jAycRIYM8vNxlHGkcavlTcQSf52pz91xRcjvUztd15fDkZHdxUKmTTHRqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qrrzjG0XHFY7hZoehfn2CoXRW3i3QKfM7zKoS5brDANGaiFwbxXB3RctJH614b6M8W3L4eZXcqX0T4GZsQ/Yy2Oth1BI0bXOjfE4xhN53vMPosU45RHCC6WHsZQc8YOXZDK/VmiiWWo8GFEMZ4AbmKrQuYQvXUgl7WuBgfwaLdc=
Received: by 10.78.190.10 with SMTP id n10mr3461937huf.1196108241526;
        Mon, 26 Nov 2007 12:17:21 -0800 (PST)
Received: by 10.78.177.20 with HTTP; Mon, 26 Nov 2007 12:17:21 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0711261433210.9605@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66111>

On Nov 26, 2007 11:52 AM, Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 26 Nov 2007, Dana How wrote:
> > Currently data can be quickly copied from pack to pack,
> > but data cannot be quickly copied blob->pack or pack->blob
> I don't see why you would need the pack->blob copy normally.
True,  but that doesn't change the main point.

> > (there was an alternate blob format that supported this,
> >  but it was deprecated).  Using the pack format for blobs
> > would fix this.
>
> Then you can do just that for big enough blobs where "big enough" is
> configurable: encapsulate them in a pack instead of a loose object.
> Problem solved.  Sure you'll end up with a bunch of packs containing
> only one blob object, but given that those blobs are so large to be a
> problem in your work flow when written out as loose objects, then they
> certainly must be few enough not to cause an explosion in the number of
> packs.
Are you suggesting that "git add" create a new pack containing
one blob when the blob is big enough?  Re-using (part of) the pack format
in a blob (or maybe only some blobs) seems like less code change.

> > It would also mean blobs wouldn't need to
> > be uncompressed to get the blob type or size I believe.
>
> They already don't.
It looks like sha1_file.c:parse_sha1_header() works on a buffer
filled in by sha1_file.c:unpack_sha1_header() by calling inflate(), right?

It is true you don't have to uncompress the *entire* blob.

> > The equivalent operation in git would require the creation of
> > the blob,  and then of a temporary pack to send to the server.
> > This requires 3 calls to zlib for each blob,  which for very
> > large files is not acceptable at my site.
>
> I currently count 2 calls to zlib, not 3.
I count 3:

Call 1: git-add calls zlib to make the blob.

Call 2: builtin-pack-objects.c:write_one() calls sha1_file.c:read_sha1_file()
calls :unpack_sha1_file() calls :unpack_sha1_{header,rest}() calls
inflate() to get the data from the blob into a buffer.

Call 3: Then write_one() calls deflate to make the new buffer
to write into the pack.  This is all under the "if (!to_reuse) {" path,
which is active when packing a blob.

Remember,  I'm comparing "p4 submit file" to
"git add file"/"git commit"/"git push",  which is the comparison
the users will be making.

On the other hand,  I'm looking at code from June;
but I haven't noticed big changes since then on the list.

Calls 2 and 3 go away if the blob and pack formats were more similar.
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
