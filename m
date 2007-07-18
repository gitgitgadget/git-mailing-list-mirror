From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Empty directories...
Date: Wed, 18 Jul 2007 09:23:46 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
References: <85lkdezi08.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707180135200.14781@racer.site>
 <858x9ez1li.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 18:24:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBCJu-00055w-8R
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 18:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755014AbXGRQYE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 12:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759839AbXGRQYD
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 12:24:03 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44282 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755738AbXGRQYA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 12:24:00 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6IGNqKP024746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Jul 2007 09:23:53 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6IGNkED017830;
	Wed, 18 Jul 2007 09:23:46 -0700
In-Reply-To: <858x9ez1li.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-2.671 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52875>



On Wed, 18 Jul 2007, David Kastrup wrote:
> 
> In the same manner as empty regular files have no contents, and git
> tracks those.  Existence and permissions are important.

Yes, but directories really are different.

First off, git wouldn't track the permissions anyway (git tracks execute 
bits, but for directories that _has_ to be set or git couldn't use them 
itself, so that's not going to happen).

Second, and much more important, the directories will exist or not 
*regardless* of what git does.

> b) The problem is not just that empty directories don't get added into
> the repository.  They also don't get removed again when switching to a
> different checkout.

Bzzt. Wrong.

We *do* remove directories when all files under them go away.

HOWEVER (and this is where one of the reasons for not tracking them comes 
in):

   ** YOU CANNOT REMOVE A DIRECTORY IF IT HAS SOME UNTRACKED CONTENTS **

Think about that for five seconds, then think about it some more. Ponder 
it.

So the fact is, git *already* does ass good of a job as it could possibly 
do wrt directories that go away: it tries to remove them if all the files 
that are tracked in it have gone away.

But that leaves a very common case, namely switching to another branch 
without those files, and the directory still having stale object files etc 
build crud in it.

A SCM *must*not* just remove that directory. It would be horrible. The 
fact that it has untracked files in it does not make those untracked files 
"unimportant". Maybe you feel that way about object files, but what about 
tracking some important parts of your home directory - does the fact that 
you don't necessarily track *all* of it mean that the rest is totally 
unimportant adn that git should just remove it? HELL NO!

So directories really _are_ problematic. You cannot (and should not) track 
them the same way as you track a file.

And the difference is very fundamental indeed: when you track a regular 
file, you track *all* of its content. But when you track a directory, 
you don't track it's content *at*all*.

Think about that, and then think about the fact that git is defined as a 
"content tracker", and it's not "weasely" at all to say that you don't 
track directories.

So your argument is totally bogus. When you track an empty file, you very 
much track the *content* of that file, and "empty" just happens to be a 
very valid content.

But when you track a "directory", you don't actually track its content at 
all, you track it's *existence*, which is a very very very different 
thing. I hope you understand from the above what is so different.

(A true "directory content" tracker by definition would have to track 
every single file under that directory. You can claim that for the case of 
an empty directory the "existence tracking" is 100% equivalent with 
"content tracking", but that's simply not true. It becomes non-true the 
moment there are any files at all inside that directory, and be honest 
now: the only _point_ of an empty directory is that you expect it to 
potentially get files under it).

So "existence" != "content". Git very much does not track "existence" of 
files, it tracks the total content of them too.

			Linus
