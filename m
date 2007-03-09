From: Anton Tropashko <atropashko@yahoo.com>
Subject: Re: Errors cloning large repo
Date: Fri, 9 Mar 2007 15:48:46 -0800 (PST)
Message-ID: <20070309234846.7641.qmail@web52613.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 10 00:48:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPopR-0005Au-Uy
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 00:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767669AbXCIXss (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 18:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767670AbXCIXss
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 18:48:48 -0500
Received: from web52613.mail.yahoo.com ([206.190.48.216]:45112 "HELO
	web52613.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1767669AbXCIXsr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Mar 2007 18:48:47 -0500
Received: (qmail 7643 invoked by uid 60001); 9 Mar 2007 23:48:46 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=K8RMJc7LXoyWCOMr+C8ueWyjr5w1kbFzOJKqfjk7f6qoCh44WyzjNJwW1VWmXdc9e5Vr8Ha7gYHrsDRsMBq6ptAsbK8WB2drOloWuXsU2OXrWCKB0WsYooHcF5z6xl/mznqdWqpLLx0x7xKkfl46rC8Kc6sscG3UD3qMJFw70/Y=  ;
X-YMail-OSG: QDvdh0UVM1mbs33lCm7vlDBN9QNSI.g57wqIqZXcjvw6uhMzYYLKsR7CyAk7TQRRziXEnfgy2SxNgD81_fu80_Bo0rCWwm0.Vu7u8f_R5aaoT3X848rMugXh4A5xTdQOI8bjHzMGQuIRKd54bafayMW5Zg--
Received: from [136.182.158.129] by web52613.mail.yahoo.com via HTTP; Fri, 09 Mar 2007 15:48:46 PST
X-Mailer: YahooMailRC/471 YahooMailWebService/0.6.132.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41823>

answers inline prefixed with >>>> while I'm trying to figure out how to deal
with new "improvement" to yahoo mail beta.

On Fri, 9 Mar 2007, Anton Tropashko wrote:
>
> I managed to stuff 8.5 GB worth of files into a git repo (two two git commits since
> it was running out of memory when I gave it -a option)

So you might be able to do just do

    git add dir1
    git add dir2
    git add dir3
    ..
    git commit

or something.

>>>>>>>>>>>>  For some reason git add . swallowed the whole thing
>>>>>>>>>>>>  but git commit did not and I had to split it up. I trimmed the tree a bit
>>>>>>>>>>>>  since then by removing c & c++ files ;-)

But one caveat: git may not be the right tool for the job. May I inquire 
what the heck you're doing? We may be able to fix git even for your kinds 

>>>>>>>>>>>>  I dumped a rather large SDK into it. Headers, libraries
>>>>>>>>>>>> event crs.o from the toolchains that are part of SDK. The idea is to keep
>>>>>>>>>>>>  SDK versioned and being able to pull an arbitrary version once tagged.

So I'm not saying that git won't work for you, I'm just warning that the 
whole model of operation may or may not actually match what you want to 
do. Do you really want to track that 8.5GB as *one* entity?

>>>>>>>>>>>> Yes. It would be nice if I won't have to prune pdfs, txts, and who
>>>>>>>>>>>> knows what else people put in there just to reduce the size.

> but when I'm cloning to another linux box I get:
> 
> Generating pack...
> Done counting 152200 objects.
> Deltifying 152200 objects.

.. this is the part makes me think git *should* be able to work for you. 
Having lots of smallish files is much better for git than a few DVD 
images, for example. And if those 152200 objects are just from two 
commits, you obviously have lots of files ;)

However, if it packs really badly (and without any history, that's quite 
likely), maybe the resulting pack-file is bigger than 4GB, and then you'd 
have trouble (in fact, I think you'd hit trouble at the 2GB pack-file 
mark).

Does "git repack -a -d" work for you?

>>>>>>>>>>>> I'll tell you as soon as I get another failure. As you
>>>>>>>>>>>> might guess it takes a while :-]

> /usr/bin/git-clone: line 321:  2072 File size limit exceededgit-fetch-pack --all -k $quiet "$repo"

"File size limit exceeded" sounds like SIGXFSZ, which is either:

 - you have file limits enabled, and the resulting pack-file was just too 
   big for the limits.

 - the file size is bigger than MAX_NON_LFS (2GB-1), and we don't use 
   O_LARGEFILE.

I suspect the second case. Shawn and Nico have worked on 64-bit packfile 
indexing, so they may have a patch / git tree for you to try out.

>>>>>>>>>>>> Ok. I think you're correct:
from ulimit -a:
...
file size             (blocks, -f) unlimited
...

Good to know developers are ahead of the users.

Is there way to get rid of pending (uncommitted) changes?
git revert does not work the same way as svn revert as I just discovered
and git status still reports a ton of pending deletions
(I changed my mind and need my object files back). I suppose I can move .git out
of the way blow all the files move it back and git pull or whatever
does a local checkout, but there must be a better way.
 





 
____________________________________________________________________________________
No need to miss a message. Get email on-the-go 
with Yahoo! Mail for Mobile. Get started.
http://mobile.yahoo.com/mail 
