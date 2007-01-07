From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How git affects kernel.org performance
Date: Sun, 7 Jan 2007 11:13:06 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701071028450.3661@woody.osdl.org>
References: <1166297434.26330.34.camel@localhost.localdomain>
 <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com>
 <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com>
 <45A083F2.5000000@zytor.com> <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org>
 <20070107085526.GR24090@1wt.eu> <45A0B63E.2020803@zytor.com>
 <20070107090336.GA7741@1wt.eu> <20070107102853.GB26849@infradead.org>
 <Pine.LNX.4.64.0701070957080.3661@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Willy Tarreau <w@1wt.eu>, "H. Peter Anvin" <hpa@zytor.com>,
	git@vger.kernel.org, nigel@nigel.suspend2.net,
	"J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 20:16:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3dUH-0004ks-Kn
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 20:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbXAGTPB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 14:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbXAGTPB
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 14:15:01 -0500
Received: from smtp.osdl.org ([65.172.181.24]:41869 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964924AbXAGTO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 14:14:58 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l07JD8Wi031230
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 7 Jan 2007 11:13:08 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l07JD6Ak023490;
	Sun, 7 Jan 2007 11:13:07 -0800
To: Christoph Hellwig <hch@infradead.org>
In-Reply-To: <Pine.LNX.4.64.0701070957080.3661@woody.osdl.org>
X-Spam-Status: No, hits=-0.668 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.167 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36186>



On Sun, 7 Jan 2007, Linus Torvalds wrote:
> 
> A year or two ago I did a totally half-assed code for the non-hashed 
> readdir that improved performance by an order of magnitude for ext3 for a 
> test-case of mine, but it was subtly buggy and didn't do the hashed case 
> AT ALL.

Btw, this isn't the test-case, but it's a half-way re-creation of 
something like it. It's _really_ stupid, but here's what you can do:

 - compile and run this idiotic program. It creates a directory called 
   "throwaway" that is ~44kB in size, and if I did things right, it should 
   not be totally contiguous on disk with the current ext3 allocation 
   logic.

 - as root, do "echo 3 > /proc/sys/vm/drop_caches" to get a cache-cold 
   schenario.

 - do "time ls throwaway > /dev/null".

I don't know what people consider to be reasonable performance, but for 
me, it takes about half a second to do a simple "ls". NOTE! This is _not_ 
reading inode stat information or anything like that. It literally takes 
0.3-0.4 seconds to read ~44kB off the disk. That's a whopping 125kB/s 
throughput on a reasonably fast modern disk.

That's what we in the industry call  "sad".

And that's on a totally unloaded machine. There was _nothing_ else going 
on. No IO congestion, no nothing. Just the cost of synchronously doing 
ten or eleven disk reads.

The fix?

 - proper read-ahead. Right now, even if the directory is totally 
   contiguous on disk (just remove the thing that writes data to the 
   files, so that you'll have empty files instead of 8kB files), I think 
   we do those reads totally synchronously if the filesystem was mounted 
   with directory hashing enabled.

   Without hashing, the directory will be much smaller too, so readdir() 
   will have less data to read. And it _should_ do some readahead, 
   although in my testing, the best I could do was still 0.185s for a (now 
   shrunken) 28kB directory. 

 - better directory block allocation patterns would likely help a lot, 
   rather than single blocks. That's true even without any read-ahead (at 
   least the disk wouldn't need to seek, and any on-disk track buffers etc 
   would work better), but with read-ahead and contiguous blocks it should 
   be just a couple of IO's (the indirect stuff means that it's more than 
   one), and so you should see much better IO patterns because the 
   elevator can try to help too.

Maybe I just have unrealistic expectations, but I really don't like how a 
fairly small 50kB directory takes an appreciable fraction of a second to 
read.

Once it's cached, it still takes too long, but at least at that point the 
individual getdents calls take just tens of microseconds.

Here's cold-cache numbers (notice: 34 msec for the first one, and 17 msec 
in the middle.. The 5-6ms range indicates a single IO for the intermediate 
ones, which basically says that each call does roughly one IO, except the 
first one that does ~5 (probably the indirect index blocks), and two in 
the middle who are able to fill up the buffer from the IO done by the 
previous one (4kB buffers, so if the previous getdents() happened to just 
read the beginning of a block, the next one might be able to fill 
everything from that block without having to do IO).

	getdents(3, /* 103 entries */, 4096)    = 4088 <0.034830>
	getdents(3, /* 102 entries */, 4096)    = 4080 <0.006703>
	getdents(3, /* 102 entries */, 4096)    = 4080 <0.006719>
	getdents(3, /* 102 entries */, 4096)    = 4080 <0.000354>
	getdents(3, /* 102 entries */, 4096)    = 4080 <0.000017>
	getdents(3, /* 102 entries */, 4096)    = 4080 <0.005302>
	getdents(3, /* 102 entries */, 4096)    = 4080 <0.016957>
	getdents(3, /* 102 entries */, 4096)    = 4080 <0.000017>
	getdents(3, /* 102 entries */, 4096)    = 4080 <0.003530>
	getdents(3, /* 83 entries */, 4096)     = 3320 <0.000296>
	getdents(3, /* 0 entries */, 4096)      = 0 <0.000006>

Here's the pure CPU overhead: still pretty high (200 usec! For a single 
system call! That's disgusting! In contrast, a 4kB read() call takes 7 
usec on this machine, so the overhead of doing things one dentry at a 
time, and calling down to several layers of filesystem is quite high):

	getdents(3, /* 103 entries */, 4096)    = 4088 <0.000204>
	getdents(3, /* 102 entries */, 4096)    = 4080 <0.000122>
	getdents(3, /* 102 entries */, 4096)    = 4080 <0.000112>
	getdents(3, /* 102 entries */, 4096)    = 4080 <0.000153>
	getdents(3, /* 102 entries */, 4096)    = 4080 <0.000018>
	getdents(3, /* 102 entries */, 4096)    = 4080 <0.000103>
	getdents(3, /* 102 entries */, 4096)    = 4080 <0.000217>
	getdents(3, /* 102 entries */, 4096)    = 4080 <0.000018>
	getdents(3, /* 102 entries */, 4096)    = 4080 <0.000095>
	getdents(3, /* 83 entries */, 4096)     = 3320 <0.000089>
	getdents(3, /* 0 entries */, 4096)      = 0 <0.000006>

but you can see the difference.. The real cost is obviously the IO.

		Linus

----
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>

static char buffer[8192];

static int create_file(const char *name)
{
	int fd = open(name, O_RDWR | O_CREAT | O_TRUNC, 0666);
	if (fd < 0)
		return fd;

	write(fd, buffer, sizeof(buffer));
	close(fd);
	return 0;
}

int main(int argc, char **argv)
{
	int i;
	char name[256];

	/* Fill up the buffer with some random garbage */
	for (i = 0; i < sizeof(buffer); i++)
		buffer[i] = "abcdefghijklmnopqrstuvwxyz\n"[i % 27];

	if (mkdir("throwaway", 0777) < 0 || chdir("throwaway") < 0) {
		perror("throwaway");
		exit(1);
	}

	/*
	 * Create a reasonably big directory by having a number
	 * of files with non-trivial filenames, and with some
	 * real content to fragment the directory blocks..
	 */
	for (i = 0; i < 1000; i++) {
		snprintf(name, sizeof(name),
			"file-name-%d-%d-%d-%d",
			i / 1000,
			(i / 100) % 10,
			(i / 10) % 10,
			(i / 1) % 10);
		create_file(name);
	}
	return 0;
}
