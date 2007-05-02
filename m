From: Steven Grimm <koreth@midwinter.com>
Subject: Re: git-svn and local only topic branch
Date: Wed, 02 May 2007 12:06:15 -0700
Message-ID: <4638E127.4010303@midwinter.com>
References: <8b65902a0705010940pb3bfb16u624d470068351624@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 21:06:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjK9e-00022Z-LQ
	for gcvg-git@gmane.org; Wed, 02 May 2007 21:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767254AbXEBTGS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 15:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767266AbXEBTGS
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 15:06:18 -0400
Received: from tater.midwinter.com ([216.32.86.90]:58853 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1767254AbXEBTGR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 15:06:17 -0400
Received: (qmail 14581 invoked from network); 2 May 2007 19:06:17 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=qVk7LrXUjMR6bR6+1gbigUemznOeR//N3uOavE4/NTgLRP/Pz+LQEgL/J0xuwDkj  ;
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1)
  by localhost with SMTP; 2 May 2007 19:06:16 -0000
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
In-Reply-To: <8b65902a0705010940pb3bfb16u624d470068351624@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46045>

Guilhem Bonnefille wrote:
> I want the following result:
>
> o--o--o-------------- o (upstream, remotes/upstream)
>         \             /
>          o--o--o--o (topic)

I did something similar recently:

http://www.spinics.net/lists/git/msg29119.html

The secret is to do a squash merge (git merge --squash) and commit that 
as a single revision onto the branch you commit into svn.

1--2--3------------4 (upstream)
       \
        A--B--C--D   (topic)

As far as git's history is concerned, at this point you have a topic 
branch with a bunch of commits ABCD, and an upstream branch with a bunch 
of commits 1234. Revision 4 has the contents of ABCD but is not marked 
as a merge in git's revision history, which means git-svn won't be 
confused since it doesn't know how to follow merges.

Now you do git svn dcommit to commit revision 4, which shows up as one 
commit on the svn side. git-svn will delete your revision 4 and create a 
new one whose comment includes the svn revision ID, so you'll have:

1--2--3------------4' (upstream)
       \
        A--B--C--D    (topic)

Since git-svn will never look earlier than revision 4' to figure out 
which svn revision it should use as a basis for future svn commits, you 
can do whatever you want with the history up to revision 4'. In 
particular, you can use git's "grafts" feature to fake git into thinking 
that a merge actually took place.

Open .git/info/grafts in your favorite editor and add a line with three 
SHA-1 hashes:

hash-of-4' hash-of-3 hash-of-D

Now as far as git is concerned you have the history you want:

1--2--3------------4' (upstream)
       \          /
        A--B--C--D    (topic)

Subsequent merges on the git side, whether they're squashed or not, will 
know about the merge you've just done.

In his reply to my script, Junio correctly pointed out that all this 
fiddling really ought to be happening in git-svn itself; it ought to 
know that you've done a merge and should record that fact directly in 
the metadata for 4' rather than treating it as a single-parent commit. 
If you do the above a zillion times you'll end up with a huge grafts 
file which is not so clean. But as a stopgap measure, this does work 
adequately.

-Steve
