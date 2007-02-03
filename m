From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use "-f" when adding files with odd names in t9200.
Date: Sat, 03 Feb 2007 15:50:13 -0800
Message-ID: <7vlkje243u.fsf@assigned-by-dhcp.cox.net>
References: <1AAD2384-C52D-4D60-A948-4F14C9515B53@silverinsanity.com>
	<20070203181329.GA10192@179.242.249.10.in-addr.arpa>
	<7v4pq358q4.fsf@assigned-by-dhcp.cox.net>
	<F16FE131-CF33-4DD0-9A06-4A24C59C7623@silverinsanity.com>
	<7vabzv3qxi.fsf@assigned-by-dhcp.cox.net>
	<A9623793-111E-47F7-9709-1D569333C40C@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sun Feb 04 00:50:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDUeD-0004BS-4B
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 00:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbXBCXuR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 18:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbXBCXuQ
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 18:50:16 -0500
Received: from fed1rmmtai19.cox.net ([68.230.241.40]:62374 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751517AbXBCXuP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 18:50:15 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070203235015.MIOS1349.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Feb 2007 18:50:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id KBqD1W00n1kojtg0000000; Sat, 03 Feb 2007 18:50:14 -0500
In-Reply-To: <A9623793-111E-47F7-9709-1D569333C40C@silverinsanity.com> (Brian
	Gernhardt's message of "Sat, 3 Feb 2007 16:31:27 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38620>

Brian Gernhardt <benji@silverinsanity.com> writes:

> On Feb 3, 2007, at 3:51 PM, Junio C Hamano wrote:
>
>> A filesystem that reports success on creat(path) and then does
>> not return that path to later readdir() from that directory is
>> broken from git's point of view.  At least that has been the
>> definition so far.
>
> I agree, it's fairly idiotic and obtuse.  By using the great Google,
> I've seen lots of other people complaining about it as well.

I am not sure if we are really agreeing, but I'll let it pass.

> "git add ." works just fine, as it reads the name of the file from
> disk which is already in the form HFS+ accepts.  The only confusion
> exists when comparing data from the user to data from disk.

I wonder even if that is true.

Luckily or unluckily, I do not have access to a system with
broken readdir() vs creat() confusion, so I cannot test it
myself, but I suspect that this sequence may not work as
expected:

	#!/bin/sh

	pathname='a pathname that canonicalize differently from original'
	rm -fr testrepo
	mkdir testrepo
        cd testrepo
        git init-db
	echo hello >"$pathname"
        git add -f .
        git ls-files -s "$pathname"

If my reading of what you said is correct, then in the above
sequence:

 (1) The shell creates, via redirection of output of echo, a file
     but using canonicalized string, which is different from
     what the user gave;

 (2) "git add" will ask readdir(2) to get inventory of files in
     the working directory, and grabs canonicalized string;

 (3) "git add" uses that canonicalized string, open(2)s, mmap(2)s and
     hashes the blob contents and registers that object name
     under the canonicazlied string in the index;

 (4) "git ls-files" tries to look up the index with the string
     user used to create the file in (1), which is without the
     canonicalization.

I think it is fairly idiotic and obtuse for a filesystem to
treat pathnames anything but a random sequence of bytes that is
slash separated and NUL terminated.  I would need a really hard
convincing to buy any path munging on the git side to match
whatever a stupid filesystem does, especially because we do not
live in the ideal Unicode/utf-8 only world.
