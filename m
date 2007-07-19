From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [REVISED PATCH 2/6] Introduce commit notes
Date: Thu, 19 Jul 2007 02:34:00 -0700
Message-ID: <7vodi83fg7.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
	<Pine.LNX.4.64.0707160022560.14781@racer.site>
	<7vejj96igx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707190258550.14781@racer.site>
	<alpine.LFD.0.999.0707181949490.27353@woody.linux-foundation.org>
	<7vfy3l3rj0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 19 11:34:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBSOf-0003ij-EQ
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 11:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933587AbXGSJeF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 05:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760526AbXGSJeE
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 05:34:04 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:36583 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757535AbXGSJeB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 05:34:01 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070719093401.NULO1399.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 19 Jul 2007 05:34:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RMa01X0041kojtg0000000; Thu, 19 Jul 2007 05:34:01 -0400
In-Reply-To: <7vfy3l3rj0.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 18 Jul 2007 22:13:07 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52954>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> ...
>> So if you're really really *really* unlucky, you might end up having to 
>> fall back on the linear search. But it still works!
>>
>> Can anybody see anything wrong in my thinking above?
> ...
> But the real problem of this approach of course is that this is
> not reliable and can get a false match.  You can find your
> beginning NUL in the SHA-1 part of one entry, and terminating
> NUL later in the SHA-1 part of next entry, and you will never
> notice.

In other words, if you are really really *really* unlucky, not
only you might end up being fooled by random byte sequences in
SHA-1 part of the tree object, you would not even notice that
you have to fall back on the linear search.

I've long time ago concluded that if we care about reliability
(and we do very much), a bisectable tree without breaking
backward compatibility is impossible.  I was hoping to find a
"hole" in tree object format so that I can place an extended
section that is invisible to older versions of git, and place a
table that records offsets of each tree entries to help
bisection and/or perhaps a hash table to help look-up, but I do
not think it is possible.  In the case of index file, the
original file format had a hole after the cache-entry array
where we can later squeeze an extension section that is
invisible to older versions of git.  But the tree object format
is designed so tight that I do not see there is any place to put
an extension section.

Side note: I also think adding "extension section" to tree
object is not a good idea to begin with.  The data nor length of
such a section cannot participate in hash computation to derive
the tree's object name so that we can still compare two tree
objects (with and without such extension) that have the same
contents by only looking at their object names.  But having
contents that are not counted as parts of the object's name goes
against the reliability and safety of git.

> ...
> I was suggesting to have a specialized parser only to read such
> tree objects that are "abused" to represent notes.  You can
> cheaply validate that these trees are of expected shape.
> ...
> For an added safety, a "notes" writer could even throw in
> signature bytes (say, a symlink whose name is " !" in the
> top-level tree, and another symlink " !{37}" in the second-level
> tree) to protect the reader.

Of course, even with the above trick with relatively cheap
validation based on size, entry format, and "signature entries",
the way I outlined to speed up "notes" access really relies on
the tree objects used in "notes" to be well formed.  If somebody
throws in a tree that is not really a "note" to refs/notes/, and
if I am really really *really* unlucky, not only I might end up
being fooled by random byte sequences in SHA-1 part of the tree
object, I would not even notice that I am reading garbage and
end up giving garbage as "note" to the object back to the user.
