From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git sideband hook output
Date: Thu, 10 Jun 2010 11:30:19 -0700
Message-ID: <20100610183019.GR14847@spearce.org>
References: <AANLkTinLWDFTn7bhcF3Vk-q9aw4lJC2vFj95M9bxLbBT@mail.gmail.com> <20100608214632.GN14847@spearce.org> <A612847CFE53224C91B23E3A5B48BAC744839BF3DD@xmail3.se.axis.com> <alpine.LFD.2.00.1006090934320.30664@xanadu.home> <A612847CFE53224C91B23E3A5B48BAC744839BF6AE@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>, Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 20:30:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMmWW-00013M-6d
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 20:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759218Ab0FJSaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 14:30:24 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54402 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758889Ab0FJSaW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 14:30:22 -0400
Received: by pwi1 with SMTP id 1so43159pwi.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 11:30:21 -0700 (PDT)
Received: by 10.114.54.28 with SMTP id c28mr455340waa.169.1276194621666;
        Thu, 10 Jun 2010 11:30:21 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id r20sm2897023wam.5.2010.06.10.11.30.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Jun 2010 11:30:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC744839BF6AE@xmail3.se.axis.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148905>

Peter Kjellerstedt <peter.kjellerstedt@axis.com> wrote:
> > 
> > Would be much more logical to fix the hook output, and keep hook
> > developers honnest by not confusing the user with output that isn't
> > local stuff.
> 
> Why should the user care whether the output is generated locally 
> or remotely? Shouldn't you prefix local hook output then as well
> to separate it from the output of the git commands themselves 
> (and no, I am not suggesting this is added)?

Because, I've been confused by hook output before.  A lot of users
have been.  We've also been confused by terminal captures posted
by users when they are having trouble with Git, it does help to
debug the problem by knowing what came from the remote side, and
what was reported locally.

The use of 'remote:' as a prefix dates back to August 2006,
in commit 2de196fe by Junio Hamano.  Prior to that we used
VT100 coloring, which Junio Hamano added that same month in
commit dfa46478:

    fetch/clone: mark messages from remote side stand out.
    
    When dealing with a corrupt or out of sync remote repository,
    the user often gets error messages like this:
    
        error: refs/heads/devel does not point to a valid commit object!
    
    which leaves the user wondering if the breakage is on the local
    end or on the remote end.  This is unnecessarily alarming.
    
    This patch changes the way we display messages received from the
    remote side over the git protocol sideband (i.e. stderr stream
    of the remote process).  It shows them with blue background with
    white letters, but this presentation is subject to proposals of
    better ways from the list.
    
    The problem was pointed out by Andrew Morton.

I guess its a long standing history now that messages from the
remote side should get echoed with 'remote:' to better describe
what is going on.

As for why it got picked up by remote hooks, its because I reused
the code, because I reused the network protocol.

> As I see it this change has taken away a little bit of freedom.

But its made the whole thing more honest.

Messages from the remote are now clearly marked as "this is stuff
the other side is trying to tell you", which is different from the
status update we display later showing the outcome of the push.

> Previously I (as a hook writer) could choose to add a prefix like 
> "remote:" to my hook if I wanted to, to make it more obvious that the
> output came from the remote server, _or_ I could choose not to and 
> have a standardized output that looked the same regardless of whether
> it was a local hook or a remote one that complained about the 
> formatting of a commit message. Now I no longer have that option.

But as a user, I really want to know what was hook output, and what
was output from Git.  Putting "remote: " in front helps me to see
the difference.

> And what if my hook output is localized? Now there is an English
> "remote:" in front of every line... Or even worse, what if the
> "remote:" string is localized in a future version of git, then I 
> have no way of knowing how wide it is and cannot take measures to 
> format my hook output so that it will look right.

Don't localize "remote:"?  Or pick a shorter translation?

If its really a problem, maybe "remote: " prefix should turn into
something shorter and language agnostic, like "<< ".  But thus far
we hadn't had to worry about it, since we didn't have translation
support in Git...  (though yes, I see that is changing now).

-- 
Shawn.
