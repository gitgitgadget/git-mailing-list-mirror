From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Re: chunking (Re: [ANNOUNCEMENT] /Arch/ embraces `git')
Date: Wed, 20 Apr 2005 19:42:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504201934380.2630@cag.csail.mit.edu>
References: <200504201000.DAA04988@emf.net> <20050420213114.GF19112@pasky.ji.cz>
 <Pine.LNX.4.61.0504201754450.2630@cag.csail.mit.edu>
 <Pine.LNX.4.58.0504201510520.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Petr Baudis <pasky@ucw.cz>, Tom Lord <lord@emf.net>,
	gnu-arch-users@gnu.org, gnu-arch-dev@lists.seyza.com,
	Git Mailing List <git@vger.kernel.org>, talli@museatech.net
X-From: git-owner@vger.kernel.org Thu Apr 21 01:39:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOOmj-0007sQ-Fy
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 01:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVDTXnZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 19:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVDTXnZ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 19:43:25 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:59068 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S261842AbVDTXnT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 19:43:19 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DOOqF-0004IY-00; Wed, 20 Apr 2005 19:42:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504201510520.6467@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Apr 2005, Linus Torvalds wrote:

> What's the disk usage results? I'm on ext3, for example, which means that
> even small files invariably take up 4.125kB on disk (with the inode).
>
> Even uncompressed, most source files tend to be small. Compressed, I'm
> seeing the median blob size being ~1.6kB in my trivial checks. That's
> blobs only, btw.

I'm working on it.  The format was chosen so that blobs under 1 block long 
*stay* 1 block long; i.e. there's no 'chunk plus index file' overhead.
So the chunking should only kick in on multiple-block files.
I hacked 'convert-cache' to do the conversion and it's running out of
memory on linux-2.6.git, however --- I found a few memory leaks in your 
code =) but I certainly seem to be missing a big one still (maybe it's in 
my code!).

When I get this working properly, my plan is to do a number of runs over 
the linux-2.6 archive trying out various combinations of chunking 
parameters.  I *will* be watching both 'real' disk usage (bunged up to 
block boundaries) and 'ideal' disk usage (on a reiserfs-type system).
The goal is to improve both, but if I can improve 'ideal' usage 
significantly with a minimal penalty in 'real' usage then I would argue 
it's still worth doing, since that will improve network times.

The handshaking penalties you mention are significant, but that's why 
rsync uses a pipelined approach.  The 'upstream' part of your full-duplex 
pipe is 'free' while you've got bits clogging your 'downstream' 
pipe.  The wonders of full-duplex...

Anyway, "numbers talk, etc".  I'm working on them.
  --scott

LIONIZER LCPANES shortwave MKSEARCH ESGAIN Saddam Hussein Rijndael 
WASHTUB Morwenstow ZPSEMANTIC SKIMMER cryptographic FJHOPEFUL assassination
                          ( http://cscott.net/ )
