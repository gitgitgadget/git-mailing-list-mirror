From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Re: Bad git status performance
Date: Fri, 21 Nov 2008 13:46:48 +0100
Message-ID: <4926ADB8.5000307@gmx.ch>
References: <4926009E.4040203@gmx.ch> <c9e534200811201711y887ddd2t33013ec4a7db3c9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Glenn Griffin <ggriffin.kernel@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 21 13:48:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3VQd-0002am-Dy
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 13:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949AbYKUMqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 07:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753912AbYKUMqw
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 07:46:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:35007 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753949AbYKUMqv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 07:46:51 -0500
Received: (qmail invoked by alias); 21 Nov 2008 12:46:49 -0000
Received: from 93-61.78-83.cust.bluewin.ch (EHLO [192.168.123.204]) [83.78.61.93]
  by mail.gmx.net (mp004) with SMTP; 21 Nov 2008 13:46:49 +0100
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX19FMslHrNdFGuo63QkWqMHui7TbJ33aJqmqMBVGvu
	Wmi5dvpPsgjWj8
User-Agent: Thunderbird 2.0.0.17 (X11/20080928)
In-Reply-To: <c9e534200811201711y887ddd2t33013ec4a7db3c9a@mail.gmail.com>
X-Enigmail-Version: 0.95.7
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101522>

Glenn Griffin wrote:
> On Thu, Nov 20, 2008 at 4:28 PM, Jean-Luc Herren <jlh@gmx.ch> wrote:
>> The first 'git status' shows the same difference as the second,
>> just the second time it's staged instead of unstaged.  Why does it
>> take 16 seconds the second time when it's instant the first time?
> 
> I believe the two runs of git status need to do very different things.
>  When run the first time, git knows the files in your working
> directory are not in the index so it can easily say those files are
> 'Changed but not updated' just from their existence.

I might be mistaken about how the index works, but those paths
*are* in the index at that time.  They just have the old content,
i.e. the same content as in HEAD.  When HEAD == index, then
nothing is staged.

But the presence of those files alone doesn't tell you that they
have changed.  You have to look at the content and compare it to
the index (== HEAD in this situation) to see whether they have
changed or not and for some reason git can do this very quickly.

> The second run
> those files do exist in both the index and the working directory, so
> git status first shows the files that are 'Changes to be committed'
> and that should be fast, but additionally git status will check to see
> if those files in your working directory have changed since you added
> them to the index.

Which is basically the same comparision as above, just it turns
out that they have not changed.  But even then, we're talking
about comparing a 1 byte file in the index to a 1 byte file in the
work tree.  That doesn't take 16 seconds, even for 100 files.

So this makes me believe it's the first step (comparing HEAD to
the index to show staged changes) that is slow.  And when you
compare a 1MB file to a 1 byte file, you don't need to read all of
the big file, you can tell they're not the same right after the
first byte.  (Even an doing stat() is enough, since the size is
not the same.)

Another thing that came to my mind is maybe rename detection kicks
in, even though no path vanished and none is new.  I believe
rename detection doesn't happen for unstaged changes, which might
explain the difference in speed.

btw, I forgot to mention that I get this with branches maint,
master, next and pu.

(And I hope you don't mind I take this back to the list.)

jlh
