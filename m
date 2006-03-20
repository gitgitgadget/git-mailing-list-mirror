From: Junio C Hamano <junkio@cox.net>
Subject: Re: efficient cloning
Date: Mon, 20 Mar 2006 15:04:34 -0800
Message-ID: <7voe00iupp.fsf@assigned-by-dhcp.cox.net>
References: <m3r74ykue7.fsf@lugabout.cloos.reno.nv.us>
	<7vbqw1nakz.fsf@assigned-by-dhcp.cox.net>
	<7vu09tjy38.fsf@assigned-by-dhcp.cox.net>
	<200603201730.19373.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 21 00:05:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLTQl-0000QE-Uv
	for gcvg-git@gmane.org; Tue, 21 Mar 2006 00:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWCTXEl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 18:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWCTXEk
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 18:04:40 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:40130 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932196AbWCTXEj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Mar 2006 18:04:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060320230231.OYAF20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 20 Mar 2006 18:02:31 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200603201730.19373.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Mon, 20 Mar 2006 17:30:19 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17769>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> On Monday 20 March 2006 09:54, you wrote:
>>  * A new flag --use-separate-remote stops contaminating local
>>    branch namespace by upstream branch names.  The upstream
>>    branch heads are copied in .git/refs/remotes/ instead of
>
> Shouldn't this be .git/refs/remotes/origin/?
> Ie. different namespaces for different remotes?
>
> Linus wanted to still be able to say "origin" which automatically
> would map to "remotes/origin/master", where the name of the remote

I do not remember that, but even if he said something similar to
that, I suspect it would not be "map remotes/origin/master to
origin", but "origin could mean remotes/origin when origin is
the unique tail-name anywhere under refs/".

I think what is reasonable is something like this:

 - If you start from a repository cloned in the traditional
   way, the upstream "master" is kept track of with your
   "origin", so "diff origin master" would be "my changes on top
   of the upstream".

 - If your repository was cloned with --use-separate-remote, the
   upstream "master" is refs/remotes/master, so the same diff
   can be had with "diff remotes/master master".

 - Regardless of how you started your cloned repository, with an
   $GIT_DIR/{remotes,refs/heads,refs/remotes} editor I hinted in
   a separate message, you can rearrange things to organize the
   refs/ hierarchy any way you want.

   - You could for example arrange to track my "master" as
     refs/heads/origin and all the other branch heads under
     refs/remotes/junkio/ (or not even track my other branches
     if you are not interested).  Then the same diff can be had
     with "diff origin master".

   - You could for example arrange to track all my branches in
     refs/remotes/junkio/, and if git-pasky were still alive,
     Pasky's branches in refs/remotes/pasky.  If we had a "take
     the unique tail-name anywhere under refs/" logic, the same
     diff can be had with "diff junkio/master master".

So I think two things that would be nice to have on top of what
we have are (1) the said "remotes-and-refs editor" [*1*], and
(2) a change to sha1_name.c to look for places other than
built-in tags/ and heads/ under refs/ to find a unique
tail-match.

Since I do not do Porcelain, (2) would obviously be the next
thing for me to work on on this topic.  I should also address
"Ouch I did not realize I have given the same name to a tag and
a branch" warning issue while doing so.


[Footnote]

*1* ... which currently I do not plan to do myself unless I have
absolutely nothing else to do and really bored.  A sound of huge
hint dropping ;-).
