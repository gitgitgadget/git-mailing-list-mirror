From: Sam Vilain <sam@vilain.net>
Subject: Tracking and committing back to Subversion?
Date: Thu, 02 Feb 2006 11:51:40 +1300
Message-ID: <1138834301.21899.40.camel@wilber.wgtn.cat-it.co.nz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Feb 01 23:54:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4QpN-00041P-Ud
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 23:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422997AbWBAWvv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 17:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423000AbWBAWvv
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 17:51:51 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:45212 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1422997AbWBAWvu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2006 17:51:50 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 8EFA8364C; Thu,  2 Feb 2006 11:51:47 +1300 (NZDT)
Received: from localhost.localdomain (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 482C9364A
	for <git@vger.kernel.org>; Thu,  2 Feb 2006 11:51:42 +1300 (NZDT)
To: Git Mailing List <git@vger.kernel.org>
X-Mailer: Evolution 2.4.1 
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15460>

Hi all,

Has anyone done any work on bidirectional access to SVN repositories?
ie, tracking and committing.

That would be porcelain that behaves like SVK (http://svk.elixus.org)

Ideally it would probably need to link against the Subversion RA (remote
access) library, neon.

I can see forsee two potential issues;

  1. file properties - such as mime type, ignores and custom properties.
     Linus, when I asked you about this in Dunedin, you mentioned that
     there is a place at the end of the directory entry where this could
     fit without breaking backwards compatibility.  Perhaps this could
     be an optional pointer to another directory node;

     /
      trunk/       # after all, we're tracking an SVN repo ;)
        MyModule/
          Makefile.PL
          MyModule.pm
          <prop-dir>/
            svn:ignore

     <prop-dir> is a directory object, with one file in this example;
     called svn:ignore.  The contents of this file would be something
     like the .gitignore;

          Makefile
          Makefile.old
          blib
          ...etc...

     This configures the directory "/trunk/MyModule" to have a property
     "svn:ignore", which makes SVN ignore those files.

  2. "forensic" file movement history - as opposed to the uncached,
     (and unversioned), automatic "analytical" file movement history.

     It would be easy for a tool to provide 100% interface compatibility
     with SVN client/SVK using properties, but properties that hang off
     the head rather than the file itself (so that they don't stuff up
     the ability to merge identical trees reached via independent
     paths).  SVN calls these "revision properties".  If a good
     convention is adopted for this, it could be used as a nice way to
     supplement git's automatic analysis of the revision history.

     So, then, git could support these three methods of finding
     revision history;

        1. automatic/analytical, as at present.  Cachable information,
           and such a cache would not form part of the revision history.

        2. forensic, if using porcelain that supports it; this would
           form part of the revision history, but be out of band to the
           content.

        3. (potentially) retrospective, for instance, somebody studying
           an old code base and tracking history for some reason - or
           even 'correcting' forensic revision history that is causing
           their advanced patch calculus algorithm to trip up (should
           someone be using git as a storage back-end for darcs, for
           instance)

     Ideally, it would be possible to distinguish between 2 and 3, of
     course this would require two head identifiers; the content head,
     and the revision history head.

This might seem like functionality not needed for merging kernel
trees ;) but I think it would add value to be able to make git truly
join the trump suit in the VCS deck (along with SVK, which can, for
instance, track Perforce and even git repositories).

Sam.
