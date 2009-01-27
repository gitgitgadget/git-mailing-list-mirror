From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: "malloc failed"
Date: Tue, 27 Jan 2009 07:29:16 -0800
Message-ID: <20090127152915.GA1321@spearce.org>
References: <878wow7pth.fsf@mcbain.luannocracy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 16:31:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRptl-0007lL-FB
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 16:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755866AbZA0P3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 10:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755761AbZA0P3T
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 10:29:19 -0500
Received: from george.spearce.org ([209.20.77.23]:49599 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755635AbZA0P3R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 10:29:17 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1BB1D38210; Tue, 27 Jan 2009 15:29:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <878wow7pth.fsf@mcbain.luannocracy.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107352>

David Abrahams <dave@boostpro.com> wrote:
> I've been abusing Git for a purpose it wasn't intended to serve:
> archiving a large number of files with many duplicates and
> near-duplicates.  Every once in a while, when trying to do something
> really big, it tells me "malloc failed" and bails out (I think it's
> during "git add" but because of the way I issued the commands I can't
> tell: it could have been a commit or a gc).  This is on a 64-bit linux
> machine with 8G of ram and plenty of swap space, so I'm surprised.
> 
> Git is doing an amazing job at archiving and compressing all this stuff
> I'm putting in it, but I have to do it a wee bit at a time or it craps
> out.  Bug?

No, not really.  Above you said you are "abusing git for a purpose
it wasn't intended to serve"...

Git was never designed to handle many large binary blobs of data.
It was mostly designed for source code, where the majority of the
data stored in it is some form of text file written by a human.

By their very nature these files need to be relatively short (e.g.
under 1 MB each) as no human can sanely maintain a text file that
large without breaking it apart into different smaller files (like
the source code for an operating system kernel).

As a result of this approach, the git code assumes it can malloc()
at least two blocks large enough for each file: one of the fully
decompressed content, and another for the fully compressed content.
Try doing git add on a large file and its very likely malloc
will fail due to ulimit issues, or you just don't have enough
memory/address space to go around.

git gc likewise needs a good chunk of memory, but it shouldn't
usually report "malloc failed".  Usually in git gc if a malloc fails
it prints a warning and degrades the quality of its data compression.
But there are critical bookkeeping data structures where we must be
able to malloc the memory, and if those fail because we've already
exhausted the heap early on, then yea, it can fail too.

-- 
Shawn.
