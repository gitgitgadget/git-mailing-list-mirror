From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: RFD: Handling case-colliding filenames on case-insensitive filesystems
Date: Wed, 23 Feb 2011 17:52:29 -0500
Message-ID: <4D658FAD.2010505@xiplink.com>
References: <201102231811.45948.johan@herland.net> <AANLkTi=MyqXYi=zNZ+MFcUW2p-_icwg0m_aMQpVioT8J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 23:52:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsNZ2-0002as-7H
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 23:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226Ab1BWWwC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 17:52:02 -0500
Received: from smtp202.iad.emailsrvr.com ([207.97.245.202]:42900 "EHLO
	smtp202.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981Ab1BWWwB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 17:52:01 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp50.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 648BE370477;
	Wed, 23 Feb 2011 17:52:00 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp50.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 2D59E37035F;
	Wed, 23 Feb 2011 17:52:00 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <AANLkTi=MyqXYi=zNZ+MFcUW2p-_icwg0m_aMQpVioT8J@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167731>

On 11-02-23 02:07 PM, Jay Soffian wrote:
> On Wed, Feb 23, 2011 at 12:11 PM, Johan Herland <johan@herland.net> wrote:
>> A colleague suggested instead that Git should notice that the collision
>> will occur, and work around the failure to represent the repository
>> objects in the file system with a one-to-one match. Either by checking
>> out only _one_ of the colliding files, or by using a non-colliding name
>> for the second file. After all, Git already has functionality for
>> manipulating the file contents on checkout (CRLF conversion). Doesn't
>> it make sense to add functionality for manipulating the _directory_
>> contents on checkout as well? Even if that makes sense, I'm not sure
>> that implementing it will be straightforward.
>>
>> Are there better suggestions on how to deal with this?
> 
> The general problem is aliasing in the working-tree, of which
> case-insenitivity is the most common form, but it also happens due to
> HFS's use of NFD. A search on gmane for "insensitive" or "nfd" will
> return many hits.
> 
> I think the argument against remapping filenames is that it doesn't
> really help the user.
> 
> Let's say (for the sake of argument) that git supported remapping
> between the index and the working-tree. Further, my repo has:
> 
> $ cat Foo.c
> #include "Foo.h"
> 
> $ cat foo.c
> #include "foo.h"
> 
> And on a case-insensitive file-system, git has remapped foo.[ch] to
> foo~2.[ch] for the purposes of avoiding collisions on checkout.
> 
> The checkout can't be compiled correctly, so what's the point of even
> allowing it?

In our case it would be useful to still have that checkout because the people
working on the case-insensitive systems are dealing with a different part of
the tree and don't care about the part with the collision.

A build designed to exploit case-sensitivity obviously won't work on a
case-insensitive system, but there's no reason to expect a git repo to have a
single, monolithic build.  There are a couple of parts of our code tree --
parts that are out of our control -- that use case sensitive file names, but
most of it doesn't.  It would be good if git would allow people on
case-insensitive systems to work with the repository, if not the complete build.

I suggest:

1. Git should emit a warning when checking out a case-colliding file (or
directory) on a case-insensitive system.  I don't really care _what_ gets
checked out for that file -- whatever it is ain't gonna work anyway.  Let's
say it checks out the associated blob the first time it runs across
thing.foo, but then emits the warning when it tries to check out Thing.Foo.

2. Git should forbid (yes, *forbid*) a user on a case-insensitive system from
adding any change to any files stored in the repository under
case-conflicting names.  The error message should basically be "You need to
use a case-sensitive system to work on this file."

3. I'm OK with git allowing case-insensitive users to forcibly delete
case-conflicting files.  "git rm thing.foo" should, on case-insensitive
systems, fail and display all case-colliding names for
[tT][hH][iI][nN][gG].[fF][oO][oO], and tell the user to use -f if they really
want to delete *all* those files.

		M.
