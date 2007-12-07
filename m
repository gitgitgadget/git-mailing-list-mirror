From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: RAM consumption when working with the gcc repo
Date: Fri, 7 Dec 2007 16:27:13 -0500
Message-ID: <9e4733910712071327u4b74e8a0idcd601dd2dcc13f8@mail.gmail.com>
References: <9e4733910712071207p750c14f4h7abc5d637da3a478@mail.gmail.com>
	 <Pine.LNX.4.64.0712071323260.12607@asgard.lang.hm>
	 <alpine.LFD.0.99999.0712071529580.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: david@lang.hm, "Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 22:27:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0kjg-000788-Sb
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 22:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435AbXLGV1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 16:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753925AbXLGV1b
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 16:27:31 -0500
Received: from ro-out-1112.google.com ([72.14.202.176]:42645 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799AbXLGV1a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 16:27:30 -0500
Received: by ro-out-1112.google.com with SMTP id p4so7314354roc
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 13:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=oM8mGcb2t2f5ubvClKImbbr+tuXzLGR94iSl02DJOKM=;
        b=jZaRbECWisAgE//cas4FLlnVYwRb1LSWtuh8CVgNthEBX4TM0pdceVr8kO0g72KHnJh3/IUuDsu+YPqvi8gIts75AyHj/VxjJjzIFSsTw1wdBEtrNw6WBS2Ks+wLMfeylCjflWtkFL0RoUyMdqrBYZcckADHnZJTcWGLf3cCeXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jGkW4ZP8iVRV6ja0ywaGfu9v62SaLFXd7Hq3eEbuYmGhu6kWmfL/UbG6qcOGcmN9rGVMM4yAx/NOlzHIg0l5VbABgykp54XMpCAzQNQIyEgBjqkNia9/EdDYQa0sMbYJy9R2N1zUjNiSi+qDh4Azv45fTxg82bvXaD/KbUU7zdk=
Received: by 10.115.54.1 with SMTP id g1mr3760288wak.1197062838955;
        Fri, 07 Dec 2007 13:27:18 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Fri, 7 Dec 2007 13:27:13 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712071529580.555@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67463>

On 12/7/07, Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 7 Dec 2007, david@lang.hm wrote:
>
> > On Fri, 7 Dec 2007, Jon Smirl wrote:
> >
> > > I noticed two things when doing a repack of the gcc repo. First is
> > > that the git process is getting to be way too big. Turning off the
> > > delta caches had minimal impact. Why does the process still grow to
> > > 4.8GB?
> > >
> > > Putting this in perspective, this is a 4.8GB process constructing a
> > > 330MB file. Something isn't right. Memory leak or inefficient data
> > > structure?
> >
> > keep in mind that that 330MB file is _very_ heavily compressed. the simple
> > zlib compression is probably getting you 10:1 or 20:1 compression and the
> > delta compression is a significant multiplier on top of that.
>
> Doesn't matter.  Something is indeed fishy.

I didn't have any problem repacking Mozilla and it ends up as a 450MB
pack file with 1.5M entries.  So something has changed. With Mozilla I
had a 3GB machine, and now I can't finish a 330MB pack on a 4GB
machine. I don't recall the Mozilla process ever exceeding 2GB.


>
> The bulk of pack-objects memory consumption can be estimated as follows:
>
> 1M objects * sizeof(struct object_entry) ~= 100MB
> 256 window entries with data (assuming a big 1MB per entry) = 256MB
> Delta result caching was disabled therefore 0MB
> read-side delta cache limited to 16MB
>
> So the purely ram allocation might get to roughly 400MB.
>
> Then add the pack and index map, which, depending on the original pack
> size,
> might be 2GB.
>
> So we're pessimistically talking of about 2.5GB of virtual space.
>
> The other 2.3GB is hard to explain.
>
>
> Nicolas
>


-- 
Jon Smirl
jonsmirl@gmail.com
