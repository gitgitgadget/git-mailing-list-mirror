From: Nick Woolley <nickwoolley@yahoo.co.uk>
Subject: Re: [PATCH] git-cvsexportcommit can't commit files which have been
 	removed from CVS
Date: Mon, 06 Jul 2009 14:23:31 +0100
Message-ID: <4A51FAD3.7010306@yahoo.co.uk>
References: <4A1F1CF5.8030002@yahoo.co.uk>	 <e2b179460906100106x2b9c0bb4r931b0a12959d4314@mail.gmail.com>	 <4A311053.5060802@yahoo.co.uk> <e2b179460907020650u672d8724p45f67173668332aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 15:23:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNoAY-0006Lx-4W
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 15:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759AbZGFNXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 09:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753532AbZGFNXc
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 09:23:32 -0400
Received: from udon.noodlefactory.co.uk ([80.68.88.167]:35902 "EHLO
	udon.noodlefactory.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509AbZGFNXb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 09:23:31 -0400
Received: from 87-194-154-6.bethere.co.uk ([87.194.154.6] helo=[192.168.0.102])
	by udon.noodlefactory.co.uk with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nickwoolley@yahoo.co.uk>)
	id 1MNoAJ-0006cZ-A6; Mon, 06 Jul 2009 14:23:27 +0100
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <e2b179460907020650u672d8724p45f67173668332aa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122787>

Mike Ralphson wrote:
> debug.out contains the following:
> 
> # before adding file
> cvs status: nothing known about attic_gremlin
> ===================================================================
> File: no file attic_gremlin             Status: Unknown
> 
>    Working revision:    No entry for attic_gremlin
>    Repository revision: No revision control file
> 
> ===================================================================
> File:  space            Status: Needs Patch

This is what I get on this line:

  File:  space           	Status: Up-to-date

Which might explain why it fails the 'up to date check' in your case - it seems
that CVS hasn't synchronised the " space" file with the respository?  Or is this
an artifact created by the race condition Robin mentioned?  I gather the problem
appears intermittently.


> 
> CVS/Entries for the file has
> / space/1.1/Thu Jul  2 12:50:17 2009//
> 
>> You might also try commenting out the following part of my test, so that it
>> should trivially work, and see if there's still an error:
>>
>> #      rm attic_gremlin &&
>> #      cvs -Q rm attic_gremlin &&
>> #      cvs -Q ci -m "removed attic_gremlin"
> 
> It all goes a bit fun if I do that...
> 

Actually, I get the error you do here - my mistake, I should have told you to
comment out the whole clause, i.e.:

#     (cd "$CVSWORK" &&
#      echo >attic_gremlin &&
#      cvs -Q add attic_gremlin &&
#      cvs -Q ci -m "added attic_gremlin" &&
#      rm attic_gremlin &&
#      cvs -Q rm attic_gremlin &&
#      cvs -Q ci -m "removed attic_gremlin") &&

I've checked this passes for me.


> Would it be acceptable to simply reorder the tests so this previously
> unreported error goes away again?

Speaking personally, I can't see why not, although I don't understand the
mechanism of the race condition in question. Wouldn't a race condition like this
potentially cause similar errors to crop up all through the test script,
whenever git-cvsexportingcommit gets a bogus "Needs Patch" status?

An alternative might be to start my particular test by creating a new CVS
repository.


Cheers,

N

ps I've patched git-cvsexportcommit.perl to get rid of the warnings I can also
see in your output, and will submit those to this list separately.
