From: Steve Folly <steve@spfweb.co.uk>
Subject: Re: Retrospectively add alternates to a repository?
Date: Sat, 27 Feb 2010 11:43:55 +0000 (UTC)
Message-ID: <loom.20100227T123539-643@post.gmane.org>
References: <loom.20100227T004822-959@post.gmane.org> <be6fef0d1002261837g794e8df2yc92261d46f3235bd@mail.gmail.com> <20100227083418.GC27191@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 12:44:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlL6L-0006H7-Qk
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 12:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966298Ab0B0LoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 06:44:17 -0500
Received: from lo.gmane.org ([80.91.229.12]:33914 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965569Ab0B0LoH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 06:44:07 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NlL5Z-00060e-KZ
	for git@vger.kernel.org; Sat, 27 Feb 2010 12:44:05 +0100
Received: from cpc1-haye16-0-0-cust629.haye.cable.virginmedia.com ([92.234.82.118])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 Feb 2010 12:44:05 +0100
Received: from steve by cpc1-haye16-0-0-cust629.haye.cable.virginmedia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 Feb 2010 12:44:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 92.234.82.118 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_2; en-gb) AppleWebKit/531.21.8 (KHTML, like Gecko) Version/4.0.4 Safari/531.21.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141195>

Jeff King <peff <at> peff.net> writes:

> 
> On Sat, Feb 27, 2010 at 10:37:25AM +0800, Tay Ray Chuan wrote:
> 
> > yes, just make sure the objects/info/alternates file points to the
> > location of that cloned repo's object directory; for example:
> > 
> >   $ echo /path/to/cloned/repo/.git/objects > .git/objects/info/alternates
> 
> You will probably want to then get rid of anything in the child that is
> now available in the alternates repository.
> 
> I would have thought "git repack -adl" works, but I think there is
> something a little funny in the logic. It reports "nothing new to pack",
> but does not delete the loose objects. But packing first then worked:
> 
>   $ git clone large-parent child
>   $ echo $PWD/large-parent/.git/objects >child/.git/objects/info/alternates
>   $ cd child
> 
>   $ du -sh .git/objects
>   51M     .git/objects
> 
>   $ git repack -adl && du -sh .git/objects
>   Nothing new to pack.
>   51M     .git/objects
> 
>   $ git repack -ad && du -sh .git/objects
>   Counting objects: 3, done.
>   Delta compression using up to 2 threads.
>   Compressing objects: 100% (2/2), done.
>   Writing objects: 100% (3/3), done.
>   Total 3 (delta 0), reused 0 (delta 0)
>   51M     .git/objects
> 
>   $ git repack -adl && du -sh .git/objects
>   Nothing new to pack.
>   20K     .git/objects
> 
> -Peff
> 

Excellent, this is exactly what I need. Thanks very much Tay
 and Jeff.

I now have a plan to write a script to attach and
detach repositories to and from local mirrors on demand:

attach = 
    echo "/path/to/mirror" > .git/objects/info/alternates && 
    git repack -adl && 
    git repack -ad && 
    git repack -adl

detach = 
    git repack -a && 
    rm .git/objects/info/alternates


Cheers,
Steve
