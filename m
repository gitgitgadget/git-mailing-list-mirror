From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: tree corrupted on disk quota full
Date: Thu, 11 Jan 2007 14:24:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701111410420.3594@woody.osdl.org>
References: <Pine.LNX.4.64.0701111324350.3594@woody.osdl.org>
 <20070111215812.GK17999@mellanox.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Thu Jan 11 23:24:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H58LW-0005Nj-2z
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 23:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbXAKWYY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 17:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbXAKWYY
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 17:24:24 -0500
Received: from smtp.osdl.org ([65.172.181.24]:39249 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932154AbXAKWYX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 17:24:23 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0BMO4Wi007879
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 11 Jan 2007 14:24:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0BMO3Kc004974;
	Thu, 11 Jan 2007 14:24:04 -0800
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <20070111215812.GK17999@mellanox.co.il>
X-Spam-Status: No, hits=-0.663 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36625>



On Thu, 11 Jan 2007, Michael S. Tsirkin wrote:
> 
> OK, now that I know what happened, this makes sense to me.
> But I'd like to understand whether what created this in the first place:
> 
> > 
> >  - you had gotten some corrupt objects due to the disk filling up 
> >    (probably during the pull that thus populated the object database with
> >    partially written objects)
> > 
> >    In particular, the 4d4d30be967d3284cbf59afd4fba6ab536e295f5 object was 
> >    corrupt. fsck gave a confusing error message:
> > 
> > 	error: 4d4d30be967d3284cbf59afd4fba6ab536e295f5: object not found
> > 	error: c03590b581d51d5fa43adbef9415e935d0229412: object not found
> > 
> >    which is really because the _file_ for that object does exist, but the 
> >    file doesn't actually contain the object it expects (due to 
> >    corruption), so the object wasn't "found". 
> 
> is something expected?

Well, it's a bug, and it's not "expected", but I think it's understood. 

What happens is that you pulled objects that were perfectly fine, and when 
you ran out of diskspace git could create the _filenames_ and inodes for 
them, but when it actually wrote the data itself, it failed.

And it failed in a very unfortunate place: when unpacking the pack-file 
(which you got when doing the "git pull"), it would call 
"write_sha1_file()" to actually write the unpacked object. That one does 
everything correctly and is actually very careful, but then it does

	if (write_buffer(fd, compressed, size) < 0)
		die("unable to write sha1 file");

which _should_ have caught the case that the buffer couldn't be written, 
and died cleanly with an error message, and it would neve rhave moved the 
temporary file that it wrote to into the real database.

In other words, it was doing everything right. A partial file would never 
have actually been allowed to be moved into the database at all, and you'd 
have gotten a nice error message, and the "git pull" would have failed 
gracefully.

However, "write_buffer()" itself was buggy. It did:

	static int write_buffer(int fd, const void *buf, size_t len)
	{
	        ssize_t size;
	
	        size = write_in_full(fd, buf, len);
	        if (!size)
	                return error("file write: disk full");
	        if (size < 0)
	                return error("file write error (%s)", strerror(errno));
	        return 0;
	}

and the problem here is that if the write was _partial_ (not totally 
empty), it would see a positive size, but not a full write, and it would 
incorrectly return zero for "everything is fine". Even though it wasn't.

So my patch to make "write_in_full()" have better semantics (and make it 
simpler too) should have fixed the fundamental problem that caused your 
failure in the first place. The other patch I just sent out should just 
make the error messages be a bit nicer, and isn't important in itself.

Btw, that "write_buffer()" bug was introduced pretty recently. It used to 
be that write_buffer() did the right thing: it used to do:

	while (len) {
		ssize_t size;

		size = write(fd, buf, len);
		if (!size)
			return error("file write: disk full");
		if (size < 0) {
			if (errno == EINTR || errno == EAGAIN)
				continue;
			return error("file write error (%s)", strerror(errno));
		}
		len -= size;
		buf = (char *) buf + size;
	}

which is safe and does the right thing for partial writes and disk full 
errors (of course it is: I wrote that piece of code).

So this bug was _literally_ introduced three days ago, and it was 
introduced by a set of patches that tried to _avoid_ the problem.

Sad. The old code was perfectly good. The new code was unsafe, but thought 
it was better. See commit 93822c2239a336e5cb583549071c59202ef6c5b2 for 
details.

Junio, pls apply my "fix write_in_full" patch asap if you haven't already. 
I find it very irritating when people "clean up" my code, and introduce 
bugs when they do so.

		Linus
