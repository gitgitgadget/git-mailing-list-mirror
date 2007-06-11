From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Add --no-reuse-delta option to git-gc
Date: Mon, 11 Jun 2007 10:01:18 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0706110930170.12885@xanadu.home>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>
 <11786309073709-git-send-email-tytso@mit.edu>
 <11786309072612-git-send-email-tytso@mit.edu>
 <11786309071033-git-send-email-tytso@mit.edu>
 <Pine.LNX.4.64.0705090056231.18541@iabervon.org>
 <7v3b26xvjo.fsf@assigned-by-dhcp.cox.net> <46418E24.9020309@midwinter.com>
 <20070509191052.GD3141@spearce.org> <466BAAD0.9060408@vilain.net>
 <alpine.LFD.0.99.0706102144080.12885@xanadu.home>
 <Pine.LNX.4.64.0706111109430.4059@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Sam Vilain <sam@vilain.net>, Steven Grimm <koreth@midwinter.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 11 16:01:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxkSU-0003fE-QL
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 16:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbXFKOBV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 10:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbXFKOBV
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 10:01:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55814 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbXFKOBU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 10:01:20 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JJH00JY95M6Z952@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 11 Jun 2007 10:01:18 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0706111109430.4059@racer.site>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49853>

On Mon, 11 Jun 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Sun, 10 Jun 2007, Nicolas Pitre wrote:
> 
> > On Sun, 10 Jun 2007, Sam Vilain wrote:
> > 
> > > Anyway it's a free world so be my guest to implement it, I guess if 
> > > this was selectable it would only be a minor annoyance waiting a bit 
> > > longer pulling from from some repositories, and it would be 
> > > interesting to see if it did make a big difference with pack file 
> > > sizes.
> > 
> > It won't happen for a simple reason: to be backward compatible with 
> > older GIT clients.  If you have your repo compressed with bzip2 and an 
> > old client pulls it then the server would have to decompress and 
> > recompress everything with gzip.  If instead your repo remains with gzip 
> > and a new client asks for bzip2 then you have to recompress as well 
> > (slow).  So in practice it is best to remain with a single compression 
> > method.
> 
> With the extension mechanism we have in place, the client can send what 
> kind of compression it supports, and the server can actually refuse to 
> send anything if it does not want to recompress.
> 
> What I am trying to say: you do not necessarily have to allow every client 
> to access that particular repository. I agree that mixed-compression repos 
> are evil, but nothing stands in the way of a flag allowing (or 
> disallowing) recompression in a different format when fetching.

I know.

But is it worthwhile?  I think not.

However I won't stand in the way of anyone who wants to try and provide 
numbers.  I just don't believe this is worthwhile and am not inclined to 
do it.

OK... Well, I just performed a really quick test:

$ mkdir test-bzip2
$ mkdir test-gzip
$ cp git/*.[cho] test-bzip2
$ cp git/*.[cho] test-gzip
$ bzip2 test-bzip2/*
$ gzip test-gzip/*
$ du -s test-bzip2 test-gzip
5016    test-bzip2
4956    test-gzip

It is true that bzip2 is better with large files, but we typically have 
very few of them in a Git repo, and in the presence of large files bzip2 
then becomes _much_ slower than gzip. So, given that the nature of Git 
objects are likely to be small in 98% of the cases due to deltas, it 
appears that bzip2 won't be a gain at all but rather a waste, making a 
poor case for supporting it forever afterwards.

> So if you should decide someday to track data with Git (remember: Generic 
> Information Tracker, not just source code),

Bah... if you please.

> that is particularly unfit for 
> compression with gzip, but that you _need_ to store in a different 
> compressed manner, you can set up a repository which will _only_ _ever_ 
> use that compression.

Maybe.  But you'd better have a concrete data set and result numbers to 
convince me.  Designing software for hypothetical situations before they 
actually exist leads to bloatware.


Nicolas
