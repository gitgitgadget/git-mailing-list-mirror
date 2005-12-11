From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: [RFC] Planning a git-cvsdaemon
Date: Sun, 11 Dec 2005 15:44:04 +1300
Message-ID: <46a038f90512101844q326b3d43nf8b40617bd82c576@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Dec 11 03:45:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElHCD-0001j3-8S
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 03:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbVLKCoI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 21:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbVLKCoI
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 21:44:08 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:57733 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965069AbVLKCoH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2005 21:44:07 -0500
Received: by wproxy.gmail.com with SMTP id 69so1173424wra
        for <git@vger.kernel.org>; Sat, 10 Dec 2005 18:44:04 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QAlLNLpJNFgOIDYUwBTogK0DSAgQsNLu4lSXoZWypkS3+Ng0ug10sLWA5U1ld6d8AR0KCQA3FrwU4RLjXdAVZpSd0LW3+CDJAxSZfnbmmeTJS3jdQa/YT1VxTVD2r9LUP8ayxh2ZL+GiqWflTgONajoNG6LnfSxly/Lxd7CpnBw=
Received: by 10.54.117.11 with SMTP id p11mr6632851wrc;
        Sat, 10 Dec 2005 18:44:04 -0800 (PST)
Received: by 10.54.70.12 with HTTP; Sat, 10 Dec 2005 18:44:04 -0800 (PST)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13479>

I am considering working on a git-cvsdaemon script, intended to
implement the CVS protocol while reading/writing to a git repo. This
would be, of course, limited in what it can do -- I am hoping to be
able to support initial checkout, diff, log and commit.

My cunning(?) plan so far is to

 - Track only one configurable "head/branch" of history and make it
appear linear. Whenever we have parallel development and then a merge,
pick a side to follow, and then show the merge as one commit. Of
course, it won't do very well with octopus merges, but you shouldn't
be doing those anyway, except for bragging purposes ;-)

 - Generate a view of the per-file history, so we can maintain
CVS-style file version numbers.

 - Provide enough support to make new commits through CVS, possibly
with some kind of delayed-execution commit mechanism. CVS's per-file
atomicity here plays against us big-time, but I think we can fudge
something that works 99% of the time. Commits aborted halfway through
will leave a botched commit in GIT too, which someone will hopefully
identify and rollback. there is also a time window while we will have
to be telling CVS that it succeeded in its commit of the initial
files, while we don't know whether the whole commit has succeeded.
Clients committing may be left in an inconsistent state if we fail
halfway through.

 - The delayed exec commit will need a locking mechanism

 - Simplify as much as possible -- ko/kb will probably be ignored, and
no keyword expansion will be supported. Ignore CVS-style branching,
and do not worry about tagging.

The goal is to support command line CVS, and popular GUI CVS clients
(Eclipse's embedded CVS, TortoiseCVS), and to make it readable, but
also writable, so a team can collaborate using GIT and CVS. It is no
weekend project...

In any case, I am after feedback in general (and any truly
insurmountable issues you can think of),  I haven't found yet  a good
library implementing the server side of the protocol (other than
cvs's). git-cvsdaemon will probably take shape in Perl initially,
though if there's a good cvs protocol library in other scripting
language, I'm interested...

cheers,


martin
