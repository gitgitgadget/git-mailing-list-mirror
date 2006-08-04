From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Creating objects manually and repack
Date: Fri, 4 Aug 2006 11:06:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608041052030.5167@g5.osdl.org>
References: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com> 
 <Pine.LNX.4.64.0608032052210.4168@g5.osdl.org> 
 <9e4733910608032124o5b5b69b5hda2eb8cb1e0ac959@mail.gmail.com> 
 <Pine.LNX.4.64.0608032138330.4168@g5.osdl.org>  <Pine.LNX.4.64.0608032150510.4168@g5.osdl.org>
  <9e4733910608040740x23a8b0cs3bc276ef9e6fb8f7@mail.gmail.com> 
 <9e4733910608040750g3f72c07ct43f54347e47f25b4@mail.gmail.com> 
 <Pine.LNX.4.64.0608040818270.5167@g5.osdl.org> 
 <9e4733910608040841v7f4f27efra63e5ead2656e07@mail.gmail.com> 
 <Pine.LNX.4.64.0608040945070.5167@g5.osdl.org>
 <9e4733910608041017v235da03ocd3eeeb0ba0e259b@mail.gmail.com>
 <Pine.LNX.4.64.0608041027530.5167@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 04 20:06:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G944F-0002mW-LH
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 20:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161360AbWHDSGg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 14:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161361AbWHDSGg
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 14:06:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3721 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161360AbWHDSGf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 14:06:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k74I6XnW002168
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 4 Aug 2006 11:06:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k74I6W94009775;
	Fri, 4 Aug 2006 11:06:32 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0608041027530.5167@g5.osdl.org>
X-Spam-Status: No, hits=-0.449 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.142 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24814>



On Fri, 4 Aug 2006, Linus Torvalds wrote:
> 
> You may definitely want to pack the pack-files together every once in a 
> while. Doing so is not that hard: just list all the objects in all the 
> pack-files you want to merge, which in turn is trivial from reading the 
> index of the pack-files (and then you do want to do the filename, 
> although you can just use the pack-file name if you want to). 

Btw, that index format is actually documented (and it really is _very_ 
simple) in Documentation/technical/pack-format.txt.

To get a list of all object names in a pack-file, you'd basically do just
something like the appended. So with this (let's call it 
"git-list-objects"), you could just do

	for i in $packlist
	do
		git-list-objects $i.idx
	done | git-pack-objects combined-pack

and it would combine all the packs in "$packlist" into one new 
"combined-pack-<sha1>" pack.

And no, I didn't actually _test_ any of this, but it looks pretty damn 
simple.

		Linus

----
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>

#define CHUNK (100)

int main(int argc, char **argv)
{
	static unsigned char buffer[24*CHUNK];
	const char *name = argv[1];
	unsigned int n;
	int fd;
	int i;

	if (!name)
		die("no filename!");

	fd = open(name, O_RDONLY);
	if (fd < 0)
		perror(name);

	/* throw away the first-level fan-out */
	if (read(fd, buffer, 4*256) != 4*256)
		perror("read fan-out");

	n = (buffer[4*255 + 0] << 24) +
	    (buffer[4*255 + 1] << 16) +
	    (buffer[4*255 + 2] << 8) +
	    (buffer[4*255 + 3] << 0);

	for (i = 0; i < n; i += CHUNK) {
		int j, left = n - i;
		if (left > CHUNK)
			left = CHUNK;
		if (read(fd, buffer, left*24) != left*24)
			perror("read chunk");
		for (j = 0; j < left; j++) {
			const unsigned char *sha1;
			sha1 = buffer + j*24 + 4;
			printf("%s %s\n", sha1_to_hex(sha1), name);
		}
	}
	return 0;
}
