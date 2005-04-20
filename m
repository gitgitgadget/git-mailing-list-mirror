From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] write-tree performance problems
Date: Wed, 20 Apr 2005 10:52:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504201040400.6467@ppc970.osdl.org>
References: <200504191250.10286.mason@suse.com> <200504201237.38374.mason@suse.com>
 <Pine.LNX.4.58.0504200957030.6467@ppc970.osdl.org> <200504201323.05447.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 19:47:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOJHP-0008MC-Q6
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 19:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVDTRuj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 13:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVDTRuj
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 13:50:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:34002 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261702AbVDTRuY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 13:50:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3KHoKs4017092
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Apr 2005 10:50:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3KHoJBo017696;
	Wed, 20 Apr 2005 10:50:19 -0700
To: Chris Mason <mason@suse.com>
In-Reply-To: <200504201323.05447.mason@suse.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 20 Apr 2005, Chris Mason wrote:
> 
> The patch below with your current tree brings my 100 patch test down to 22 
> seconds again.

If you ever have a cache_entry bigger than 16384, your code will write 
things out in the wrong order (write the new cache without flushing the 
old buffer).

You also don't free the buffer.

Finally, if you really want to go fast, you should really try to make your
writes powers-of-two, ie fill up the buffer entirely rather than saying
"if I were to overflow, flush it now". It doesn't matter that much for
some filesystems (especially local and append-only like the patterns are
here), but it can definitely matter for the stupid ones.

But yeah, we could obviously chunk things out properly. You might want to 
just use stdio and "fwrite()", though, which does all of that for you, and 
hopefully does it right.

(I'm not a big fan of stdio for something like this, so if you want to 
create a little helper function that just does the chunking, go wild. 
Something like

	#define BUFSIZ 8192
	static char buffer[BUFSIZ];
	static unsigned long buflen;

	int ce_write(int fd, void *data, unsigned int len)
	{
		while (len) {
			unsigned int buffered = buflen;
			unsigned int partial = BUFSIZ - buflen;
			if (partial > len)
				partial = len;
			memcpy(buffer + buflen, data, partial);
			buffered += partial;
			if (buffered == BUFSIZ) {
				if (write(fd, buffer, BUFSIZ) != BUFSIZ)
					die("unable to write");
				buffered = 0;
			}
			buflen = buffered;
			len -= partial;
			data += partial;
		}
	}

	int ce_flush(int fd)
	{
		unsigned int left = buflen;
		if (left) {
			buflen = 0;
			if (write(fd, buffer, left) != left)
				die("unable to write");
		}
	}

which should be ok, and cheesily avoids the allocation overhread issues by
just having a nice static buffer.

"If you want to go fast, do it right".

Untested, as usual.

		Linus
