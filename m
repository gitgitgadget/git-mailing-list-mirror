From: chris <jugg@hotmail.com>
Subject: Re: error with $ git push origin HEAD:newbranch
Date: Fri, 6 May 2011 02:16:03 +0000 (UTC)
Message-ID: <loom.20110506T034552-210@post.gmane.org>
References: <loom.20110505T103708-225@post.gmane.org> <20110505093752.GB29595@sigill.intra.peff.net> <loom.20110505T114511-660@post.gmane.org> <20110505105914.GA464@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 04:16:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIAam-0002if-Rn
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 04:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754998Ab1EFCQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 22:16:20 -0400
Received: from lo.gmane.org ([80.91.229.12]:42494 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754878Ab1EFCQT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 22:16:19 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QIAaV-0002dT-5D
	for git@vger.kernel.org; Fri, 06 May 2011 04:16:16 +0200
Received: from 114-38-69-159.dynamic.hinet.net ([114.38.69.159])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 May 2011 04:16:15 +0200
Received: from jugg by 114-38-69-159.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 May 2011 04:16:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 114.38.69.159 (Mozilla/5.0 (X11; Linux i686) AppleWebKit/534.24 (KHTML, like Gecko) Ubuntu/10.04 Chromium/11.0.696.57 Chrome/11.0.696.57 Safari/534.24)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172932>

Jeff King <peff <at> peff.net> writes:
> 
> On Thu, May 05, 2011 at 10:06:21AM +0000, chris wrote:
> 
> > It is slightly surprising that git-push doesn't default to assuming 
> > one means refs/heads/newbranch in this case.  I don't see a reason 
> > not to?
> 
> Consider something like:
> 
>   $ git checkout v1.5
>   $ git push origin HEAD:foo
> 
> Would you want "foo" to be a branch or a tag? I can see arguments for
> either.

If the above command wanted to produce a tag, just provide 'v1.5' as the source 
ref.  It seems to me that first checking out the tag then pushing from HEAD is 
extra steps in order to push a branch ref without having to be explicit about 
it.  $ git push origin v1.5:foo would have been simpler if intending to push a 
tag ref.

Given that git-push has specific syntax for pushing a tag, and git-push makes 
other assumptions that give the perception it is generally used for branches 
unless told otherwise also makes me expect that "foo" to be a branch.

The following is provided for specifically calling out a tag:

  $ git push origin tag <refspec>

However, that syntax as far as I can tell is pretty worthless anyway, as the 
following will not work:

  $ git push origin tag HEAD:newtag
  error: src refspec refs/tags/HEAD does not match any.

  $ git push origin tag 183c65e:newtag
  error: src refspec refs/tags/183c65e does not match any.

But both the following are successful, which makes me ask why the 'tag' option 
exists if the above doesn't work.

  $ git push tag existingtag:newtag1

  $ git push existingtag:newtag2

So I see little purpose in the $ git push tag <refspec> syntax, as the source 
must already be a tag anyway.

All of that to say, it isn't exactly clear what one should expect.

Personally, I would prefer that git-push work on branches by default[1], 
providing shortcuts for pushing tag[2] refs and remote branch[3] refs, while all 
other ref types must be called out explicitly.  Creating new refs isn't 
destructive, so it seems these could be supported without concern.

1. $ git push origin SHA1:branch1
  => $ git push origin SHA1:refs/heads/branch1

2. $ git push origin tag SHA1:tagname
  => $ git push origin SHA1:refs/tags/tagname

3. $ git push origin SHA1:upstream/branch2
  => $ git push origin SHA1:refs/remotes/upstream/branch2

chris
