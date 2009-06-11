From: Nick Woolley <nickwoolley@yahoo.co.uk>
Subject: Re: [PATCH] git-cvsexportcommit can't commit files which have been
 	removed from CVS
Date: Thu, 11 Jun 2009 15:10:27 +0100
Message-ID: <4A311053.5060802@yahoo.co.uk>
References: <4A1F1CF5.8030002@yahoo.co.uk> <e2b179460906100106x2b9c0bb4r931b0a12959d4314@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 16:10:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEkz3-00046Y-9v
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 16:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485AbZFKOKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 10:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbZFKOKO
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 10:10:14 -0400
Received: from udon.noodlefactory.co.uk ([80.68.88.167]:42449 "EHLO
	udon.noodlefactory.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbZFKOKN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 10:10:13 -0400
Received: from 87-194-154-6.bethere.co.uk ([87.194.154.6] helo=[192.168.0.101])
	by udon.noodlefactory.co.uk with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nickwoolley@yahoo.co.uk>)
	id 1MEkyp-00019R-In; Thu, 11 Jun 2009 15:10:11 +0100
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
In-Reply-To: <e2b179460906100106x2b9c0bb4r931b0a12959d4314@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121339>

Mike Ralphson wrote:
> Hi Nick, I'm seeing intermittent failures since your new test was
> added to 'next' on AIX 5.3
> 
> cvs commit: Up-to-date check failed for ` space'
> cvs [commit aborted]: correct above errors first!
> * FAIL 15: re-commit a removed filename which remains in CVS attic
> * failed 1 among 15 test(s)
> 
> Is there a possibility this test has a race condition?

Hm, I have thought not, but what sort of a race condition did you have in mind?

> Let me know if there's anything I can do to help debug it.
> 
> It could be a bug in the ancient CVS I have here (1.11.1p1) though.

I wouldn't be surprised.

What my fix does is to spot files marked "Up-to-date" but which have "no file "
prepended to the filename in cvs status's output, which means the file used to
exist but was deleted from the repository, not that it is "Up-to-date" in the
sense you'd expect.

If old versions of CVS report these files differently they may not be spotted.

I don't know why the  " space" file seems to be causing a problem - it shouldn't
interfere with the test I added (and indeed doesn't for me).

Perhaps you could apply the following patch to t/t9200-git-cvsexportcommit.sh,
run it, and send the contents of t/debug.out?  What I get is appended after the
patch.

You might also try commenting out the following part of my test, so that it
should trivially work, and see if there's still an error:

#      rm attic_gremlin &&
#      cvs -Q rm attic_gremlin &&
#      cvs -Q ci -m "removed attic_gremlin"

Cheers,

N


diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index ef1f8d2..4f19a47 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -320,12 +320,19 @@ test_expect_success 'use the same checkout for Git and CVS' '
 test_expect_success 're-commit a removed filename which remains in CVS attic' '

     (cd "$CVSWORK" &&
+     dlog=../../debug.out &&
+     echo "# before adding file"  >$dlog &&
+     cvs status attic_gremlin " space" >>$dlog 2>&1 &&
+
      echo >attic_gremlin &&
      cvs -Q add attic_gremlin &&
      cvs -Q ci -m "added attic_gremlin" &&
      rm attic_gremlin &&
      cvs -Q rm attic_gremlin &&
-     cvs -Q ci -m "removed attic_gremlin") &&
+     cvs -Q ci -m "removed attic_gremlin" &&
+
+     echo "# after adding file"  >>$dlog &&
+     cvs status attic_gremlin " space" >>$dlog 2>&1) &&

     echo > attic_gremlin &&
     git add attic_gremlin &&

----
# before adding file
cvs status: nothing known about `attic_gremlin'
===================================================================
File: no file attic_gremlin		Status: Unknown

   Working revision:	No entry for attic_gremlin
   Repository revision:	No revision control file

===================================================================
File:  space           	Status: Up-to-date

   Working revision:	1.1	2009-06-11 13:56:15 +0000
   Repository revision:	1.1	/home/nick/gitworking/git/t/trash
directory.t9200-git-cvsexportcommit/cvsroot/ space,v
   Commit Identifier:	oDOEzyj3FzAazrRt
   Sticky Tag:		(none)
   Sticky Date:		(none)
   Sticky Options:	(none)

# after adding file
===================================================================
File: no file attic_gremlin		Status: Up-to-date

   Working revision:	No entry for attic_gremlin
   Repository revision:	1.2	/home/nick/gitworking/git/t/trash
directory.t9200-git-cvsexportcommit/cvsroot/Attic/attic_gremlin,v
   Commit Identifier:	X1mPOnzvk5rczrRt

===================================================================
File:  space           	Status: Up-to-date

   Working revision:	1.1	2009-06-11 13:56:15 +0000
   Repository revision:	1.1	/home/nick/gitworking/git/t/trash
directory.t9200-git-cvsexportcommit/cvsroot/ space,v
   Commit Identifier:	oDOEzyj3FzAazrRt
   Sticky Tag:		(none)
   Sticky Date:		(none)
   Sticky Options:	(none)
