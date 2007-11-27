From: "Dana How" <danahow@gmail.com>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 21:59:15 -0800
Message-ID: <56b7f5510711262159x2e1fd4fdw8e914cb4a22376a1@mail.gmail.com>
References: <200711252248.27904.jnareb@gmail.com>
	 <20071127014804.GJ14735@spearce.org>
	 <alpine.LFD.0.99999.0711262346410.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 06:59:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwtTu-0003Vp-Cy
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 06:59:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560AbXK0F7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 00:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753248AbXK0F7T
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 00:59:19 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:3027 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbXK0F7S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 00:59:18 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1155596ugc
        for <git@vger.kernel.org>; Mon, 26 Nov 2007 21:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=GyoaR3QA8EX/xjaD5EQ5jJyFz7pYb0ekCRBU++TsSLs=;
        b=Y7RJgdFjOMB/RdofmUbCdgik5FCupO8OIyvbFKkzWPKkF52jfY2yHgXUUv4526mJnfhunf7hoED1PzSS9YBbs/QSZCCktA0A/6yFdFghdtWRArOzFkg1v9/7C/mS/g663bpGPNcfPu8pxTMza2ChaLXvg/qIAvQzTOua1RkEFFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ftDc/ELqu1GxOG4N2+fzA7EKwu+aNKwJHDmIoLHBj1blmS7iUAsJ9iT3Mx3p5kvm68+RyqYMcPND93D9MrLhmSN336zYP15RERRyoVeDj+EME7ZFzmc1J6L+owPF+ItuIEmL+OS55xUdq3JecL1GZhR7M1jTfseiaRw5ohPKH4w=
Received: by 10.78.180.18 with SMTP id c18mr3711206huf.1196143156004;
        Mon, 26 Nov 2007 21:59:16 -0800 (PST)
Received: by 10.78.177.20 with HTTP; Mon, 26 Nov 2007 21:59:15 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0711262346410.9605@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66168>

On Nov 26, 2007 8:58 PM, Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 26 Nov 2007, Shawn O. Pearce wrote:
> > - Loose objects storage is difficult to work with
> >
> >   The standard loose object format of DEFLATE("$type $size\0$data")
> >   makes it harder to work with as you need to inflate at least
> >   part of the object just to see what the hell it is or how big
> >   its final output buffer needs to be.
>
> It is a bit cumbersome indeed, but I'm afraid we're really stuck with it
> since every object SHA1 depends on that format.

Yes,  now I remember: this was the same argument you used to
convince me that losing the "new" (deprecated) loose format was OK.

However,  if we changed
WRITE(DEFLATE(SHA1("$type $size\0$data")))
(where SHA1(x) = x but has the side-effect of updating the SHA-1)
to
WRITE($pack_style_object_header)
SHA1("$type $size\0")
WRITE(DEFLATE(SHA1($data)))
then the SHA-1 result is the same but we get the pack-style header,
and blobs can be sucked straight into packs when not deltified.
The SHA-1 result is still usable at the end to rename the temporary
loose object file
(and put it in the correct xx subdirectory).

Because we can't change the SHA-1 result we unfortunately can
never drop the 2nd call above [this is something that could
have been different, to respond to the email that started this thread].
You didn't like the duplication between the 1st and 2nd call,
but I can't say I see that as a big deal.

> >   It also makes it very hard to stream into a packfile if you have
> >   determined its not worth creating a delta for the object (or no
> >   suitable delta base is available).
> >
> >   The new (now deprecated) loose object format that was based on
> >   the packfile header format simplified this and made it much
> >   easier to work with.
>
> Not really.  Since separate zlib compression levels for loose objects
> and packed objects were introduced, there was a bunch of correctness
> issues.  What do you do when both compression levels are different?
> Sometimes ignore them, sometimes not? Because the default loose object
> compression level is about speed and the default pack compression level
> is about good space reduction, the correct thing to do by default would
> have been to always decompress and recompress anyway when copying an
> otherwise unmodified loose object into a pack.
Not exactly.  I did think about this.  When you are packing to stdout,
and only sending the resulting packfile locally,  you don't want to
bother with recompressing everything.  [This is the "workgroup" case
that concerns me.]  Other cases,  sure,
recompression could help (e.g., packing to a file means the file
will probably be around for a while,  so you want to recompress
if the levels are unequal;  and you probably want to recompress
as well if the packfile will be sent over a "slow" link).

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
