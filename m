From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Errors cloning large repo
Date: Fri, 9 Mar 2007 17:45:22 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703091736290.10832@woody.linux-foundation.org>
References: <891197.22028.qm@web52611.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Anton Tropashko <atropashko@yahoo.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 02:45:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPqeT-0004LX-0p
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 02:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767714AbXCJBp0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 20:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767715AbXCJBp0
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 20:45:26 -0500
Received: from smtp.osdl.org ([65.172.181.24]:56701 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767714AbXCJBpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 20:45:25 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2A1jOo4024077
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Mar 2007 17:45:24 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2A1jN87008560;
	Fri, 9 Mar 2007 17:45:23 -0800
In-Reply-To: <891197.22028.qm@web52611.mail.yahoo.com>
X-Spam-Status: No, hits=-0.492 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41834>



On Fri, 9 Mar 2007, Anton Tropashko wrote:
> 
> but your /usr should be large enough if /usr/local and /usr/local/src 
> are not!!!

I don't like the size distribution.

My /usr has 181585 files, but is 4.0G in size, which doesn't match yours. 
Also, I've wanted to generate bogus data for a while, just for testing, so 
I wrote this silly program that I can tweak the size distribution for.

It gives me something that approaches your distribution (I ran it a few 
times, I now have 110402 files, and 5.7GB of space according to 'du').

It's totally unrealistic wrt packing, though (no deltas, and no 
compression, since the data itself is all random), and I don't know how to 
approximate that kind of details samely.

I'll need to call it a day for the kids dinner etc, so I'm probably done 
for the day. I'll play with this a bit more to see if I can find various 
scalability issues (and just ignore the delta/compression problem - you 
probably don't have many deltas either, so I'm hoping that the fact 
that I only have 5.7GB will approximate your data thanks to it not being 
compressible).

		Linus

---
#include <time.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/fcntl.h>

/*
 * Create a file with a random size in the range
 * 0-1MB, but with a "pink noise"ish distribution
 * (ie equally many files in the 1-2kB range as in
 * the half-meg to megabyte range).
 */
static void create_file(const char *name)
{
	int i;
	int fd = open(name, O_CREAT | O_WRONLY | O_TRUNC, 0666);
	static char buffer[1000];
	unsigned long size = random() % (1 << (10+(random() % 10)));

	if (fd < 0)
		return;
	for (i = 0; i < sizeof(buffer); i++)
		buffer[i] = random();
	while (size) {
		int len = sizeof(buffer);
		if (len > size)
			len = size;
		write(fd, buffer, len);
		size -= len;
	}
	close(fd);
}

static void start(const char *base,
	float dir_likely, float dir_expand,
	float end_likely, float end_expand)
{
	int len = strlen(base);
	char *name = malloc(len + 10);

	mkdir(base, 0777);

	memcpy(name, base, len);
	name[len++] = '/';

	dir_likely *= dir_expand;
	end_likely *= end_expand;

	for (;;) {
		float rand = (random() & 65535) / 65536.0;

		sprintf(name + len, "%ld", random() % 1000000);
		rand -= dir_likely;
		if (rand < 0) {
			start(name, dir_likely, dir_expand, end_likely, end_expand);
			continue;
		}
		rand -= end_likely;
		if (rand < 0)
			break;
		create_file(name);
	}
}

int main(int argc, char **argv)
{
	/*
	 * Tune the numbers to your liking..
	 *
	 * The floats are:
	 *  - dir_likely (likelihood of creating a recursive directory)
	 *  - dir_expand (how dir_likely behaves as we move down recursively)
	 *  - end_likely (likelihood of ending file creation in a directory)
	 *  - end_expand (how end_likely behaves as we move down recursively)
	 *
	 * The numbers 0.3/0.6 0.03/1.1 are totally made up, and for me
	 * generate a tree of between a few hundred files and a few tens 
	 * of thousands of files.
	 *
	 * Re-run several times to generate more files in the tree.
	 */
	srandom(time(NULL));
	start("tree",
		0.3, 0.6,
		0.02, 1.1);
	return 0;
}
