From: Geert Bosch <bosch@adacore.com>
Subject: Re: RFC: New diff-delta.c implementation
Date: Sun, 23 Apr 2006 22:57:41 -0400
Message-ID: <20060424025741.GA636@adacore.com>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com> <444A2334.3030501@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 24 04:57:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXrGs-0002z9-PG
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 04:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbWDXC5m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Apr 2006 22:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWDXC5m
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Apr 2006 22:57:42 -0400
Received: from nile.gnat.com ([205.232.38.5]:12974 "EHLO nile.gnat.com")
	by vger.kernel.org with ESMTP id S1751495AbWDXC5l (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Apr 2006 22:57:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 4BB7A48CDCC;
	Sun, 23 Apr 2006 22:57:41 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 00208-01-2; Sun, 23 Apr 2006 22:57:41 -0400 (EDT)
Received: by nile.gnat.com (Postfix, from userid 4190)
	id 246D348CC09; Sun, 23 Apr 2006 22:57:41 -0400 (EDT)
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Content-Disposition: inline
In-Reply-To: <444A2334.3030501@lsrfire.ath.cx>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19083>

On Sat, Apr 22, 2006 at 02:36:04PM +0200, Rene Scharfe wrote:
> Could you please send your code inline, not as an attachment?  And
> possibly as a patch with a Signed-off-by: tag (see
> Documentation/SubmittingPatches)?
For various reasons, mostly to do with managing and searching huge
mailboxes, I'm using Apple Mail. What sucks though is that automatic
line wrapping can't be turned off. This never got fixed, so it's useless
for posting inline patches. That said, I now leave a synchronized copy
of the git repository on my mailserver and use mutt for this reply.
Hopefully things will be better.

Note that I sent this code as a RFC, with explicit disclaimers about
style. So, I did not want to sign off on this code, since I pretty
much knew there would be some problems with the undocumented
("proprietary", according the libxdiff site) file format. In contrast
the GDIFF fileformat was documented very well, and I have a version
of this code that works flawlessly with that format.

> Regarding your FIXME comment about endianess: I think you are looking
> for htonl().  Use it to convert the values from host byte order to
> network byte order (= big endian) and you can get rid of those ugly
> branches.
Ah, I'll use that. It's of course a slight change that all processing
now is big-endian centric, but that might actually even result in
better code in this case. I'm just assuming any decent system has
some highly optimized macro for this and will never do a function call.
This is used in the most performance critical loops, and doing function
calls here will lead to horrendous performance.
> 
> You can use "indent -npro -kr -i8 -ts8 -l80 -ss -ncs" to reformat your
> code into a similar style as used in the rest of git (settings taken
> from Lindent which is shipped with the Linux source).
Although I cringe at 8-space indenting, and find much of the GIT
code close to unreadable for lack of design-level comments, I'll
gladly reformat any code to conform to existing code standards.
Please let me know if you've got documentation on that, as it would
be helpful for me to know what the standard is. (No flame intended. :-)
> 
> After converting to htonl() "make test" ran fine on my x86 box.  Here is
> what I get when I try to repack the git repo, though:
> 
>    $ git repack -a -d
>    Generating pack...
>    Done counting 18985 objects.
>    Deltifying 18985 objects.
>    git-pack-objects: diff-delta.c:766: create_delta: Assertion `ptr -
> delta == (int)delta_size' failed.
> 
> Please let me know if you need more details.
This was a result of incorrect calculation of the size of copy and
data commands. I fixed this in a follow-up patch sent to the list.
For any bug reports, they're easiest to fix if you can find a reproducer
using test-delta.

  -Geert
