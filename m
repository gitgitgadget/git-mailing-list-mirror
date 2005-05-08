From: Junio C Hamano <junkio@cox.net>
Subject: Re: Broken adding of cache entries
Date: Sat, 07 May 2005 17:43:03 -0700
Message-ID: <7vll6q8s4o.fsf@assigned-by-dhcp.cox.net>
References: <1115408460.32065.37.camel@localhost.localdomain>
	<20050506231447.GG32629@pasky.ji.cz>
	<1115421933.32065.111.camel@localhost.localdomain>
	<20050506233003.GJ32629@pasky.ji.cz>
	<1115423450.32065.138.camel@localhost.localdomain>
	<20050507001409.GP32629@pasky.ji.cz>
	<1115431767.32065.182.camel@localhost.localdomain>
	<20050507152849.GD9495@pasky.ji.cz>
	<7vhdhealjm.fsf@assigned-by-dhcp.cox.net>
	<20050507224116.GF9495@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 02:36:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUZmM-0007QU-UJ
	for gcvg-git@gmane.org; Sun, 08 May 2005 02:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbVEHAnP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 20:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbVEHAnP
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 20:43:15 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:51100 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262771AbVEHAnH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2005 20:43:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050508004304.MMWP26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 May 2005 20:43:04 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050507224116.GF9495@pasky.ji.cz> (Petr Baudis's message of
 "Sun, 8 May 2005 00:41:16 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> What about
PB> ... suggested changes removed.
PB> then? (Completely untested and everything.)

It is clear that it is untested.  In the sequence Kay had
trouble with:

    $ rm -fr path; date >path
    $ git-update-cache --add path
    $ rm -f path; mkdir path; date >path/file
    $ git-update-cache --add path/file

The cache_name_compare function you are looking at is called
with "path" and "path/file", and compares the name strings (up
to the length of the shorter one), and when they are the same,
then compares the lengths of them.  At that point, the if()
statements have already answered that "path" comes before
"path/file" and your changes will _not_ change the behavior of
that function.

That said, I understand the behaviour you would want to see, and
I tend to agree that this should be prevented from happening in
the first place when git-update-cache happens.  Let me think a
bit more about it.

PB> I'd still prefer add_cache_entry() to just replace the original entry
PB> (as it does otherwise).

I do not think it should just silently replace; instead it
should make the user take notice, because this is an unusual
situation.  In other words, it should refuse until the user
makes a conscious decision to tell it that the user is removing
it and then placing something completely different.

This implies (I am thinking aloud here):

    $ find fs -type f -print | xargs git-update-cache --add
    $ rm -fr fs
    $ date >fs
    $ git-update-cache --add fs

would refuse to add "fs" because it notices it has some entry
whose "name" field starts with "fs/".  Likewise, for the
opposite sequence:

    $ date >fs
    $ git-update-cache --add fs
    $ rm -f fs; mkdir fs; date >fs/file    
    $ find fs -type f -print | xargs git-update-cache --add

Telling git-update-cache about anything that contains a '/' in
its name would first check if an entry whose name is exactly one
of the leading path prefix, and refuses the operation if it
finds one.

The above logic should work and it would also work if we decide
to just replace without refusing as well.  I'll code it up and
see which one I like; maybe it will end up as an option.


